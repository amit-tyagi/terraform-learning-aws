resource "random_shuffle" "subnets" {
  input        = var.subnets
  result_count = 1
}

resource "aws_instance" "web_instance" {

  ami           = var.instance_ami
  instance_type = var.instance_size

  root_block_device {
    volume_size = var.instance_root_device_size
    volume_type = "gp3"
  }

  subnet_id              = random_shuffle.subnets.result[0]
  vpc_security_group_ids = var.security_groups

  tags = merge({

      Role        = var.infra_role
      Project     = "Terraform Project"
      Environment = var.infra_env
      ManagedBy   = "terraform"

    },
    var.tags
  )

}

resource "aws_eip" "web_addr" {

  count = (var.create_eip) ? 1 : 0

  vpc = true

  lifecycle {

    prevent_destroy = false

  }

  tags = {

    Name        = "terraform-${var.infra_env}-web-address"
    Role        = var.infra_role
    Project     = "Terraform Project"
    Environment = var.infra_env
    ManagedBy   = "terraform"

  }

}

resource "aws_eip_association" "eip_assoc" {
 
  count = (var.create_eip) ? 1 : 0

  instance_id   = aws_instance.web_instance.id
  allocation_id = aws_eip.web_addr[0].id

}

