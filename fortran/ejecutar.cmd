@echo off
cls
set /p nombre=Nombre de archivo Fortran a compilar y ejecutar (no incluir extension): 
set extension=.EXE
set ejecutable=%nombre%%extension%
ftn95 %nombre% /link
pause
%nombre%
call ejecutar.cmd