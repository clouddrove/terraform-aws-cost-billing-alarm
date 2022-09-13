module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm"

  name                      = "billing/aws"
  environment               = "test"
  label_order               = ["name", "environment"]
  aws_account_id            = 111111111111
  monthly_billing_threshold = 500
  currency                  = "USD"
  aws_sns_topic_arn         = ["arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack"]
}