#!/bin/bash
set -e

cat>./terraform-a-DEV.auto.tfvars<<EOF

project_name = "wf"

region = "us-east-1"

env = "a"
environment = "dev" 

##### SSM VPC Parameters ##### 

ssm_vpc_id = "/wf-vpc/vpc/vpc_id"

ssm_public_subnet_1 = "/wf-vpc/vpc/subnet_public_1a"

ssm_public_subnet_2 = "/wf-vpc/vpc/subnet_public_1b"

ssm_public_subnet_3 = "/wf-vpc/vpc/subnet_public_1c"

ssm_private_subnet_1 = "/wf-vpc/vpc/subnet_private_1a"

ssm_private_subnet_2 = "/wf-vpc/vpc/subnet_private_1b"

ssm_private_subnet_3 = "/wf-vpc/vpc/subnet_private_1c"


##### Balancer #####

load_balancer_internal = false

load_balancer_type = "application"


#### ECS General ######


node_instance_type = "t3.micro"

node_volume_size = "30"

node_volume_size2 = "20"

node_volume_type = "gp3"

cluster_on_demand_min_size = 2

cluster_on_demand_max_size = 4

cluster_on_demand_desired_size = 3

cluster_spot_min_size = 2

cluster_spot_max_size = 4

cluster_spot_desired_size = 3



EOF