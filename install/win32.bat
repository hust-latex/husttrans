@echo off
rem LaTeX package install script
rem Author: Xu Cheng

cd /d "%~dp0"
cd ..

if not defined TEXMFLOCAL (
    for /f "delims=" %%I in ('kpsewhich --var-value=TEXMFLOCAL') do @set TEXMFLOCAL=%%I
)

if /i "%1" == "install"      goto :install
if /i "%1" == "uninstall"    goto :uninstall
goto :help

:install
echo. Install husttrans.cls template into local.
mkdir "%TEXMFLOCAL%\tex\latex\husttrans\"
xcopy /q /y .\husttrans\husttrans.cls "%TEXMFLOCAL%\tex\latex\husttrans\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\husttrans\"
xcopy /q /y .\husttrans\husttrans.pdf "%TEXMFLOCAL%\doc\latex\husttrans\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\husttrans\example\"
xcopy /q /y .\husttrans\husttrans-example.pdf "%TEXMFLOCAL%\doc\latex\husttrans\example\" > nul
xcopy /q /y .\husttrans\husttrans-example.tex "%TEXMFLOCAL%\doc\latex\husttrans\example\" > nul
xcopy /q /y .\husttrans\fig-example.pdf "%TEXMFLOCAL%\doc\latex\husttrans\example\" > nul
xcopy /q /y .\husttrans\ref-example.bib "%TEXMFLOCAL%\doc\latex\husttrans\example\" > nul
goto :hash

:uninstall
echo. Uninstall husttrans.cls template.
rd /q /s "%TEXMFLOCAL%\tex\latex\husttrans\"
rd /q /s "%TEXMFLOCAL%\doc\latex\husttrans\"
goto :hash

:hash
echo. Refresh TeX hash database.
texhash
goto :exit

:help
echo Usage:
echo. %~nx0 install          - install husttrans.cls template into local.
echo. %~nx0 uninstall        - uninstall husttrans.cls template.
echo.
goto :exit

:exit