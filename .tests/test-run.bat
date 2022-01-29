@echo off
set bash="%~dp0..\.tools\busybox64.exe" bash
set test_run_sh="%~dp0..\.tests\test-run.sh"

%bash% %test_run_sh% %*
exit /b %errorlevel%
