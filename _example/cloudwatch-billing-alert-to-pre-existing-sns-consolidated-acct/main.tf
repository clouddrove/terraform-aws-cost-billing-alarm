provider "aws" {
  region = "us-east-1"
}

module "billing_cloudwatch_alert" {
  source                    = "../.././"
  name                      = "billing/aws"
  environment               = "test"
  monthly_billing_threshold = 500
  currency                  = "USD"
  #sns_topic_arns           = ["arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack"]
  subscribers = {
    sms = {
      protocol                        = "email"
      endpoint                        = "xxxxxclouddrove.com"
      endpoint_auto_confirms          = false
      raw_message_delivery            = false
      filter_policy                   = ""
      delivery_policy                 = ""
      confirmation_timeout_in_minutes = "60"
    }
  }
}
