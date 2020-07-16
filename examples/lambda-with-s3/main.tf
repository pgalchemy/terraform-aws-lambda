terraform {
  required_version = ">= 0.12.16"
}

provider aws {
  region  = "us-east-1"
  version = ">= 2.35.0"
}

locals {
  bucket_name = "terratest-lambda-bucket"
  bucket_key  = "hello_world.zip"
}


resource aws_s3_bucket bucket {
  bucket = local.bucket_name
}

resource aws_s3_bucket_object key {
  bucket = aws_s3_bucket.bucket.bucket
  key    = local.bucket_key
  source = local.bucket_key
}

module lambda {
  source = "../../"

  lambda_name        = "terratest"
  handler            = "terratest"
  lambda_description = "Lambda function to test terraform-aws-lambda module"
  s3_bucket          = local.bucket_name
  s3_key             = aws_s3_bucket_object.key.key
  region             = "us-east-1"
  rest_api_id        = ""
  version_id         = ""
  environment = {
    variables = {
      loglevel = "INFO"
    }
  }
}
