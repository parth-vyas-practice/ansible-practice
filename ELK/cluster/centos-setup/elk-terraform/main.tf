provider "azurerm" {
}

module "vnet" {
  source = "./vnet"
    location = var.location
    resource_group_name = var.resource_group_name
    fullcidr = var.fullcidr
    subnet1 = var.subnet1
    subnet2 = var.subnet2
    subnet3 = var.subnet3
}
module "master" {
  source = "./vm"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet-id = module.vnet.subentid1
  env = var.env
  vmsize = var.vmsize
  vm-user-name = var.vm-user-name
  prefix = "master"
}
module "nodes" {
  source = "./vm"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet-id = module.vnet.subentid1
  env = var.env
  vmsize = var.vmsize
  vm-user-name = var.vm-user-name
  prefix = "node"
}
resource "local_file" "vm-ip" {
    content     = <<-EOT
    [master_node]
    master ansible_host=${module.master.publicip} ansible_user=${var.vm-user-name}
    
    [data_node]
    data1 ansible_host=${module.nodes.publicip} ansible_user=${var.vm-user-name}
    
    [master_node:vars]
    master_node_private_ip=${module.master.privateip}
    
    [data_node:vars]
    master_node_private_ip=${module.master.privateip}
    data_node_private_ip=${module.nodes.privateip}
    EOT
    filename = var.inventory
    depends_on = [module.master, module.nodes]
}

resource "null_resource" "run-ansible-master-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.inventory} ${var.ansible-master-playbook-path}"
  }
  depends_on          = [module.master, local_file.vm-ip]
}
resource "null_resource" "run-ansible-nodes-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.inventory} ${var.ansible-nodes-playbook-path}"
  }
  depends_on          = [module.nodes, local_file.vm-ip, null_resource.run-ansible-master-playbook]
}