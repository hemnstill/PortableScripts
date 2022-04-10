#!/bin/bash
dp0="$(realpath "$(dirname "$0")")"
dp0_tools="$dp0/../.tools" && source "$dp0_tools/env_tools.sh"

runtime_tools="$dp0/tools"
mkdir -p "$runtime_tools"

linux_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-unknown-linux-musl-noopt-20211017T1616.tar.zst
windows_download_url=https://github.com/indygreg/python-build-standalone/releases/download/20211017/cpython-3.10.0-x86_64-pc-windows-msvc-shared-pgo-20211017T1616.tar.zst
download_url="$linux_download_url" && $is_windows_os && download_url="$windows_download_url"
cpython_zip="$runtime_tools/raw_cpython-linux.tar.zst" && $is_windows_os && cpython_zip="$runtime_tools/raw_cpython-win.tar.zst"
[[ ! -f "$cpython_zip" ]] && "$busybox" wget "$download_url" -O "$cpython_zip"

cpython_tar_zstd="$runtime_tools/cpython-linux.tar.zst" && $is_windows_os && cpython_tar_zstd="$runtime_tools/cpython-win.tar.zst"
if [[ ! -f "$cpython_tar_zstd" ]]; then
  echo repacking "$cpython_zip" to "$cpython_tar_zstd" ...
  "$bsdtar" \
  --exclude="__pycache__" \
  --exclude="test" \
  --exclude="tests" \
  --exclude="idle_test" \
  --exclude="site-packages" \
  --exclude="venv" \
  --exclude="Scripts" \
  --exclude="*.pdb" \
  --exclude="*.whl" \
  --exclude="*.lib" \
  --exclude="*.pickle" \
  --exclude="pythonw.exe" \
  --exclude="python/install/include" \
  -xf "$cpython_zip" python/install

  "$bsdtar" --zstd -cf "$cpython_tar_zstd" python/install

  rm -rf python/install
fi;