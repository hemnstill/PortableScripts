#!/bin/bash
dp0="$(dirname "$0")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

errors_count=0

uname -a
echo ">> Init (Bash)"
"$dp0/../Bash/init.sh"
"$dp0/../Bash/run.sh"

echo ">> Init (Python)"
"$dp0/../Python/init.sh"
"$dp0/../Python/run.sh"

echo ">> Init (PowerShell)"
"$dp0/../PowerShell/init.sh"
"$dp0/../PowerShell/run.sh"

echo ">> Test (Bash)"
etalon_log=$(echo -e "Hello, 's1 ы1'\nexit code: 42\n")
actual_log=$("$dp0/../Bash/run.sh" s1 ы1)
if [ "$etalon_log" != "$actual_log" ]; then
  errors_count=$((errors_count + 1))
  echo "<< Failed (Bash)"
  echo expected: "$etalon_log"
  echo actual: "$actual_log"
else
  echo "<< Passed (Bash)"
fi

echo ">> Test (Python)"
etalon_log=$(echo -e "Hello, '['s1', 'ы1']'\nexit code: 42\n")
actual_log=$("$dp0/../Python/run.sh" s1 ы1)
# crlf fix
$is_windows_os && actual_log=$(echo "$actual_log" | dos2unix)
if [ "$etalon_log" != "$actual_log" ]; then
  errors_count=$((errors_count + 1))
  echo "<< Failed (Python)"
  echo expected: "$etalon_log"
  echo actual: "$actual_log"
else
  echo "<< Passed (Python)"
fi

echo ">> Test (PowerShell)"
etalon_log=$(echo -e "Hello, 's1 ы1'\nexit code: 42\n")
actual_log=$("$dp0/../PowerShell/run.sh" s1 ы1)
# crlf fix
$is_windows_os && actual_log=$(echo "$actual_log" | dos2unix)
if [ "$etalon_log" != "$actual_log" ]; then
  errors_count=$((errors_count + 1))
  echo "<< Failed (PowerShell)"
  echo expected: "$etalon_log"
  echo actual: "$actual_log"
else
  echo "<< Passed (PowerShell)"
fi

echo Errors: "$errors_count"
exit $errors_count