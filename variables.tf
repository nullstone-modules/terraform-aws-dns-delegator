variable "zone_id" {
  description = "The AWS Route53 Zone ID for the zone that this user will be able to modify."
  type        = string
}

variable "name" {
  description = "The name of the IAM User to create for dns delegation."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
