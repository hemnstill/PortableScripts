#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz
windows_download_url=https://nodejs.org/dist/v16.13.2/node-v16.13.2-win-x64.zip
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
runtime_zip="$runtime_tools/node-linux.tar.gz" && $is_windows_os && runtime_zip="$runtime_tools/node-win.zip"
[[ ! -f "$runtime_zip" ]] && "$busybox" wget "$download_url" -O "$runtime_zip"

$is_windows_os || "$p7z" e "$runtime_zip" "-o$runtime_tools" -aoa -r