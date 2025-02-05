output "publicip" {
  value = azurerm_public_ip.publicip-1.ip_address
  depends_on = [azurerm_virtual_machine.vm1, azurerm_public_ip.publicip-1]
}
output "privateip" {
  value = azurerm_network_interface.nic-1.private_ip_address
  depends_on = [azurerm_virtual_machine.vm1, azurerm_network_interface.nic-1]
}