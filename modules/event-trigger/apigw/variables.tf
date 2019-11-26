variable "enable" {
  description = "Conditionally enables this module (and all it's resources)."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of the REST API"
}

variable "stage_name" {
  default = "api"
}

variable "iam_role_name" {
  description = "The name of the IAM role to attach stream policy configuration."
  default     = ""
}

variable "function_name" {
  description = "The ARN of the Lambda function that will be subscribing to events."
  default     = ""
}

variable "invoke_arn" {
  description = "The Lambda invoke uri"
}

variable "rest_method" {
  description = "HTTP method for the endpoint"
}

variable "path_part" {
  description = "Unique piece of path for this APIGW endpoint"
}

variable "rest_api_id" {

}

variable "parent_id" {

}

variable "api_version" {
  description = "Current version of our API"
  default     = "v1"
}
