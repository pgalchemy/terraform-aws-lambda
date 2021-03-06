terraform {
  required_version = ">= 0.12.16"
}

provider aws {
  region  = "us-east-1"
  version = ">= 2.35.0"
}

resource aws_api_gateway_rest_api api {
  name        = "My Rest API"
  description = "terratest"
}

resource aws_api_gateway_resource version {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "v1"
}

module lambda {
  source             = "../../"
  lambda_name        = "terratest"
  handler            = "terratest"
  lambda_description = "Lambda function to test terraform-aws-lambda module with API Gateway"
  filename           = "hello_world.zip"
  rest_api_id        = aws_api_gateway_rest_api.api.id
  version_id         = aws_api_gateway_resource.version.id
  authorization_type = "NONE"
  api_key_required   = true
  region             = "us-east-1"

  event = {
    type        = "apigw"
    stage_name  = "api"
    rest_method = "POST"
    path_part   = "helloWorld"
  }
}

module lambda_two {
  source             = "../../"
  lambda_name        = "terratest2"
  handler            = "terratest2"
  lambda_description = "Lambda function to test terraform-aws-lambda module with API Gateway"
  filename           = "hello_world.zip"
  rest_api_id        = aws_api_gateway_rest_api.api.id
  version_id         = aws_api_gateway_resource.version.id
  authorization_type = "NONE"
  region             = "us-east-1"

  event = {
    type        = "apigw"
    stage_name  = "api"
    rest_method = "POST"
    path_part   = "helloWorld2"
  }
}

module lambda_three {
  source             = "../../"
  lambda_name        = "terratest3"
  handler            = "terratest3"
  lambda_description = "Lambda function to test terraform-aws-lambda module with API Gateway"
  filename           = "hello_world.zip"
  rest_api_id        = aws_api_gateway_rest_api.api.id
  version_id         = aws_api_gateway_resource.version.id
  authorization_type = "NONE"
  region             = "us-east-1"

  event = {
    type        = "apigw"
    stage_name  = "api"
    rest_method = "GET"
    path_part   = "helloWorld2"
  }
}

module lambda_four {
  source             = "../../"
  lambda_name        = "terratest4"
  handler            = "terratest4"
  lambda_description = "Lambda function to test terraform-aws-lambda module with API Gateway"
  filename           = "hello_world.zip"
  rest_api_id        = aws_api_gateway_rest_api.api.id
  version_id         = aws_api_gateway_resource.version.id
  authorization_type = "NONE"
  region             = "us-east-1"

  event = {
    type        = "apigw"
    stage_name  = "api"
    rest_method = "PUT"
    path_part   = "helloWorld"
  }
}
