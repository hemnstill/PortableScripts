#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

zstd_download_url=https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-v1.5.2-win64.zip
zstd_zip="$dp0/tools/zstd-win64.zip"
[[ ! -f "$zstd_zip" ]] && "$busybox" wget "$zstd_download_url" -O "$zstd_zip"
"$p7z" e "$zstd_zip" "-o." "zstd.exe" -aoa -r
zstd="$dp0/tools/zstd.exe"

download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-pc-windows-msvc-static-noopt-20211017T1616.tar.zst
cpython_zip="$dp0/tools/cpython-windows.tar.zst"
[[ ! -f "$cpython_zip" ]] && "$busybox" wget "$download_url" -O "$cpython_zip"

$zstd -df "$cpython_zip"