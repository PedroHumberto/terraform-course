
resource "random_id" "random" {
  byte_length = 2
  count       = var.repo_max
}

resource "github_repository" "terraform_repo" {
  for_each    = var.repos
  name        = "terraform_repo-${each.key}"
  description = "${each.value.lang} - Teste de criação de repositório com o Terraform"
  visibility  = var.env == "dev" ? "private" : "public"
  auto_init   = true
}


resource "github_repository_file" "readme" {
  for_each   = var.repos
  repository = github_repository.terraform_repo[each.key].name
  branch     = "main"
  file       = "README.md"
  content = templatefile("templates/readme.tftpl", {
    env  = var.env
    lang = each.value.lang
    repo = github_repository.terraform_repo[each.key].name
    name = data.github_user.current.name
  })
  overwrite_on_create = true
  # lifecycle {
  #   ignore_changes = [
  #     content,
  #   ]
  # }
}

resource "github_repository_file" "main" {
  for_each            = var.repos
  repository          = github_repository.terraform_repo[each.key].name
  branch              = "main"
  file                = each.value.filename
  content             = each.value.content
  commit_message      = "Add file"
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
    ]
  }
}

# moved {
#   from = github_repository_file.index_html
#   to   = github_repository_file.main
# }