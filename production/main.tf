module "vpc" {
  source = "../modules/vpc"

  infra_env = var.infra_env
  vpc_cidr  = var.vpc_cidr

}

// module "ec2_app" {
//   source = "../modules/ec2"

//   infra_env = var.infra_env
//   infra_role = "web"
//   instance_size = "t2.micro"
//   instance_ami = var.instance_ami
//   instance_root_device_size = 20

//   subnets = keys(module.vpc.vpc_public_subnets)
//   security_groups = [module.vpc.security_group_public]

//   tags = {
//     Name = "terraform-${var.infra_env}-web"
//   }

//   create_eip = true

// }

// module "ec2_worker" {
//   source = "../modules/ec2"

//   infra_env = var.infra_env
//   infra_role = "worker"
//   instance_size = "t2.micro"
//   instance_ami = var.instance_ami

//   subnets = keys(module.vpc.vpc_private_subnets)
//   security_groups = [module.vpc.security_group_private]

//   tags = {
//     Name = "terraform-${var.infra_env}-worker"
//   }

//   create_eip = false

// }
