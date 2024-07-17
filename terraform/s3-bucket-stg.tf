resource "aws_s3_bucket" "s3_stg" {
  bucket   = "${var.aws_s3_bucket_name}-stg"
  provider = aws.aws_provider
  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "s3_stg" {
  depends_on = [aws_s3_bucket.s3_stg]
  bucket     = aws_s3_bucket.s3_stg.bucket
  provider   = aws.aws_provider
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_stg" {
  depends_on          = [aws_s3_bucket.s3_stg]
  bucket              = aws_s3_bucket.s3_stg.bucket
  provider            = aws.aws_provider
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_policy" "s3_policy_stg" {
  depends_on = [aws_s3_bucket_public_access_block.s3_stg]
  bucket     = aws_s3_bucket.s3_stg.bucket
  provider   = aws.aws_provider
  policy     = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "PublicReadGetObject",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "arn:aws:s3:::${aws_s3_bucket.s3_stg.bucket}/*"
          }
      ]
    }
  EOF
}