data "aws_secretsmanager_secret" "ec2_key" {
  count = var.vpn_key_secret_name != null ? 1 : 0
  name  = var.vpn_key_secret_name
}

data "aws_secretsmanager_secret_version" "ec2_key" {
  count     = var.vpn_key_secret_name != null ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.ec2_key[0].id
}

locals {
  key_secret = var.vpn_key_secret_name != null ? jsondecode(data.aws_secretsmanager_secret_version.ec2_key[0].secret_string) : null
  public_key = local.key_secret != null ? local.key_secret["public_key"] : var.ec2_public_key

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_key_pair" "this" {
  key_name   = "vpn-${var.project}-${var.environment}"
  public_key = local.public_key

  tags = local.tags
}

module "ec2" {
  source = "../modules/terraform-aws-ec2-instance"

  name                        = "vpn-${var.project}-${var.environment}"
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = var.associate_public_ip_address
  create_eip                  = true

  security_group_ingress_rules = {
    ssh = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = local.tags
}
