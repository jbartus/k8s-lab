module "efs" {
  source                = "terraform-aws-modules/efs/aws"
  name                  = "my-efs"
  security_group_vpc_id = module.vpc.vpc_id

  mount_targets = {
    "us-east-1a" = {
      subnet_id = module.vpc.private_subnets[0]
    }
    "us-east-1c" = {
      subnet_id = module.vpc.private_subnets[1]
    }
    "us-east-1d" = {
      subnet_id = module.vpc.private_subnets[2]
    }
  }

  security_group_rules = {
    vpc = {
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }
}

output "efs_id" {
  value = module.efs.id
}