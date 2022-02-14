#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_exe_relative_path=slua-0.8/bin/slua-x64 && $is_windows_os && runtime_exe_relative_path=lua54.exe
runtime_version_name=. && $is_windows_os && runtime_version_name=lua54.windows
runtime_archive_name=lua-linux.tar && $is_windows_os && runtime_archive_name=lua-win.zip

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/luac54.exe" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

(cd "$dp0" && "$runtime_bin_path" "$dp0/main.lua" "$@")
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
