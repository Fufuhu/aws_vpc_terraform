# aws_vpc_terraform
AWSのVPCを作成するためのTerraformモジュールコードです

## 使い方

現時点ではTerraform Registryで公開はしていないので、
[Module Sources#GitHub](https://www.terraform.io/language/modules/sources#github)を参考に利用してください。

特定のタグを利用する場合などは、
[Module Sources#Selecting a Revision](https://www.terraform.io/language/modules/sources#selecting-a-revision)
などを参照すると良いでしょう。

呼び出しのサンプルは以下のとおりです。

```hcl
module "vpc" {
  source = "./modules/vpc"
  service_name = "sample"
  env          = terraform.workspace
  vpc_cidr_block = "10.0.0.0/16"
  vpc_additional_tags = {
    Usage = "blog writing"
  }
  subnet_cidrs = {
    public = [
      "10.0.0.0/24",
      "10.0.1.0/24",
      "10.0.2.0/24"
    ]
    private = [
      "10.0.3.0/24",
      "10.0.4.0/24",
      "10.0.5.0/24"
    ]
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

```