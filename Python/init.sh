#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"
set -e
runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20220528/cpython-3.10.4+20220528-x86_64-unknown-linux-musl-noopt-full.tar.zst
windows_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20220528/cpython-3.10.4+20220528-x86_64-pc-windows-msvc-shared-pgo-full.tar.zst
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
cpython_zip="$runtime_tools/raw_cpython-linux.tar.zst" && $is_windows_os && cpython_zip="$runtime_tools/raw_cpython-win.tar.zst"
[[ ! -f "$cpython_zip" ]] && "$busybox" wget "$download_url" -O "$cpython_zip"

cpython_7z="$runtime_tools/cpython-linux.7z" && $is_windows_os && cpython_7z="$runtime_tools/cpython-win.7z"
if [[ ! -f "$cpython_7z" ]]; then
  echo repacking "$cpython_zip" to "$cpython_7z" ...
  rm -rf "$dp0/.tmp/"* && mkdir -p "$dp0/.tmp" && cd "$dp0/.tmp" || exit 1

  "$bsdtar" \
  --exclude="__pycache__" \
  --exclude="test" \
  --exclude="tests" \
  --exclude="idle_test" \
  --exclude="site-packages" \
  --exclude="venv" \
  --exclude="Scripts" \
  --exclude="*.pdb" \
  --exclude="*.whl" \
  --exclude="*.lib" \
  --exclude="*.pickle" \
  --exclude="pythonw.exe" \
  --exclude="python/install/include" \
  --exclude="tcl*.dll" \
  --exclude="tk*.dll" \
  --exclude="python/install/tcl" \
  -xf "$cpython_zip" python/install

  "$p7z" a "$cpython_7z" -mx=9 -up0q0 "python/install"
fi;

echo "::set-output name=artifact_path::$cpython_7z"