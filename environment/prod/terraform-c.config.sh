#!/bin/bash
set -e

cat>./terraform-c-PROD.auto.tfvars<<EOF

project_name = "wf"

region = "us-east-1"

env = "c"
environment = "prod" 

EOF