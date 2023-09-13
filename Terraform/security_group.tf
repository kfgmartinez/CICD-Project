resource "aws_security_group" "JenkinsMaster-sg" {
  name        = "JenkinsMaster-sg"
  description = "allow ssh"
  vpc_id      = aws_vpc.CICD2.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow traffic from AnsibleControl"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = ["aws_security_group.AnsibleControl-sg.id"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_security_group" "AnsibleControl-sg" {
  name        = "AnsibleControl-sg"
  description = "allow ssh"
  vpc_id      = aws_vpc.CICD2.id
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow traffic from JenkinsMaster"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = ["aws_security_group.JenkinsMaster-sg.id"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_security_group" "JenkinsBuildSlave-sg" {
  name        = "JenkinsBuildSlave-sg"
  description = "allow ssh"
  vpc_id      = aws_vpc.CICD2.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow traffic from AnsibleControl"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = ["aws_security_group.AnsibleControl-sg.id"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
