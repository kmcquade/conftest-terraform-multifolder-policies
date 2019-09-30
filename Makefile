.PHONY: init plan show test all clean

all:
	@echo  "Running ALL"
	make plan
	make show
	@echo "Running OPA unit tests"
	make unit-test
	@echo "Running conftest test"
	make test

test:
	@opa test policy -v

fmt:
	@opa fmt policy/*.rego -w

TF_MODULE_SUBFOLDER="./terraform/$(TF_MODULE_NAME)"
PLAN_FILE = plan.tfplan
SHOW_FILE = plan.json
ROOT_DIR = $(shell pwd)
NAMESPACE=${CONFTEST_NAMESPACE}

conftest: tfplan show conftest-test

tfplan:
	cd $(TF_MODULE_SUBFOLDER) && \
	 	terraform init && \
		pwd && \
		terraform plan -out=$(PLAN_FILE) && \
		cd $(ROOT_DIR)

show:
	cd $(TF_MODULE_SUBFOLDER) && \
		terraform show -json $(PLAN_FILE) | jq . -M > $(SHOW_FILE)

unit-test:
	opa test policy

unit-test-verbose:
	opa test -v policy

conftest-test:
	conftest test $(TF_MODULE_SUBFOLDER)/$(SHOW_FILE) -p policy 

conftest-test-trace:
	conftest test --trace $(TF_MODULE_SUBFOLDER)/$(SHOW_FILE) -p policy 

clean:
	@rm -f $(TF_MODULE_SUBFOLDER)/$(PLAN_FILE) $(TF_MODULE_SUBFOLDER)/$(SHOW_FILE)
