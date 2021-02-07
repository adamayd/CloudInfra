variable "http_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

output "public_ip" {
  value       = aws_instance.webserver_app.public_ip
  description = "The public IP address of the web server"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "webserver_app" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p ${var.http_port} &
              EOF


  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "webserver_sg" {
  name = "webserver_sg"

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

