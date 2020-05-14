module "reflex_aws_budget_modified_or_deleted" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.7"
  rule_name        = "BudgetModifiedOrDeleted"
  rule_description = "A Reflex Rule for detecting the modification or deletion of an AWS Budget"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.budgets"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "budgets.amazonaws.com"
    ],
    "eventName": [
      "UpdateBudget",
      "DeleteBudget"
    ]
  }
}
PATTERN

  function_name   = "BudgetModifiedOrDeleted"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_budget_modified_or_deleted.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
  }

  queue_name    = "BudgetModifiedOrDeleted"
  delay_seconds = 0

  target_id = "BudgetModifiedOrDeleted"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
