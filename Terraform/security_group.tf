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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "allow_AnsibleControl_to_JenkinsMaster" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.AnsibleControl-sg.id
  security_group_id        = aws_security_group.JenkinsMaster-sg.id
  
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "allow_JenkinsMaster_to_AnsibleControl" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.JenkinsMaster-sg.id
  security_group_id        = aws_security_group.AnsibleControl-sg.id
  
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "allow_AnsibleControl_to_JenkinsBuildSlave-sg" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.AnsibleControl-sg.id
  security_group_id        = aws_security_group.JenkinsBuildSlave-sg.id
  
}
