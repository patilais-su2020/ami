#!/bin/bash -x

packer build \
    --var "aws_access_key=" \
    --var "aws_secret_key=" \
    --var 'aws_region=' \
    templates/ami_aws_ec2_template.json