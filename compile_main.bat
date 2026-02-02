@echo off
setlocal

set "ROOT_DIR=%~dp0"
set "OUTPUT_DIR=%ROOT_DIR%output"
set "MAIN_TEX=%ROOT_DIR%buku_ajar\main.tex"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo Compiling main.tex 4 times...
for /L %%i in (1,1,4) do (
  echo Pass %%i...
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="%OUTPUT_DIR%" "%MAIN_TEX%"
  if errorlevel 1 (
    echo Compilation failed on pass %%i.
    exit /b 1
  )
)

call :cleanup "%OUTPUT_DIR%"
echo Done. Output PDF: %OUTPUT_DIR%\main.pdf
exit /b 0

:cleanup
set "TARGET=%~1"
for %%E in (aux bbl blg bcf log out toc lof lot fls fdb_latexmk nav snm vrb idx ilg ind acn acr alg glg glo gls ist xdy run.xml synctex pdfsync) do (
  del /q "%TARGET%\*.%%E" 2>nul
)
del /q "%TARGET%\*.synctex.gz" 2>nul
exit /b 0
