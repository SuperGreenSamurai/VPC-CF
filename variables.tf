
#there are 2 buckets 
#Because buckets need unique names, I added randomizer string as a suffix
#there is 1 IAM role > Logs access role.
#Logs access role is used by EC2 instances to write logs to the Logs bucket.


variable "images_bucket_name" {
  description = "Name of the images bucket"
  type        = string
}

variable "logs_bucket_name" {
  description = "Name of the logs bucket"
  type        = string
}

#change role name (ex: logs-access-role) here if needed.  

variable "logs_access_role_name" {
  description = "Name of the logs access role"
  type        = string
}

variable "cidr_block_vpc" {
  description = "CIDR block range for the VPC"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "instance_ami" {
  type        = string
  description = "instance ami - Red Hat Enterprise Linux 9 (HVM), SSD Volume Type"
  #default = "ami-0da4b082c0455e0a0"
  default = "ami-0da4b082c0455e0a0"
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = "t2.micro"
}

variable "volume_size" {
  type        = number
  description = "volume size"
  default     = 20

}

variable "key_name" {
  type        = string
  description = "launch template and ec2 key name"
  default     = "coalfire"

}

variable "sub1" {
  description = "subnet 1"
  type        = string
  default     = "10.1.0.0/24"

}

variable "sub2" {
  description = "subnet 2"
  type        = string
  default     = "10.1.1.0/24"

}

#private subnets
variable "sub3" {
  description = "subnet 3"
  type        = string
  default     = "10.1.2.0/24"

}
variable "sub4" {
  description = "subnet 4"
  type        = string
  default     = "10.1.3.0/24"

}

variable "az1" {
  description = "us-west-2a"
  type        = string
  default     = "us-west-2a"

}

variable "az2" {
  description = "us-west-2b"
  type        = string
  default     = "us-west-2b"

}

variable "public_cidr_block" {
  description = "CIDR block range for the public subnet"
  type        = string
  default     = "0.0.0.0/0"
}

variable "name_prefix" {
  description = "application name prefix"
  type        = string
  default     = "MyApp-"
}
