variable "name" {
  description = "ec2 machine name"
  type        = string
  default     = "ec2-machine"
}

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "env" {
  type        = string
  description = "environment"
  default     = "dev"
}

variable "machine_count" {
  type    = list(any)
  default = ["ram", "sam"]
}
