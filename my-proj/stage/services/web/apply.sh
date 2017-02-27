#!/bin/bash
terraform remote config \
        -backend=s3 \
        -backend-config="bucket=karasys-terraform-up-and-running-state" \
        -backend-config="key=my-proj/stage/services/webserver-cluster/terraform.tfstate" \
        -backend-config="region=us-east-1" \
        -backend-config="encrypt=true"

terraform apply
