resource "aws_security_group" "web" {
  name = "web"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
      Name = "web"
    }
    vpc_id = aws_vpc.ntier.id
    depends_on = [
      aws_subnet.subnets
    ]
  }
  data "aws_ami_ids" "ubuntu_2204" {
    owners = ["656439170234"]
    filter {
      name   = "description"
      values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-02-08"]
    }
    filter {
      name   = "is-public"
      values = ["true"]
    }

  }

  data "aws_subnet" "web" {
    vpc_id = aws_vpc.ntier.id
    filter {
      name   = "tag:Name"
      values = [var.ntier_vpc_info.web_ec2_subnet]
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
      Name = "web2"
    }

  resource "aws_key_pair" "key-pair" {
  key_name   = "key-gen2"
  public_key = file("~/.ssh/id_rsa.pub")
}
 connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_instance.web.public_ip
  }
  provisioner "remote-exec" {
  scripts = ["kubectl.sh"]

  }
    depends_on = [
      aws_security_group.web
    ]

  }


