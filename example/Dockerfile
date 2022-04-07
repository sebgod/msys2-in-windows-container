# escape=`

FROM sgservianbench.azurecr.io/msys2:latest-windowsservercore-ltsc2019 as base

WORKDIR /src
COPY hello_world.c .
# RUN & ${ENV:MSYS_HOME}/mingw64/bin/gcc -o hello_world hello_world.c