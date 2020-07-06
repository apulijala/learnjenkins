provider "aws" {
  region = "eu-west-2"
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}


resource "aws_ebs_volume" "jenkins-volume" {
  availability_zone = "eu-west-2a"
  size              = var.volume_size

  tags = {
    Name = var.volume_name
  }
}

data "template_file" "init" {
  template = "${file("${path.module}/install_jenkins.sh")}"
  vars = {
   volsize = var.volume_size
   force_detach = true
  }
  
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.jenkins-volume.id
  instance_id = aws_instance.web.id
  skip_destroy = true # necessary if volume needs to be deatached.
}


resource "aws_instance" "web" {
   
   ami = "ami-032598fcc7e9d1c7a"
   depends_on = [aws_ebs_volume.jenkins-volume]
   instance_type = "t2.micro"
   availability_zone = "eu-west-2a"
   vpc_security_group_ids = [aws_security_group.allow_tls.id]
   key_name = "awsinaction"
   associate_public_ip_address = true
   user_data = data.template_file.init.rendered
   tags = {
     Name = var.machine_name
   }
}
