output "publicip-master" {
  value = module.master.publicip
  depends_on = [module.master]
}
output "publicip-node" {
  value = module.nodes.publicip
  depends_on = [module.nodes]
}