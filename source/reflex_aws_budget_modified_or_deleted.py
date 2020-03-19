""" Module for BudgetModifiedOrDeleted """

import json
import os

import boto3
from reflex_core import AWSRule


class BudgetModifiedOrDeleted(AWSRule):
    """ A Reflex Rule for detecting the modification or deletion of AWS Budgets """

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        self.event_name = event["detail"]["eventName"]

        if self.event_name == "UpdateBudget":
            self.event_type = "updated"
            self.budget_name = event["detail"]["requestParameters"]["newBudget"]["budgetName"]
        else:  # self.event_name == "DeleteBudget"
            self.event_type = "deleted"
            self.budget_name = event["detail"]["requestParameters"]["budgetName"]

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        # We simply want to know when this event occurs. Since this rule was
        # triggered we know that happened, and we want to alert. Therefore
        # the resource is never compliant.
        return False

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"The AWS Budget {self.budget_name} was {self.event_type}."


def lambda_handler(event, _):
    """ Handles the incoming event """
    rule = BudgetModifiedOrDeleted(json.loads(event["Records"][0]["body"]))
    rule.run_compliance_rule()
