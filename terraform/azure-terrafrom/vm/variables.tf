variable "overall" {
  type = object({
    region     = string
    name       = string
    size       = string
    os_details = map(string)
    username   = string
    password   = string
    env = string
    os_type=string
    count = number
  })
  default = {
    region = "west us"
    name   = "test"
    size   = "Standard_DS1_v2"
    os_details = {
      publisher = "Canonical" 
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "Latest"
    }
    password = "Pass!word@"
    username = "azureadmin"
    env = "dev"
    count = 2
    os_type = "linux"  # windows
  }
}


