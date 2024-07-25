# ew-terraform
experiments with terraform

## create s3 bucket to store terraform states (once for all projects)
[Configuring Terraform backend with AWS S3 and DynamoDB state locking - DEV Community](https://dev.to/bhusein/configuring-terraform-backend-with-aws-s3-and-dynamodb-state-locking-96l).

```shell
vim main.tf
```

```terraform
terraform {
  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "5.48.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}
```

check latest version of "hashicorp/aws" (https://registry.terraform.io/providers/hashicorp/aws/latest).

```terraform
# ...

resource "aws_s3_bucket" "terraform-backend-s3-bucket" {
  bucket = <tfstate_bucket_name>
}
```

create unique name for terraform backend s3 bucket and replace <tfstate_bucket_name>:
```shell
echo \"tfstate-$( uuidgen )\"
```

```shell
terraform fmt
terraform init
terraform validate
```

```shell
vim main.tf
```

```terraform
terraform {
  # ...

  backend "s3" {
    bucket = <tfstate_bucket_name>
    key = "common/terraform_backend_s3_bucket.tfstate"
    region = "eu-central-1"
  }
}
```

replace <tfstate_bucket_name> by previous created name.

```shell
terraform fmt
terraform validate
terraform init
```

enter `yes` to copy the previous "local" backend to the newly configured "s3" backend.

## ...
