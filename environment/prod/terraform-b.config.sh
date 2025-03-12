#!/bin/bash
set -e

cat>./terraform-b-PROD.auto.tfvars<<EOF

project_name = "wf"

region = "us-east-1"

env = "b"
environment = "prod" 

EOF