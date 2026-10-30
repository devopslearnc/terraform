data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-eks/k8s_1.33/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20251007"]
  }

  
  owners = ["099720109477"] 
}  



resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name =  var.key_name 
  user_data     = file("${path.module}/user_data/user_data.sh")
  tags = {
    Name = var.name
  }
}
