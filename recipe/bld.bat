echo on

CALL npm install || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

CALL npm run clean || EXIT /B 1
CALL npm run build || EXIT /B 1
CALL npm run build:release || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

dir /s %SP_DIR%\nbpresent

dir /s node_modules

(rmdir /s /q "\\?\%cd%\node_modules" 2> NUL) || echo "some issues cleaning up"
"%PYTHON%" setup.py install --single-version-externally-managed --record=record.txt

CALL "%PREFIX%\Scripts\jupyter-nbextension" install nbpresent --py --sys-prefix --overwrite --log-level=0 || EXIT /B 1
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
