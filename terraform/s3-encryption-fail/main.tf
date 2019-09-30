provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "profile_picture_storage" {
  bucket_prefix = "profile-picture-storage"
  acl    = "public"

  versioning {
    enabled = true
  }
  
  tags = {
    Owner           = "UserEngagement"
    Project         = "ProfileUploadService"
    ApplicationRole = "FileStorage"
  }
  
}