output "public_dns" {
  description = "DNS name of the isntance"
  value       = aws_instance.web.public_dns
}

output "ebs_volume" {
  description = "EBS volume name"
  value       = aws_volume_attachment.ebs_att.device_name 
}

