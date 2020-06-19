output "db_subnet_group" {
  value = aws_db_subnet_group.this
}

output "db_instance" {
  value = aws_db_instance.this
}

output "iam_policy_document" {
  value = data.aws_iam_policy_document.this
}

output "iam_role" {
  value = aws_iam_role.this
}

output "iam_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.this
}
