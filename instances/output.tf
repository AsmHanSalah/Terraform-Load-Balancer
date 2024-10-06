output "public_instance_id" {
  value       = aws_instance.public_instance.id
}

output "private_1_id" {
  value       = aws_instance.private_instance_1.id
}

output "private_2_id" {
  value       = aws_instance.private_instance_2.id
}
