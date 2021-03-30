
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "random_id" "node_id" {
  byte_length = 2
  count       = var.instance_count

  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id

  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
  #user_data = ""
  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = "node-${random_id.node_id[count.index].dec}"
  }
}
