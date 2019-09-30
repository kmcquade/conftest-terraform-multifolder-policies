package s3
import data.terraform

#### Helpers - probably put them in separate package 
#### and import them as needed

# Probably put this into a shared place for s3 related policies
s3_bucket_changes[r] {
	resource := terraform.resource_changes[_]
    resource.type = "aws_s3_bucket"
    r := resource
}