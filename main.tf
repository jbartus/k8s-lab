provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "eks-vpc"
  azs                = ["us-east-1a", "us-east-1c", "us-east-1d"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  cluster_name                             = "my-eks-cluster"
  vpc_id                                   = module.vpc.vpc_id
  subnet_ids                               = module.vpc.private_subnets
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    spot = {
      min_size      = 1
      max_size      = 6
      desired_size  = 2
      instance_type = ["t4g.large"]
      capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
    }
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}