export LC_ALL=en_US.UTF-8
is_windows_os=false && [[ $(uname) == Windows_NT* ]] && is_windows_os=true
is_nanoserver_os=false && $is_windows_os && [[ ! -f "C:\Windows\notepad.exe" ]] && is_nanoserver_os=true
is_alpine_os=false && [[ -f "/etc/alpine-release" ]] && is_alpine_os=true

p7z="$dp0_tools/7zzs" && $is_windows_os && p7z="$dp0_tools/7z.exe"

busybox_filename=busybox && $is_windows_os && busybox_filename=busybox64.exe
busybox="$dp0_tools/$busybox_filename"

bsdtar="$dp0_tools/bsdtar" && $is_windows_os && bsdtar="$dp0_tools\bsdtar.exe"

log_env() {
  echo ">> env:"
  uname -a
  echo is_windows: "$is_windows_os", is_alpine: "$is_alpine_os"
  "$busybox" | head -n 1
  "$p7z" | head -n 2 | tail -n 1
}

assert_stdout() {
  local runtime_name="$1"
  echo ">> Test ($runtime_name)"
  local etalon_log=$(echo -e "$2")
  local actual_log=$("$dp0_tools/../$runtime_name/run.sh" "$3")
  # crlf fix
  $is_windows_os && actual_log=$(echo "$actual_log" | dos2unix)
  assetEquals "$etalon_log" "$actual_log"
}