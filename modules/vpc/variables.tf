variable "vpc_cidr_block" {
  description = "VPCに割り当てるCIDRブロックを記述します"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}", var.vpc_cidr_block))
    error_message = "Specify VPC CIDR block with the CIDR format."
  }
}

variable "service_name" {
  description = "VPCを利用するサービス名"
  type        = string
}

variable "service_suffix" {
  description = "VPCを利用するサービス名のサフィックス(サブサービス名、コンポーネント名などを含める)"
  type        = string
  default     = ""
}

variable "env" {
  description = "環境識別子（dev, stg, prod）"
  type        = string
}

variable "vpc_additional_tags" {
  description = "VPCに付与したい追加タグ"
  type        = map(string)
  default     = {}
  validation {
    condition     = length(setintersection(keys(var.vpc_additional_tags), ["Name", "Env", "ServiceName"])) == 0
    error_message = "Key names, Name and Env, ServiceName is reserved. Not allowed to use them."
  }
}

variable "subnet_cidrs" {
  description = "サブネット毎のCIDR指定"
  type        = object({
    public  = list(string)
    private = list(string)
  })

  # CIDRフォーマットのバリデーション
  validation {
    condition = length(setintersection([
    for cidr in var.subnet_cidrs.public : (can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", cidr)) ? cidr : null)
    ], var.subnet_cidrs.public)) == length(var.subnet_cidrs.public)
    error_message = "Specify VPC Public Subnet CIDR block with the CIDR format."
  }


  validation {
    condition = length(setintersection([
    for cidr in var.subnet_cidrs.private : (can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", cidr)) ? cidr : null)
    ], var.subnet_cidrs.private)) == length(var.subnet_cidrs.private)
    error_message = "Specify VPC Private Subnet CIDR block with the CIDR format."
  }

  # 可用性的な観点でのバリデーション
  validation {
    condition     = length(var.subnet_cidrs.public) >= 2
    error_message = "For availability, set more than or equal to 2 public subnet cidrs."
  }

  validation {
    condition     = length(var.subnet_cidrs.private) >= 2
    error_message = "For availability, set more than or equal to 2 public subnet cidrs."
  }

  # publicとprivateの配列長が同じことを確認するバリデーション
  validation {
    condition     = length(var.subnet_cidrs.public) == length(var.subnet_cidrs.private)
    error_message = "Redundancy of public subnet and private subnet must be same."
  }
}

variable "subnet_additional_tags" {
  description = "サブネットに付与したい追加タグ(Name, Env, AvailabilityZone, Scope 除く)"
  type        = map(string)
  default     = {}
  validation {
    condition     = length(setintersection(keys(var.subnet_additional_tags), ["Name", "Env", "AvailabilityZone", "Scope", "ServiceName"])) == 0
    error_message = "Key names, Name and Env, AvailabilityZone, Scope, ServiceName are reserved. Not allowed to use them."
  }
}

variable "igw_additional_tags" {
  description = "インターネットゲートウェイに付与したい追加タグ(Name, Env, VpcId 除く)"
  type        = map(string)
  default     = {}
  validation {
    condition     = length(setintersection(keys(var.igw_additional_tags), ["Name", "Env", "VpcId", "ServiceName"])) == 0
    error_message = "Key names, Name and Env, VpcId, ServiceName are reserved. Not allowed to use them."
  }
}

variable "nat_gateway_redundancy_enabled" {
  description = "NATゲートウェイの冗長性の有効化"
  type        = bool
  default     = true
}

locals {
  default_resource_tags = var.service_suffix == "" ? {
    ServiceName   = var.service_name
    Env           = var.env
  } : {
    ServiceName   = var.service_name
    ServiceSuffix = var.service_suffix
    Env           = var.env
  }
}