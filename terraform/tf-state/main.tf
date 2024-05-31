terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-files123"
    key = "tf.state"
    region     = "ap-south-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
  ami = "ami-001843b876406202a"
}
