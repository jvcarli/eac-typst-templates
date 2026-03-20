"""
Shared constants for dev scripts (REPO_ROOT, PKG_NAME, VERSION, PKG_DEV_DIR).
"""

import tomllib
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

_pkg = tomllib.loads((REPO_ROOT / "typst.toml").read_text())["package"]

PKG_NAME = _pkg["name"]
VERSION = _pkg["version"]
PKG_DEV_DIR = REPO_ROOT / ".typst" / "cache" / "preview" / PKG_NAME / VERSION

if __name__ == "__main__":
    raise SystemExit("This module is not meant to be run directly.")
