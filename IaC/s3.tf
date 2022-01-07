
#Creating S3 Bucket

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket = "mafia-app-terraform-statefile" 
  force_destroy = true
# Enable versioning to see history of our state files
  versioning {
         enabled = true
        }
}