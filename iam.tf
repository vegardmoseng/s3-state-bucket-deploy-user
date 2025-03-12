locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

resource "aws_iam_user" "state_bucket_deployer" {
  name = var.state_bucket_deployer_name
  path = "/"
}

resource "aws_iam_role" "state_bucket_deployer" {
  name                 = var.state_bucket_deployer_role_name
  max_session_duration = 28800

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${local.account_id}:user/${aws_iam_user.state_bucket_deployer.name}"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "state_bucket_deployer" {
  name = var.state_bucket_deployer_policy_name
  role = aws_iam_role.state_bucket_deployer.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1740573181520",
        "Action": [
          "s3:CreateBucket",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketLogging",
          "s3:GetBucketMetadataTableConfiguration",
          "s3:GetBucketNotification",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketOwnershipControls",
          "s3:GetBucketPolicy",
          "s3:GetBucketPolicyStatus",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketWebsite",
          "s3:GetAccelerateConfiguration",
          "s3:GetAccountPublicAccessBlock",
          "s3:GetAnalyticsConfiguration",
          "s3:GetDataAccess",
          "s3:GetEncryptionConfiguration",
          "s3:GetIntelligentTieringConfiguration",
          "s3:GetInventoryConfiguration",
          "s3:GetJobTagging",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:PutBucketAcl",
          "s3:PutBucketLogging",
          "s3:PutBucketPolicy",
          "s3:PutBucketTagging",
          "s3:PutBucketVersioning",
          "s3:PutBucketOwnershipControls",
          "s3:ListBucket",
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::vmosengcerts-dev-tf-state-bucket"
      },
      {
        "Sid": "Stmt1740573300547",
        "Action": [
          "dynamodb:CreateTable",
          # "dynamodb:ListTables",
          # "dynamodb:UpdateTable"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:dynamodb:${local.region}:${local.account_id}:table/${var.state_bucket_dynamodb_table_name}"
      }
    ]
  })
}