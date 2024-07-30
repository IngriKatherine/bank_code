@echo off
echo My path is "%~dp0"

"C:\Program Files\Stata17\StataMP-64" /e do "%~dp0batch_test.do"