
module "github_repo_module" {
  source  = "app.terraform.io/customer-demo-yulei-management-org/github-repo-module/specialcustomer"
  version = "0.0.4"

  reponame = "repositoryfor-${var.namespace-name}"
}

module "tfe_vault_workspace_module" {
  source  = "app.terraform.io/customer-demo-yulei-management-org/tfe-vault-workspace-module/specialcustomer"
  version = "0.0.6"

  github-repo-fullname = "${module.github_repo_module.repoidentifier}"
  //oauth-token-id been hardcoded to the only vcs connection.
  oauth-token-id = "ot-Xsx6ReJAouFcMzYN"
  tfe-organization = "customer-demo-yulei-consumer-org"
  tfe-workspace-name = "workspacefor-${module.vault_namespace_module.vault-namespace}"
  vault-namespace = "${module.vault_namespace_module.vault-namespace}"
  vault-token = "${module.vault_namespace_module.vault-token}"
  vault-addr = var.vault-addr
}

module "vault_namespace_module" {
  source  = "app.terraform.io/customer-demo-yulei-management-org/vault-namespace-module/specialcustomer"
  version = "0.0.7"

  namespace = var.namespace-name
}

output "results" {
  value = "Your Vault namespace ${var.namespace-name} has been provisioned successfully.\n You can now commit your terraform code for vault to repositoryfor-${var.namespace-name}."

}

