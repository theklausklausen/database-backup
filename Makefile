# variable VERION set to 1.92.0
VERSION := 1.92.0

dec_env:
	sops -d workspace.env > workspace.decrypted.env

enc_env:
	sops -e workspace.decrypted.env > workspace.env

prettier:
	prettier --write .

encrypt:
	@echo "Encrypting ${f} to $$(echo ${f} | sed 's/\.yml/\.enc.yml/g' | sed 's/\.yaml/\.enc.yaml/g')"
	sops --encrypt --encrypted-suffix='secretTemplates' ${f} > $$(echo '${f}' | sed 's/\.yml/\.enc.yml/g' | sed 's/\.yaml/\.enc.yaml/g')

decrypt:
	@echo "Decrypting ${f} to $$(echo ${f} | sed 's/\.enc.yml/\.yml/g' | sed 's/\.enc.yaml/\.yaml/g')"
	sops --decrypt --unencrypted-suffix='secretTemplates' ${f} > $$(echo ${f} | sed 's/\.enc.yml/\.yml/g' | sed 's/\.enc.yaml/\.yaml/g')

apply_secrets:
	for file in $$(find . \( -name "secret.yml" -o -name "secrets.yml" -o -name "secret.yaml" -o -name "secrets.yaml" \) -print); do kubectl apply -f $$file; done

encrypt_secrets:
	for file in $$(find . \( -name "secret.yml" -o -name "secrets.yml" -o -name "secret.yaml" -o -name "secrets.yaml" \) -print); do make encrypt f=$$file; done

decrypt_secrets:
	for file in $$(find . \( -name "secret.enc.yml" -o -name "secrets.enc.yml" -o -name "secret.enc.yaml" -o -name "secrets.enc.yaml" \) -print); do make decrypt f=$$file; done

yaml:
	find . -type f -name '*.yml' -exec yamllint {} \;
	find . -type f -name '*.yaml' -exec yamllint {} \;

lint_helm:
	helm lint database-backup/

helm_render:
	helm template database-backup/
# helm template helm/**

helm_package:
	helm package database-backup/