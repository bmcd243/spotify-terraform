terraform {
  required_providers {
    spotify = {
      source = "conradludgate/spotify"
      version = "0.2.7"
    }
  }
}


provider "aws" {
  region = "eu-west-2"
}

data "aws_secretsmanager_secret" "secrets" {
  name = "spotify-creds"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

locals {
    spotify_creds = jsondecode(
        data.aws_secretsmanager_secret_version.current.secret_string
        )
}

provider "spotify" {
  api_key = var.api_key
}