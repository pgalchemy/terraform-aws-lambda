resource aws_api_gateway_resource proxy {
  count       = var.enable ? 1 : 0
  rest_api_id = var.rest_api_id
  parent_id   = var.version_id
  path_part   = var.path_part
}

resource "aws_api_gateway_deployment" "deployment" {
  count       = var.enable ? 1 : 0
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name

  depends_on = [
    aws_api_gateway_integration.request_integration,
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
  source_arn = "${aws_api_gateway_deployment.deployment[count.index].execution_arn}/*/*"
}

resource aws_api_gateway_method request_method {
  count         = var.enable ? 1 : 0
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = var.rest_method
  authorization = var.authorization_type
  authorizer_id = var.authorization_id
}

resource aws_api_gateway_integration request_integration {
  count       = var.enable ? 1 : 0
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_method.request_method[count.index].resource_id
  http_method = aws_api_gateway_method.request_method[count.index].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn
}
