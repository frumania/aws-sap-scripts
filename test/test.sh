# !/bin/bash

sh_command_id="c580b59b-31b7-4d6b-a119-8d73a338ee92"
instance_id="i-0beb34f54767b1818"

while true; do
    finished=0
    
    STATUS=$( aws ssm get-command-invocation --command-id "$sh_command_id" --instance-id "$instance_id" --plugin-name "downloadContent" --query "Status" --output text | tr '[A-Z]' '[a-z]' )
    NOW=$( date +%Y-%m-%dT%H:%M:%S%z )

    echo $NOW $instance_id: $STATUS
    case $STATUS in
        pending|inprogress|delayed) : ;;
        *) finished=$(( finished + 1 )) ;;
    esac

    [ $finished -ge 1 ] && break
    sleep 2
done
result=$(aws ssm get-command-invocation --instance-id $instance_id --command-id "$sh_command_id" --plugin-name runPowerShellScript --output text --query "Status")
echo $result
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi

echo "ALL DONE"