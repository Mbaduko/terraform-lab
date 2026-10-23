# Remote state in S3 with DynamoDB locking.
# The bucket and table are created by ./bootstrap (backend blocks cannot use variables).
terraform {
  backend "s3" {
    bucket         = "terraform-lab-state-288761743924"
    key            = "terraform-lab/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lab-lock"
    encrypt        = true
  }
}
