 terragrunt = {
  remote_state {
    backend = "s3"
    config {
                bucket = "techmanlabs"
      		key = "homelab/deployed.tfstate"
                region = "us-east-1"     encrypt = true
                dynamodb_table = "homelabterragruntstate"
    }
  }

  terraform {
    source = "../../modules//global/"
	extra_arguments "variable_file" {
        commands = [
          "apply",
          "plan",
          "destroy",
      ]

      arguments = [
        "-var-file=${get_tfvars_dir()}/terraform.tfvars",
        "-var-file=${get_tfvars_dir()}/global.tfvars",
        "-var-file=${get_tfvars_dir()}/credentials.tfvars"
      ]
    }
  }

}

