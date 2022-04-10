#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-unknown-linux-musl-noopt-20211017T1616.tar.zst
windows_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-pc-windows-msvc-shared-pgo-20211017T1616.tar.zst
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
cpython_zip="$runtime_tools/cpython-linux.tar.zst" && $is_windows_os && cpython_zip="$runtime_tools/cpython-win.tar.zst"
[[ ! -f "$cpython_zip" ]] && "$busybox" wget "$download_url" -O "$cpython_zip"