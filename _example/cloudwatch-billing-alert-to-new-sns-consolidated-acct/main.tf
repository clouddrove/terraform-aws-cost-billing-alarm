provider "aws" {
  region = "us-east-1"
}

module "billing_cloudwatch_alert" {
  source                    = "../.././"
  name                      = "billing/aws"
  environment               = "test"
  monthly_billing_threshold = 10
  currency                  = "USD"
  subscribers = {
    sms = {
      protocol                        = "email"
      endpoint                        = "xxxxxxx@clouddrove.com"
      endpoint_auto_confirms          = false
      raw_message_delivery            = false
      filter_policy                   = ""
      delivery_policy                 = ""
      confirmation_timeout_in_minutes = "60"
    }
  }
}
