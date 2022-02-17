#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://github.com/FooBarWidget/traveling-ruby/releases/download/rel-20210206/traveling-ruby-20210206-2.4.10-linux-x86_64.tar.gz
windows_download_url=https://github.com/FooBarWidget/traveling-ruby/releases/download/rel-20210206/traveling-ruby-20210206-2.4.10-x86_64-win32.tar.gz
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
runtime_zip="$runtime_tools/ruby-linux.tar.gz" && $is_windows_os && runtime_zip="$runtime_tools/ruby-win.tar.gz"
[[ ! -f "$runtime_zip" ]] && "$busybox" wget "$download_url" -O "$runtime_zip"

$is_windows_os || ([[ ! -f "$runtime_tools/ruby-linux.tar" ]] && "$p7z" e "$runtime_zip" "-o$runtime_tools" -aoa -r)
$is_windows_os && ([[ ! -f "$runtime_tools/ruby-win.tar" ]] && "$p7z" e "$runtime_zip" "-o$runtime_tools" -aoa -r)