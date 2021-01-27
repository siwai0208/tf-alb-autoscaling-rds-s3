variable "S3BucketName" {
  type        = string
}

resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.S3BucketName
  acl    = "private"
}

resource "aws_s3_bucket_policy" "BucketPolicy" {
  bucket = aws_s3_bucket.S3Bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.S3Bucket.arn}/*"
    }
  ]
}
POLICY
}
