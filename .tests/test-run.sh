#!/bin/bash
cd "$(dirname "$0")"

errors_count=0

echo ">> Init (Bash)"
../Bash/init.sh

echo ">> Test (Bash)"
etalon_log=$(echo -e "hello, 's1 ы1'\nexit code: 42\n")
actual_log=$(../Bash/run.bat s1 ы1)
if [ "$etalon_log" != "$actual_log" ]; then
  errors_count=$((errors_count + 1))
  echo "<< Failed (Bash)"
  echo expected: "$etalon_log"
  echo actual: "$actual_log"
else
  echo "<< Passed (Bash)"
fi

echo Errors: "$errors_count"
exit $errors_count