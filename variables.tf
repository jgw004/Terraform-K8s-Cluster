variable "region" {
    decription = "AWS region"
    type       = string
    default    = "us-east-2"
}

variable "enable_logging" {
    description = "enable/disable cluster plane logging"
    type        = bool
    default     = false         ## default disabled logging
}