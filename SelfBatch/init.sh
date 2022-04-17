#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"
set -e

busybox_base64="$dp0/.tmp/_content.txt"
certutil.exe -f -encode "$busybox" "$busybox_base64"

{ printf ': '\''"
@echo off

set busybox_local=%%~dp0busybox64_v1.35.0.exe
if not exist %%busybox_local%% (
  certutil.exe -f -decode "%%~f0" "%%busybox_local%%"
)

goto :entrypoint

'
} > "$dp0/.tmp/_before.sh"

{ printf '
:entrypoint
echo Hello, Batch %%*
"%%busybox_local%%" sh "%%~f0" %%*
exit /b 42
"'\''

echo Hello, Bash "$@"
exit 42

'
} > "$dp0/.tmp/_after.sh"

cat "$dp0/.tmp/_before.sh" "$busybox_base64" "$dp0/.tmp/_after.sh" > "$dp0/run.bat"