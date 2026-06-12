$zipUrl = 'https://dl.google.com/firebase/sdk/cpp/firebase_cpp_sdk_windows_13.5.0.zip'
$tempZip = Join-Path $env:TEMP 'firebase_cpp_sdk_windows_13.5.0_fixed.zip'
$extractPath = Join-Path $PSScriptRoot 'build\windows\x64\extracted\firebase_cpp_sdk_windows_temp'

if (Test-Path $tempZip) { Remove-Item -Path $tempZip -Force }
if (Test-Path $extractPath) { Remove-Item -Path $extractPath -Recurse -Force }

Write-Host "Downloading $zipUrl to $tempZip"
Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip -UseBasicParsing
Write-Host "Extracting to $extractPath"
Expand-Archive -Path $tempZip -DestinationPath $extractPath -Force
Write-Host "Extraction finished. Contents:"
Get-ChildItem -Path $extractPath | Select-Object Name,Mode | Format-Table -AutoSize
