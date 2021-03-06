# !/bin/bash
set -e

echo "Boot Instance Win..."
instance_id=$(aws ec2 run-instances --launch-template LaunchTemplateId=lt-0376ef5c4d666d6df --subnet subnet-0da163953b5f2df20 --query 'Instances[].[InstanceId]' --output text)
echo $instance_id
aws ec2 wait instance-status-ok --instance-ids $instance_id
echo "...finished"


echo "Test SAP GUI..."
sh_command_id=$(aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"sap_gui\"\n}"],"commandLine":["powershell.exe -File \"deploy.ps1\" \"sap-sources\" \"SAPGUI_CLIENT\""],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1 --output text --query "Command.CommandId")
echo $sh_command_id
echo "Wait 5 min"
sleep 300
result=$(aws ssm get-command-invocation --instance-id $instance_id --command-id "$sh_command_id" --plugin-name runPowerShellScript --output text --query "Status")
echo $result
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi
echo "...finished"


echo "Test HANA Studio..."
sh_command_id=$(aws ssm send-command --document-name "AWS-RunRemoteScript" --document-version "1" --targets "Key=instanceids,Values=$instance_id" --parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\":\"frumania\",\n\"repository\":\"aws-sap-scripts\",\n\"path\":\"hana_studio\"\n}"],"commandLine":["powershell.exe -File \"deploy.ps1\""],"workingDirectory":[""],"executionTimeout":["3600"]}' --timeout-seconds 600 --max-concurrency "50" --max-errors "0" --output-s3-bucket-name "aws-ssm-instance-logs" --region eu-central-1 --output text --query "Command.CommandId")
echo $sh_command_id
echo "Wait 6 min"
sleep 360
result=$(aws ssm get-command-invocation --instance-id $instance_id --command-id "$sh_command_id" --plugin-name runPowerShellScript --output text --query "Status")
echo $result
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi
echo "...finished"


echo "Terminate Instance"
aws ec2 terminate-instances --instance-ids $instance_id


echo "All done!"
