# github-action-terraform-init

GitHub Actions to run `terraform init` and `terraform providers lock`.
If Terraform lock file `.terraform.lock.hcl` is created or updated in `pull_request` event workflow, this action pushes a commit to the remote branch `GITHUB_HEAD_REF`.

## Requirements

* terraform
* [github-comment](https://github.com/suzuki-shunsuke/github-comment)
* [ghcp](https://github.com/int128/ghcp)

## Example

```yaml
- uses: suzuki-shunsuke/github-action-terraform-init@v0.1.2
  with:
    github_app_token: ${{ secrets.GITHUB_APP_TOKEN }}
```

```yaml
- uses: suzuki-shunsuke/github-action-terraform-init@v0.1.2
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    github_app_token: ${{ secrets.GITHUB_APP_TOKEN }}
    working_directory: foo
```

## Inputs

### Required Inputs

name | description
--- | ---
github_app_token | GitHub Access Token. This is used to push a commit to the remote branch

### Optional Inputs

name | default | description
--- | --- | ---
github_token | `github.token` | GitHub Access Token. This is used to notify the failure with github-comment
working_directory | "" (current directory) | Working Directory path
providers_lock_opts | `-platform=windows_amd64 -platform=linux_amd64 -platform=darwin_amd64` | [terraform providers lock](https://www.terraform.io/cli/commands/providers/lock) options

## Outputs

Nothing.

## License

[MIT](LICENSE)
