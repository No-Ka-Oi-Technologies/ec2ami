# ec2ami.sh

Simple bash script for creation of AMIs from your RUNNING EC2 Instances without rebooting the instances.

## Requirements

- AWSCLI installed & configured
  - If you have multiple AWS accounts, ensure to properly `export AWS_PROFILE=<name_of_account>`

- `jq` for parsing json

## Limitations

- Instances with `tag.Name` that include a space will be truncated due to restrictions with AMI naming

- AMI names are immutable so you cannot have more than one with the same name (i.e. this script isn't meant to be run multiple times a day unless you want to include a timestamp in the AMI name)

## Run

`chmod +x ec2ami.sh`
`./ec2ami.sh` 