@setlocal enabledelayedexpansion

::
:: Copyright (c) 2019 Marat Abrarov (abrarov@gmail.com)
::
:: Distributed under the MIT License (see accompanying LICENSE)
::

@set "PATH=%MSYS_HOME%\usr\bin;%PATH%"

@set exit_code=0

@echo Initializing MSYS2
@call "%MSYS_HOME%\msys2_shell.cmd" -no-start -defterm -c exit
@set exit_code=%errorlevel%
@if %exit_code% neq 0 goto exit

@set PACKAGES=mingw-w64-%MSYS2_TARGET%-gcc
@if "%~1" NEQ "" @for /F "usebackq" %%P in ("%~1") do set PACKAGES=!PACKAGES! %%P
@echo Installing packages %PACKAGES%

@pacman -S --needed --noconfirm --overwrite '*' %PACKAGES%
@set exit_code=%errorlevel%
@if %exit_code% neq 0 goto exit

:exit
@exit /B %exit_code%