terraform {
  required_version = ">= 0.12.21"
}

provider aws {
  region  = "us-east-1"
  version = ">= 2.51.0"
}

resource "aws_lambda_layer_version" "test_layer" {
  filename   = "test_layer.zip"
  layer_name = "test_layer"

  compatible_runtimes = ["python3.7"]
}

module lambda {
  source             = "../../"
  lambda_name        = "terratest"
  handler            = "terratest"
  lambda_description = "Lambda function to test terraform-aws-lambda module"
  filename           = "hello_world.zip"
  region             = "us-east-1"
  rest_api_id        = ""
  version_id         = ""
  runtime            = "python3.7"
  layers             = [aws_lambda_layer_version.test_layer.arn]
  environment = {
    variables = {
      loglevel = "INFO"
    }
  }
}
