variable "enable" {
  description = "Conditionally enables this module (and all it's resources)."
  type        = bool
  default     = false
}

variable "name" {
  type        = "string"
  description = "Name of the REST API"
}

variable "stage_name" {
  type        = "string"
  description = "Stage name for REST api"
}

variable "rest_method" {
  type        = "string"
  description = "HTTP method for the endpoint"
}

variable "path_part" {
  type        = "string"
  description = "Unique piece of path for this APIGW endpoint"
}

variable "api_version" {
  type        = "string"
  description = "Current version of API"
  default     = "v1"
}

variable "function_name" {
  type        = "string"
  description = "Function name of the related Lambda"
}

variable "invoke_arn" {
  type        = "string"
  description = "Invoke arn of the related Lambda"
}
