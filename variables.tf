########################################
# Général / région
########################################

variable "aws_region" {
  description = "Région AWS de déploiement"
  type        = string
  default     = "us-east-1"
}

variable "environment_name" {
  description = "Préfixe utilisé pour nommer et tagger toutes les ressources"
  type        = string
  default     = "prod"
}

########################################
# Réseau
########################################

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "app_subnet_1_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "app_subnet_2_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "data_subnet_1_cidr" {
  type    = string
  default = "10.0.21.0/24"
}

variable "data_subnet_2_cidr" {
  type    = string
  default = "10.0.22.0/24"
}

########################################
# Sécurité / WAF 
########################################

variable "waf_rate_limit" {
  description = "Nombre max de requêtes par IP sur 5 minutes avant blocage par le WAF"
  type        = number
  default     = 2000
}

variable "log_retention_in_days" {
  description = "Durée de rétention des logs WAF dans CloudWatch Logs"
  type        = number
  default     = 90
}

########################################
# Niveau web 
########################################

variable "web_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "web_ami_ssm_parameter" {
  description = "Paramètre SSM pointant vers la dernière AMI Amazon Linux 2023"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

variable "web_min_size" {
  type    = number
  default = 2
}

variable "web_max_size" {
  type    = number
  default = 4
}

variable "web_desired_capacity" {
  type    = number
  default = 2
}

########################################
# Niveau applicatif
########################################

variable "app_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "app_min_size" {
  type    = number
  default = 2
}

variable "app_max_size" {
  type    = number
  default = 4
}

variable "app_desired_capacity" {
  type    = number
  default = 2
}

########################################
# Base de données
########################################

variable "db_username" {
  description = "Nom d'utilisateur maître de la base de données"
  type        = string
  default     = "appadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Mot de passe de la base de données (min 8 caractères)"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "Le mot de passe doit contenir au moins 8 caractères."
  }
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}
