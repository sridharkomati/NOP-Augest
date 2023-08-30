output "vpc_id" {

  value =aws_vpc.ntier.id
}


output "vpc_cidr_block" {

  value = var.ntier_vpc_info.vpc_cidr
}

output "subnet_ids" {

  value = compact(aws_subnet.subnets[*].cidr_block)
}


