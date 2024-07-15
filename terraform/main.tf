#region DEVELOPMENT
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
#endregion DEVELOPMENT

#region STAGING
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
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_stg.name
  node_group_name = "node_group_stg"
  node_role_arn   = aws_eks_cluster.eks_cluster_stg.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_stg.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.micro"]
  labels = {
    env = "stg"
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
#endregion

#region PRODUCTION
resource "aws_eks_cluster" "eks_cluster_prod" {
  provider = aws.aws_provider
  role_arn = var.role_arn
  name     = "cluster_prod"
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

resource "aws_eks_node_group" "eks_nodegroup_prod" {
  provider        = aws.aws_provider
  cluster_name    = aws_eks_cluster.eks_cluster_prod.name
  node_group_name = "node_group_prod"
  node_role_arn   = aws_eks_cluster.eks_cluster_prod.role_arn
  subnet_ids      = aws_eks_cluster.eks_cluster_prod.vpc_config[0].subnet_ids
  capacity_type   = "ON_DEMAND"
  instance_types  = ["t3.micro"]
  labels = {
    env = "prod"
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
#endregion

#region ECR Repositories
resource "aws_ecr_repository" "ecr_repository_frontend" {
  provider = aws.aws_provider
  name     = "frontend"
}
resource "aws_ecr_repository" "ecr_repository_orders-service-example" {
  provider = aws.aws_provider
  name     = "orders-service-example"
}
resource "aws_ecr_repository" "ecr_repository_payments-service-example" {
  provider = aws.aws_provider
  name     = "payments-service-example"
}
resource "aws_ecr_repository" "ecr_repository_products-service-example" {
  provider = aws.aws_provider
  name     = "products-service-example"
}
resource "aws_ecr_repository" "ecr_repository_shipping-service-example" {
  provider = aws.aws_provider
  name     = "shipping-service-example"
}
#endregion
