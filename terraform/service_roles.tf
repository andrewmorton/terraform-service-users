locals {

 home_service_role_permissions = [
  "autoscaling:*",
  "ec2:*",
  "vpc:*",
  "lambda:*",
  "cloudwatch:*",
  "s3:*",
  "dynamodb:*",
  "route53:*",
  "sqs:*",
  "sns:*",
  "eks:*",
  "rds:*",
  "iam:*"
  ]

  allowed_service_users = [
  for user in aws_iam_user.iam_service_users:
  user.arn
  ]

}

resource aws_iam_role "home_account_tf_service_role" {
 name = "candyland-service-role"
 assume_role_policy = templatefile("${path.module}/tf-templates/service_roles_assume_role_policy.tmpl", {
  users_allowed: local.allowed_service_users
 })
}

resource aws_iam_policy "home_account_tf_service_role_permissions" {
 name = "home-account-tf-service-role-policy"
 policy = templatefile("${path.module}/tf-templates/service_role_permissions_policy.tmpl", {
  allowed_permissions: local.home_service_role_permissions
 })
}

resource aws_iam_role_policy_attachment "home_account_tf_policy_attachment" {
 role = aws_iam_role.home_account_tf_service_role.name
 policy_arn = aws_iam_policy.home_account_tf_service_role_permissions.arn
}
