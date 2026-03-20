output "sns_topic" {
  value       = [module.billing_cloudwatch_alert.sns_topic_arns]
  description = "List of SNS Topic ARNs to be subscribed to in order to delivery the clodwatch billing alarms."
}
