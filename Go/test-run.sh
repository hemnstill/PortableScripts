#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

errors_count=0

echo ">> env:"
uname -a
echo is_windows: "$is_windows_os", is_alpine: "$is_alpine_os"
"$busybox" | head -n 1
"$p7z" | head -n 2 | tail -n 1

function test_init() {
  local runtime_name="$1"
  echo ">> Init ($runtime_name)"
  "$dp0/init.sh"
  "$dp0/run.sh"
}

function test_stdout() {
  local runtime_name="$1"
  echo ">> Test ($runtime_name)"
  local etalon_log=$(echo -e "$2")
  local actual_log=$("$dp0/../$runtime_name/run.sh" "$3")
  # crlf fix
  $is_windows_os && actual_log=$(echo "$actual_log" | dos2unix)
  if [ "$etalon_log" != "$actual_log" ]; then
    errors_count=$((errors_count + 1))
    echo "<< Failed ($runtime_name)"
    echo expected: "$etalon_log"
    echo actual: "$actual_log"
  else
    echo "<< Passed ($runtime_name)"
  fi
}

test_init "Go"
test_stdout "Go" "Hello, 's1 todo_fix_encoding_and_exitcode1'\nexit code: 1\n" "s1 todo_fix_encoding_and_exitcode1"

echo Errors: "$errors_count"
exit $errors_count