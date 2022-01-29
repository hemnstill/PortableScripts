export LC_ALL=en_US.UTF-8
dp0="$(dirname "$0")"

p7z="$dp0/../.tools/7zzs" && [[ $(uname) == Windows_NT* ]] && p7z="$dp0/../.tools/7z.exe"