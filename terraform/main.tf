# Ec 2 for kafka
resource "aws_instance" "my-tf-server" {
  ami = "ami-0bd4d695347c0ef88"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vu-sg.id]
  user_data = file("user_data.sh")
  tags = {
    Name= "kafka"
  }
}

# Security Group
resource "aws_security_group" "vu-sg" {
  name = "tf-security"
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}