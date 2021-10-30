#!/usr/bin/env bash

set -eu
set -o pipefail

terraform init -input=false || github-comment exec -- terraform init -input=false -upgrade

github-comment exec -- terraform providers lock -platform=windows_amd64 -platform=linux_amd64 -platform=darwin_amd64

if ! git diff --exit-code .terraform.lock.hcl; then
	ghcp commit -r "$GITHUB_REPOSITORY" -b "$GITHUB_HEAD_REF" \
		-m "chore(terraform-provider): update .terraform.lock.hcl" \
		-C "$ROOT_DIR" "$WORKING_DIR/.terraform.lock.hcl" \
		--token "$GITHUB_APP_TOKEN"
	exit 1
fi
