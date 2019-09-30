package s3.s3_buckets_without_aes256
import data.s3

# # Negation example (probably more useful since it catches invalid buckets)
s3_buckets_without_aes256[name] {
	# Any resource that has a type "aws_s3_bucket"
    resource := s3.s3_bucket_changes[_]
    
    # After the plan applies..
    new_resource := resource.change.after
    
    # Does *not* use AES256
    "AES256" != sse_algorithm(new_resource.server_side_encryption_configuration)
    
      # Add it to the list of buckets missing the encryption
    name := resource.name
}
sse_algorithm(sse_config) = algorithm {
    algorithm := sse_config[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
} else = algorithm {
    algorithm := ""
}

# Matching example
# s3_bucket_encryption_aes256 {
# 	# Some s3 bucket change..
#     resource := s3.s3_bucket_changes[_]
    
#     # After the plan applies..
#     new_resource := resource.change.after
    
#     # Must have AES256 encryption by default
#     "AES256" == new_resource.server_side_encryption_configuration[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm
# }