provider "aws" {

    access_key = "**************"
    secret_key = "*********"
    region     = "ap-south-1"


}

# desire state
resource "aws_instance" "My_web_os1" {
    ami = "ami-0a1235697f4afa8a4"
    instance_type = "t2.micro"

    tags = {
        Name = "myos1"
        Team = "dev"
    }

}


# current state : live
output "o1" {
  value = aws_instance.My_web_os1.public_ip

}
