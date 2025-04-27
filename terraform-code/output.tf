output "clone_urls" {
  value       = { for key, repo in github_repository.terraform_repo : key => repo.http_clone_url }
  description = "Clone URLs of the created repositories"
  sensitive   = false
}

output "varsource" {
  value       = var.varsource
  description = "value of the variable source"
  sensitive   = false
}
