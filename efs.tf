module "efs" {
  source    = "terraform-aws-modules/efs/aws"
  name      = "my-efs"
  encrypted = true

  create_security_group      = true
  security_group_vpc_id      = module.vpc.vpc_id
  security_group_name        = "efs-sg"
  security_group_description = "EFS security group"

  mount_targets = {
    for subnet in module.vpc.private_subnets : subnet => {
      subnet_id = subnet
    }
  }

  security_group_rules = {
    vpc = {
      type        = "ingress"
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }
}

output "efs_id" {
  value = module.efs.id
}