locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "https://github.com/kmichael-devops/terraform_aws_modules.git//terraform_aws_ec2_instance?ref=v0.0.1"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name           = "ec2_testing_terraform_code"
  instance_count = 1

  ami                    = "ami-06b263d6ceff0b3dd"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-07c7a07ee8b4238e1"]
  subnet_id              = "subnet-056133ad47ef8e2f6"
}

# dependencies {
#   paths = ["../terraform_aws_vpc_network"]
# }
