output "public_ip" {
  value = module.vm.public_ips["nic-ipconfig1"].ip_address
}

output "ssh" {
  value = "ssh ${var.admin_username}@${module.vm.public_ips["nic-ipconfig1"].ip_address}"
}
