variable "pm_url" {
  description = "url of api server"
  type        = string
  sensitive   = true
}

variable "pm_token_id" {
  description = "token id"
  type        = string
  sensitive   = true
}

variable "pm_token_secret" {
  description = "secret"
  type        = string
  sensitive   = true
}

variable "cipassword" {
  description = "cloud init password"
  type        = string
  sensitive   = true
}

variable "ciuser" {
  description = "cloud init user"
  type        = string
  sensitive   = true
}

