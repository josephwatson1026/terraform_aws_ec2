# variable for keyname
variable "key-name" {
  default = "terraform_key"
  type = string
}
# variable for tags
variable "key_pair_tags" {
  default = {}
  type = map(string)
}
# variable for server count
variable "ec2_count" {
  default = 1
  type = number
}
# for aws intance type configuration
variable "aws_instance_type" {
  default = "t3.micro"
  type = string
}

# tags for instances
variable "instance_tags" {
  default = {}
  type = map(string)
}

#ec2 security group
variable "ec2_security_name" {
  default = ""
  type = string
}
variable "allowing_ip_address" {
  default = "0.0.0.0/0"
  type = string
}