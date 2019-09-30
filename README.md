# conftest-terraform-multifolder-policies

Example of how to use conftest in a modular fashion with Terraform 0.12 plans.

## Prerequisites

* Terraform 0.12 installed
* Authenticated to AWS CLI (for the Terraform plan)
* [Conftest](https://github.com/instrumenta/conftest/) >= 0.13.0 installed
* [Open Policy Agent](https://github.com/open-policy-agent/opa) >= 0.14.1 installed

## Instructions

### OPA Unit Tests

* I don't have any unit tests right now, but when we add some you can just run `make test`

### Formatting

* Run `make fmt` to correctly format the rego policy files

### Conftest tests

We want to avoid a situation where the unit tests work but it doesn't work with
conftest IRL. You can insert your compliant and non-compliant Terraform code to
test in the [terraform](terraform/) folder. Please ensure that the folder name
follows this format:

* `terraform/rule-description-fail`
* `terraform/rule-description-pass`

Once you have your Terraform code set up, export the name of the folder for your
Terraform code as an environment variable:

```bash
export TF_MODULE_NAME=s3-encryption-pass
```

* Then to test, run `make conftest`

To troubleshoot errors in policy execution, you can also run `make conftest-test-trace`.


### Adding a policy

* All new policies can be added to the `policy` folder. When adding a new policy:

  1. If the test covers a new service other than those that already exist:
    - Add a folder under the [policy/](policy/) folder
    - Add a rego file that matches the service for common functions. For example, the [policy/s3/s3.rego](policy/s3/s3.rego) file just creates a list of `aws_s3_bucket` resources to be analyzed by the other policy files under the [policy/s3/](policy/s3) folder.
  2. For the specific policy to be added, ensure that it creates a list of resources meeting violation criteria, which is then called by the [policy/main.rego](policy/main.rego) folder. It is helpful to do this instead of simple true/false rules because it tells the user which specific resource meets the violation criteria. In the case of large Terraform plans with many nested modules, the user should know whether it is their own Terraform code that meets violation criteria, or if it is the fault of the nested Terraform module.
  3. Add a `deny` statement to the [policy/main.rego](policy/main.rego) file, following the format of the existing rules.

In general, use the existing policies for inspiration and mirror their structure/approach accordingly.