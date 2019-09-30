provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.0"
}

resource "aws_s3_bucket" "profile_picture_storage" {
  bucket_prefix = "profile-picture-storage"
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Owner           = "UserEngagement"
    Project         = "ProfileUploadService"
    ApplicationRole = "FileStorage"
  }

}