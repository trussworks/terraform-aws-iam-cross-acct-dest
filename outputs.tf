output "iam_role_name" {
  description = "The name of the created role."
  value       = aws_iam_role.main.name
}
