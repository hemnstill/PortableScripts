#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

if $is_windows_os; then
  zstd_download_url=https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-v1.5.2-win64.zip
  zstd_zip="$runtime_tools/zstd-win64.zip"
  [[ ! -f "$zstd_zip" ]] && "$busybox" wget "$zstd_download_url" -O "$zstd_zip"
  "$p7z" e "$zstd_zip" "-o$runtime_tools" "zstd.exe" -aoa -r
  zstd="$runtime_tools/zstd.exe"
else
  zstd="zstd"
fi

linux_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-unknown-linux-musl-noopt-20211017T1616.tar.zst
windows_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-pc-windows-msvc-shared-pgo-20211017T1616.tar.zst
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
cpython_zip="$runtime_tools/cpython-linux.tar.zst" && $is_windows_os && cpython_zip="$runtime_tools/cpython-win.tar.zst"
[[ ! -f "$cpython_zip" ]] && "$busybox" wget "$download_url" -O "$cpython_zip"

cpython_tar="$runtime_tools/cpython-linux.tar" && $is_windows_os && cpython_tar="$runtime_tools/cpython-win.tar"
[[ ! -f "$cpython_tar" ]] && $zstd -df "$cpython_zip"