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