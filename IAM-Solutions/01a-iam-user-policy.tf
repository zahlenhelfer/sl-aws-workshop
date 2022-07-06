resource "aws_iam_policy" "s3_admin_policy" {
  name        = "s3_admin_policy"
  description = "Allow all S3 actions"
  policy      = file("s3_admin_policy.json.tmpl")
}

resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.devdan.name
  policy_arn = aws_iam_policy.s3_admin_policy.arn
}
