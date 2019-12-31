## REQUIRED
variable lambda_name {
  type        = string
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

variable region {
  description = "AWS Region to deploy to, this is necessary to deploy the same lambda to different regions and avoid role collision"
  type        = string
}

## OPTIONAL
variable policy_filepath {
  type        = string
  description = "Filepath to JSON file with IAM policy for the Lambda"
  default     = ""
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

variable event {
  description = "Event source configuration which triggers the Lambda function. Supported events: apigw"
  type        = map(string)
  default     = {}
}

variable rest_api_id {
  description = "The API Gateway REST API Resource, required for apigw events"
  type        = string
}

variable version_id {
  description = "The required version id from the API Gateway Resource"
  type        = string
}

variable authorization_type {
  description = "The type of authorizer to run at the API Gateway layer"
  type        = string
  default     = "COGNITO_USER_POOLS"
}

variable authorization_id {
  description = "The ID from the API Gateway Authorizer resource"
  type        = string
  default     = ""
}