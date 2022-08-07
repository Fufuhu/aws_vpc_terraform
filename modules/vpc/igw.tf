resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(
    var.igw_additional_tags,
    {
      Name          = "${var.service_name}-${var.env}-igw"
      VpcId         = aws_vpc.vpc.id
    },
    local.default_resource_tags
  )
}