resource "aws_security_group" "web" {
  name = "web"
  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    cidr_blocks = [local.anywhere]
    protocol    = local.tcp

  }
  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    cidr_blocks = [local.anywhere]
    protocol    = local.tcp

  }
  tags = {
    Name = "web"
  }
  vpc_id = local.vpc_id

  depends_on = [
    aws_subnet.subnets
  ]
}

data "aws_ami_ids" "ubuntu_2204" {
  owners = ["656439170234"]
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-03-25"]
  }
  filter {
    name   = "is-public"
    values = ["true"]
  }

}


data "aws_subnet" "web" {
  vpc_id = local.vpc_id
  filter {
    name   = "tag:Name"
    values = [var.ntier_vpc_info.web_ec2_subnet]

  }
   filter {
    name   = "vpc-id"
    values = [aws_vpc.ntier.id]
   }

  depends_on = [
    aws_subnet.subnets
  ]
}

resource "aws_instance" "web" {
  ami                         = "ami-051f7e7f6c2f40dc1"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnet.web.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  tags = {
    Name = "web1"
  }


  depends_on = [
     aws_security_group.web
  ]

}