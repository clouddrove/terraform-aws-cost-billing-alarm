module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm"

  name                      = "billing/aws"
  environment               = "test"
  label_order               = ["name", "environment"]
  monthly_billing_threshold = 10
  currency                  = "USD"
}
