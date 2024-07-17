resource "aws_eks_cluster" "eks_cluster_prod" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_prod"
  vpc_config {
    subnet_ids = [
      "subnet-08d3a1aaa06749b4f",
      "subnet-0bf6ca46c41a0c9ad",
    ]
  }
}

resource "aws_eks_node_group" "eks_nodegroup_prod" {
  depends_on      = [aws_eks_cluster.eks_cluster_prod]
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_prod.name
  node_group_name = "node_group_prod"
  node_role_arn   = aws_eks_cluster.eks_cluster_prod.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_prod.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  labels = {
    env = "prod"
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
