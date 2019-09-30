package s3.s3_buckets_non_private
import data.s3

# Negation example (probably more useful since it catches invalid buckets)
s3_buckets_non_private[name] {
	# Any resource that has a type "aws_s3_bucket"
    resource := s3.s3_bucket_changes[_]
    
    # After the plan applies..
    new_resource := resource.change.after
    
    # Does *not* use AES256
    "private" != new_resource.acl

    # Add it to the list of buckets missing the encryption
    name := resource.name
}