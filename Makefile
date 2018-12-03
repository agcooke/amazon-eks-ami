BUILD_TAG := $(or $(BUILD_TAG), $(shell date +%s))
KUBERNETES_VERSION ?= 1.10.3

DATE ?= $(shell date +%Y-%m-%d)

AWS_DEFAULT_REGION ?= "us-east-2"

.PHONY: all validate ami

all: ami

validate:
	docker-compose run --rm -T packer validate eks-worker-bionic.json

ami: validate
	docker-compose run --rm -T packer build -color=false -var aws_region=${AWS_DEFAULT_REGION} -var build_tag=$(BUILD_TAG) -var source_ami_id=$(SOURCE_AMI_ID) eks-worker-bionic.json
