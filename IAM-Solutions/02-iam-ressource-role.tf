resource "aws_s3_bucket" "s3-demo" {
  bucket_prefix = "sw-test-"
}

resource "aws_iam_role" "s3-admin-role" {
  name               = "s3-admin-role"
  assume_role_policy = file("assume-role-policy.json")
}

resource "aws_iam_policy" "s3-admin-policy" {
  name        = "s3-admin-policy"
  description = "An s3 admin policy"
  policy = templatefile("policy-s3-admin.json", {
    bucket_name = aws_s3_bucket.s3-demo.id
  })
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "s3-policy-attachment"
  roles      = [aws_iam_role.s3-admin-role.name]
  policy_arn = aws_iam_policy.s3-admin-policy.arn
}

resource "aws_iam_instance_profile" "s3-admin-profile" {
  name = "s3-admin-profile"
  role = aws_iam_role.s3-admin-role.name
}

# EC2 Instance creation in eu-central-1
resource "aws_instance" "main" {
  ami                    = "ami-01d9d7f15bbea00b7"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.s3-admin-profile.name
  vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
  name        = "ssh"
  description = "ssh"
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.main.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.main.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

output "ip" {
  value = aws_instance.main.public_ip
}
