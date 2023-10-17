##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  enabled     = var.enabled
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

#Module      : locals
#Description : This terraform module to creat account-billing alarm
locals {

  alarm = {
    name                = "account-billing-alarm-${lower(var.currency)}-${var.environment}"
    description         = var.aws_account_id == null ? "Billing consolidated alarm >= ${var.currency} ${var.monthly_billing_threshold}" : "Billing alarm account ${var.aws_account_id} >= ${var.currency} ${var.monthly_billing_threshold}"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "1"
    metric_name         = "EstimatedCharges"
    namespace           = "AWS/Billing"
    period              = "28800"
    statistic           = "Maximum"
    threshold           = var.monthly_billing_threshold
    alarm_actions       = var.enable ? concat([aws_sns_topic.default[0].arn], var.sns_topic_arns) : var.sns_topic_arns

    dimensions = {
      currency       = var.currency
      linked_account = var.aws_account_id
    }
  }
}

##-----------------------------------------------------------------------------
## Cloudwatch alarm is used to monitor a single cloud watch metric or the result of Match expression using cloud watch metrics.
##-----------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "account_billing_alarm" {
  count               = var.enable ? 1 : 0
  alarm_name          = lookup(local.alarm, "name")
  alarm_description   = lookup(local.alarm, "description")
  comparison_operator = lookup(local.alarm, "comparison_operator")
  evaluation_periods  = lookup(local.alarm, "evaluation_periods", "1")
  metric_name         = lookup(local.alarm, "metric_name")
  namespace           = lookup(local.alarm, "namespace", "AWS/Billing")
  period              = lookup(local.alarm, "period", "28800")
  statistic           = lookup(local.alarm, "statistic", "Maximum")
  threshold           = lookup(local.alarm, "threshold")
  alarm_actions       = lookup(local.alarm, "alarm_actions")

  dimensions = {
    Currency      = lookup(lookup(local.alarm, "dimensions"), "currency")
    LinkedAccount = lookup(lookup(local.alarm, "dimensions"), "linked_account", null)
  }

  tags = module.labels.tags
}

##-----------------------------------------------------------------------------
## Amazon Simple Notification Service (Amazon SNS) coordinates and manages the delivery or sending of messages to subscribing endpoints or clients.
##-----------------------------------------------------------------------------
#tfsec:ignore:aws-sns-enable-topic-encryption
resource "aws_sns_topic" "default" {
  count                                    = var.enable ? 1 : 0
  name                                     = "billing-alarm-notification-${lower(var.currency)}-${var.environment}"
  display_name                             = var.display_name
  policy                                   = var.policy
  delivery_policy                          = var.delivery_policy
  application_success_feedback_role_arn    = var.application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.application_success_feedback_sample_rate
  application_failure_feedback_role_arn    = var.application_failure_feedback_role_arn
  http_success_feedback_role_arn           = var.http_success_feedback_role_arn
  http_success_feedback_sample_rate        = var.http_success_feedback_sample_rate
  http_failure_feedback_role_arn           = var.http_failure_feedback_role_arn
  kms_master_key_id                        = var.kms_master_key_id
  lambda_success_feedback_role_arn         = var.lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate      = var.lambda_success_feedback_sample_rate
  lambda_failure_feedback_role_arn         = var.lambda_failure_feedback_role_arn
  sqs_success_feedback_role_arn            = var.sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate         = var.sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn            = var.sqs_failure_feedback_role_arn
  tags                                     = module.labels.tags
}

##-----------------------------------------------------------------------------
## provides a resource for subscribing to SNS topics. Requires that an SNS topic exist for the subscription to attach to.
##-----------------------------------------------------------------------------
resource "aws_sns_topic_subscription" "this" {
  for_each                        = var.subscribers
  topic_arn                       = join("", aws_sns_topic.default[*].arn)
  protocol                        = var.subscribers[each.key].protocol
  endpoint                        = var.subscribers[each.key].endpoint
  endpoint_auto_confirms          = var.subscribers[each.key].endpoint_auto_confirms
  raw_message_delivery            = var.subscribers[each.key].raw_message_delivery
  filter_policy                   = var.subscribers[each.key].filter_policy
  delivery_policy                 = var.subscribers[each.key].delivery_policy
  confirmation_timeout_in_minutes = var.subscribers[each.key].confirmation_timeout_in_minutes
}
