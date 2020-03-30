terraform {
  required_version = ">= 0.12.21"
}

provider aws {
  region  = "us-east-1"
  version = ">= 2.51.0"
}

module honeycomb {
  source             = "../../"
  lambda_name        = "terratest"
  handler            = "terratest"
  lambda_description = "Lambda function to test terraform-aws-lambda module"
  filename           = "hello_world.zip"
  region             = "us-east-1"
  rest_api_id        = ""
  version_id         = ""
  environment = {
    variables = {
      loglevel = "INFO"
    }
  }
}

module lambda {
  depends_on = module.honeycomb
  source             = "../../"
  lambda_name        = "terratest2"
  handler            = "terratest2"
  lambda_description = "Lambda function to test terraform-aws-lambda module"
  filename           = "hello_world.zip"
  region             = "us-east-1"
  rest_api_id        = ""
  version_id         = ""
  honeycomb_arn      = module.honeycomb.arn
  environment = {
    variables = {
      loglevel = "INFO"
    }
  }
}
