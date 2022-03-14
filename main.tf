provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "ant-s3bucket-terraform-projects" // Bucket where to SAVE Terraform State
    key    = "dev/network/terraform.tfstate"             // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                 // Region where bycket created
  }
}

provider "http" {}