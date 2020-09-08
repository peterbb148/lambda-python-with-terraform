terraform {
 backend "remote" {
   organization = "peterbb"

   workspaces {
     name = "lambda-python-with-terraform"
   }
 }
}

provider "aws" {
  region                    = "eu-west-1"
}

module "aws_lambda_function" {
  source                   = "git::git@github.com:CarlsbergGBS/carlsberg-infra-source.git//modules/tf_aws_lambda?ref=v3.9"

  env                      = var.env
  function_name            = var.function_name
  description              = var.description
  environment              = var.environment_vars
  s3_key                   = var.s3_key
  s3_bucket                = var.s3_bucket
  function_version         = var.function_version
  runtime                  = var.runtime
  vpc_config               = var.vpc_config
  tags                     = var.tags
  memory_size              = var.memory_size
  timeout                  = var.timeout
  handler                  = var.handler
  tracing_config           = var.tracing_config   
  create_api_gateway       = var.create_api_gateway
}


resource "aws_iam_policy" "custom_policy" {
  name        = "${var.env}-${var.function_name}"
  path        = "/"
  description = "Custom policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries"
      ],
      "Resource": [
         "*"
      ]
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "lambda_vpc" {
  role       = module.aws_lambda_function.this_role_name
  policy_arn = aws_iam_policy.custom_policy.arn
}



# module "aws_cloudwatch_rule" {
#   source                   = "git::git@github.com:CarlsbergGBS/carlsberg-infra-source.git//modules/tf_aws_cloudwatch_rule?ref=v4.1"
#   lambda_arn                      = module.aws_lambda_function.this_lambda_arn
#   function_name                   = "${var.env}-${var.function_name}"
#   crs = var.crs
# }
