#!/bin/bash -x

packer build \
    --var "aws_access_key=" \
    --var "aws_secret_key=" \
    --var 'aws_region=' \
    --var 'source_ami=' \
    --var 'ssh_username=' \
    --var 'ami_name=' \
    --var 'ami_users=' \
    
    templates/ami_aws_ec2_template.json