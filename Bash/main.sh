#!/bin/ash
dp0="$(realpath "$(dirname "$0")")"

source "$dp0/foo.sh"

# shellcheck disable=SC2005
echo "$(hello "$@")"

exit 42