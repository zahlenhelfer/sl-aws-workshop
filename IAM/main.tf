provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_user" "audit-user" {
  name = "auditjack"
}

resource "aws_iam_user" "devdan-user" {
  name = "devdan"
}

resource "aws_iam_group" "dev-group" {
  name = "dev-staff"
}

resource "aws_iam_group_membership" "dev-membership" {
  name = "dev-group-membership"

  users = [
    aws_iam_user.devdan-user.name,
  ]

  group = aws_iam_group.dev-group.name
}

resource "aws_iam_policy" "ec2-admin-policy" {
  name        = "ec2-admin-policy"
  description = "Allow all EC2 actions"
  policy      = file("policies/ec2_admin_policy.tmpl")
}
