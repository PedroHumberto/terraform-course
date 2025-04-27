variable "repo_max" {
  type        = number
  description = "Numbers of repositories to create"
  default     = 2
  validation {
    condition     = var.repo_max <= 5
    error_message = "Do not deploy more than 10 repositories at once."
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

variable "repos" {
  type        = map(map(string))
  description = "List of repositories to create"
  validation {
    condition     = length(var.repos) <= var.repo_max
    error_message = "The list of repositories cannot be empty and must not exceed the maximum number of repositories specified by 'repo_max'."
  }
}