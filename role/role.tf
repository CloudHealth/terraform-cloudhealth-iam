#Setting up internal variables

locals {
  default-s3-billing-bucket-policy = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::${var.s3-billing-bucket}", "arn:aws:s3:::${var.s3-billing-bucket}/*" ]
        }
  POLICY

  default-s3-cloudtrail-bucket-policy = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::${var.s3-cloudtrail-bucket}", "arn:aws:s3:::${var.s3-cloudtrail-bucket}/*" ]
        }
  POLICY

  default-s3-cur-bucket-policy = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::${var.s3-cur-bucket}", "arn:aws:s3:::${var.s3-cur-bucket}/*" ]
        }
  POLICY

  default-s3-config-bucket-policy = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::${var.s3-config-bucket}", "arn:aws:s3:::${var.s3-config-bucket}/*" ]
        }
  POLICY

  default-s3-ecs-bucket-policy = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::${var.s3-ecs-bucket}", "arn:aws:s3:::${var.s3-ecs-bucket}/*" ]
        }
  POLICY
}

resource "aws_iam_role" "cht_iam_role" {
  name = var.role-name
  path = "/"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "${var.external-id}"
                }
            },
            "Principal": {
                "AWS": "arn:aws:iam::454464851268:root"
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "cht_iam_policy" {
  name = var.role-name

  policy = <<POLICY
{
  "Id": "cloudhealth-iam-policy",
  "Version": "2012-10-17",
  "Statement": [
    ${var.default-readonly-policy}
    ${var.s3-billing-bucket == "" ? "" : format(",%s", local.default-s3-billing-bucket-policy)}
    ${var.s3-cloudtrail-bucket == "" ? "" : format(",%s", local.default-s3-cloudtrail-bucket-policy)}
    ${var.s3-cur-bucket == "" ? "" : format(",%s", local.default-s3-cur-bucket-policy)}
    ${var.s3-config-bucket == "" ? "" : format(",%s", local.default-s3-config-bucket-policy)}
    ${var.s3-ecs-bucket == "" ? "" : format(",%s", local.default-s3-ecs-bucket-policy)}
    ${var.automated-ri-modification-enabled ? format(",%s", var.default-reservation-policy) : ""}
    ${var.automated-actions-enabled ? format(",%s", var.default-actions-policy) : ""}
    ${var.additional-policy == "" ? "" : format(",%s", var.additional-policy)}
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cht_aws_iam_role_policy_attachment" {
  role       = aws_iam_role.cht_iam_role.name
  policy_arn = aws_iam_policy.cht_iam_policy.arn
}
