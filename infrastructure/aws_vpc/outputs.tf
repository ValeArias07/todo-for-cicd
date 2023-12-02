output "subnet_a_id" {
  value = aws_default_subnet.default_subnet_a.id
}

output "subnet_b_id" {
  value = aws_default_subnet.default_subnet_b.id
}

output "default_vpc_id" {
   value = aws_default_vpc.default_vpc.id 
}