resource_configuration_metadata = {
  "dynamodb" = {
    "main_table" = {
      "description" = {
        "name" = "recipes_dynamo_db_main"
      }
      "attributes" = {
        "UUID" = "S"
        "Service" = "S"
      }
      "iops" = {
        "read_capacity" = 1
        "write_capacity" = 1
      }
    }
  }
}

source_provider_assume_role_arn = "" #TODO: create an assume role ARN for terraform in personal account