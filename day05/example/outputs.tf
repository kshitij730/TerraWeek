output "web_instance_id" {

  description = "Instance ID of the web server."

  value = module.web_server.instance_id

}

output "web_public_ip" {

  description = "Public IP of the web server."

  value = module.web_server.public_ip

}

output "web_private_ip" {

  description = "Private IP of the web server."

  value = module.web_server.private_ip

}

output "server_private_ips" {

  description = "Private IPs of all servers."

  value = {

    for name, server in module.servers :

    name => server.private_ip

  }

}