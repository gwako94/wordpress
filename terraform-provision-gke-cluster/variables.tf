variable "project" {
  type        = string
  description = "The name of the project in which the resources belong."
  default     = "cloudkite-interviews-galgallo"
}


variable "project_id" {
  type        = string
  description = "The ID of the project in which the resources belong."
  default     = "cloudkite-interviews-galgallo1"
}

variable "region" {
  type        = string
  description = "The region in which the cluster master will be created, as well as the default node location."
  default     = "us-west2"
}


variable "secondary_ip_ranges" {
  type        = map(any)
  description = "The ID of the project in which the resources belong."
  default = {
    "pod-ip-range"      = "10.0.0.0/14",
    "services-ip-range" = "10.4.0.0/19"
  }
}


variable "wordpress_db_name" {
  description = "Name of your database. Needs to follow MySQL identifier rules: https://dev.mysql.com/doc/refman/5.7/en/identifiers.html"
  type        = string
  default     = "wordpress_db"
}

variable "wordpress_user_name" {
  description = "The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control."
  type        = string
}

variable "wordpress_user_password" {
  description = "The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control."
  type        = string
}