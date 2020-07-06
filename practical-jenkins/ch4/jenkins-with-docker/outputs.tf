output "public_dns" {
  description = "DNS name of the isntance"
  value       = aws_instance.web.public_dns
}

output "docker_dns" {
  description = "DNS name of the docker instance"
  value       = aws_instance.docker.public_dns
}

output "ebs_volume" {
  description = "EBS volume name"
  value       = aws_volume_attachment.ebs_att.device_name 
}

