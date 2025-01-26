# # 1 vpc, 1 subnet, 1 security group

# resource "aws_vpc" "myvpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support = true

#   tags = {
#     Name = "myvpc"
#   }
# }

# resource "aws_subnet" "pb_sn" {
#   vpc_id = aws_vpc.myvpc.id
#   cidr_block = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone = "us-west-2a"

# tags = {
#   Name = "pn_sn1"
# }
# }

# resource "aws_security_group" "sg" {
#   vpc_id = aws_vpc.myvpc.id
#   name = "mg_sg"
#   description = "Public Security"

#   # inbound traffic
#   ingress {
#     from_port = 22
#     to port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # outbound traffic
#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]

#   }
  
# }