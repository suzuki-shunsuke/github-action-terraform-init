# github-action-terraform-init

GitHub Actions to run `terraform init` and `terraform providers lock`.
If Terraform lock file `.terraform.lock.hcl` is created or updated, this action pushes a commit to the remote branch `GITHUB_HEAD_REF`.

<img width="894" alt="image" src="https://user-images.githubusercontent.com/13323303/155866735-85f964d8-7bb7-411c-9b20-5f7abcea3e1a.png">

--

<img width="1410" alt="image" src="https://user-images.githubusercontent.com/13323303/155866753-32012a3b-02fe-4f58-935e-178283ae2c77.png">

## Requirements

- terraform
- [github-comment](https://github.com/suzuki-shunsuke/github-comment)
- [ghcp](https://github.com/int128/ghcp)

## Example

```yaml
- uses: suzuki-shunsuke/github-action-terraform-init@main
  with:
    github_app_token: ${{ secrets.GITHUB_APP_TOKEN }}
```

```yaml
- uses: suzuki-shunsuke/github-action-terraform-init@main
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    github_app_token: ${{ secrets.GITHUB_APP_TOKEN }}
    working_directory: foo
    skip_push: "true"
    terraform_command: tofu
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
skip_push | "" | If "true", a commit isn't pushed to the remote branch
terraform_command | terraform | You can execute a tool such as OpenTofu instead of Terraform

## Outputs

Nothing.

## License

[MIT](LICENSE)
