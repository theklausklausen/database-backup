HELM_FILES := $(shell find . -name 'Chart.yaml' -exec dirname {} \;)

help: ## Display this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

pull-submodules: ## Pulls all submodules
	cd shared-configuration && git pull origin main

lint: yaml-lint ansible-lint markdown-lint json-lint helm-lint ## Lints all files

prettier: ## Formats all files with prettier
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /tmp repo.kk.int/prettier sh -c 'npx prettier --config /src/shared-configuration/lint-rules/.prettierrc.yml --ignore-path /src/shared-configuration/lint-rules/.prettierignore --write /src/**/*'

prettier-lint: ## Lints all files with prettier
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /tmp repo.kk.int/prettier sh -c 'npx prettier --config /src/shared-configuration/lint-rules/.prettierrc.yml --ignore-path /src/shared-configuration/lint-rules/.prettierignore --check /src/**/*'

yaml-lint: ## Lints all yaml files
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /src pipelinecomponents/yamllint sh -c 'yamllint -c shared-configuration/lint-rules/.yamllintrc.yml .'

ansible-lint: ## Lints all ansible files
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /src pipelinecomponents/ansible-lint sh -c 'ansible-lint .'

markdown-lint: ## Lints all markdown files
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /src pipelinecomponents/markdownlint sh -c 'mdl --style shared-configuration/lint-rules/.markdownlintrc.rb --warnings .'

json-lint: ## Lints all json files
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /src pipelinecomponents/jsonlint sh -c 'find . -not -path './.git/*' -name '*.json' -type f -print0 | parallel --will-cite -k -0 -n1 jsonlint -p'

go-lint: ## Lints all go files
	docker run --rm --user 1000:1000 -v $(PWD):/src -w /src registry.gitlab.com/pipeline-components/go-lint:latest sh -c 'golint -set_exit_status ./...'

helm-lint: ## Lints all helm files
	echo $(HELM_FILES)
	docker run --rm --user 1000:1000 -v $(HELM_FILES):/src -w /src repo.kk.int/infra-images/helm sh -c 'helm lint /src'

helm-render: ## Renders helm templates
	docker run --rm --user 1000:1000 -v $(HELM_FILES):/src -w /src repo.kk.int/infra-images/helm sh -c 'helm template /src'

helm-package: ## Packages helm charts
	docker run --rm --user 1000:1000 -v $(HELM_FILES):/src -w /src repo.kk.int/infra-images/helm sh -c 'helm package /src'