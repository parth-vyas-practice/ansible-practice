output "publicip" {
  value = module.vm.publicip
  depends_on = [module.vm]
}

