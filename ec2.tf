resource "aws_instance" "inst-1" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.inst-security-grp-rule.id]
    subnet_id = aws_subnet.inst-public-subnet1.id
    availability_zone = var.availability_zone["a"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/mini-project/lookup.pem")
    }

    tags = {
      Name = "inst-1"
      source = "terraform"
    }

}

resource "aws_instance" "inst-2" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.inst-security-grp-rule.id]
    subnet_id = aws_subnet.inst-public-subnet2.id
    availability_zone = var.availability_zone["b"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/mini-project/lookup.pem")
    }

    tags = {
      Name = "inst-2"
      source = "terraform"
    }

}

resource "aws_instance" "inst-3" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key_pair
    security_groups = [aws_security_group.inst-security-grp-rule.id]
    subnet_id = aws_subnet.inst-public-subnet1.id
    availability_zone = var.availability_zone["a"]

    connection {
      type = "ssh"
      host = "self.public_ip"
      user = "ubuntu"
      private_key = file("/root/.mini-project/lookup.pem")
    }

    tags = {
      Name = "inst-3"
      source = "terraform"
    }
}

resource "local_file" "Ip_address" {
    filename = "/root/mini-project/ansible-playbook/host-inventory"
    content = <<EOT
    ${aws_instance.inst-1.public_ip}
    ${aws_instance.inst-2.public_ip}
    ${aws_instance.inst-3.public_ip}
     EOT
}
