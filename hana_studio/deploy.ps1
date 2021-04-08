echo "START"
$ErrorActionPreference = "Stop"

$mypath = "c:/eclipse2020-12"
If(!(test-path $mypath))
{
      New-Item -ItemType Directory -Force -Path $mypath
}

cd $mypath

echo "Downloading Amazon Corretto 11..."
$url = "https://corretto.aws/downloads/latest/amazon-corretto-11-x64-windows-jdk.msi"
$output = $mypath+"/amazon-corretto-11-x64-windows-jdk.msi"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Amazon Corretto 11..."
.\amazon-corretto-11-x64-windows-jdk.msi /qn /L* "install.log" /norestart ALLUSERS=2
echo "...done!"

echo "Downloading Eclipse..."
$url = "https://mirrors.dotsrc.org/eclipse//technology/epp/downloads/release/2020-12/R/eclipse-java-2020-12-R-win32-x86_64.zip"
$output = $mypath+"/eclipse-java-2020-12-R-win32-x86_64.zip"
(New-Object System.Net.WebClient).DownloadFile($url, $output)
echo "...done!"
echo "Installing Eclipse..."
Expand-Archive -Path eclipse-java-2020-12-R-win32-x86_64.zip -DestinationPath $mypath
echo "...done!"

cd eclipse

dir

Start-Process -FilePath c:/eclipse2020-12/eclipse/eclipse.exe -ArgumentList "-nosplash -consoleLog -application org.eclipse.equinox.p2.director -repository https://tools.hana.ondemand.com/2020-12,http://download.eclipse.org/releases/2020-12 -installIU HANATools"

echo "Create Shortcut..."

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\Users\Public\Desktop\eclipse.lnk")
$Shortcut.TargetPath = $mypath+"/eclipse/eclipse.exe"
$Shortcut.Save()

echo "...done!"

echo "Installing SAP HANA Tools for Eclipse, please wait for new window to close! Closing here in 10 seconds!"
sleep 10
