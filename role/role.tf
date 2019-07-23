#Setting up internal variables

data "template_file" "default-s3-billing-bucket-policy" {
  template = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::$${s3-billing-bucket}", "arn:aws:s3:::$${s3-billing-bucket}/*" ]
        }
  POLICY

  vars {
    s3-billing-bucket = "${var.s3-billing-bucket}"
  }
}

data "template_file" "default-s3-cloudtrail-bucket-policy" {
  template = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::$${s3-cloudtrail-bucket}", "arn:aws:s3:::$${s3-cloudtrail-bucket}/*" ]
        }
  POLICY

  vars {
    s3-cloudtrail-bucket = "${var.s3-cloudtrail-bucket}"
  }
}

data "template_file" "default-s3-cur-bucket-policy" {
  template = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::$${s3-cur-bucket}", "arn:aws:s3:::$${s3-cur-bucket}/*" ]
        }
  POLICY

  vars {
    s3-cur-bucket = "${var.s3-cur-bucket}"
  }
}

data "template_file" "default-s3-config-bucket-policy" {
  template = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::$${s3-config-bucket}", "arn:aws:s3:::$${s3-config-bucket}/*" ]
        }
  POLICY

  vars {
    s3-config-bucket = "${var.s3-config-bucket}"
  }
}

data "template_file" "default-s3-ecs-bucket-policy" {
  template = <<POLICY
{
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [ "arn:aws:s3:::$${s3-ecs-bucket}", "arn:aws:s3:::$${s3-ecs-bucket}/*" ]
        }
  POLICY

  vars {
    s3-ecs-bucket = "${var.s3-ecs-bucket}"
  }
}

resource "aws_iam_role" "cht_iam_role" {
  name = "${var.role-name}"
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
  name = "${var.role-name}"

  policy = <<POLICY
{
  "Id": "cloudhealth-iam-policy",
  "Version": "2012-10-17",
  "Statement": [
    ${var.default-readonly-policy}
    ${var.s3-billing-bucket == "" ? "" : format(",%s", data.template_file.default-s3-billing-bucket-policy.rendered)}
    ${var.s3-cloudtrail-bucket == "" ? "" : format(",%s", data.template_file.default-s3-cloudtrail-bucket-policy.rendered)}
    ${var.s3-cur-bucket == "" ? "" : format(",%s", data.template_file.default-s3-cur-bucket-policy.rendered)}
    ${var.s3-config-bucket == "" ? "" : format(",%s", data.template_file.default-s3-config-bucket-policy.rendered)}
    ${var.s3-ecs-bucket == "" ? "" : format(",%s", data.template_file.default-s3-ecs-bucket-policy.rendered)}
    ${var.automated-ri-modification-enabled ? format(",%s", var.default-reservation-policy) : ""}
    ${var.automated-actions-enabled ? format(",%s", var.default-actions-policy) : ""}
    ${var.additional-policy == "" ? "" : format(",%s", var.additional-policy)}
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cht_aws_iam_role_policy_attachment" {
  role = "${aws_iam_role.cht_iam_role.name}"
  policy_arn = "${aws_iam_policy.cht_iam_policy.arn}"
}
