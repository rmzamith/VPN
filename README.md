# Artifactory

This repository houses the provisioning and automation scripts for the DT F&I
Artifactory installation.

## Usage

VPN is deployed into AWS using terraform.  We're using terragrunt to
store remote state in DynamoDB and provide a mutually exlcusive lock on
terraform execution.

###### STEP 1

Set the required env vars - `AWS_ACCESS_KEY_ID`,
`AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN`.

###### STEP 2

Run terragrunt to plan and apply resources from the correct environment
directory:

```sh
$ cd terraform/providers/sa_east_1
$ terragrunt plan
$ terragrunt apply
```

## Development Notes

All components are split up logically in the `modules` directory.