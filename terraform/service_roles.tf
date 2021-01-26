locals {
 home_service_role_permissions = [
  ""
 ]
}

resource aws_iam_role "home_account_tf_service_role" {
 assume_role_policy = templatefile("${path.module}/tf-templates/service_roles_assume_role_policy.tmpl", {
  users_allowed: aws_iam_user.iam_service_users[*].arn
 })
}

resource aws_iam_policy "home_account_tf_service_role_permissions" {
 name = "home-account-tf-service-role-policy"
 policy = templatefile("${path.module}/tf-templates/service_role_permissions_policy", {
  allowed_permissions: local.home_service_role_permissions
 })
}