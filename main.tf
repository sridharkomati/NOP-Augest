## creating vpc
resource "aws_vpc" "sri" {

    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "my-vpc"
    }
}

resource "aws_subnet" "sri_sub" {
   cidr_block = "10.0.0.0/24"
   vpc_id = aws_vpc.sri.id 
   tags = {
    Name = "my-subnet"
    }

}