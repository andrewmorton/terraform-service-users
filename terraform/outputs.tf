locals {
  service_role_arns = [
  # aws_iam_role.home_account_tf_service_role.arn
    "arn::test::arn/user"
  ]
}

output "iam_group_policy_template" {
  value = templatefile("tf-templates/iam_group_policy_template.tmpl", {
   service_roles_allowed: local.service_role_arns
  } )
}