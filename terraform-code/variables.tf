variable "repo_count" {
  type        = number
  description = "Numbers of repositories to create"
  default     = 2

  validation {
    condition     = var.repo_count < 5
    error_message = "Do not deploy more than 5 repositories at once."
  }
}

variable "env" {
  type        = string
  description = "Environment where the code is running"

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "The environment must be either 'dev' or 'prod'."
  }
}

variable "varsource" {
  type        = string
  description = "Source of the variable"
  default     = "variables.tf"
}