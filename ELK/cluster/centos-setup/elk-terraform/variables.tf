variable "resource_group_name" {
    default = "test1"
}
variable "env" {
  default = "dev"
}

variable "location" {
  default = "westus2"
}
variable "fullcidr" {
  default = "10.0.0.0/16"
}

variable "subnet1" {
  default = "10.0.1.0/24"
}
variable "subnet2" {
  default = "10.0.2.0/24"
}
variable "subnet3" {
  default = "10.0.3.0/24"
}

variable "vmsize" {
  default = "Standard_B2s"
}
variable "vm-user-name" {
  default = "azure"
}
variable "ansible-master-playbook-path" {
  default = "../ELK-master.yml"
}
variable "ansible-nodes-playbook-path" {
  default = "../ELK-nodes.yml"
}
variable "inventory"{
  default = "./ansible-inventory"
}