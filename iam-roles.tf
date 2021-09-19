resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
  description = "An EC2 policy for accessing rds, s3 and cloudwatch"
  policy      = file("ec2-policy.json")
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "ec2_policy_attach" {
  name       = "ec2_policy_attach"
  roles      = ["${aws_iam_role.ec2_role.name}"]
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "aws_ec2_profile" {
  name = "aws_ec2_profile"
  role = aws_iam_role.ec2_role.name
}