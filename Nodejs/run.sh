#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_exe_relative_path=bin/node && $is_windows_os && runtime_exe_relative_path=node.exe
runtime_version_name=node-v16.13.2-linux-x64 && $is_windows_os && runtime_version_name=node-v16.13.2-win-x64
runtime_archive_name=node-linux.tar && $is_windows_os && runtime_archive_name=node-win.zip

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/npm" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" --experimental-modules "$dp0/main.mjs" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
