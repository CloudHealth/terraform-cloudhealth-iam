variable "role-name" {
  default = "CloudHealth-IAM-Role"
}

variable "external-id" {
  default = ""
}

variable "s3-billing-bucket" {
  default = ""
}

variable "s3-cloudtrail-bucket" {
  default = ""
}

variable "s3-cur-bucket" {
  default = ""
}

variable "s3-config-bucket" {
  default = ""
}

variable "s3-ecs-bucket" {
  default = ""
}

variable "automated-ri-modification-enabled" {
  default = false
}

variable "automated-actions-enabled" {
  default = false
}

variable "additional-policy" {
  default = ""
}

variable "default-readonly-policy" {
  default = <<POLICY
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:Describe*",
        "cloudformation:ListStacks",
        "cloudformation:ListStackResources",
        "cloudformation:DescribeStacks",
        "cloudformation:DescribeStackEvents",
        "cloudformation:DescribeStackResources",
        "cloudformation:GetTemplate",
        "cloudfront:Get*",
        "cloudfront:List*",
        "cloudtrail:DescribeTrails",
        "cloudtrail:GetEventSelectors",
        "cloudtrail:ListTags",
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "config:Get*",
        "config:Describe*",
        "config:Deliver*",
        "config:List*",
        "cur:Describe*",
        "dms:Describe*",
        "dms:List*",
        "dynamodb:DescribeTable",
        "dynamodb:List*",
        "ec2:Describe*",
        "ec2:GetReservedInstancesExchangeQuote",
        "ecs:List*",
        "ecs:Describe*",
        "elasticache:Describe*",
        "elasticache:ListTagsForResource",
        "elasticbeanstalk:Check*",
        "elasticbeanstalk:Describe*",
        "elasticbeanstalk:List*",
        "elasticbeanstalk:RequestEnvironmentInfo",
        "elasticbeanstalk:RetrieveEnvironmentInfo",
        "elasticfilesystem:Describe*",
        "elasticloadbalancing:Describe*",
        "elasticmapreduce:Describe*",
        "elasticmapreduce:List*",
        "es:List*",
        "es:Describe*",
        "firehose:ListDeliveryStreams",
        "firehose:DescribeDeliveryStream",
        "iam:List*",
        "iam:Get*",
        "iam:SimulateCustomPolicy",
        "iam:GenerateCredentialReport",
        "kinesis:Describe*",
        "kinesis:List*",
        "kms:DescribeKey",
        "kms:GetKeyRotationStatus",
        "kms:ListKeys",
        "lambda:List*",
        "logs:Describe*",
        "organizations:ListAccounts",
        "organizations:ListTagsForResource",
        "organizations:DescribeOrganization",
        "redshift:Describe*",
        "route53:Get*",
        "route53:List*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "s3:GetAccountPublicAccessBlock",
        "s3:GetBucketPublicAccessBlock",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation",
        "s3:GetBucketLogging",
        "s3:GetBucketPolicy",
        "s3:GetBucketPolicyStatus",
        "s3:GetBucketTagging",
        "s3:GetBucketVersioning",
        "s3:GetBucketWebsite",
        "s3:List*",
        "sagemaker:Describe*",
        "sagemaker:List*",
        "savingsplans:DescribeSavingsPlans",
        "sdb:GetAttributes",
        "sdb:List*",
        "ses:Get*",
        "ses:List*",
        "sns:Get*",
        "sns:List*",
        "sqs:GetQueueAttributes",
        "sqs:ListQueues",
        "storagegateway:List*",
        "storagegateway:Describe*",
        "workspaces:Describe*"
      ],
      "Resource": "*"
    }
  POLICY
}

variable "default-reservation-policy" {
  default = <<POLICY
    {
      "Effect": "Allow",
      "Action": [
        "ec2:ModifyReservedInstances"
      ],
      "Resource": "*"
    }
  POLICY
}

variable "default-actions-policy" {
  default = <<POLICY
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:TerminateInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:RebootInstances",
        "lambda:InvokeFunction",
        "ec2:ReleaseAddress"
      ],
      "Resource": "*"
    }
  POLICY
}
