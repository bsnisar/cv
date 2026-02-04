# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a LaTeX-based CV/resume for Bohdan Snisar. The main document is `wp.tex` using the `moderncv` document class with the classic style.

## Build Commands

**Local build (requires Docker):**
```bash
# First time: build the Docker image
make docker-build

# Build the PDF
make
```

**Clean build artifacts:**
```bash
make clean
```

**Full rebuild:**
```bash
make rebuild
```

## CI/CD

The GitHub Actions workflow (`.github/workflows/build-latex.yml`) automatically:
- Builds `wp.tex` on every push to `main` and on pull requests
- Creates a GitHub Release with the PDF named `cv.pdf` on pushes to `main`
- Latest PDF available at: https://github.com/bsnisar/cv/releases/latest/download/cv.pdf

## File Structure

- `wp.tex` - Main CV document (moderncv format)
- `tikz-uml.sty` - TikZ UML package (included but not currently used)
- `Makefile` - Local build automation using Docker
- `Dockerfile` - TeX Live environment for local builds
- `entrypoint.sh` - Script used by GitHub Actions latex-action
