provider "aws" {
  region = "us-east-1"
  version = "3.25.0"
  assume_role {
    target_arn = var.source_provider_assume_role_arn
  }
}
