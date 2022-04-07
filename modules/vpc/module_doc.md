## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.eips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateways](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_default_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_tables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_table_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.availability_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境識別子（dev, stg, prod） | `string` | n/a | yes |
| <a name="input_igw_additional_tags"></a> [igw\_additional\_tags](#input\_igw\_additional\_tags) | インターネットゲートウェイに付与したい追加タグ(Name, Env, VpcId 除く) | `map(string)` | `{}` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | VPCを利用するサービス名 | `string` | n/a | yes |
| <a name="input_subnet_additional_tags"></a> [subnet\_additional\_tags](#input\_subnet\_additional\_tags) | サブネットに付与したい追加タグ(Name, Env, AvailabilityZone, Scope 除く) | `map(string)` | `{}` | no |
| <a name="input_subnet_cidrs"></a> [subnet\_cidrs](#input\_subnet\_cidrs) | サブネット毎のCIDR指定 | <pre>object({<br>    public = list(string)<br>    private = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_vpc_additional_tags"></a> [vpc\_additional\_tags](#input\_vpc\_additional\_tags) | VPCに付与したい追加タグ | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPCに割り当てるCIDRブロックを記述します | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_route_tables"></a> [private\_route\_tables](#output\_private\_route\_tables) | プライベートサブネットのルートテーブル情報です |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | プライベートサブネットの情報です |
| <a name="output_public_route_tables"></a> [public\_route\_tables](#output\_public\_route\_tables) | パブリックサブネットのルートテーブル情報です |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | パブリックサブネットの情報です |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPCのIDです |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | 作成したVPCの名前です |
