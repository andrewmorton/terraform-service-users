locals {
  service_role_arns = [
  aws_iam_role.home_account_tf_service_role.arn
  ]
}

# Create listed iam users within target account
resource aws_iam_user "iam_service_users" {
  for_each = toset(var.service_iam_users)
  name = each.value
}

resource aws_iam_user_policy_attachment "s3_policy_attachment" {
  for_each = aws_iam_user.iam_service_users
  user = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource aws_iam_group "service_users_group"{
  name = "candyland-service-users"
}

resource aws_iam_group_membership "adding_service_users" {
  name = "candyland_group_membership"
  group = aws_iam_group.service_users_group.name
  users = [
    for user in aws_iam_user.iam_service_users:
          user.name
  ]
}

resource aws_iam_policy "service_users_group_policy" {
  name = "service-users-group-policy"
  policy = templatefile("${path.module}/tf-templates/iam_group_policy_template.tmpl", {
    service_roles_allowed: local.service_role_arns
  })
}

resource aws_iam_group_policy_attachment "service_group_policy_attachment" {
  group = aws_iam_group.service_users_group.name
  policy_arn = aws_iam_policy.service_users_group_policy.arn
}