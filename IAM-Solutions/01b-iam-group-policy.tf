data "aws_iam_policy" "EC2ReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_policy_attachment" {
  group      = aws_iam_group.dev-group.name
  policy_arn = data.aws_iam_policy.EC2ReadOnlyAccess.arn
}
