#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://github.com/philanc/slua/archive/refs/tags/v0.8.tar.gz
windows_download_url=https://sourceforge.net/projects/luabinaries/files/5.4.2/Tools%20Executables/lua-5.4.2_Win64_bin.zip
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
runtime_zip="$runtime_tools/lua-linux.tar.gz" && $is_windows_os && runtime_zip="$runtime_tools/lua-win.zip"

# TODO: links to sourceforge are not stable.
$is_windows_os || [[ ! -f "$runtime_zip" ]] && "$busybox" wget "$download_url" -O "$runtime_zip"

$is_windows_os || ([[ ! -f "$runtime_tools/lua-linux.tar" ]] && "$p7z" e "$runtime_zip" "-o$runtime_tools" -aoa -r)