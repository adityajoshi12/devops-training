variable "rg_name" {
  type        = string
  description = "The name of the resource group"
  default     = "default-rg"
}

variable "age" {
  type    = number
  default = 30
}

variable "rg_region" {
  type        = string
  description = "The name of the resource group region"
}

variable "my-tags" {
  type = map(string)
  default = {
    Name        = "demo-instance"
    Environment = "production"
  }
}

variable "my-tags-1" {
  type = map(bool)
  default = {
    Name        = true
    Environment = true
    Region      = false
  }
}

variable "user" {
  type = object({
    name  = string
    email = string
    age   = number
    male  = bool
  })
  default = {
    name  = "Sam"
    email = "sam@example.com"
    age   = 30
    male  = true
  }
}
