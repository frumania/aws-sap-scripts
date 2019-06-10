echo "START"
$ErrorActionPreference = "Stop"
$bucket = $Args[0]
$prefix = $Args[1]

mkdir c:/tmp_sapgui
cd c:/tmp_sapgui

echo "Download software from bucket..."

Read-S3Object -BucketName $bucket -KeyPrefix $prefix -Folder c:/tmp_sapgui

echo "Install SAP GUI 7.60"

.\GUI760_1-80003144.EXE /noDlg

sleep 120

if (!(Test-Path "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe")) {
  echo "Error - Script failed!"
  exit 1
}

echo "Clean up..."

rm c:/tmp_sapgui -R

echo "ALL DONE"