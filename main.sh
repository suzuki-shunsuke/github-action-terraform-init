#!/usr/bin/env bash

set -euo pipefail

CMD=terraform
if [ "${USE_OPENTOFU}" = true ]; then
  CMD=tofu
fi

if [ "$SKIP_PUSH" = "true" ]; then
  github-comment exec -- "$CMD" init -input=false
  exit 0
fi

exist_lock_file=false
if [ -f .terraform.lock.hcl ]; then
  exist_lock_file=true
fi

"$CMD" init -input=false || github-comment exec -- "$CMD" init -input=false -upgrade

# shellcheck disable=SC2086
github-comment exec -- "$CMD" providers lock $PROVIDERS_LOCK_OPTS

if [ "$exist_lock_file" = "false" ] || ! git diff --quiet .terraform.lock.hcl; then
	ghcp commit -r "$GITHUB_REPOSITORY" -b "$GITHUB_HEAD_REF" \
		-m "chore: update .terraform.lock.hcl" \
		-C "$ROOT_DIR" "$WORKING_DIR/.terraform.lock.hcl" \
		--token "$GITHUB_APP_TOKEN"
	exit 1
fi
