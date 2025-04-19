resource "github_repository" "terraform_repo" {
  name        = "terraform_repo"
  description = "Teste de criação de repositório com o Terraform"
  visibility = "private"
  auto_init = true


}