#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
windows_download_url=https://go.dev/dl/go1.17.6.windows-amd64.zip
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
runtime_zip="$runtime_tools/go-linux.tar.gz" && $is_windows_os && runtime_zip="$runtime_tools/go-win.zip"
[[ ! -f "$runtime_zip" ]] && "$busybox" wget "$download_url" -O "$runtime_zip"

$is_windows_os || ([[ ! -f "$runtime_tools/go-linux.tar" ]] && "$p7z" e "$runtime_zip" "-o$runtime_tools" -aoa -r)