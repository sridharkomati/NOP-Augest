variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Region to create resources"
}
variable "ntier_vpc_info" {
  type = object({
    vpc_cidr        = string,
    subnet_azs      = list(string),
    subnet_names    = list(string),
    private_subnets = list(string),
    public_subnets  = list(string),
    web_ec2_subnet  = string
  })
  default = {
    vpc_cidr        = "192.168.0.0/16"
    subnet_azs      = ["a", "b", "c", "a", "b", "c"]
    subnet_names    = ["web1", "web2", "app1", "app2", "db1", "db2"]
    private_subnets = ["app1", "app2", "db1", "db2"]
    public_subnets  = ["web1", "web2"]
    web_ec2_subnet      = "web2"
  }
}
