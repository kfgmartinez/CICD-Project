resource "aws_eks_cluster" "eks" {
  name = "kfgmartinez-eks-01"
  role_arn = aws_iam_role.master.arn

  vpc_config {
    subnet_ids = [var.subnet_ids[0],var.subnet_ids[1]]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]

}
#################################################################################################################

resource "aws_eks_node_group" "backend" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "dev"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids = [var.subnet_ids[0],var.subnet_ids[1]]
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.small"]
  remote_access {
    ec2_ssh_key = "CICD-2-key"
    source_security_group_ids = [var.securitygroup_ids]
  } 
  
  labels =  tomap({env = "dev"})
  
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]
}

