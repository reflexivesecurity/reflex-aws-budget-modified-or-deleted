module "cwe" {
  source      = "git::https://github.com/reflexivesecurity/reflex-engine.git//modules/cwe?ref=v2.1.2"
  name        = "BudgetModifiedOrDeleted"
  description = "A Reflex Rule for detecting the modification or deletion of an AWS Budget"

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
