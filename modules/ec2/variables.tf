variable infra_env {
  type          = string
  description   = "infrastructure environment"
}

variable infra_role {
  type          = string
  description   = "infrastructure purpose"
}

variable instance_size {
  type          = string
  description   = "ec2 web server size"
  default       = "t3.small"
}

variable instance_ami {
  type          = string
  description   = "Server image to use"
}

variable instance_root_device_size {
  type          = number
  description   = "Root block device size in GB"
  default       = 10
}

variable subnets {
  type = list(string)
  description = "valid subnets to assing to server"
}

variable security_groups {
  type = list(string)
  description = "security groups to assing to server"
  default = []
}

variable tags {
  type = map(string)
  description = "Tags for the resource"
  default = {}
}

variable create_eip {
  type = bool
  description = "whether or not create an EIP for the ec2 instance"
  default = false
}
