#
# Copyright (c) 2017 Marat Abrarov (abrarov@gmail.com)
#
# Distributed under the MIT License (see accompanying LICENSE)
#

# Stop immediately if any error happens
$ErrorActionPreference = "Stop"

# Enable all versions of TLS
[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")

$tmp_dir = "${env:TMP}\docker-inst-temp"
$null = mkdir $tmp_dir
# Download and install 7-Zip
$seven_zip_version_suffix = "${env:SEVEN_ZIP_VERSION}" -replace "\.", ""
$seven_zip_dist_name = "7z${seven_zip_version_suffix}-x64.msi"
$seven_zip_dist = "$tmp_dir\${seven_zip_dist_name}"
$seven_zip_target = "${ENV:ProgramFiles}\7-Zip"

$seven_zip_url = "${env:SEVEN_ZIP_DOWNLOAD_URL}/${seven_zip_dist_name}"
Write-Host "Downloading 7-Zip from $seven_zip_url into $seven_zip_dist"
(New-Object System.Net.WebClient).DownloadFile($seven_zip_url, $seven_zip_dist)

Write-Host "Installing 7-Zip from $seven_zip_dist into $seven_zip_target"
$p = Start-Process -FilePath $seven_zip_dist `
  -ArgumentList ("/norestart", "/quiet", "/qn", "ALLUSERS=1", "TargetDir=""$seven_zip_target""") `
  -Wait -PassThru
if (${p}.ExitCode -ne 0) {
  throw "Failed to install 7-Zip"
}
Write-Host "7-Zip ${env:SEVEN_ZIP_VERSION} installed into $seven_zip_target"

# Install MSYS2
$msys_tar_name = "msys2-base-${env:MSYS2_TARGET}-${env:MSYS2_VERSION}.tar"
$msys_dist_name = "${msys_tar_name}.xz"
$msys_url = "${env:MSYS2_URL}/${env:MSYS2_TARGET}/${msys_dist_name}"
$msys_dist = "$tmp_dir/${msys_dist_name}"

Write-Host "Downloading MSYS2 from ${msys_url} into ${msys_dist}"

(New-Object System.Net.WebClient).DownloadFile($msys_url, $msys_dist)
Write-Host "Extracting MSYS2 from $msys_dist into ${env:MSYS_HOME}"
& "$seven_zip_target\7z.exe" x "$msys_dist" -o"$tmp_dir" -aoa -y -bd | out-null
& "$seven_zip_target\7z.exe" x "$tmp_dir\$msys_tar_name" -o"C:" -aoa -y -bd | out-null
& "${PSScriptRoot}\msys2.bat"
Write-Host "MSYS2 ${env:MSYS2_VERSION} installed into ${env:MSYS_HOME}"

# Cleanup
Write-Host "Removing all files and directories from $tmp_dir"
Remove-Item -Path "$tmp_dir\*" -Recurse -Force