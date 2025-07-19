provider "aws" {
	region = "ap-south-1"
}

resource "aws_instance" "myweb" {
  ami = "ami-0a1235697f4afa8a4"
  instance_type = "t2.micro"
  key_name = "LW-Projects"
  security_groups = ["LW_Projects"]

  tags = {
      Name = "My_WebServer"
  }
}

resource "aws_ebs_volume" "ebs1" {
  size = 2
  availability_zone = aws_instance.myweb.availability_zone
  tags = {
    Name = "My Web Server Extera Volume"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs1.id
  instance_id = aws_instance.myweb.id
}

resource "null_resource" "remort_login" {
  provisioner "remote-exec" {
    inline = [#✅Force format to avoid mount errors
              "sudo mkfs.xfs -f /dev/xvdh",

              # ✅Install Apache
              "sudo yum install httpd -y",

               # ✅Mount volume to HTML directory
              "sudo mount /dev/xvdh  /var/www/html",
              "sudo sh -c \"echo 'Welcome To my Webpage created using Terraform' > /var/www/html/index.html\" ",
              "sudo systemctl restart httpd"
     ]
  }

  connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("c:/Users/hp/LW-Projects.pem")
      host     = aws_instance.myweb.public_ip
  }
}

resource "null_resource" "local_access" {
  provisioner "local_exec" {
      command = "chrome http://${aws_instance.myweb.public_ip}/"
  }
}

output "o1" {
  value = aws_instance.myweb.region
}

output "o2" {
  value = aws_instance.myweb.availability_zone
}

output "o3" {
 value = aws_ebs_volume.ebs1.id
}

output "o4" {
  value = aws_instance.myweb.id
}
output "o5" {
  value = aws_instance.myweb.public_ip
}
