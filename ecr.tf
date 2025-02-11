module "ecr" {
  source                          = "terraform-aws-modules/ecr/aws"
  repository_name                 = "php-apache-mysql"
  create_lifecycle_policy         = false
  repository_image_tag_mutability = "MUTABLE"
}

output "repository_url" {
  value = module.ecr.repository_url
}