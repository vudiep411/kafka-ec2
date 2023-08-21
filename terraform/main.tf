# Ec 2 for kafka
resource "aws_instance" "my-tf-server" {
  ami = "ami-0bd4d695347c0ef88"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vu-sg.id]
  user_data = data.template_file.user_data.rendered
  tags = {
    Name= "kafka"
  }
}

# User Data
data "template_file" "user_data" {
    template = file("${path.module}/user_data.sh")
}


# Security Group
resource "aws_security_group" "vu-sg" {
  name = "kafka-security"
  ingress {
    from_port   = 0
    to_port     = 0
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