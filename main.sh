#!/usr/bin/env bash

set -eu
set -o pipefail

if ! terraform init -input=false; then
	# You have to run `terraform init -upgrade` if `terraform init` fails.
	# This happens when there's a change in the version in *.tf files
	# but the lock file hasn't been updated
	github-comment exec -- terraform init -input=false -upgrade
fi
# https://www.terraform.io/docs/cli/commands/providers/lock.html
# To prevent a diff when you run `terraform init` at local on Mac
github-comment exec -- terraform providers lock -platform=linux_amd64 -platform=darwin_amd64
github-comment exec -- git add .terraform.lock.hcl

if ! git diff --cached --exit-code; then
	github-comment exec -- \
		ghcp commit -r "$GITHUB_REPOSITORY" -b "$GITHUB_HEAD_REF" \
		-m "chore(terraform-provider): update .terraform.lock.hcl" \
		-C "$ROOT_DIR" "$WORKING_DIR/.terraform.lock.hcl" \
		--token "$GITHUB_APP_TOKEN"
	exit 1
fi
