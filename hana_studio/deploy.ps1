 echo "START"
$ErrorActionPreference = "Stop"

$mypath = "c:/eclipse2020-06"
If(!(test-path $mypath))
{
      New-Item -ItemType Directory -Force -Path $mypath
}

cd $mypath

echo "Downloading Amazon Corretto 8..."
$url = "https://corretto.aws/downloads/latest/amazon-corretto-8-x64-windows-jdk.msi"
$output = $mypath+"/amazon-corretto-8-x64-windows-jdk.msi"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Amazon Corretto 8..."
.\amazon-corretto-8-x64-windows-jdk.msi /qn /L* "install.log" /norestart ALLUSERS=2
echo "...done!"

echo "Sleep 60s"

sleep 60

echo "Set JAVA HOME..."
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Amazon Corretto\jre8")
[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$($Env:JAVA_HOME)\bin", "User")
echo "...done!"

echo "Downloading Eclipse..."
$url = "http://ftp.fau.de/eclipse/technology/epp/downloads/release/2020-06/R/eclipse-java-2020-06-R-win32-x86_64.zip"
$output = $mypath+"/eclipse-java-2020-06-R-win32-x86_64.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Eclipse..."
Expand-Archive -Path eclipse-java-2020-06-R-win32-x86_64.zip -DestinationPath $mypath
echo "...done!"

cd eclipse

dir

echo 'Start-Process -FilePath c:/eclipse2020-06/eclipse/eclipse.exe -ArgumentList "-nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository https://tools.hana.ondemand.com/2020-06,http://download.eclipse.org/releases/2020-06 -installIU HANATools"' > C:\Users\Public\Desktop\Install_SAP_HANA_STUDIO_Plugins.ps1

echo "Create Shortcut..."

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\eclipse.lnk")
$Shortcut.TargetPath = $mypath+"/eclipse/eclipse.exe"
$Shortcut.Save()

echo "...done!"

echo "ALL DONE"
