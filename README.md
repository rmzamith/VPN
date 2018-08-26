# Artifactory

This repository houses the provisioning and automation scripts for the DT F&I
Artifactory installation.

## Usage

VPN is deployed into AWS using terraform.  We're using terragrunt to
store remote state in DynamoDB and provide a mutually exlcusive lock on
terraform execution.

You need a programatic user already created on IAM to provide aws created.
Also will need a private/public key pairs used to communicate with EC2 instance.

###### STEP 1

Set the required env vars - `AWS_ACCESS_KEY_ID`,
`AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN`.

###### STEP 2

On `terraform/providers/sa_east_1` edit the variables defined on the botton of the 
`terraform.tfvars` to correspond to your aws vpc, key name and public key content.

###### STEP 3

Run terragrunt to plan and apply resources from the correct environment
directory:

```sh
$ cd terraform/providers/sa_east_1
$ terragrunt plan
$ terragrunt apply
```

## Development Notes

All components are split up logically in the `modules` directory.

## Images

The base Amazon AMI images are created by [packer](https://www.packer.io/). In
order to build the image, follow these steps:

```sh
$ make ami
```
