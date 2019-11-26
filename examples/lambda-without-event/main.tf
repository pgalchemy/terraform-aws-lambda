terraform {
  required_version = "= 0.12.16"
}

provider aws {
  region  = "us-east-1"
  version = "= 2.35.0"
}

provider random {
  version = "~> 2.1"
}

module lambda {
  source             = "../../"
  lambda_name        = "terratest"
  handler            = "terratest"
  lambda_description = "Lambda function to test terraform-aws-lambda module"
  filename           = "hello_world.zip"
}
