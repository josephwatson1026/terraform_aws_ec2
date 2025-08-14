# show values of key pair created
output "create_key_pair" {
  value = [aws_key_pair.ec2_key_pair.arn,aws_key_pair.ec2_key_pair.id]
}
# show all ec2 IPs created
output "show_ec2_ips"{
  value = [for instance in aws_instance.creating_ec2_instance : instance.public_ip]
}
