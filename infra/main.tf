terraform {
  backend "s3" {
    bucket = "s3-backend-nathan"
    key    = "nasa/apod/terraform.tfstate"
    region = "eu-west-2"
  }
}
