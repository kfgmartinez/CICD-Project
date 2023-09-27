output "VPC_name" {
    description = "VPC id name"
    value = "${aws_vpc.CICD2.id}" 
  
}

output "jenkins-public-ip" {
    description = "this is jenkins master ip"
    value = try(aws_instance.Jenkins-Master.public_ip,"")
  
}

output "slave-public-ip" {
    description = "this is jenkins slave ip"
    value = try(aws_instance.Ansible-Master.public_ip,"")
  
}

output "ansible-public-ip" {
    description = "this is Ansible public ip"
    value = try(aws_instance.Jenkins-BuildSlave.public_ip,"")
  
}