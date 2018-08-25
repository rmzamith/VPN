IS_PACKER_PRESENT := $(shell command -v packer 2> /dev/null)
IS_TF_PRESENT := $(shell command -v terraform 2> /dev/null)
IS_TG_PRESENT := $(shell command -v terragrunt 2> /dev/null)

.PHONY: check-packer
help:
	@echo "These are the targets you may use:"
	@echo "  ami: creates a new artifactory AMI on AWS"
	@echo "  plan-lab: creates a new artifactory AMI on AWS"

.PHONY: check-packer
check-packer:
ifndef IS_PACKER_PRESENT
	$(error packer is not available. Install packer: https://www.packer.io/downloads.html)
endif

.PHONY: check-tf
check-tf:
ifndef IS_TF_PRESENT
	$(error terraform is not available. Install terraform: https://terraform.io)
endif

.PHONY: check-tg
check-tg:
ifndef IS_TG_PRESENT
	$(error terragrunt is not available. Install terragrunt: https://github.com/gruntwork-io/terragrunt/releases)
endif

.PHONY: ami
ami: check-packer
	@(cd ./packer/aws/bpn/; packer build \
	    ./vpn.json)
	    
# .PHONY: plan
# plan: check-tf check-tg
# 	terragrunt plan
#
# .PHONY: apply
# apply: check-tf check-tg
# 	terragrunt apply
