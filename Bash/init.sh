#!/bin/bash
cd "$(dirname "$0")"

source ../.tools/env_tools.sh

archive_name=./tools/busybox-linux.7z && [[ $(uname) == Windows_NT* ]] && archive_name=./tools/busybox-win.7z
binary_name=../.tools/busybox && [[ $(uname) == Windows_NT* ]] && binary_name=../.tools/busybox64.exe

$p7z a $archive_name -up0q0 "$binary_name"