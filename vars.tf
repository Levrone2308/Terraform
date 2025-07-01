variable "zone1" {
  description = "The availability zone for the EC2 instance"
  type        = string
  default     = "us-east-1a" # Default value can be changed as needed
}

variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1" # Default region can be changed as needed
}