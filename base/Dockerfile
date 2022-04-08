# escape=`

ARG BASE_VERSION=ltsc2022
ARG MSYS2_VERSION=20220319
# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-$BASE_VERSION
ARG MSYS2_VERSION

ENV MSYS2_URL="https://mirror.msys2.org/distrib" `
    MSYS2_TARGET="x86_64" `
    MSYS2_VERSION=${MSYS2_VERSION} `
    MSYS_HOME="C:\msys64" `
    SEVEN_ZIP_VERSION="21.07" `
    SEVEN_ZIP_DOWNLOAD_URL="https://www.7-zip.org/a"

WORKDIR /install
COPY 07-pacman-key.post .
COPY msys2.bat .
COPY install_msys2.ps1 .
COPY packages.txt .
COPY msys2_shell.exe .

RUN /install/install_msys2.ps1

WORKDIR /src

# launch the msys shell, by default execute bash. PowerShell works as well
# can use things like gcc as the command
SHELL ["C:\\install\\msys2_shell.exe"]