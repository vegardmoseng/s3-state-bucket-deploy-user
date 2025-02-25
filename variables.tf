########################################
# ENV
########################################

variable "env" {
    type        = string
    description = "Either: dev, uat or prod"
    default     = "dev"
}

########################################
# IAM
########################################

variable "state_bucket_deployer_name" {
    type        = string
    description = "S3 state user deployer user"
    default     = null
}

variable "state_bucket_deployer_role_name" {
    type        = string
    description = "S3 state bucket deployer role"
    default     = null
}

variable "state_bucket_deployer_policy_name" {
    type        = string
    description = "S3 state bucket deployer policy"
    default     = null  
}