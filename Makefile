.PHONY: lint fixtures clean help

FIXTURE_DIR := fixtures

## Quality

lint: ## yamllint action.yml + workflows (uses dockerized yamllint, no host install needed)
	docker run --rm -v $$(pwd):/data cytopia/yamllint -d relaxed action.yml .github/workflows/

## Fixtures

fixtures: ## Create a local fixture chart for manual testing
	@mkdir -p $(FIXTURE_DIR)/charts/test-chart/templates
	@printf 'apiVersion: v2\nname: test-chart\nversion: 0.1.0\nappVersion: "1.0.0"\ndescription: local fixture\ntype: application\n' > $(FIXTURE_DIR)/charts/test-chart/Chart.yaml
	@printf 'apiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: test-chart\ndata:\n  hello: world\n' > $(FIXTURE_DIR)/charts/test-chart/templates/configmap.yaml

## Cleanup

clean: ## Remove fixtures and helm-repo artifacts
	rm -rf $(FIXTURE_DIR) helm-repo

## Help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
