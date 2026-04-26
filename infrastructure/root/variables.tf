variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "myapp"
}

variable "subnet_id" {
  description = "VPC Subnet ID to launch the instance in"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpn_key_secret_name" {
  description = "Secrets Manager secret name containing the EC2 key pair name"
  type        = string
  default     = null
}

variable "ec2_public_key" {
  description = "Public key content for EC2 SSH access (used when not reading from Secrets Manager)"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}
