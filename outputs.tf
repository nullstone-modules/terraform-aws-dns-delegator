output "delegator" {
  value = {
    name       = aws_iam_user.delegator.name
    access_key = aws_iam_access_key.delegator.id
    secret_key = aws_iam_access_key.delegator.secret
  }

  description = "object({ name: string, access_key: string, secret_key: string }) ||| "

  sensitive = true
}
