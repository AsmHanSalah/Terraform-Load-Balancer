output "alb_security_group_id" {
  value       = aws_security_group.alb_security_group.id
}

output "bastion_host_security_group_id" {
  value       = aws_security_group.bastion_host_security_group.id
}

output "private_security_id" {
  value       = aws_security_group.private_security_group.id
}
