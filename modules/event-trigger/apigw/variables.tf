variable "enable" {
  description = "Conditionally enables this module (and all it's resources)."
  type        = bool
  default     = false
}

variable "rest_api_id" {
  type        = string
  description = "The instance of the API Gateway Rest API module"
}

variable "stage_name" {
  type        = string
  description = "Stage name for REST api"
}

variable "rest_method" {
  type        = string
  description = "HTTP method for the endpoint"
}

variable "path_part" {
  type        = string
  description = "Unique piece of path for this APIGW endpoint"
}

variable "version_id" {
  type        = string
  description = "Current version of API"
}

variable "function_name" {
  type        = string
  description = "Function name of the related Lambda"
}

variable "invoke_arn" {
  type        = string
  description = "Invoke arn of the related Lambda"
}

variable authorization_type {
  description = "The type of authorizer to run at the API Gateway layer"
  type        = string
}

variable authorization_id {
  description = "The ID from the API Gateway Authorizer resource"
  type        = string
}
