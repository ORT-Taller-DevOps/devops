resource "aws_eks_cluster" "eks_cluster_dev" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_dev"
  vpc_config {
    subnet_ids = [
      "subnet-00472f5a3c442297d",
      "subnet-0a5de4b5eb1a44c74",
    ]
  }
}

resource "aws_eks_node_group" "eks_nodegroup_dev" {
  depends_on      = [aws_eks_cluster.eks_cluster_dev]
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_dev.name
  node_group_name = "node_group_dev"
  node_role_arn   = aws_eks_cluster.eks_cluster_dev.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_dev.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  labels = {
    env = "dev"
  }

  scaling_config {
    desired_size = 8
    max_size     = 12
    min_size     = 4
  }

  update_config {
    max_unavailable = 4
  }
}
