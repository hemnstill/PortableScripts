#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

archive_name="$dp0/tools/busybox-linux.7z" && $is_windows_os && archive_name="$dp0/tools/busybox-win.7z"
"$p7z" a "$archive_name" -up0q0 "$busybox"