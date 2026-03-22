#!/usr/bin/env python3

"""Pre-commit hook: ensure all Typst examples compile successfully."""

import os
import subprocess
import sys
import tempfile
from pathlib import Path
from get_pkg_env import REPO_ROOT
from symlink_pkg import main as symlink_pkg

ENV = {
    **os.environ,
    "TYPST_PACKAGE_CACHE_PATH": str(REPO_ROOT / ".typst" / "cache"),
}


def find_examples() -> list[Path]:
    examples_dir = REPO_ROOT / "examples"
    if not examples_dir.is_dir():
        print(
            f"[check-typst-examples] No examples/ directory found at {REPO_ROOT}",
            file=sys.stderr,
        )
        sys.exit(1)
    top_level = sorted(examples_dir.glob("*.typ"))
    sub_mains = sorted(examples_dir.glob("*/main.typ"))
    return top_level + sub_mains


def compile_example(typ_file: Path, output: Path) -> tuple[bool, str]:
    result = subprocess.run(
        ["typst", "compile", str(typ_file), str(output)],
        capture_output=True,
        text=True,
        env=ENV,
    )
    return result.returncode == 0, result.stderr.strip()


def main() -> None:
    symlink_pkg()

    examples = find_examples()

    if not examples:
        print("[check-typst-examples] No examples found in examples/")
        sys.exit(0)

    print(f"[check-typst-examples] Compiling {len(examples)} example(s)...")

    failed: list[tuple[Path, str]] = []

    with tempfile.TemporaryDirectory() as tmp:
        for i, typ_file in enumerate(examples, 1):
            rel = typ_file.relative_to(REPO_ROOT)
            out = Path(tmp) / f"out_{i}.pdf"
            ok, stderr = compile_example(typ_file, out)
            if ok:
                print(f"  PASS {rel}")
            else:
                print(f"  FAIL {rel}")
                failed.append((rel, stderr))

    if failed:
        print(
            f"\n[check-typst-examples] {len(failed)} example(s) failed to compile:\n",
            file=sys.stderr,
        )
        for rel, stderr in failed:
            print(f"--- {rel} ---", file=sys.stderr)
            print(stderr, file=sys.stderr)
            print(file=sys.stderr)
        sys.exit(1)

    print("\n[check-typst-examples] All examples compiled successfully.")


if __name__ == "__main__":
    main()
