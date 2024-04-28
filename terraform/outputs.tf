output "instance_id" {
  value = "Public IP is: ${aws_instance.ec2_resource.public_ip}"
}
