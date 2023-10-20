#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = "aws/billing"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-cost-billing-alarm/tree/aws-cost-billing-alarm"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "environment" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

#Module      :Cloudwatch Billing Alarm
#Description : Terraform Cloudwatch Billing Alarm module variables.

variable "monthly_billing_threshold" {
  type        = string
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
}

variable "currency" {
  type        = string
  default     = "USD"
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
}

variable "aws_account_id" {
  type        = string
  default     = null
  description = "AWS account id"
}

#Module      : SNS TOPIC
#Description : Terraform SNS TOPIC module variables.

variable "display_name" {
  type        = string
  default     = ""
  description = "The display name for the SNS topic."
}

variable "policy" {
  type        = string
  default     = ""
  description = "The fully-formed AWS policy as JSON. For more information about building AWS IAM policy documents with Terraform."
}

variable "delivery_policy" {
  type        = string
  default     = null
  description = "The SNS delivery policy."
}

variable "sns_topic_arns" {
  type        = list(string)
  default     = []
  description = "List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs"
}

variable "application_success_feedback_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role permitted to receive success feedback for this topic."
}

variable "application_success_feedback_sample_rate" {
  type        = number
  default     = 100
  description = "Percentage of success to sample."
}

variable "application_failure_feedback_role_arn" {
  type        = string
  default     = ""
  description = "IAM role for failure feedback."
}

variable "http_success_feedback_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role permitted to receive success feedback for this topic."
  sensitive   = true
}

variable "http_success_feedback_sample_rate" {
  type        = number
  default     = 100
  description = "Percentage of success to sample."
}

variable "http_failure_feedback_role_arn" {
  type        = string
  default     = ""
  description = "IAM role for failure feedback."
}

variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information."
}

variable "lambda_success_feedback_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role permitted to receive success feedback for this topic."
}

variable "lambda_success_feedback_sample_rate" {
  type        = number
  default     = 100
  description = "Percentage of success to sample."
}

variable "lambda_failure_feedback_role_arn" {
  type        = string
  default     = ""
  description = "IAM role for failure feedback."
}

variable "sqs_success_feedback_role_arn" {
  type        = string
  default     = ""
  description = "The IAM role permitted to receive success feedback for this topic."
}

variable "sqs_success_feedback_sample_rate" {
  type        = number
  default     = 100
  description = "Percentage of success to sample."
}

variable "sqs_failure_feedback_role_arn" {
  type        = string
  default     = ""
  description = "IAM role for failure feedback."
}

variable "enable" {
  type        = bool
  default     = "true"
  description = "Boolean indicating whether or not to create sns module."
}

variable "subscribers" {
  type = map(object({
    protocol = string
    # The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is an option but is unsupported, see below).
    endpoint = string
    # The endpoint to send data to, the contents will vary with the protocol. (see below for more information)
    endpoint_auto_confirms = bool
    # Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)
    raw_message_delivery = bool
    # Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)
    filter_policy = string
    # JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource.
    delivery_policy = string
    # The SNS delivery policy
    confirmation_timeout_in_minutes = string
    # Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols.
  }))
  description = "Required configuration for subscibres to SNS topic."
  default     = {}
}
