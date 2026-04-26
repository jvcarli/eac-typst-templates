set windows-shell := ["cmd.exe", "/c"]

BUILD_DIR := "build"

REPO_ROOT := justfile_directory()
export TYPST_ROOT := REPO_ROOT

# Redirect Typst's package cache to the repo root so examples can use the
# published import syntax (#import "@preview/eac-typst-templates:0.1.0")
# instead of relative paths (#import "../../src/lib.typ").
export TYPST_PACKAGE_CACHE_PATH := REPO_ROOT / ".typst/cache"

# Cross-platform rm -rf and mkdir -p
rmrf := if os_family() == "windows" { REPO_ROOT / "scripts/rmrf.cmd" } else { "rm -rf" }
mkdirp := if os_family() == "windows" { REPO_ROOT / "scripts/mkdirp.cmd"} else { "mkdir -p" }

[private]
default:
  @just --list --unsorted

# Set up the local dev environment (symlink package into .typst/cache and install git hooks)
setup: _symlink_pkg
  prek install

# Compile all examples using typst
compile-examples: _symlink_pkg _create_build_dir
  typst compile examples/slides/simple/main.typ {{BUILD_DIR}}/examples/slides/simple.pdf
  typst compile examples/slides/complex/main.typ {{BUILD_DIR}}/examples/slides/complex.pdf
  typst compile examples/slides/kitchen-sink/main.typ {{BUILD_DIR}}/examples/slides/kitchen-sink.pdf

  typst compile examples/technical-report/main.typ {{BUILD_DIR}}/examples/technical-report.pdf

# Compile examples/kitchen-sink.typ using typst watch mode. Meant for development.
watch-kitchen-sink: _symlink_pkg _create_build_dir
  typst watch examples/slides/kitchen-sink/main.typ {{BUILD_DIR}}/examples/slides/kitchen-sink.pdf

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
  @{{rmrf}} {{BUILD_DIR}}

# Gets fresh environment. It will be necessary to run `just setup` afterwards.
freshenv: clean
  @{{rmrf}} .typst

_create_build_dir:
  @{{mkdirp}} {{BUILD_DIR}} {{BUILD_DIR}}/examples {{BUILD_DIR}}/examples/slides

_symlink_pkg:
  python scripts/symlink_pkg.py
