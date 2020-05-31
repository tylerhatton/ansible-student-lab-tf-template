output "vpc_id" {
  value       = aws_vpc.ansible_student_lab.id
  description = "The ID of the VPC."
}

output "mgmt_subnet_id" {
  value       = aws_subnet.ansible_student_mgmt.id
  description = "The ID of the management subnet."
}