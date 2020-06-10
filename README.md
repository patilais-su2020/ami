
# AMAZON MACHINE IMAGE

Amazon Machine Image

## Installations

Install packer using the following commands:
```
wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer_1.6.0_linux_amd64.zip
sudo mv packer /usr/local/bin/
```

## Configure AWS
Configure your IAM users using the following command: 

``` aws configure --profile dev ```
```	aws configure --profile prod ```

## Validate packer

Validate your packer file:

``` packer validate templates/ami_aws_ec2_template.json ``` 

## Build Packer

Build your your packer file to create a new AMI
``` 
packer build 
	--var "aws_access_key={your values}" 
	--var "aws_secret_key={your values}" 
	--var 'aws_region={your values}' 
	--var 'source_ami={your values}' 
	--var 'ssh_username={your values}' 
	--var 'ami_name={your values}' 
	--var 'ami_users={your values}' 
	```