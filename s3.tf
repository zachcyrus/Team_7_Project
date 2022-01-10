
#Creating S3 Bucket

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket        = "mafia-app-terraform-statefile"
  force_destroy = true
  # Enabling versioning to see history of our state files
  versioning {
    enabled = true
  }
  # Enabling server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
