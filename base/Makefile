# keys
SSH_KEY_NAME = id_ed25519
SSH_KEY_DIR = .ssh
SSH_KEY_PUB_PATH = ./$(SSH_KEY_DIR)/$(SSH_KEY_NAME).pub
SSH_KEY_PRIV_PATH = ./$(SSH_KEY_DIR)/$(SSH_KEY_NAME)

# tokens
DIGITALOCEAN_TOKEN = $(shell lpass show --notes 'DigitalOcean Access Tokens'/default)

.PHONY: apply
apply: apply-digitalocean apply-docker

.PHONY: apply-digitalocean
apply-digitalocean: ssh-key
	@terraform apply \
		-target=module.digitalocean \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)' \
		-var 'ssh_key_pub_path=$(SSH_KEY_PUB_PATH)' \
		-var 'ssh_key_priv_path=$(SSH_KEY_PRIV_PATH)'

.PHONY: apply-docker
apply-docker: ssh-key
	@terraform apply \
		-target=module.docker \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)' \
		-var 'ssh_key_pub_path=$(SSH_KEY_PUB_PATH)' \
		-var 'ssh_key_priv_path=$(SSH_KEY_PRIV_PATH)'

.PHONY: enter
enter: $(SSH_KEY_PRIV_PATH)
	@ssh -i $(SSH_KEY_PRIV_PATH) $(shell terraform output droplet_base_ipv4_address)

.PHONY: clean
clean: clean-digitalocean
	@rm -rf $(SSH_KEY_DIR)

.PHONY: clean-digitalocean
clean-digitalocean: ssh-key
	@terraform destroy \
		-target=module.digitalocean \
		-var 'digitalocean_token=$(DIGITALOCEAN_TOKEN)' \
		-var 'ssh_key_pub_path=$(SSH_KEY_PUB_PATH)' \
		-var 'ssh_key_priv_path=$(SSH_KEY_PRIV_PATH)'

.PHONY: ssh-key
ssh-key: $(SSH_KEY_DIR) $(SSH_KEY_PUB_PATH) $(SSH_KEY_PRIV_PATH)

$(SSH_KEY_DIR):
	@mkdir -p $(SSH_KEY_DIR)

$(SSH_KEY_PUB_PATH): $(SSH_KEY_DIR)
	@lpass show --notes 'SSH Keys'/default.pub > $(SSH_KEY_PUB_PATH)

$(SSH_KEY_PRIV_PATH): $(SSH_KEY_DIR)
	@lpass show --notes 'SSH Keys'/default > $(SSH_KEY_PRIV_PATH)
	@chmod 600 $(SSH_KEY_PUB_PATH)
