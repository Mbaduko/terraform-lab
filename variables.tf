variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
  default     = "terraform-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet (must be inside vpc_cidr)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "my_ip" {
  description = "Your public IP in CIDR notation for SSH access (e.g. 203.0.113.10/32)"
  type        = string

  validation {
    condition     = can(cidrhost(var.my_ip, 0))
    error_message = "my_ip must be a valid CIDR block, e.g. 203.0.113.10/32."
  }
}
