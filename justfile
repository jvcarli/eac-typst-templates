set windows-shell := ["cmd.exe", "/c"]

REPO_ROOT := justfile_directory()
export TYPST_ROOT := REPO_ROOT

# Cross-platform rm -rf and mkdir -p
rmrf := if os_family() == "windows" { REPO_ROOT / "scripts/rmrf.cmd" } else { "rm -rf" }
mkdirp := if os_family() == "windows" { REPO_ROOT / "scripts/mkdirp"} else { "mkdir -p" }

[private]
default:
  @just --list --unsorted

# Compile examples using typst
compile-examples:
  @{{mkdirp}} build/examples
  @{{mkdirp}} build/examples/complex
  typst compile examples/simple.typ build/examples/simple.pdf
  typst compile examples/complex/main.typ build/examples/complex/complex.pdf
  typst compile examples/kitchen-sink.typ build/examples/kitchen-sink.pdf

# Compile examples/kitchen-sink.typ using typst watch mode. Meant for development.
watch-kitchen-sink:
  @{{mkdirp}} build/examples
  typst watch examples/kitchen-sink.typ build/examples/kitchen-sink.pdf

# Clean build artifacts
clean:
  @{{rmrf}} build
