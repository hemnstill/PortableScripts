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
  sh "$dp0/run.bat"
}

function test_init_batch() {
  local runtime_name="$1"
  echo ">> Init ($runtime_name)"
  "$dp0/init.sh"
  cmd.exe /c call "$dp0/run.bat"
}

function test_stdout() {
  local runtime_name="$1"
  echo ">> Test ($runtime_name)"
  local etalon_log=$(echo -e "$2")
  local actual_log=$("$busybox" sh "$dp0/run.bat" "$3")
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

function test_stdout_batch() {
  local runtime_name="$1"
  echo ">> Test ($runtime_name)"
  local etalon_log=$(echo -e "$2")
  local actual_log=$(cmd.exe /c call "$dp0/run.bat" "$3")
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

test_init "SelfBash"
test_stdout "SelfBash" "Hello, Bash s1 todo_fix_encoding1\n" "s1 todo_fix_encoding1"

$is_windows_os && test_init_batch "SelfBatch"
$is_windows_os && test_stdout_batch "SelfBatch" "Hello, Batch \"s1 todo_fix_encoding1\"\nHello, Bash s1 todo_fix_encoding1\n" "s1 todo_fix_encoding1"

echo Errors: "$errors_count"
exit $errors_count