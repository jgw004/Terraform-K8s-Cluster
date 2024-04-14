provider "kubernetes" {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
    region = var.region
}
###

data "aws_availability_zones" "available" {}
###

locals {
    cluster_name = "eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
    length  = 8
    special = false
}
###

locals {
    cluster_logging = var.enable_logging ? 1 : 0
}

resource "enable_cluster_logging" "log" {
    depends_on = [local.cluster_logging]

    enabled_cluster_log_types = ["api", "audit"]
    name                      = local.cluster_name
}
#############

#resource "aws_cloudwatch_log_group" "cloudwatch" {
    ## This naming is AWS format \
    ## https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
#    name           = "/aws/eks/${local.cluster_name}/cluster"
#    retention_days = 7
#}