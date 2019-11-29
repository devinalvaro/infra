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

.PHONY: clean
clean: clean-docker clean-digitalocean

.PHONY: clean-docker
clean-docker:
	@terraform destroy \
		-target=module.docker \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: clean-digitalocean
clean-digitalocean:
	@terraform destroy \
		-target=module.digitalocean \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)'

.PHONY: enter
enter:
	@ssh $(shell terraform output droplet_base_ipv4_address)
