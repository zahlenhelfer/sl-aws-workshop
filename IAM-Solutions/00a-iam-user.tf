resource "aws_iam_user" "devdan" {
  name = "devdan"
}

resource "aws_iam_user_login_profile" "devdan-profile" {
  user                    = aws_iam_user.devdan.name
  password_length         = 20
  password_reset_required = false
}

resource "aws_iam_group_membership" "devdan-membership" {
  name  = "tf-testing-group-membership"
  group = aws_iam_group.dev-group.name
  users = [
    aws_iam_user.devdan.name,
  ]
}
