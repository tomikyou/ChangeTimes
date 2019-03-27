@echo off
echo Changingc
powershell -NoProfile -ExecutionPolicy Unrestricted .\ChangeTime.ps1
echo Times is changed!
pause > nul
exit