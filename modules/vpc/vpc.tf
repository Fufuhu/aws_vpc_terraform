
locals {
  vpc_tags = merge(
  var.vpc_additional_tags
  ,
  {
    Name = "${var.service_name}-${var.env}-vpc"
    Env  = var.env
    ServiceName = var.service_name
  }
  )
}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags       = local.vpc_tags
}