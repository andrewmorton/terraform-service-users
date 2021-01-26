####
# Variable declarations for project
####

# IAM credentials
variable "source_provider_assume_role_arn" {
  type = map
  description = "Configuration map for targeted resources"
}

variable "service_iam_users" {
  type = list
  description = "List of IAM user name to provision in the account"
}
