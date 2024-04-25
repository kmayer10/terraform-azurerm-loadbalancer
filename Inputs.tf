variable "name" {
  description = "Enter Value to be used for name arguments"
  default = "demo"
}
variable "resource_group_name" {
  description = "Resource Group Name to create Resources."
}
variable "location" {
  description = "Location to create Resources."
  default = "eastus"
}
variable "allocation_method" {
  description = "Enter: (Static/Dynamic)"
  default = "Static"
}
variable "ports" {
  description = "Enter the Port information for Probe & NATRule creation in format as: [\"SSH-22-TCP\",\"HTTP-80-TCP\"]"
  default = ["SSH-22-Tcp"]
}