terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = ">= 2.35.0"
  }
}

resource aws_lambda_function lambda {
  description   = var.lambda_description
  filename      = var.filename
  function_name = "${var.lambda_name}_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler

  source_code_hash = filebase64sha256(var.filename)

  runtime                        = var.runtime
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  layers                         = var.layers
  reserved_concurrent_executions = var.reserved_concurrent_executions
  dynamic "environment" {
    for_each = length(var.environment) < 1 ? [] : [var.environment]
    content {
      //noinspection HILUnresolvedReference
      variables = environment.value.variables
    }
  }
}

resource aws_iam_role lambda_role {
  name = "${var.lambda_name}_role_${var.region}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource aws_iam_role_policy lambda_policy {
  name = "${var.lambda_name}_policy"
  role = aws_iam_role.lambda_role.name

  policy = templatefile(var.policy_filepath, {})

}