
EXTRA_VARS ?=

EXTRA_ARGS = -e @./overrides.yml 

##@ Common Tasks
.PHONY: help
help: ## This help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^(\s|[a-zA-Z_0-9-])+:.*?##/ { printf "  \033[36m%-35s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


.PHONY: bgp-routing
bgp-routing: ## Sets up the BGP routing with a client ec2 in aws
	ansible-playbook -i hosts $(EXTRA_ARGS) $(EXTRA_VARS) playbooks/router.yml


.PHONY: bgp-routing-cleanup
bgp-routing-cleanup: ## Cleans up the BGP routing with a client ec2 in aws
	ansible-playbook -i hosts $(EXTRA_ARGS) $(EXTRA_VARS) playbooks/router-cleanup.yml