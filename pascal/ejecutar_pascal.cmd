@echo off
cls
set /p nombre=Nombre de archivo Pascal a ejecutar (sin extension): 
set ext=.pas
fpc %nombre%%ext%
pause
cls
%nombre%
call ejecutar_pascal.cmd