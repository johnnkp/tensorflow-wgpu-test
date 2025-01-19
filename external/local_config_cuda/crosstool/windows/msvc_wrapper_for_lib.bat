for /f %%a in ("%*") do set d=%%a
echo.d : %d%
C:/Users/AMD/anaconda3/python.exe %~dp0msvc_wrapper_for_lib.py %*