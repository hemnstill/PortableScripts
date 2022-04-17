#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

busybox_base64="$dp0/.tmp/_content.txt"
certutil.exe -f -encode "$busybox" "$busybox_base64"

{ printf ': '\''"
@echo off

set busybox_local=%%~dp0busybox64_v1.35.0.exe
certutil.exe -f -decode "%%~f0" "%%busybox_local%%"

goto :entrypoint

'
} > .tmp/_before.sh

{ printf '
:entrypoint
"%%busybox_local%%" sh "%%~f0"
exit /b %%errorlevel%%
"'\''

echo Hello from Bash!
exit 0

'
} > .tmp/_after.sh

cat .tmp/_before.sh .tmp/_content.txt .tmp/_after.sh > init.bat