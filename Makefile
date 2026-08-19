.PHONY: help fmt validate helm-lint helm-template docs-check workflow-check check clean

help: ## Show available validation commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

fmt: ## Check Terraform formatting recursively
	terraform fmt -check -recursive terraform

validate: ## Initialize providers without state access and validate Terraform
	terraform -chdir=terraform/environments/dev init -backend=false
	terraform -chdir=terraform/environments/dev validate

helm-lint: ## Lint the Basalt Helm chart
	helm lint charts/basalt

helm-template: ## Render the production-safe Helm chart values
	mkdir -p rendered
	helm template basalt charts/basalt -f charts/basalt/values.yaml > rendered/basalt.yaml

docs-check: ## Validate internal Markdown links and platform guardrails
	python3 scripts/validate_repo.py

workflow-check: ## Lint GitHub Actions workflow syntax
	actionlint

check: fmt validate helm-lint helm-template docs-check workflow-check ## Run all static platform gates

clean: ## Remove local Terraform and rendered artifacts
	rm -rf terraform/environments/dev/.terraform rendered coverage
