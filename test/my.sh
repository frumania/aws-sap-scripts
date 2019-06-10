set result = "Failed"
if [[ $result != *"Success"* ]]; then
  echo "Error - Script failed!"
  exit 1
fi