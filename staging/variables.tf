variable infra_env {
  type        = string
  description = "infrastructure environment"
  default     = "staging"
}

variable instance_size {
  type        = string
  description = "ec2 web server size"
  default     = "t3.small"
}

variable instance_ami {
  type        = string
  description = "Server image to use"
}

variable instance_root_device_size {
  type        = number
  description = "Root block device size in GB"
  default     = 10
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
}