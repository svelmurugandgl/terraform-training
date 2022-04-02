resource "aws_iam_role_policy" "application_policy" {
  depends_on = [
    aws_iam_role.application_role
  ]
  name   = "application_policy-${random_string.tftraining.result}"
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
