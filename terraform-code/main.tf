resource "random_id" "random" {
  byte_length = 2
  count       = 2
}

resource "github_repository" "terraform_repo" {
  count       = 2
  name        = "terraform_repo-${random_id.random[count.index].dec}"
  description = "Teste de criação de repositório com o Terraform"
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  count               = 2
  repository          = github_repository.terraform_repo[count.index].name
  branch              = "main"
  file                = "README.md"
  content             = "# This is a README file for the Terraform repository. ${count.index}"
  commit_message      = "Add README file"
  overwrite_on_create = true
}

resource "github_repository_file" "index_html" {
  count               = 2
  repository          = github_repository.terraform_repo[count.index].name
  branch              = "main"
  file                = "index.html"
  content             = "<html><body><h1>Hello, World! ${count.index}</h1></body></html>"
  commit_message      = "Add index.html file"
  overwrite_on_create = true
}

output "repo_names" {
  value       = github_repository.terraform_repo[*].name
  description = "Repository names created by Terraform"
  sensitive   = true
}
