data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.tpl")}"
}

data "aws_ami" "latest_student_image" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ansible_student_vm" {
  ami                  = data.aws_ami.latest_student_image.id
  instance_type        = "t2.small"
  user_data            = data.template_file.user_data.rendered
  key_name             = var.key_pair

  network_interface {
    network_interface_id = aws_network_interface.ansible_student_vm_mgmt.id
    device_index         = 0
  }

  tags = merge(map("Name", "${var.name_prefix}-ansible_student_vm"), var.default_tags)
}

resource "aws_eip" "ansible_student_vm_mgmt" {
  vpc        = true
  network_interface         = aws_network_interface.ansible_student_vm_mgmt.id
  associate_with_private_ip = var.mgmt_private_ip

  tags = merge(map("Name", "${var.name_prefix}-ansible_student_vm_mgmt"), var.default_tags)

  depends_on = [aws_instance.ansible_student_vm]
}

resource "aws_network_interface" "ansible_student_vm_mgmt" {
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.ansible_student_vm.id]
  private_ips                 = [var.mgmt_private_ip]

  tags = merge(map("Name", "${var.name_prefix}-ansible_student_vm_mgmt"), var.default_tags)
}

data "aws_network_interface" "ansible_student_vm_mgmt" {
  id = aws_network_interface.ansible_student_vm_mgmt.id
}

resource "aws_security_group" "ansible_student_vm" {
  name        = "${var.name_prefix}-ansible_student_vm"
  description = "Allow inbound ssh traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}