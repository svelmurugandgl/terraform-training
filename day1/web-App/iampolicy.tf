resource "aws_iam_role_policy" "application_policy" {
  name   = "application_policy-${random_string.random_name.result}"
  role   = aws_iam_role.application_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
