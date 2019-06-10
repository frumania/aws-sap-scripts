echo "START"
$ErrorActionPreference = "Stop"
$bucket = $Args[0]
$prefix = $Args[1]

$mypath = "c:/tmp_sapgui"
If(!(test-path $mypath))
{
      New-Item -ItemType Directory -Force -Path $mypath
}

cd $mypath

echo "Download software from bucket..."

Read-S3Object -BucketName $bucket -KeyPrefix $prefix -Folder $mypath

echo "Install SAP GUI 7.60"

.\GUI760_1-80003144.EXE /noDlg

sleep 120

if (!(Test-Path "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe")) {
  echo "Error - Script failed!"
  exit 1
}

echo "ALL DONE"