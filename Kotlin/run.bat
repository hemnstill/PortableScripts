@echo off
set p7z=%~dp0..\.tools\7z.exe

set jdk_runtime_version_name=jdk-17.0.2
set JAVA_HOME=%~dp0tools\%jdk_runtime_version_name%

set runtime_version_name=kotlin-compiler-1.6.10
set runtime_exe_relative_path=kotlinc.bat
set runtime_archive_name=kotlin-compiler.zip

set runtime_version_path=%~dp0tools\%runtime_version_name%
set runtime_bin_path=%runtime_version_path%\kotlinc\bin\%runtime_exe_relative_path%

set need_extract_runtime=0
if not exist "%runtime_bin_path%" set need_extract_runtime=1
if not exist "%runtime_version_path%\kotlinc\bin\kotlinc" set need_extract_runtime=1

if "%need_extract_runtime%"=="1" (
  echo extracting '%runtime_archive_name%' to '%~dp0tools' ...
  "%p7z%" -bd x "%~dp0tools\%runtime_archive_name%" "-o%~dp0tools\%runtime_version_name%" -aoa
  "%p7z%" -bd x "%~dp0tools\openjdk-windows.zip" "-o%~dp0tools" -aoa
)

if "%need_extract_runtime%"=="1" if %errorlevel% neq 0 (
  echo exit code: %errorlevel%
  exit /b %errorlevel%
)

call "%runtime_bin_path%" -script "%~dp0main.kts" %*
echo exit code: %errorlevel%
exit /b %errorlevel%
