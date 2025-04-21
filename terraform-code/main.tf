resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_count
}

resource "github_repository" "terraform_repo" {
  count       = var.repo_count
  name        = "terraform_repo-${random_id.random[count.index].dec}"
  description = "Teste de criação de repositório com o Terraform"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = var.repo_count
  repository          = github_repository.terraform_repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# This is a ${var.env} environment\n\nThis is a README file for the ${github_repository.terraform_repo[count.index].name} repository."
  commit_message      = "Add README file"
  overwrite_on_create = true
}

resource "github_repository_file" "index_html" {
  count               = var.repo_count
  repository          = github_repository.terraform_repo[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "<html><body><h1>Hello, World! ${count.index}</h1></body></html>"
  commit_message      = "Add index.html file"
  overwrite_on_create = true
}

output "clone_urls" {
  value       = { for i in github_repository.terraform_repo[*] : i.name => i.http_clone_url }
  description = "Clone URLs of the created repositories"
  sensitive   = false
}

output "varsource" {
  value       = var.varsource
  description = "value of the variable source"
  sensitive   = false
}
