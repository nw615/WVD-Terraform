variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "tags" {
  description = "default tags"
  type        = map(any)
}