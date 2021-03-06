# !/bin/bash
set -e

echo "Boot Instance Linux..."
instance_id=$(aws ec2 run-instances --launch-template LaunchTemplateId=lt-0224bf3ab77c362a2,Version=17 --subnet subnet-0da163953b5f2df20 --query 'Instances[].[InstanceId]' --output text)
echo $instance_id
aws ec2 wait instance-status-ok --instance-ids $instance_id
echo "...finished"


echo "Test Cloud Connector..."
sh_command_id=$(aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"cloud_connector\"\n}"],"commandLine":["deploy.sh"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1 --output text --query "Command.CommandId")
echo $sh_command_id
echo "Wait 3 min"
sleep 180
result=$(aws ssm get-command-invocation --instance-id $instance_id --command-id "$sh_command_id" --plugin-name runShellScript --output text --query "Status")
echo $result
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi
echo "...finished"


echo "Test HANA SDA Athena..."
sh_command_id=$(aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"hana_sda_athena\"\n}"],"commandLine":["deploy.sh s3://aws-athena-hana-int/logs/ eu-central-1"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1 --output text --query "Command.CommandId")
echo $sh_command_id
echo "Wait 3 min"
sleep 180
result=$(aws ssm get-command-invocation --instance-id $instance_id --command-id "$sh_command_id" --plugin-name runShellScript --output text --query "Status")
echo $result
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi
echo "...finished"

#echo "Test HANA Cockpit"
#sh_command_id=$(aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"hana_sda_athena\"\n}"],"commandLine":["deploy.sh s3://sap-sources/HANA_CLIENT/HANA_COCKPIT/ MyHanaCP123#"],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1 --output text --query "Command.CommandId")
#echo "Wait 4 min"
#sleep 300
#result=$(aws ssm list-command-invocations --command-id "$sh_command_id" --details --query "CommandInvocations[].CommandPlugins[].{Status:Status,Output:Output}")
#echo $result

echo "Terminate Instance"
aws ec2 terminate-instances --instance-ids $instance_id


echo "All done!"