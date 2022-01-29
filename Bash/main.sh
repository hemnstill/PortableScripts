#!/bin/bash
cd "$(dirname "$0")"

source ./foo.sh

# shellcheck disable=SC2005
echo "$(hello "$@")"

exit 42