
output "vpc_id" {
  value = aws_vpc.vpc1.id
}
output "sub1-public-id" {
  value = aws_subnet.sub1.id
}
output "nat-id" {
  value = aws_nat_gateway.nat1.id
}
output "vpc-arn" {
  value = aws_vpc.vpc1.arn
}