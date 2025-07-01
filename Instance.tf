resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  availability_zone      = var.zone1 # Specify the availability zone if needed

  tags = {
    Name = "DoveInstance"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("dovekey") # Path to your private key
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]

  }

}

resource "aws_ec2_instance_state" "dove_instance_state" {
  instance_id = aws_instance.web.id
  state       = "running" # Set the desired state of the instance
}