@echo off
set p7z=%~dp0tools\7z.exe

set GOPATH=%~dp0

set runtime_version_name=go1.17.6.windows-amd64
set runtime_exe_relative_path=go.exe
set runtime_archive_name=go-windows.zip

set runtime_version_path=%~dp0tools\%runtime_version_name%
set runtime_bin_path=%runtime_version_path%\go\bin\%runtime_exe_relative_path%

set need_extract_runtime=0
if not exist "%runtime_bin_path%" set need_extract_runtime=1
if not exist "%runtime_version_path%\go\src\run.bat" set need_extract_runtime=1

if "%need_extract_runtime%"=="1" (
  echo extracting '%runtime_archive_name%' to '%~dp0tools' ...
  "%p7z%" -bd x "%~dp0tools\%runtime_archive_name%" "-o%~dp0tools\%runtime_version_name%" -aoa
)

if "%need_extract_runtime%"=="1" if %errorlevel% neq 0 (
  echo exit code: %errorlevel%
  exit /b %errorlevel%
)

"%runtime_bin_path%" run "%~dp0main.go" "%~dp0foo.go" %*
echo exit code: %errorlevel%
exit /b %errorlevel%
