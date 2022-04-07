data "aws_availability_zones" "availability_zones" {
  state = "available"

  # すでにobsoleteになっているap-northeast-1bを除外
  exclude_names = [
    "ap-northeast-1b"
  ]
}

locals {
  # 利用可能かつ除外されていないなアベイラビリティゾーンの数
  number_of_availability_zones = length(data.aws_availability_zones.availability_zones.names)
}