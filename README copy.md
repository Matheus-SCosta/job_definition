# Usage:

```
module "job_definition" {
  source = "git::https://github.com/ps-moip/moip-aws-resources-modules.git//job_definition_batch"
  job_definition = {
    hitch = {
        name_job_definition = lookup(var.name_job_definition_hitch, var.environment)
        type_job_definition = "container"
        platform_capabilities = var.platform_capabilities
        container_properties = jsonencode({
            command     = var.comands
            image       = var.image
            environment = var.environments
            memory      = lookup(var.memory, var.environment)
            vcpus       = lookup(var.cpu, var.environment)
            logConfiguration = {
                logDriver = var.log_driver
                options   = var.options_log
            }
        })
        tags = var.tags
        parameters = var.parameters
        propagate_tags = var.propagate_tags
        retry_strategy = {
          attempts = var.attempts
          evaluate_on_exit = {
            action = var.action
            on_exit_code = var.on_exit_code
            on_reason = var.on_reason
            on_status_reason = var.on_status_reason
          }  
        }
        timeout = {
            attempt_duration_seconds = var.attempt_duration_seconds
        }
            
    }
  }
}
```

# Variables:

| Name                          | Type      | Required  | Default                     |  Description                                           |
|-------------------------------|-----------|-----------|-----------------------------|--------------------------------------------------------| 
| `name_job_definition`         | string    | yes       |                             | 
| `type_job_definition`         | string    | yes       |                             | 
| `platform_capabilities`       | list      | no        | ["EC2"]                     |
| `container_properties`        | list      | yes       |                             |
| `tags`                        | map       | yes       |                             |
| `parameters`                  | list      | yes       |                             |
| `propagate_tags`              | bool      | no        | false                       |
| `retry_strategy`              | map       | no        |                             |
| `attempts`                    | number    | no        |                             |
| `evaluate_on_exit`            | map       | no        |                             |
| `action`                      | string    | no/yes    |                             | Apenas se a variável `evaluate_on_exit`  for passada, o action se torna obrigatório |
| `on_exit_code`                | number    | no        |                             |
| `on_reason`                   | string    | no        |                             |
| `on_status_reason`            | string    | no        |                             |
| `container_properties`        | json      | no        |                             |
| `comands`                     | list      | no        |                             |
| `image`                       | string    | no        |                             |
| `environment`                 | list[maps]| no        |                             |
| `memory`                      | number    | no        |                             |
| `vcpus`                       | number    | no        |                             |
| `logConfiguration`            | map       | no        |                             |
| `logDriver`                   | string    | no        |                             | Por padrão, ideal usar splunk
| `options`                     | string    | no        |                             | Opcoes para a configuracão do splunk, como source-type
| `timeout`                     | map       | no        |                             |
| `attempt_duration_seconds`    | number    | no        |                             |



