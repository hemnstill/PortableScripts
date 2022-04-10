#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

PYTHONIOENCODING=UTF-8

runtime_exe_relative_path=bin/python3 && $is_windows_os && runtime_exe_relative_path=python.exe
runtime_archive_name=cpython-linux.tar && $is_windows_os && runtime_archive_name=cpython-win.tar

runtime_version_path="$dp0/tools/python/install"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/Lib/subprocess.py" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools' ...";
  "$bsdtar" -xf "$dp0/tools/$runtime_archive_name" -C "$dp0/tools";
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" "$dp0/main.py" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
