variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "admin_username" {
  description = "Username for the Administrator account"
}

variable "admin_password" {
  description = "Password for the Administrator account"
}
############################
##   WVD VM - Variables   ##
############################

# Windows VM Admin User
variable "windows-10-admin-username" {
  type        = string
  description = "Windows VM Admin User"
}

# Windows VM Admin Password
variable "windows-10-admin-password" {
  type        = string
  description = "Windows VM Admin Password"
}

# Windows VM Hostname (limited to 15 characters long)
variable "windows-10-vm-hostname" {
  type        = string
  description = "Windows VM Hostname"
}

# Windows VM Virtual Machine Size
variable "windows-10-vm-size" {
  type        = string
  description = "Windows VM Size"
}

##############
## OS Image ##
##############

# Windows 10 Multi-Session SKU used to build VMs
variable "WVD" {
  type        = string
  description = "Windows 10 Multi-session with M365"
}
