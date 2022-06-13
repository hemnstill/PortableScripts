@echo off
"%~dp0..\.tools\busybox.exe" bash "%~dp0run.sh" %*
exit /b %errorlevel%
