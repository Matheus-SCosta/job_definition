variable "platform_capabilities" {
  type = list
  default = [
    "EC2"
  ]
}


variable "propagate_tags" {
  type = bool
  default = false
}


variable "job_definition" {
  
}