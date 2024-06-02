# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
    backend "azurerm" {
    storage_account_name = ""
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "prod.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

# Configure Azure Credentials
provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.overall.name}"
  location = var.overall.region

}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.overall.name}-virtual-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.overall.name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Public IP Address
resource "azurerm_public_ip" "pip" {
  name                = "${var.overall.name}-public-ip-${count.index+1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  count = var.overall.count 
}

# Create a Network Security Group

resource "azurerm_network_security_group" "ssh_rule" {
  name                = "${var.overall.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                     = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.overall.name}-nic-${count.index+1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  count = var.overall.count 
  ip_configuration {
    name                          = "ipconfig-${count.index+1}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }

}

# Create a Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  count = var.overall.os_type == "linux" ? var.overall.count : 0
  name                  = "${var.overall.name}-linux-vm-${count.index+1}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.overall.size
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  source_image_reference {
    publisher = var.overall.os_details.publisher
    offer     = var.overall.os_details.offer
    sku       = var.overall.os_details.sku
    version   = var.overall.os_details.version
  }

  computer_name                   = "${var.overall.name}-linux-vm"
  admin_username                  = var.overall.username
  admin_password                  = var.overall.password
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.overall.env == "prod" ?  "Premium_LRS" : "Standard_LRS" 
    disk_size_gb         = 100
  }
}

resource "azurerm_windows_virtual_machine" "wvm" {
  count = var.overall.os_type == "windows" ? var.overall.count : 0
  name                  = "${var.overall.name}-windows-vm-${count.index+1}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.overall.size
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  source_image_reference {
   publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"


  }

  computer_name                   = "${var.overall.name}-windows-vm"
  admin_username                  = var.overall.username
  admin_password                  = var.overall.password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.overall.env == "prod" ?  "Premium_LRS" : "Standard_LRS" 
    disk_size_gb         = 100
  }
}

