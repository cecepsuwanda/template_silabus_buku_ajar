@echo off
setlocal

set "ROOT_DIR=%~dp0"
set "OUTPUT_DIR=%ROOT_DIR%output"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

pushd "%ROOT_DIR%"
echo Compiling each chapter...
for %%F in (buku_ajar\bab\bab-*.tex) do (
  echo Compiling %%~nxF...
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="%OUTPUT_DIR%" "%%F"
  if errorlevel 1 (
    echo Compilation failed for %%~nxF.
    popd
    exit /b 1
  )
)
popd

call :cleanup "%OUTPUT_DIR%"
echo Done. Output PDFs are in %OUTPUT_DIR%.
exit /b 0

:cleanup
set "TARGET=%~1"
for %%E in (aux bbl blg bcf log out toc lof lot fls fdb_latexmk nav snm vrb idx ilg ind acn acr alg glg glo gls ist xdy run.xml synctex pdfsync) do (
  del /q "%TARGET%\*.%%E" 2>nul
)
del /q "%TARGET%\*.synctex.gz" 2>nul
exit /b 0
