output "sns_topic" {
  value = [module.billing_cloudwatch_alert.sns_topic_arns]
}
