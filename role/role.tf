#Setting up internal variables

data "template_file" "default-s3-billing-bucket-policy" {
  template = "${file(default-s3-billing-bucket-policy.json)}"
  vars = {
    s3-billing-bucket = var.s3-billing-bucket
  }
}

data "template_file" "default-s3-cloudtrail-bucket-policy" {
  template = "${file(default-s3-cloudtrail-bucket-policy.json)}"
  vars = {
    s3-cloudtrail-bucket = var.s3-cloudtrail-bucket
  }
}

data "template_file" "default-s3-cur-bucket-policy" {
  template = "${file(default-s3-cur-bucket-policy.json)}"
  vars = {
    s3-cur-bucket = var.s3-cur-bucket
  }
}

data "template_file" "default-s3-config-bucket-policy" {
  template = "${file(default-s3-config-bucket-policy.json)}"

  vars = {
    s3-config-bucket = var.s3-config-bucket
  }
}

data "template_file" "default-s3-ecs-bucket-policy" {
  template = "${file(default-s3-ecs-bucket-policy.json)}"
  vars = {
    s3-ecs-bucket = var.s3-ecs-bucket
  }
}

resource "aws_iam_role" "cht_iam_role" {
  name = var.role-name
  path = "/"

  assume_role_policy = "${file(cht_iam_role.json)}"

}

resource "aws_iam_policy" "cht_iam_policy" {
  name = var.role-name

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
  role       = aws_iam_role.cht_iam_role.name
  policy_arn = aws_iam_policy.cht_iam_policy.arn
}
