# addresses
DROPLET_ADDRESS = $(shell terraform output droplet_base_ipv4_address)

# tokens
DIGITALOCEAN_TOKEN = $(shell lpass show --notes 'DigitalOcean Access Tokens'/default)

.PHONY: apply
apply: apply-digitalocean apply-docker

.PHONY: apply-digitalocean
apply-digitalocean:
	@terraform apply \
		-target=module.digitalocean \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: apply-docker
apply-docker:
	@terraform apply \
		-target=module.docker \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: destroy
destroy: destroy-docker destroy-digitalocean

.PHONY: destroy-docker
destroy-docker:
	@terraform destroy \
		-target=module.docker \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: destroy-digitalocean
destroy-digitalocean:
	@terraform destroy \
		-target=module.digitalocean \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: enter
enter:
	@docker -H ssh://devin@$(DROPLET_ADDRESS) exec -it base fish
