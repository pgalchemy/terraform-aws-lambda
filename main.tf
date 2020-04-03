locals {
  default_policy = "${path.module}/templates/defaultLambdaPolicy.json"
}

module lambda {
  source             = "./modules/lambda"
  lambda_name        = var.lambda_name
  handler            = var.handler
  lambda_description = var.lambda_description
  filename           = var.filename
  region             = var.region
  environment        = var.environment
  policy_filepath    = var.policy_filepath != "" ? var.policy_filepath : "${path.module}/templates/defaultLambdaPolicy.json"
  layers             = var.layers
  enable_honeycomb   = var.enable_honeycomb
  honeycomb_arn      = var.honeycomb_arn
}

module event-trigger-apigw {
  source = "./modules/event-trigger/apigw"
  enable = lookup(var.event, "type", "") == "apigw" ? true : false

  rest_method        = lookup(var.event, "rest_method", "")
  path_part          = lookup(var.event, "path_part", "")
  stage_name         = lookup(var.event, "stage_name", "")
  rest_api_id        = var.rest_api_id
  version_id         = var.version_id
  function_name      = module.lambda.function_name
  invoke_arn         = module.lambda.invoke_arn
  authorization_id   = var.authorization_id
  authorization_type = var.authorization_type
  api_key_required   = var.api_key_required
}
