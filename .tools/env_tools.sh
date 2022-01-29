export LC_ALL=en_US.UTF-8
is_windows_os=false && [[ $(uname) == Windows_NT* ]] && is_windows_os=true
is_alpine_os=false && [[ -f "/etc/alpine-release" ]] && is_alpine_os=true

p7z="$dp0_tools/7zzs" && $is_windows_os && p7z="$dp0_tools/7z.exe"

busybox_filename=busybox && $is_windows_os && busybox_filename=busybox64.exe
busybox="$dp0_tools/$busybox_filename"