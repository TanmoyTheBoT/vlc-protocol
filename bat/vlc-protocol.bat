Setlocal EnableDelayedExpansion
set url=%~1
set url=!url: =%%20!
set url=!url:https//=https://!
set url=!url:http//=http://!
start "VLC" "%~dp0vlc.exe" --open "%url:~6%"
