# escape=`

ARG BASE_VERSION=ltsc2022
# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-$BASE_VERSION

ENV MSYS2_URL="https://mirror.msys2.org/distrib" `
    MSYS2_TARGET="x86_64" `
    MSYS2_VERSION="20220319" `
    MSYS_HOME="C:\msys64" `
    SEVEN_ZIP_VERSION="21.07" `
    SEVEN_ZIP_DOWNLOAD_URL="https://www.7-zip.org/a"

WORKDIR /install
COPY 07-pacman-key.post /install
COPY msys2.bat /install
COPY install_msys2.ps1 /install/
RUN /install/install_msys2.ps1

WORKDIR /src

# launch the msys shell, by default execute bash
# can use things like gcc as the command
ENTRYPOINT ["C:\\msys64\\msys2_shell.cmd", "-mingw64", "-no-start", "-defterm", "-c"]
CMD ["bash"]