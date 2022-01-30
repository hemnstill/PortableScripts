#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

jdk_runtime_version_name=jdk-17.0.2
JAVA_HOME="$dp0/tools/$jdk_runtime_version_name"

openjdk_runtime_archive_name=openjdk-linux.tar && $is_windows_os && openjdk_runtime_archive_name=openjdk-windows.zip

runtime_exe_relative_path=kotlinc/bin/kotlinc && $is_windows_os && runtime_exe_relative_path=kotlinc/bin/kotlinc.bat
runtime_version_name=kotlin-compiler-1.6.10
runtime_archive_name=kotlin-compiler.zip

runtime_version_path="$dp0/tools/$runtime_version_name"
runtime_bin_path="$runtime_version_path/$runtime_exe_relative_path"
windows_lib_check=false && $is_windows_os && [[ ! -f "$runtime_version_path/kotlinc/bin/kotlinc" ]] && windows_lib_check=true
if [[ ! -f "$runtime_bin_path" ]] || $windows_lib_check; then
  echo "file '$runtime_bin_path' does not exists.";
  echo "extracting '$runtime_archive_name' to '$dp0/tools/$runtime_version_name' ...";
  "$p7z" -bd x "$dp0/tools/$runtime_archive_name" "-o$dp0/tools/$runtime_version_name" -aoa;
  echo "extracting '$openjdk_runtime_archive_name' to '$dp0/tools' ...";
  "$p7z" -bd x "$dp0/tools/$openjdk_runtime_archive_name" "-o$dp0/tools" -aoa;
  errorlevel=$?; if [[ $errorlevel -ne 0 ]]; then echo "exit code: $errorlevel"; exit $errorlevel; fi
fi

"$runtime_bin_path" -script "$dp0/main.kts" "$@"
errorlevel=$?
echo exit code: $errorlevel
exit $errorlevel
