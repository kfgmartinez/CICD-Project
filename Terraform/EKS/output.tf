output "security_group_public" {
   value = "${aws_security_group.worker_node_sg.id}"
}

output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}