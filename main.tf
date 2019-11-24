resource aws_lambda_function lambda {
  description   = var.lambda_description
  filename      = "../../build/${var.handler}.zip"
  function_name = "${var.lambda_name}_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler

  source_code_hash = filebase64sha256("../../build/${var.handler}.zip")

  runtime     = var.runtime
  memory_size = var.memory_size
  timeout     = var.timeout
}

resource aws_iam_role lambda_role {
  name = "${var.lambda_name}_role"

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

  policy = templatefile("${var.policy_filepath}", {})

}
