# Get a list of all running EC2 instances
instance_ids=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId' --output json)

# Set current date for naming AMI
current_date=$(date +"%Y%m%d")

# Loop through each instance and create an AMI without rebooting
for instance_id in $(echo "${instance_ids}" | jq -r '.[]'); do
    # Get the description of the instance
    description=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[].Instances[].Tags[?Key==`Name`].Value' --output text)
    
    # Combine the current date with the full description
    ami_name="$current_date-$description"
    
    # Output instance ID and AMI name
    echo "Instance ID: $instance_id, Creating AMI Name: $ami_name"
    
    # Create the AMI without rebooting and suppress standard output
    if ! aws ec2 create-image --instance-id $instance_id --name "$ami_name" --no-reboot > /dev/null; then
        echo "Error creating AMI for instance: $instance_id" >&2
    fi
done
