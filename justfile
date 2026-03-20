set windows-shell := ["cmd.exe", "/c"]

REPO_ROOT := justfile_directory()
export TYPST_ROOT := REPO_ROOT

# Redirect Typst's package cache to the repo root so examples can use the
# published import syntax (#import "@preview/eac-typst-slides-template:0.1.0")
# instead of relative paths (#import "../../src/lib.typ").
export TYPST_PACKAGE_CACHE_PATH := REPO_ROOT / ".typst/cache"

# Cross-platform rm -rf and mkdir -p
rmrf := if os_family() == "windows" { REPO_ROOT / "scripts/rmrf.cmd" } else { "rm -rf" }
mkdirp := if os_family() == "windows" { REPO_ROOT / "scripts/mkdirp"} else { "mkdir -p" }

[private]
default:
  @just --list --unsorted

# Set up the dev environment
setup:
    python scripts/symlink_pkg.py

# Compile all examples using typst
compile-examples: setup _create_build_dir
  typst compile examples/simple.typ build/examples/simple.pdf
  typst compile examples/complex/main.typ build/examples/complex.pdf
  typst compile examples/kitchen-sink.typ build/examples/kitchen-sink.pdf

# Compile examples/kitchen-sink.typ using typst watch mode. Meant for development.
watch-kitchen-sink: setup _create_build_dir
  typst watch examples/kitchen-sink.typ build/examples/kitchen-sink.pdf

# Build package documentation using mdbook
docs:
  mdbook build docs

# Run mdbook server for developing package documentation
dev-docs:
  mdbook serve docs

# Build the package for submission to Typst Universe, see: https://typst.app/universe/
package:
    python scripts/build_pkg.py

# Clean build artifacts
clean:
  @{{rmrf}} build

# Gets fresh environment
freshenv: clean
  @{{rmrf}} .typst

_create_build_dir:
  @{{mkdirp}} build/examples
