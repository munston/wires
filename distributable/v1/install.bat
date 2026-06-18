@echo off
setlocal
set "SCRIPT_DIR=%~dp0."
set "TARBALL=%~1"

if "%TARBALL%"=="" (
  for %%F in ("%SCRIPT_DIR%\*.tar" "%SCRIPT_DIR%\*.tar.gz" "%SCRIPT_DIR%\*.tgz" "%SCRIPT_DIR%\*.tar.xz" "%SCRIPT_DIR%\*.tar.bz2") do (
    if exist "%%~fF" (
      set "TARBALL=%%~fF"
      goto found_tarball
    )
  )
)

:found_tarball
if "%TARBALL%"=="" (
  echo no tarball found beside install.bat 1>&2
  exit /b 1
)

if not exist "%TARBALL%" (
  echo tarball not found: %TARBALL% 1>&2
  exit /b 1
)

set "WORK=%SCRIPT_DIR%\work"
if exist "%WORK%" rmdir /s /q "%WORK%"
mkdir "%WORK%"

tar -xf "%TARBALL%" -C "%WORK%"
if errorlevel 1 exit /b %ERRORLEVEL%

cd /d "%WORK%\ollama.wires"
call installer.bat
exit /b %ERRORLEVEL%
