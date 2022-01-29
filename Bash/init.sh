#!/bin/bash
cd "$(dirname "$0")"

p7z="../.tools/7z.exe"

archive_name=./tools/busybox-win.7z
$p7z a $archive_name -up0q0 "../.tools/busybox64.exe"