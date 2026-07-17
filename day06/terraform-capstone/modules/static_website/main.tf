#############################################################
# S3 Bucket
#############################################################

resource "aws_s3_bucket" "website" {

  bucket = var.bucket_name

  force_destroy = true

  tags = var.tags
}

#############################################################
# Versioning
#############################################################

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.website.id

  versioning_configuration {

    status = "Enabled"

  }

}

#############################################################
# Encryption
#############################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket = aws_s3_bucket.website.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}

#############################################################
# Public Access Block
#############################################################

resource "aws_s3_bucket_public_access_block" "block" {

  bucket = aws_s3_bucket.website.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}

#############################################################
# Upload index.html
#############################################################

resource "aws_s3_object" "index" {

  bucket = aws_s3_bucket.website.id

  key = "index.html"

  source = "${path.root}/website/index.html"

  content_type = "text/html"

  etag = filemd5("${path.root}/website/index.html")

}

#############################################################
# Upload error.html
#############################################################

resource "aws_s3_object" "error" {

  bucket = aws_s3_bucket.website.id

  key = "error.html"

  source = "${path.root}/website/error.html"

  content_type = "text/html"

  etag = filemd5("${path.root}/website/error.html")

}

#############################################################
# Upload CSS
#############################################################

resource "aws_s3_object" "css" {

  bucket = aws_s3_bucket.website.id

  key = "style.css"

  source = "${path.root}/website/style.css"

  content_type = "text/css"

  etag = filemd5("${path.root}/website/style.css")

}
