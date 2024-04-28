terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    gcp = {
      source  = "hashicorp/google"
      version = "5.26.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "gcp" {

}

resource "aws_instance" "ec2_resource" {
  instance_type = "t2.micro"
  ami           = "ami-001843b876406202a"
  key_name      = "aditya-ec2"
  tags = {
    "Name" = "${var.name}"
  }
}
