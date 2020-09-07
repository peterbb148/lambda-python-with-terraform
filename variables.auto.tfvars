env                = "dev"
region             = "eu-west-1"
function_name      = "cx-lambda-get"
description        = "cx-lambda-get"
s3_key             = "cx-lambda-initial-image-nodejs/cx-lambda-initial-image-nodejs.zip"
s3_bucket          = "dev-cx-lambda-deploys"
stage_name         = "stable"
function_version   = "v.0.0.1"
runtime            = "nodejs12.x"
create_api_gateway = false

# Entry point\
# "main" is the filename within the zip file (main.js) and "handler"
# is the name of the property under which the handler function was
# exported in that file
handler          = "index.handler"

# Memory size (128 to 3000 in 64 steps)
memory_size      = 128

# Execution timeout
timeout          = 3

# No limits coccurrent
concurrent_executions = -1

# Activate X-Ray
tracing_config      = { mode = "Active" }

vpc_config = {
  subnet_ids         = ["subnet-0f183aa846de70e5c","subnet-0c5186e6aef47899b","subnet-01e882eedcb4bed25"]
  security_group_ids = ["sg-02305252927c026f6"]
}

environment_vars = {
  Environment = "dev"
}

tags = {
  Environment = "dev"
}

# Cloudwatch
# crs = [
#   {
#   cloudwatch_rule_input          = "{  \"name\": \"cx-catalog-services.tst.services\",  \"path\": \"/services/import/catalog?salesOrg=2040\",  \"port\": 1203 }"
#   cloudwatch_rulename_postfix    = "catalog-services_for_salesOrg_2040"
#   cloudwatch_description         = "Fires every one hour"
#   cloudwatch_schedule_expression = "rate(1 hour)"
#   },
#   {
#   cloudwatch_rule_input          = "{  \"name\": \"cx-pricing-services.tst.services\",  \"path\": \"/services/import/pricing?salesOrg=2040\",  \"port\": 1205 }"
#   cloudwatch_rulename_postfix    = "pricing-services_for_salesOrg_2040"
#   cloudwatch_description         = "Fires every one hour"
#   cloudwatch_schedule_expression = "rate(1 hour)"
#   },
#   {
#   cloudwatch_rule_input          = "{  \"name\": \"cx-pricing-services.tst.services\",  \"path\": \"/services/import/promotions?salesOrg=2040\",  \"port\": 1205 }"
#   cloudwatch_rulename_postfix    = "promotions-services_for_salesOrg_2040"
#   cloudwatch_description         = "Fires every one hour"
#   cloudwatch_schedule_expression = "rate(1 hour)"
#   },
#   {
#   cloudwatch_rule_input          = "{  \"name\": \"cx-target-groups-services.tst.services\",  \"path\": \"/services/import/target/groups?salesOrg=2040\",  \"port\": 1206 }"
#   cloudwatch_rulename_postfix    = "target-groups-services_for_salesOrg_2040"
#   cloudwatch_description         = "Fires every one hour"
#   cloudwatch_schedule_expression = "rate(1 hour)"
#   },
#   {
#   cloudwatch_rule_input          = "{  \"name\": \"cx-target-groups-services.tst.services\",  \"path\": \"/services/import/target/groups?salesOrg=1010\",  \"port\": 1206 }"
#   cloudwatch_rulename_postfix    = "target-groups-services_for_salesOrg_1010"
#   cloudwatch_description         = "Fires every one hour"
#   cloudwatch_schedule_expression = "rate(1 hour)"
#   }  
# ]

