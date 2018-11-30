BUILD_TAG := $(or $(BUILD_TAG), $(shell date +%s))
KUBERNETES_VERSION ?= 1.10.3

DATE ?= $(shell date +%Y-%m-%d)

AWS_DEFAULT_REGION = eu-west-1

.PHONY: all validate ami

all: ami

validate:
	docker-compose run --rm -T packer validate eks-worker-bionic.json

ami: validate
	docker-compose run --rm -T packer build -color=false -var build_tag=$(BUILD_TAG) -var source_ami_id=$(SOURCE_AMI_ID) eks-worker-bionic.json
