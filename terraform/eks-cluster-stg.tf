resource "aws_eks_cluster" "eks_cluster_stg" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_stg"
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

resource "aws_eks_node_group" "eks_nodegroup_stg" {
  depends_on      = [aws_eks_cluster.eks_cluster_stg]
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_stg.name
  node_group_name = "node_group_stg"
  node_role_arn   = aws_eks_cluster.eks_cluster_stg.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_stg.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  labels = {
    env = "stg"
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}
