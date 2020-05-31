output "lab_access" {
  value       = [
    {
      "ip": module.student_vm.public_ip,
      "port": "22"
    }
  ]
  description = "Lab Access Information"
}