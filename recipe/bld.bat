echo on

mkdir "nbpresent\static\nbpresent\css"
copy "%RECIPE_DIR%\nbpresent\static\nbpresent\css\nbpresent.min.css" "nbpresent\static\nbpresent\css"

CALL npm install || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

CALL npm run clean || EXIT /B 1
CALL npm run build:release || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

(rmdir /s /q "\\?\%cd%\node_modules" 2> NUL) || echo "some issues cleaning up"
"%PYTHON%" setup.py install --single-version-externally-managed --record=record.txt

CALL "%PREFIX%\Scripts\jupyter-nbextension" install nbpresent --py --sys-prefix --overwrite --log-level=0 || EXIT /B 1

mkdir "%SP_DIR%\nbpresent\static\nbpresent\css"
mkdir "%PREFIX%\nbpresent\static\nbpresent\css"
copy "%RECIPE_DIR%\nbpresent\static\nbpresent\css\nbpresent.min.css" "%SP_DIR%\nbpresent\static\nbpresent\css"
copy "%RECIPE_DIR%\nbpresent\static\nbpresent\css\nbpresent.min.css" "%PREFIX%\nbpresent\static\nbpresent\css"

IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
