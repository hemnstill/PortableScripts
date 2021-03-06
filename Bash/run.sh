#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_version_name=busybox-1.35-linux && $is_windows_os && runtime_version_name=busybox-1.35-win
runtime_archive_name=busybox-linux.7z && $is_windows_os && runtime_archive_name=busybox-win.7z

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$busybox_filename"

if [[ ! -f "$runtime_bin_path" ]]; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" ash "$dp0/main.sh" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
