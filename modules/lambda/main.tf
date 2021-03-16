terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = ">= 2.35.0"
  }
}

resource aws_lambda_function lambda {
  description       = var.lambda_description
  filename          = var.s3_bucket == "" ? var.filename : null
  s3_bucket         = var.filename == "" ? var.s3_bucket : null
  s3_key            = var.filename == "" ? var.s3_key : null
  s3_object_version = var.filename == "" ? var.s3_object_version : null
  function_name     = "${var.lambda_name}_lambda"
  role              = aws_iam_role.lambda_role.arn
  handler           = var.handler

  source_code_hash = var.source_code_hash != "" ? var.source_code_hash : null

  runtime                        = var.runtime
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  layers                         = var.layers
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  dynamic "environment" {
    for_each = length(var.environment) < 1 ? [] : [var.environment]
    content {
      //noinspection HILUnresolvedReference
      variables = environment.value.variables
    }
  }

  // Only create vpc_config block if var.security_group_ids has a value
  dynamic "vpc_config" {
    for_each = var.security_group_ids[0] == "" ? [] : [1]
    content {
      security_group_ids = var.security_group_ids
      subnet_ids         = var.subnet_ids
    }
  }

  // Only create file_system_config block if var.file_system_config has a value
  dynamic "file_system_config" {
    for_each = var.file_system_config_arn == "" ? [] : [1]
    content {
      arn              = var.file_system_config_arn
      local_mount_path = var.local_mount_path
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