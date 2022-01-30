#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_exe_relative_path=pwsh && $is_windows_os && runtime_exe_relative_path=pwsh.exe
runtime_version_name=PowerShell-7.2.1-win-x64 && $is_windows_os && runtime_version_name=PowerShell-7.2.1-linux-x64
runtime_archive_name=powershell-linux.tar && $is_windows_os && runtime_archive_name=powershell-win.zip

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/pwsh.xml" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" "$dp0/main.ps1" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
