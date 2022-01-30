#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

openjdk_linux_download_url=https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
openjdk_windows_download_url=https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_windows-x64_bin.zip
openjdk_download_url="$openjdk_linux_download_url" && $is_windows_os && openjdk_download_url="$openjdk_windows_download_url"
openjdk_runtime_zip="$runtime_tools/openjdk-linux.tar.gz" && $is_windows_os && openjdk_runtime_zip="$runtime_tools/openjdk-windows.zip"
[[ ! -f "$openjdk_runtime_zip" ]] && "$busybox" wget "$openjdk_download_url" -O "$openjdk_runtime_zip"
$is_windows_os || [[ ! -f "$runtime_tools/openjdk-linux.tar" ]] && "$p7z" e "$openjdk_runtime_zip" "-o$runtime_tools" -aoa -r

download_url=https://github.com/JetBrains/kotlin/releases/download/v1.6.10/kotlin-compiler-1.6.10.zip
runtime_zip="$runtime_tools/kotlin-compiler.zip"
[[ ! -f "$runtime_zip" ]] && "$busybox" wget "$download_url" -O "$runtime_zip"