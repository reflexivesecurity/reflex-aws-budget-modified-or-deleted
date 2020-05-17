module "sqs_lambda" {
  function_name   = "BudgetModifiedOrDeleted"
  source_code_dir = "${path.module}/../../source"
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
