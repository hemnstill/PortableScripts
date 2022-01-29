export LC_ALL=en_US.UTF-8
p7z="$dp0_tools/7zzs" && [[ $(uname) == Windows_NT* ]] && p7z="$dp0_tools/7z.exe"

busybox_filename=busybox && [[ $(uname) == Windows_NT* ]] && busybox_filename=busybox64.exe
busybox="$dp0_tools/$busybox_filename"