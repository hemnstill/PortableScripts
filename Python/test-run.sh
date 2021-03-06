#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

oneTimeSetUp() {
  log_env
}

test_init() {
  "$dp0/init.sh"
  assertEquals 0 $?
  "$dp0/run.sh"
  assertEquals 42 $?
}

test_stdout() {
  assert_stdout "Python" "Hello, '['s1 ы1']'\nexit code: 42\n" "s1 ы1"
}

# Load and run shUnit2.
source "$dp0/../.tests/shunit2/shunit2"