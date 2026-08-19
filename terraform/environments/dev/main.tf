terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region

  default_tags {
    tags = local.tags
  }
}

locals {
  name = "basalt-${var.environment}"
  tags = {
    Application = "basalt"
    Environment = var.environment
    ManagedBy   = "terraform"
    Repository  = "kingsokafor777-droid/basalt-platform"
  }
}

module "network" {
  source             = "../../modules/network"
  name               = local.name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  tags               = local.tags
}

module "artifacts" {
  source = "../../modules/artifact-store"
  name   = var.artifact_bucket_name
  tags   = local.tags
}

module "eks" {
  source              = "../../modules/eks"
  name                = local.name
  private_subnet_ids  = module.network.private_subnet_ids
  kubernetes_version  = var.kubernetes_version
  node_instance_types = var.node_instance_types
  tags                = local.tags
}

module "github_oidc" {
  source              = "../../modules/github-oidc"
  name                = local.name
  github_subjects     = var.github_subjects
  artifact_bucket_arn = module.artifacts.bucket_arn
  tags                = local.tags
}
