resource "aws_iam_user" "state_bucket_deployer" {
  name = var.state_bucket_deployer_name
  path = "/"
}

resource "aws_iam_role" "state_bucket_deployer" {
  name = var.state_bucket_deployer_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.state_bucket_deployer.name}"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "state_bucket_deployer" {
  name = var.state_bucket_deployer_policy_name
  role = aws_iam_role.state_bucket_deployer.id

  policy = file("policy-documents/s3-state-bucket-deployer.json")
}