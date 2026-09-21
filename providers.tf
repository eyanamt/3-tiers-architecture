terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Décommentez et adaptez si vous voulez un state distant (recommandé en prod)
  # backend "s3" {
  #   bucket         = "mon-bucket-terraform-state"
  #   key            = "3-tier/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment_name
      ManagedBy   = "terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

data "aws_ssm_parameter" "al2023_ami" {
  name = var.web_ami_ssm_parameter
}
