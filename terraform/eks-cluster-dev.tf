resource "aws_eks_cluster" "eks_cluster_dev" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_dev"
  vpc_config {
    subnet_ids = [
      "subnet-00472f5a3c442297d",
      "subnet-0a5de4b5eb1a44c74",
      "subnet-08d3a1aaa06749b4f",
      "subnet-0bf6ca46c41a0c9ad",
      "subnet-013d3ef8fbd090b6e",
    ]
  }
}

resource "aws_eks_node_group" "eks_nodegroup_dev" {
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_dev.name
  node_group_name = "node_group_dev"
  node_role_arn   = aws_eks_cluster.eks_cluster_dev.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_dev.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.micro"]
  labels = {
    env = "dev"
  }
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
}