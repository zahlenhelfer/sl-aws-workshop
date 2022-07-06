output "devdan-username" {
  value = aws_iam_user.devdan.name
}

output "devdan-password" {
  value = aws_iam_user_login_profile.devdan-profile.password
}
