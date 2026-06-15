## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_failure\_feedback\_role\_arn | IAM role for failure feedback. | `string` | `""` | no |
| application\_success\_feedback\_role\_arn | The IAM role permitted to receive success feedback for this topic. | `string` | `""` | no |
| application\_success\_feedback\_sample\_rate | Percentage of success to sample. | `number` | `100` | no |
| aws\_account\_id | AWS account id | `string` | `null` | no |
| currency | Short notation for currency type (e.g. USD, CAD, EUR) | `string` | `"USD"` | no |
| delivery\_policy | The SNS delivery policy. | `string` | `null` | no |
| display\_name | The display name for the SNS topic. | `string` | `""` | no |
| enable | Boolean indicating whether or not to create sns module. | `bool` | `"true"` | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | n/a | yes |
| http\_failure\_feedback\_role\_arn | IAM role for failure feedback. | `string` | `""` | no |
| http\_success\_feedback\_role\_arn | The IAM role permitted to receive success feedback for this topic. | `string` | `""` | no |
| http\_success\_feedback\_sample\_rate | Percentage of success to sample. | `number` | `100` | no |
| kms\_master\_key\_id | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK. For more information. | `string` | `""` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| lambda\_failure\_feedback\_role\_arn | IAM role for failure feedback. | `string` | `""` | no |
| lambda\_success\_feedback\_role\_arn | The IAM role permitted to receive success feedback for this topic. | `string` | `""` | no |
| lambda\_success\_feedback\_sample\_rate | Percentage of success to sample. | `number` | `100` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| monthly\_billing\_threshold | The threshold for which estimated monthly charges will trigger the metric alarm. | `string` | n/a | yes |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"aws/billing"` | no |
| policy | The fully-formed AWS policy as JSON. For more information about building AWS IAM policy documents with Terraform. | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-cost-billing-alarm/tree/aws-cost-billing-alarm"` | no |
| sns\_topic\_arns | List of SNS topic ARNs to be used. If `create_sns_topic` is `true`, it merges the created SNS Topic by this module with this list of ARNs | `list(string)` | `[]` | no |
| sqs\_failure\_feedback\_role\_arn | IAM role for failure feedback. | `string` | `""` | no |
| sqs\_success\_feedback\_role\_arn | The IAM role permitted to receive success feedback for this topic. | `string` | `""` | no |
| sqs\_success\_feedback\_sample\_rate | Percentage of success to sample. | `number` | `100` | no |
| subscribers | Required configuration for subscibres to SNS topic. | <pre>map(object({<br>    protocol = string<br>    # The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is an option but is unsupported, see below).<br>    endpoint = string<br>    # The endpoint to send data to, the contents will vary with the protocol. (see below for more information)<br>    endpoint_auto_confirms = bool<br>    # Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)<br>    raw_message_delivery = bool<br>    # Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)<br>    filter_policy = string<br>    # JSON String with the filter policy that will be used in the subscription to filter messages seen by the target resource.<br>    delivery_policy = string<br>    # The SNS delivery policy<br>    confirmation_timeout_in_minutes = string<br>    # Integer indicating number of minutes to wait in retying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols.<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| sns\_topic\_arns | List of SNS Topic ARNs to be subscribed to in order to delivery the clodwatch billing alarms |

