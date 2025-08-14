# selected provider aws and region
provider "aws" {
  region = "ap-south-1"
  profile = "terraform"
}

# configure the resources

# updating the ec2_key_pair
resource "aws_key_pair" "ec2_key_pair" {
    key_name = var.key-name
    public_key = file("${path.module}/terraform_key.pub")
    tags = var.key_pair_tags
}
# ec2 security group
resource "aws_security_group" "ec2_security_group" {
  name = var.ec2_security_name
  ingress {
    description = "Allowing ssh incoming from my IP"
    cidr_blocks =  [var.allowing_ip_address]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress{
    description = "Allowing https incoming from my IP"
    cidr_blocks =  [var.allowing_ip_address]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  egress {
    description = "rules for outgoing traffic"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}
# creating ec2 instance
resource "aws_instance" "creating_ec2_instance" {
  ami = "ami-0144277607031eca2"
  instance_type = var.aws_instance_type
  tags = var.instance_tags
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  count = var.ec2_count
  key_name = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
}

