## REQUIRED
variable lambda_name {
  type        = string
  description = "The name of your Lambda function"
}

variable handler {
  type        = string
  description = "The entrypoint to your Lambda function"
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
  default     = "../../templates/json/defaultLambdaPolicy.json"
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
