##### General Configs #####

variable "project_name" {
  description = "O nome do projeto, usado para nomear recursos no escopo deste Terraform."
  type        = string
}

variable "region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
}

variable "environment" {
  type        = string
  description = "Deploy environment"
  validation {
    condition     = length(regex("(prod|dev|hml)", var.environment)) == 1
    error_message = "Environment setup should be only 'prod' or 'dev' or 'hml'."
  }
}

variable "env" {
  type        = string
  description = "Define if the environment should be 'a' or 'b'"
  validation {
    condition     = contains(["a", "b"], var.env)
    error_message = "The 'env' variable must be either 'a' or 'b'."
  }
}

variable "vault_token" {}
variable "vault_addr" {}

##### SSM VPC #####

variable "ssm_vpc_id" {
  description = "O ID da VPC onde os recursos relacionados ao SSM serão criados."
  type        = string
}

variable "ssm_public_subnet_1" {
  description = "O ID da primeira subnet pública na VPC para recursos SSM."
  type        = string
}

variable "ssm_public_subnet_2" {
  description = "O ID da segunda subnet pública na VPC para recursos SSM."
  type        = string
}

variable "ssm_public_subnet_3" {
  description = "O ID da terceira subnet pública na VPC para recursos SSM."
  type        = string
}

variable "ssm_private_subnet_1" {
  description = "O ID da primeira subnet privada na VPC para recursos SSM."
  type        = string
}

variable "ssm_private_subnet_2" {
  description = "O ID da segunda subnet privada na VPC para recursos SSM."
  type        = string
}

variable "ssm_private_subnet_3" {
  description = "O ID da terceira subnet privada na VPC para recursos SSM."
  type        = string
}

##### Balancer #####

variable "load_balancer_internal" {
  description = "Define se o Load Balancer deve ser interno (true) ou externo (false)."
  type        = bool
  }

variable "load_balancer_type" {
  description = "O tipo de Load Balancer a ser criado (ex: 'application' ou 'network')."
  type        = string
}

#### ECS General ######

variable "nodes_ami" {
  description = "A AMI a ser usada pelos nodes do cluster ECS."
  type        = string
  default     = ""
}


variable "node_instance_type" {
  description = "O tipo de instância EC2 a ser usado pelos nodes do ECS."
  type        = string
}

variable "node_volume_size" {
  description = "O tamanho do volume, em GiB, a ser usado pelos nodes do ECS."
  type        = number
}

variable "node_volume_size2" {
  description = "O tamanho do volume, em GiB, a ser usado pelos nodes do ECS."
  type        = number
}

variable "node_volume_type" {
  description = "O tipo de volume EBS a ser usado pelos nodes do ECS (ex: 'gp2', 'io1')."
  type        = string
}

variable "cluster_on_demand_min_size" {
  description = "O tamanho mínimo do cluster ECS para instâncias on-demand."
  type        = number
}

variable "cluster_on_demand_max_size" {
  description = "O tamanho máximo do cluster ECS para instâncias on-demand."
  type        = number
}

variable "cluster_on_demand_desired_size" {
  description = "O número desejado de instâncias on-demand no cluster ECS."
  type        = number
}

variable "cluster_spot_min_size" {
  description = "O tamanho mínimo do cluster ECS para instâncias spot."
  type        = number
}

variable "cluster_spot_max_size" {
  description = "O tamanho máximo do cluster ECS para instâncias spot."
  type        = number
}

variable "cluster_spot_desired_size" {
  description = "O número desejado de instâncias spot no cluster ECS."
  type        = number
}



