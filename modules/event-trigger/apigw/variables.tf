variable "enable" {
  description = "Conditionally enables this module (and all it's resources)."
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of the REST API"
}

variable "stage_name" {
  description = "Stage name for REST api"
}

variable "rest_method" {
  description = "HTTP method for the endpoint"
}

variable "path_part" {
  description = "Unique piece of path for this APIGW endpoint"
}

variable "api_version" {
  description = "Current version of API"
  default     = "v1"
}

variable "function_name" {

}

variable "invoke_arn" {

}
