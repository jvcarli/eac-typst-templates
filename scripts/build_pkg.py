#!/usr/bin/env python3

"""
Builds a distributable copy of the package at <REPO_ROOT>/build/<pkg>/.
Respects .typstignore. The name and version are read from typst.toml.
"""

import fnmatch
import os
import shutil
from pathlib import Path
from get_pkg_env import REPO_ROOT, PKG_NAME


def load_ignores() -> list[tuple[bool, str]]:
    """Return list of (negated, pattern) tuples."""
    ignore_file = REPO_ROOT / ".typstignore"
    if not ignore_file.exists():
        return []
    result = []
    for line in ignore_file.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("!"):
            result.append((True, line[1:].rstrip("/")))
        else:
            result.append((False, line.rstrip("/")))
    return result


def is_ignored(rel: Path, ignores: list[tuple[bool, str]]) -> bool:
    """
    Apply ignore rules in order. Last matching rule wins.
    * matches across directory separators (unlike gitignore).
    .git and .typstignore are excluded automatically.
    """
    rel_str = rel.as_posix()
    if rel_str in (".git", ".typstignore"):
        return True
    ignored = False
    for negated, pattern in ignores:
        if fnmatch.fnmatch(rel_str, pattern) or fnmatch.fnmatch(
            rel_str, pattern + "/*"
        ):
            ignored = not negated
    return ignored


def collect_files(ignores: list[tuple[bool, str]]) -> list[Path]:
    """Collect all files under REPO_ROOT not matched by ignores."""
    files = []
    for dirpath, dirnames, filenames in os.walk(REPO_ROOT, followlinks=False):
        dirpath = Path(dirpath)
        for filename in filenames:
            f = dirpath / filename
            rel = f.relative_to(REPO_ROOT)
            if not is_ignored(rel, ignores):
                files.append(rel)
    return sorted(files)


def main():
    target = REPO_ROOT / "build" / PKG_NAME

    print(f"Building {PKG_NAME}")
    print(f"  {REPO_ROOT}")
    print(f"  -> {target}")

    ignores = load_ignores()
    files = collect_files(ignores)

    if target.exists():
        shutil.rmtree(target)
        print("Overwriting existing build.")

    for rel in files:
        dest = target / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(REPO_ROOT / rel, dest)

    print(f"Done. ({len(files)} files)")


if __name__ == "__main__":
    main()
