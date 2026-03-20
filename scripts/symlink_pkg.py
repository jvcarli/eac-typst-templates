#!/usr/bin/env python3

"""
Links the repo root directory into the Typst package cache
at <REPO_ROOT>/.typst/cache/preview/eac-typst-slides-template/<version>/.
Uses symlinks on Unix, junctions on Windows. No admin permissions required.
"""

import os
import sys
import shutil
from pathlib import Path
from get_pkg_env import REPO_ROOT, PKG_NAME, VERSION, PKG_DEV_DIR


def is_windows() -> bool:
    return sys.platform == "win32"


def remove_existing():
    if not PKG_DEV_DIR.exists() and not PKG_DEV_DIR.is_symlink():
        return
    if PKG_DEV_DIR.is_dir() and not PKG_DEV_DIR.is_symlink():
        os.rmdir(PKG_DEV_DIR) if is_windows() else shutil.rmtree(PKG_DEV_DIR)
    else:
        PKG_DEV_DIR.unlink()


def link_windows():
    """Junction for the directory link (no admin needed)."""
    import subprocess

    PKG_DEV_DIR.parent.mkdir(parents=True, exist_ok=True)
    result = subprocess.run(
        ["cmd", "/c", "mklink", "/J", str(PKG_DEV_DIR), str(REPO_ROOT)],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print(f"Failed to create junction: {result.stderr.strip()}")
        sys.exit(1)


def link_unix():
    PKG_DEV_DIR.parent.mkdir(parents=True, exist_ok=True)
    PKG_DEV_DIR.symlink_to(REPO_ROOT)


def main():
    print(f"Linking {PKG_NAME} {VERSION}")
    print(f"  {REPO_ROOT}")
    print(f"  -> {PKG_DEV_DIR}")
    remove_existing()
    link_windows() if is_windows() else link_unix()
    print("Done.")


if __name__ == "__main__":
    main()
