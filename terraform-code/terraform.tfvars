repo_max  = 2
varsource = "terraform.tfvars"
env       = "dev"
repos = {
  terraform = {
    lang     = "terraform",
    filename = "main.tf"
    content  = "terraform { required_providers { aws = { source = \"hashicorp/aws\" } } }"
  },
  backend = {
    lang     = "python",
    filename = "main.py"
    content  = "hello = 'Hello, World!' \nprint(hello)"
  }
}