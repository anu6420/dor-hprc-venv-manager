# ModuLair Makefile
# Builds and installs the ModuLair virtual environment management tools

# Configuration
ROOTDIR := $(PWD)
BINDIR := $(ROOTDIR)/bin
LOGDIR := $(ROOTDIR)/logs
SRCDIR := $(ROOTDIR)/src

# Default metadata location - can be overridden
METDIR ?= /scratch/user/$$USER

# Template and output files
TEMPLATES := activate_venv.template list_venvs.template create_venv.template delete_venv.template add_venv.template utils.py.template json_to_command.template
SCRIPTS := activate_venv list_venvs create_venv delete_venv utils.py json_to_command add_venv

# Default target
.PHONY: all
all: build

# Build target - processes templates and prepares scripts
.PHONY: build
build: directories $(SCRIPTS)
	@echo "Build completed successfully!"
	@echo "Binary directory: $(BINDIR)"
	@echo "Log directory: $(LOGDIR)"
	@echo "Metadata location: $(METDIR)"

# Create necessary directories
.PHONY: directories
directories:
	@echo "Creating directories..."
	@mkdir -p $(BINDIR)
	@mkdir -p $(LOGDIR)
	@touch $(LOGDIR)/venv.log
	@chmod uog+rw $(LOGDIR)/venv.log

# Template processing rules
activate_venv: $(SRCDIR)/activate_venv.template
	@echo "Processing activate_venv..."
	@cp $< $@
	@sed -i 's|<BINDIR>|$(BINDIR)|g' $@
	@sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@

list_venvs: $(SRCDIR)/list_venvs.template
	@echo "Processing list_venvs..."
	@cp $< $@
	@sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@
	@sed -i 's|<METDIR>|$(METDIR)|g' $@

create_venv: $(SRCDIR)/create_venv.template
	@echo "Processing create_venv..."
	@cp $< $@
	@sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@
	@sed -i 's|<METDIR>|$(METDIR)|g' $@

delete_venv: $(SRCDIR)/delete_venv.template
	@echo "Processing delete_venv..."
	@cp $< $@
	@sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@
	@sed -i 's|<METDIR>|$(METDIR)|g' $@

add_venv:
	@echo "Processing add_venv..."
	@if [ -f "$(SRCDIR)/add_venv.template" ]; then \
		cp $(SRCDIR)/add_venv.template $@ && \
		sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@ && \
		sed -i 's|<METDIR>|$(METDIR)|g' $@; \
	elif [ -f "$(SRCDIR)/add_venv" ]; then \
		cp $(SRCDIR)/add_venv $@ && \
		sed -i 's|<LOGDIR>|$(LOGDIR)|g' $@ && \
		sed -i 's|<METDIR>|$(METDIR)|g' $@; \
	else \
		echo "Error: Neither add_venv.template nor add_venv found in $(SRCDIR)"; \
		exit 1; \
	fi

json_to_command:
	@echo "Processing json_to_command..."
	@if [ -f "$(SRCDIR)/json_to_command.template" ]; then \
		cp $(SRCDIR)/json_to_command.template $@; \
	elif [ -f "$(SRCDIR)/json_to_command" ]; then \
		cp $(SRCDIR)/json_to_command $@; \
	else \
		echo "Error: Neither json_to_command.template nor json_to_command found in $(SRCDIR)"; \
		exit 1; \
	fi

utils.py: $(SRCDIR)/utils.py.template
	@echo "Processing utils.py..."
	@cp $< $@
	@sed -i 's|<METDIR>|$(METDIR)|g' $@

# Install target - copies processed scripts to bin directory
.PHONY: install
install: build
	@echo "Installing scripts to $(BINDIR)..."
	@mv activate_venv $(BINDIR)/
	@mv list_venvs $(BINDIR)/
	@mv create_venv $(BINDIR)/
	@mv delete_venv $(BINDIR)/
	@mv utils.py $(BINDIR)/
	@mv json_to_command $(BINDIR)/
	@mv add_venv $(BINDIR)/
	@echo ""
	@echo "Installation completed successfully!"
	@echo ""
	@echo "To use ModuLair tools, add the following to your PATH:"
	@echo "  export PATH=\"$(BINDIR):\$$PATH\""
	@echo ""
	@echo "Available tools:"
	@echo "  - create_venv: Create new virtual environments"
	@echo "  - list_venvs: List existing virtual environments"
	@echo "  - activate_venv: Generate activation commands (use with 'source')"
	@echo "  - delete_venv: Delete virtual environments"
	@echo "  - add_venv: Add existing virtual environments to management"

# Development build target - processes templates but doesn't move to bin
.PHONY: dev
dev: directories $(SCRIPTS)
	@echo "Development build completed!"
	@echo "Scripts are ready for testing in the current directory."
	@echo "Use 'make install' to move them to the bin directory."

.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -f activate_venv list_venvs create_venv delete_venv add_venv utils.py json_to_command
	@rm -rf $(BINDIR)
	@echo "Clean completed."

.PHONY: clean-all
clean-all: clean
	@echo "Removing logs..."
	@rm -rf $(LOGDIR)
	@echo "Full clean completed."

# Help target
.PHONY: help
help:
	@echo "ModuLair Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all         - Build the project (default)"
	@echo "  build       - Process templates and prepare scripts"
	@echo "  install     - Build and install scripts to bin directory"
	@echo "  dev         - Development build (build but don't install)"
	@echo "  clean       - Remove generated files"
	@echo "  clean-all   - Remove generated files and logs"
	@echo "  help        - Show this help message"
	@echo ""
	@echo "Configuration variables:"
	@echo "  METDIR      - Metadata directory location (default: /scratch/user/\$$USER)"
	@echo ""
	@echo "Examples:"
	@echo "  make install                               # Standard installation"
	@echo "  make install METDIR=/custom/path          # Custom metadata location"
	@echo "  make dev                                   # Development build"

# Declare all targets as phony to avoid conflicts with files of the same name
.PHONY: all build install dev clean clean-all help directories
