module "cwe" {
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

}
