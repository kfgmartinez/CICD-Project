resource "aws_key_pair" "CICD-2-key" {
  key_name   = "CICD-2-key"
  public_key = file(var.PUB_KEY)

}

resource "aws_instance" "Jenkins-Master" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.small"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.CICD-2-key.key_name
  vpc_security_group_ids = [aws_security_group.JenkinsMaster-sg.id]
  subnet_id              = aws_subnet.CICD2-pub-1.id
  tags = {
    Name    = "Jenkins-Master"
    Project = "CI/CD 2"
  }

  connection {
    user        = var.USER
    private_key = file("CICD2-key")
  }
}


resource "aws_instance" "Ansible-Master" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.CICD-2-key.key_name
  vpc_security_group_ids = [aws_security_group.AnsibleControl-sg.id]
  subnet_id              = aws_subnet.CICD2-pub-1.id
  tags = {
    Name    = "Jenkins-Master"
    Project = "CI/CD 2"
  }

  connection {
    user        = var.USER
    private_key = file("CICD2-key")
  }
}

resource "aws_instance" "Jenkins-BuildSlave" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.CICD-2-key.key_name
  vpc_security_group_ids = [aws_security_group.JenkinsBuildSlave-sg.id]
  subnet_id              = aws_subnet.CICD2-pub-1.id
  tags = {
    Name    = "Jenkins-Master"
    Project = "CI/CD 2"
  }

  connection {
    user        = var.USER
    private_key = file("CICD-2-key")
  }
}