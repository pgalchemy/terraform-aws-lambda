## REQUIRED
variable lambda_name {
  type = string
  description = "A descriptive name for the lambda"
}

variable handler {
  type        = string
  description = "The entrypoint to your function and name of your Lambda"
}

variable lambda_description {
  type        = string
  description = "A description of what your Lambda function does"
}

variable "filename" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
}


## OPTIONAL
variable policy_filepath {
  type        = string
  description = "Filepath to JSON file with IAM policy for the Lambda"
  default     = "../../templates/defaultLambdaPolicy.json"
}

variable runtime {
  type        = string
  description = "The runtime environment for your Lambda function"
  default     = "go1.x"
}

variable memory_size {
  type        = number
  description = "Memory your Lambda function needs - maximum is 3008"
  default     = 128
}

variable timeout {
  type        = number
  description = "Duration of the Lambda before timeout - maximum is 15 minutes"
  default     = 60
}

variable "event" {
  description = "Event source configuration which triggers the Lambda function. Supported events: apigw"
  type        = map(string)
  default     = {}
}
