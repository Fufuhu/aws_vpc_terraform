output "vpc_id" {
  description = "VPCのIDです"
  value       = aws_vpc.vpc.id
}


output "vpc_name" {
  description = "作成したVPCの名前です"
  value       = local.vpc_tags["Name"]
}

output "public_subnets" {
  description = "パブリックサブネットの情報です"
  value       = {for subnet in aws_subnet.public_subnets : subnet.availability_zone => subnet.id}
}

output "private_subnets" {
  description = "プライベートサブネットの情報です"
  value       = {for subnet in aws_subnet.private_subnets : subnet.availability_zone => subnet.id}
}

output "public_route_tables" {
  description = "パブリックサブネットのルートテーブル情報です"
  value       = {for route_table in aws_route_table.public_route_tables : route_table.tags["AvailabilityZone"] => route_table.id}
}

output "private_route_tables" {
  description = "プライベートサブネットのルートテーブル情報です"
  value       = {for route_table in aws_route_table.private_route_tables : route_table.tags["AvailabilityZone"] => route_table.id}
}


output "default_resource_tags" {
  description = "各種リソースに付与されているデフォルトのタグです"
  value = local.default_resource_tags
}