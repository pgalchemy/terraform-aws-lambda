locals {
  default_policy = "${path.module}/templates/defaultLambdaPolicy.json"
}

module "lambda" {
  source             = "./modules/lambda"
  lambda_name        = var.lambda_name
  handler            = var.handler
  lambda_description = var.lambda_description
  filename           = var.filename
  policy_filepath    = var.policy_filepath != "" ? var.policy_filepath : "${path.module}/templates/defaultLambdaPolicy.json"
}

module "event-trigger-apigw" {
  source = "./modules/event-trigger/apigw"
  enable = lookup(var.event, "type", "") == "apigw" ? true : false

  name          = lookup(var.event, "name", "")
  rest_method   = lookup(var.event, "rest_method", "")
  path_part     = lookup(var.event, "path_part", "")
  stage_name    = lookup(var.event, "stage_name", "")
  function_name = module.lambda.function_name
  invoke_arn    = module.lambda.invoke_arn
}
