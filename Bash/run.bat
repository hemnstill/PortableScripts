@echo off
set p7z=%~dp0..\.tools\7z.exe

set runtime_version_name=busybox-1.35-win
set runtime_exe_relative_path=busybox64.exe
set runtime_archive_name=busybox-win.7z

set runtime_version_path=%~dp0tools\%runtime_version_name%
set runtime_bin_path=%runtime_version_path%\%runtime_exe_relative_path%

set need_extract_runtime=0
if not exist "%runtime_bin_path%" set need_extract_runtime=1

if "%need_extract_runtime%"=="1" (
  echo extracting '%runtime_archive_name%' to '%~dp0tools' ...
  "%p7z%" -bd x "%~dp0tools\%runtime_archive_name%" "-o%~dp0tools\%runtime_version_name%" -aoa
)

if "%need_extract_runtime%"=="1" if %errorlevel% neq 0 (
  echo exit code: %errorlevel%
  exit /b %errorlevel%
)

"%runtime_bin_path%" bash "%~dp0main.sh" %*
echo exit code: %errorlevel%
exit /b %errorlevel%
