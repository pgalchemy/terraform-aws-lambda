resource "aws_api_gateway_rest_api" "api" {
  count       = var.enable ? 1 : 0
  name        = var.name
  description = "API for ${var.name}"
}

resource aws_api_gateway_resource version {
  count       = var.enable ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.api_version
}

resource aws_api_gateway_resource proxy {
  count       = var.enable ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = var.path_part
}

resource "aws_api_gateway_deployment" "deployment" {
  count       = var.enable ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name

  depends_on = [
    "aws_api_gateway_integration.request_integration",
  ]
}

resource aws_lambda_permission allow_api_gateway {
  count         = var.enable ? 1 : 0
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.deployment.execution_arn}/*/*"
}

resource aws_api_gateway_method request_method {
  count         = var.enable ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = var.rest_method
  authorization = "NONE"
}

resource aws_api_gateway_integration request_integration {
  count       = var.enable ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_method.request_method.resource_id
  http_method = aws_api_gateway_method.request_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}
