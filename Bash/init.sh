#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

archive_name="$dp0/tools/busybox-linux.7z" && [[ $(uname) == Windows_NT* ]] && archive_name="$dp0/tools/busybox-win.7z"

echo busybox version:
"$busybox"

"$p7z" a "$archive_name" -up0q0 "$busybox"