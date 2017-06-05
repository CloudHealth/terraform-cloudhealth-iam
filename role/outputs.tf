output "cloudhealth-role-policy" {
	value = "${aws_iam_policy.cht_iam_policy.policy}"
}

output "cloudhealth-role-arn" {
	value = "${aws_iam_role.cht_iam_role.arn}"
}

output "external-id" {
	value = "${var.external-id}"
}