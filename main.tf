resource "aws_instance" "flipkart" {
  ami           = "ami-0ea3c35c5c3284d82"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.flipkart-sg.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Welcome to the flipkart flash sale" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  user_data_replace_on_change = true

  tags = {
    Name = "flipkart-server"
  }
}

resource "aws_security_group" "flipkart-sg" {
  name = "terraform-example-instance-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}