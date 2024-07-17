resource "aws_eks_cluster" "eks_cluster_stg" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_stg"
  vpc_config {
    subnet_ids = [
      "subnet-013d3ef8fbd090b6e",
      "subnet-02a860f80a87c4894",
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
    desired_size = 8
    max_size     = 12
    min_size     = 4
  }

  update_config {
    max_unavailable = 4
  }
}
