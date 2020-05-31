output "public_ip" {
  value       = aws_eip.ansible_student_vm_mgmt.public_ip
  description = "The mgmt IP of the student vm."
}