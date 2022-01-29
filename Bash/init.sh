#!/bin/ash
dp0="$(dirname "$0")"

source "$dp0/../.tools/env_tools.sh"

archive_name="$dp0/tools/busybox-linux.7z" && [[ $(uname) == Windows_NT* ]] && archive_name="$dp0/tools/busybox-win.7z"
binary_name="$dp0/../.tools/busybox" && [[ $(uname) == Windows_NT* ]] && binary_name="$dp0/../.tools/busybox64.exe"

echo busybox version:
"$binary_name"

"$p7z" a "$archive_name" -up0q0 "$binary_name"