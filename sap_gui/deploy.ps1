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

Write-Host "Download software from bucket $bucket/$prefix"

Read-S3Object -BucketName $bucket -KeyPrefix $prefix -Folder $mypath

#.\GUI760_1-80003144.EXE /noDlg

$files = get-childitem -Filter *GUI*.exe $mypath
foreach ($file in $files)
{
  Write-Host "Install SAP GUI $file"
  Start-Process $file.Fullname -ArgumentList "/noDlg"
}

sleep 120

echo "Checking installation..."

if (!(Test-Path "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe")) {
  echo "Error - Script failed!"
  exit 1
}

echo "ALL DONE"