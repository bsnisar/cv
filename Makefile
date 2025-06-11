# Name of the LaTeX source file (without the .tex extension)
TARGET = wp

# Docker image name
DOCKER_IMAGE = ltx

# Docker volume path (current directory)
DOCKER_VOLUME = $(PWD)

# Default target: Build the PDF
.PHONY: all
all: build

# Build the Docker image
.PHONY: docker-build
docker-build:
	@echo "Building Docker image..."
	docker build -t $(DOCKER_IMAGE) .

# Generate git commit information
.PHONY: gitinfo
gitinfo:
	@echo "Generating git commit info..."
	# @echo "\\\renewcommand{\\gitcommit}{(commit: \\\texttt{$(shell git rev-parse --short HEAD)})}" > gitinfo.tex

# Compile the LaTeX document using the Docker container
.PHONY: build
build: gitinfo
	@echo "Compiling LaTeX document..."
	docker run --rm -v "$(DOCKER_VOLUME):/workspace" $(DOCKER_IMAGE) latexmk -pdf $(TARGET).pdf

# Clean up temporary files and artifacts
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(TARGET).aux $(TARGET).log $(TARGET).out $(TARGET).toc $(TARGET).pdf $(TARGET).fls $(TARGET).fdb_latexmk

# Rebuild everything (clean + build)
.PHONY: rebuild
rebuild: clean build

# Help target to list all commands
.PHONY: help
help:
    @echo "Makefile commands:"
	@echo "  make          - Build the LaTeX document (default)"
	@echo "  make docker-build - Build the Docker image"
	@echo "  make gitinfo  - Generate git commit information"
	@echo "  make build    - Compile the LaTeX document"
	@echo "  make clean    - Clean up temporary files and artifacts"
	@echo "  make rebuild  - Clean and rebuild the LaTeX document"
	@echo "  make help     - Show this help message"