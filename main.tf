# fetching my public IP to be used
# creating security group
data "http" "fetching_public_ip" {
  url = "https://ipv4.icanhazip.com"
}
# this will create a local variable
locals {
  my_public_ip = "${chomp(data.http.fetching_public_ip.response_body)}/32"
}

# for creating ec2 resources
module "ec2_resources" {
  source   = "./modules/ec2"
  key-name = "kube-aws-key"
  ec2_security_name = "allowing_ssh_for_my_public_ip"
  key_pair_tags = {
    "environment" : "dev",
    "created_by" : "terraform",
    "resource_action" : "create_key_pair"
  }
  ec2_count           = 3
  aws_instance_type   = "t3.small"
  allowing_ip_address = local.my_public_ip
  instance_tags = {
    "environment" : "dev"
    "created_by" : "terraform"
    "resource_action" : "create_ec2_creation"
  }

  # count = 3

}
# creating ec2
# module "ec2_creation"{
#     source = "./modules/ec2"
#     aws_instance_type = "t3.small"
# }



# print the ip of ec2 instances
output "print_ec2_output" {
  value = module.ec2_resources.show_ec2_ips
}

