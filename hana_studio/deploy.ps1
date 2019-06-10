echo "START"
$ErrorActionPreference = "Stop"
$bucket = $Args[0]
$prefix = $Args[1]

$mypath = "c:/tmp_eclipse"
If(!(test-path $mypath))
{
      New-Item -ItemType Directory -Force -Path $mypath
}

cd $mypath
Read-S3Object -BucketName $bucket -KeyPrefix $prefix -Folder $mypath

amazon-corretto-8.212.04.2-windows-x64.msi /qn /L* "install.log" /norestart ALLUSERS=2

sleep 60

[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Amazon Corretto\jdk1.8.0_212")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$($Env:JAVA_HOME)\bin", "User")

Expand-Archive -Path eclipse-java-2019-03-R-win32-x86_64.zip -DestinationPath $mypath

cd eclipse

#.\eclipse.exe -nosplash \
#  -application org.eclipse.equinox.p2.director \
#  -repository http://download.eclipse.org/releases/indigo/,http://download.eclipse.org/tools/cdt/releases/helios/ \
#  -destination C:\tmp\eclipse\eclipse \
#  -installIU org.eclipse.cdt.feature.group \
#  -installIU org.eclipse.cdt.sdk.feature.group \
#  -installIU org.eclipse.cdt.platform.feature.group \
#  -installIU org.eclipse.cdt.debug.ui.memory.feature.group \
#  -installIU org.eclipse.cdt.debug.edc.feature.group \
#  -installIU org.eclipse.cdt.util.feature.group

#.\eclipse.exe -nosplash -application org.eclipse.equinox.p2.director -repository http://download.eclipse.org/releases/indigo/,http://download.eclipse.org/tools/cdt/releases/helios/ -destination C:\tmp\eclipse\eclipse -installIU org.eclipse.cdt.feature.group

echo "ALL DONE"