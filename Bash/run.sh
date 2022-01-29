#!/bin/bash
dp0="$(dirname "$0")"
source "$dp0/../.tools/env_tools.sh"

runtime_version_name=busybox-1.35-linux && [[ $(uname) == Windows_NT* ]] && runtime_version_name=busybox-1.35-win
runtime_exe_relative_path=busybox && [[ $(uname) == Windows_NT* ]] && runtime_exe_relative_path=busybox64.exe
runtime_archive_name=busybox-linux.7z && [[ $(uname) == Windows_NT* ]] && runtime_archive_name=busybox-win.7z

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"

if [[ ! -f "$runtime_bin_path" ]]; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" ash "$dp0/main.sh" "$@"
