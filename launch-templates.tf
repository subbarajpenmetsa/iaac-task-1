resource "aws_key_pair" "tcs_server_key" {
  key_name   = "tcs_server_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfiDNxGlf4J5OBZ2skHJnt1TwrzPdJ91br/iakg5RfeQDN0ZmfWYJH3kv6mPc4VSJMIlFRE1CFp1paWqr4fOEQZlZaaf0KlaidTumj2i4IPyO3hBNHq0baTdDlBThQwM5WSv65u5QLGQ/jW5tQCOvucBMeS2zc6399sVOonj6ujOdy98xo0k7Ca2tRR1T/247ZlIKMsGzKxjwFy2KboPDmBU6szUMkmUwhTqnLCZZ4DiUU3rRnHTWqi8m1aViQTQYuEiRfHMmerDwYaAiXONqQRYstcuyvIB6odLrqccZvyYhVEm1i5nU/b7kQfj7nNi7q9+7BK+X6HV/bp8cv4O7kcLov25y/l5+3NdSalr8JFoxYR8x14SmYnAk6Muy/c/eMnVlCGrpatNgEejc4Nl+g/tPi0rxsujM4mwb000cXioIk9aqPhYgtspeAUf47M2CXE0ygVFhTY7owjcW92mpfXwvzas2VBGy5D8q3KOGMALyGr/EG6eTr8XkoAYEW07c= admin@example.com"
}

data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "web_tier_lt" {
  name = "web-tier-launch-template"

  image_id = data.aws_ami.amazon_linux_2.id

  instance_type = var.instance_type

  key_name = aws_key_pair.tcs_server_key.id

  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-server",
      Tier = "web"
    }
  }

  user_data = base64encode(file("./user-data.sh"))

}

resource "aws_launch_template" "app_tier_lt" {
  name = "app-tier-launch-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.aws_ec2_profile.name
  }

  image_id = data.aws_ami.amazon_linux_2.id

  instance_type = var.instance_type

  key_name = aws_key_pair.tcs_server_key.id

  vpc_security_group_ids = ["${aws_security_group.app_sg.id}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-server",
      Tier = "app"
    }
  }

  user_data = base64encode(file("./user-data.sh"))

}