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

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}







resource "aws_instance" "ec2_resource" {
  instance_type = "t2.micro"
  ami           = "ami-001843b876406202a"
  key_name      = "myKey"
  tags = {
    "Name" = "${var.name}"
  }
  #   provisioner "local-exec" {
  #     command = "bash run.sh"
  #   }
  #    provisioner "local-exec" {
  #     command = "echo ${self.public_ip} >> ip.txt"
  #   }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file("./myKey.pem")
    }
    inline = [
      "pip3 install ansible; ansible-playbook playbook.yaml"
    ]
  }
}

# resource "null_resource" "delete" {
#   provisioner "local-exec" {
#     command = "bash run.sh"
#   }
# }
