CloudHealth Technologies Terraform module for CloudHealth IAM Role AWS account provisioning.
==================
This module manages installation of CloudHealth IAM Role in your AWS account.


Inputs
----------
<table>
  <tr>
    <th>Variable</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>external-id</tt></td>
    <td>String</td>
    <td>IAM Role External ID assigned in CloudHealth platform</td>
  </tr>
  <tr>
    <td><tt>s3-billing-bucket</tt></td>
    <td>String</td>
    <td>S3 bucket location for consolidated accounts billing data (optional)</td>
  </tr>
  <tr>
    <td><tt>s3-cur-bucket</tt></td>
    <td>String</td>
    <td>S3 bucket location for consolidated accounts cost and usage data (optional)</td>
  </tr>
  <tr>
    <td><tt>s3-cloudtrail-bucket</tt></td>
    <td>String</td>
    <td>S3 bucket location for Cloudtrail data (optional)</td>
  </tr>
  <tr>
    <td><tt>s3-config-bucket</tt></td>
    <td>String</td>
    <td>S3 bucket location for AWS Config data (optional)</td>
  </tr>
  <tr>
    <td><tt>s3-ecs-bucket</tt></td>
    <td>String</td>
    <td>S3 bucket location for Elastic Container Service event stream data (optional)</td>
  </tr>
  <tr>
    <td><tt>automated-ri-modification-enabled</tt></td>
    <td>Boolean</td>
    <td>Additional permissions for enabling automated RI modification (default: false)</td>
  </tr>
  <tr>
    <td><tt>automated-actions-enabled</tt></td>
    <td>Boolean</td>
    <td>Additional permissions for enabling automated actions (default: false)</td>
  </tr>
  <tr>
    <td><tt>additional-policy</tt></td>
    <td>String</td>
    <td>Additional policy to associate with IAM Role (optional)</td>
  </tr>
</table>

Outputs
----------
<table>
  <tr>
    <th>Variable</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>cloudhealth-role-arn</tt></td>
    <td>String</td>
    <td>IAM Role ARN created by the module</td>
  </tr>
  <tr>
    <td><tt>external-id</tt></td>
    <td>String</td>
    <td>IAM Role External ID assigned in CloudHealth platform</td>
  </tr>
  <tr>
    <td><tt>cloudhealth-policy-arn</tt></td>
    <td>String</td>
    <td>IAM Policy ARN created by the module</td>
  </tr>
</table>

Usage
-----
Obtain your External ID from the CloudHealth platform under new AWS account setup page.

Define invocation of TF module

```
module "cloudhealth-iam-role" {
    source  = "github.com/CloudHealth/terraform-cloudhealth-iam/role"
    external-id = "1234567890abcdefg"
    s3-billing-bucket = "billing-bucket"
    s3-cloudtrail-bucket = "cloudtrail-bucket"
    automated-ri-modification-enabled = true
    automated-actions-enabled = true
    additional-policy = <<POLICY
{
   "Action": [
     "ec2:CreateTags"
   ],
   "Effect": "Allow",
   "Resource": "*"
}
POLICY
}
```

**NOTE:** You can pin a specific Git tagged version of this module using this notation. Here we're pinning to the tag, 0.0.16:
```
    source  = "git::https://github.com/CloudHealth/terraform-cloudhealth-iam.git//role?ref=tags/0.0.16"
```

Run terraform plan and apply
```bash
terraform plan -target=module.cloudhealth-iam-role
terraform apply -target=module.cloudhealth-iam-role
```

Get created ARN and External ID to use in CHT portal
```bash
terraform output -module=cloudhealth-iam-role
```

Requirements
------------
terraform-cloudhealth-iam >= v0.1.0 - Requires Terraform >= 0.12
terraform-cloudhealth-iam <= v0.0.18 - Requires Terraform <= 0.11

License and Authors
-------------------
Authors: CloudHealth Team GSD (devops@cloudhealthtech.com)
