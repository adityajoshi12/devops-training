# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure Azure Credentials
provider "azurerm" {
  features {}
}

module "virtual_machine" {
  source = "./modules/vm"
  overall = {
    region = "west us"
    name   = "modules"
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
    count = 1
    os_type = "linux"  # windows
  }
}

# data "azurerm_virtual_machine" "vm" {
#   name                = "modules-linux-vm-1"
#   resource_group_name = "rg-modules"
# }
# output "ip"  {
#   value = data.azurerm_virtual_machine.vm.public_ip_address
# }

# resource "null_resource" "example2" {
#   provisioner "remote-exec" {
#     connection {
#       type = "ssh"
#       user = "azureadmin"
#       password = "Pass!word@"
#       host = data.azurerm_virtual_machine.vm.public_ip_address
#     }
#     inline = [ "sudo apt-get update && sudo apt install nginx -y" ]
#   }
# }
