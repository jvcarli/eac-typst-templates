@echo off
REM Windows shim for mkdir -p. Creates directories (including nested paths).
REM Safe to run even if the directory already exists.
REM
REM Usage:
REM   mkdirp.cmd <path> [<path> ...]
for %%A in (%*) do (
    if not exist "%%A\" (
        mkdir "%%A"
    )
)
