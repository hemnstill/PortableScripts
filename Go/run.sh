#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_exe_relative_path=go/bin/go && $is_windows_os && runtime_exe_relative_path=go/bin/go.exe
runtime_version_name=go1.17.6.linux && $is_windows_os && runtime_version_name=go1.17.6.windows
runtime_archive_name=go-linux.tar && $is_windows_os && runtime_archive_name=go-win.zip

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/go/src/run.bat" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" run "$dp0/main.go" "$dp0/foo.go" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
