#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"
set -e

content_before="$dp0/.tmp/content_before.sh"
content_after="$dp0/.tmp/content_after.sh"
content_busybox="$dp0/.tmp/_content.txt"

if [ "$is_windows_os" == true ]; then
  certutil.exe -f -encode "$busybox" "$content_busybox"
else
  {
    echo -----BEGIN CERTIFICATE-----
    base64 "$busybox"
    echo -----END CERTIFICATE-----
  } > "$content_busybox"
fi

{ printf ': '\''"
@echo off

set busybox_local=%%~dp0busybox64_v1.35.0.exe
if not exist %%busybox_local%% (
  certutil.exe -f -decode "%%~f0" "%%busybox_local%%"
)

goto :entrypoint

'
} > "$content_before"

{ printf '
:entrypoint
echo Hello, Batch %%*
"%%busybox_local%%" sh "%%~f0" %%*
exit /b 42
"'\''

echo Hello, Bash "$@"
exit 42

'
} > "$content_after"

cat "$content_before" "$content_busybox" "$content_after" > "$dp0/run.bat"