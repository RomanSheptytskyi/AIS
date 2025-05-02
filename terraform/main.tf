provider "aws" {
  region = var.region
}

resource "aws_instance" "roman" {
  count         = 2
  ami           = lookup(var.ec2_ami, var.region)
  instance_type = var.instance_type

  tags = {
    Name = "roman-${count.index + 1}"
  }
}

resource "local_file" "tf_ip" {
  content  = "[ALL]\n${aws_instance.roman[0].public_ip} ansible_ssh_user=ubuntu"
  filename = "${path.module}/inventory"
}
