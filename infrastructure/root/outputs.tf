output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "EC2 private IP"
  value       = module.ec2.private_ip
}
