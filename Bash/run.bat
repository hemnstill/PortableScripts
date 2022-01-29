@echo off
"%~dp0..\.tools\busybox64.exe" bash "%~dp0run.sh" %*
exit /b %errorlevel%
