provider "vault" {
  address = var.vault_addr
  auth_login {
    path = "auth/waynerferreira/login"
    parameters = {
      token = var.vault_token
    }
  }
}

data "vault_aws_access_credentials" "creds" {
  type    = "sts"
  backend = "waynerferreira"
  role    = var.environment == "prod" ? "queima-adm" : format("queima-adm-%s", var.environment)
}

provider "aws" {
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  token      = data.vault_aws_access_credentials.creds.security_token
  region     = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">=2.20.0"
    }
  }
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "waynerferreira"
    workspaces {
      prefix = "qd-ecs-infra-b-"
    }
  }
}
data "aws_caller_identity" "current" {}

data "terraform_remote_state" "bastion" {
  backend = "remote"

  config = {
    organization = "waynerferreira"
    workspaces = {
      name = format("bastion-infra-%s", var.environment)
    }
  }
}


data "terraform_remote_state" "base_infra" {
  backend = "remote"

  config = {
    organization = "waynerferreira"
    workspaces = {
      name = format("base-infra-%s", var.environment)
    }
  }
}

data "terraform_remote_state" "vault_consul" {
  backend = "remote"
  config = {
    organization = "waynerferreira"
    workspaces = {
      name = format("consul-vault-%s", var.environment)
    }
  }
}