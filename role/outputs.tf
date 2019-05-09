output "cloudhealth-role-arn" {
  value = "${var.gov_cloud ? join("",aws_iam_user.cht_iam_user_govcloud.*.arn) : join("",aws_iam_role.cht_iam_role.*.arn)}"
}

output "external-id" {
  value = "${var.external-id}"
}

output "cloudhealth-policy-arn" {
  value = "${var.gov_cloud ? join("",aws_iam_policy.cht_iam_policy_govcloud.*.arn) : join("", aws_iam_policy.cht_iam_policy.*.arn)}"
}
