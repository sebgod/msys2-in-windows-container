# escape=`

FROM sgservianbench.azurecr.io/msys2:20220319-windowsservercore-ltsc2019 as base

WORKDIR /src
COPY hello_world.c .
RUN gcc -o hello_world hello_world.c && ls && ./hello_world
RUN echo "Hello world!"
