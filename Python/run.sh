#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

PYTHONIOENCODING=UTF-8
runtime_version_name=install
runtime_exe_relative_path=bin/python3 && $is_windows_os && runtime_exe_relative_path=python.exe
runtime_archive_name=cpython-linux.tar && $is_windows_os && runtime_archive_name=cpython-win.tar

runtime_version_path="$dp0/tools/python/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"

if [[ ! -f "$runtime_bin_path" ]] || [[ ! -f "$runtime_version_path/Lib/subprocess.py" ]]; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" "$dp0/main.py" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
