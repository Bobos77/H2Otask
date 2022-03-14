variable "region" {
  default = "us-east-1"
  description = "Please Enter Region"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "env" {
  default = "dev"
}

variable "projectname" {
  default = "ant-march22"
}


variable "owner" {
  default = "devops"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.11.0/24"]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.21.0/24"]
}  

variable "db-private_subnet_cidrs" {
  default = [
    "10.0.31.0/24"]
}  

variable "username" {
  default = "user1"
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "443", "8080", "22"]
  }
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
  type        = string
}

variable "key_pair_name" {
  description = "Name of EC2 SSH key pair"
  default     = "bastion"
  type        = string
}

variable "cluster-name" {
  default = "terraform-eks-ant-project"
  type    = string
}

