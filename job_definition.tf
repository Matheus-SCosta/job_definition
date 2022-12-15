resource "aws_batch_job_definition" "job_definition_batch" {
  for_each = var.job_definition
  name       = each.value.name_job_definition
  type       = each.value.type_job_definition
  platform_capabilities = try(each.value.platform_capabilities, var.platform_capabilities)
  parameters = each.value.parameters
  container_properties = each.value.container_properties
  propagate_tags = try(each.value.propagate_tags, var.propagate_tags)

  dynamic retry_strategy {
    for_each = try([each.value.retry_strategy], [])
    content {
        attempts = try(retry_strategy.value.attempts, null)
        dynamic evaluate_on_exit {
            for_each = try([retry_strategy.value.evaluate_on_exit], {})
            content {
                action = try(evaluate_on_exit.value.action, null)
                on_exit_code = try(evaluate_on_exit.value.on_exit_code, null)
                on_reason = try(evaluate_on_exit.value.on_reason, null)
                on_status_reason = try(evaluate_on_exit.value.on_status_reason, null)   
            }
        }
    }
  }

  dynamic timeout {
    for_each = try([each.value.timeout], {})
    content {
        attempt_duration_seconds = timeout.value.attempt_duration_seconds < 60 ? 60 : timeout.value.attempt_duration_seconds
    }
  }

  tags = each.value.tags

}