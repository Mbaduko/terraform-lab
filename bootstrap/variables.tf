variable "aws_region" {
  description = "AWS region for the backend resources"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name prefix applied to all resources"
  type        = string
  default     = "terraform-lab"
}
