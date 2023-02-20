.PHONY: help
help: ## This outputs help information.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

preinstall: ## requirements are managed by pip-tools this command installs pip-tools.
	pip install pip-tools

requirements: ## generates requirements.txt file from requirements.in
	pip-compile --generate-hashes requirements.in

install: requirements ## installs requirements into current virtualenv.
	pip-sync
