@echo off
REM Windows shim for rm -rf. Removes files and directories.
REM Safe to run even if paths don't exist.
REM
REM Usage:
REM   rmrf.cmd <path> [<path> ...]

for %%A in (%*) do (
    if exist "%%A\" (
        rd /s /q "%%A"
    ) else if exist "%%A" (
        del /f /q "%%A"
    )
)
