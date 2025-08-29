#!/bin/bash

# ModuLair Setup Script
# This script sets up the ModuLair virtual environment management tools

set -e  # Exit on any error

rootdir=$PWD

# Configuration variables 
default_bindir="${rootdir}/bin"
default_logdir="${rootdir}/logs"

# Require user to specify metadata locations
if [ -z "$MODULAIR_METADATA_DIR" ]; then
    echo "Error: MODULAIR_METADATA_DIR environment variable must be set."
    echo "Example: MODULAIR_METADATA_DIR=\"/scratch/user/\$USER\" ./setup.sh"
    echo "Or:      MODULAIR_METADATA_DIR=\"/home/\$USER/.venvs\" ./setup.sh"
    exit 1
fi

if [ -z "$MODULAIR_GROUP_METADATA_DIR" ]; then
    echo "Error: MODULAIR_GROUP_METADATA_DIR environment variable must be set."
    echo "Example: MODULAIR_GROUP_METADATA_DIR=\"/scratch/group\" ./setup.sh"
    echo "Or:      MODULAIR_GROUP_METADATA_DIR=\"/shared/groups\" ./setup.sh"
    exit 1
fi

metadataloc="$MODULAIR_METADATA_DIR"
groupmetaloc="$MODULAIR_GROUP_METADATA_DIR"

echo "Setting up ModuLair with the following configuration:"
echo "  Root directory: $rootdir"
echo "  Binary directory: $default_bindir"
echo "  Log directory: $default_logdir"
echo "  User metadata location: $metadataloc"
echo "  Group metadata location: $groupmetaloc"
echo

# Create necessary directories
mkdir -p bin
mkdir -p logs

# Copy template files and replace placeholders
echo "Processing template files..."

# Process activate_venv
cp src/activate_venv.template activate_venv
sed -i "s|<BINDIR>|${default_bindir}|g" activate_venv
sed -i "s|<LOGDIR>|${default_logdir}|g" activate_venv

# Process list_venvs
cp src/list_venvs.template list_venvs
sed -i "s|<LOGDIR>|${default_logdir}|g" list_venvs
sed -i "s|<METDIR>|${metadataloc}|g" list_venvs
sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" list_venvs

# Process create_venv
cp src/create_venv.template create_venv
sed -i "s|<LOGDIR>|${default_logdir}|g" create_venv
sed -i "s|<METDIR>|${metadataloc}|g" create_venv
sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" create_venv

# Process delete_venv
cp src/delete_venv.template delete_venv
sed -i "s|<LOGDIR>|${default_logdir}|g" delete_venv
sed -i "s|<METDIR>|${metadataloc}|g" delete_venv
sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" delete_venv

# Process utils.py
if [ -f "src/utils.py.template" ]; then
    cp src/utils.py.template utils.py
    sed -i "s|<METDIR>|${metadataloc}|g" utils.py
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" utils.py
elif [ -f "src/utils.py" ]; then
    cp src/utils.py utils.py
    sed -i "s|<METDIR>|${metadataloc}|g" utils.py
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" utils.py
else
    echo "Error: Neither utils.py.template nor utils.py found in src/"
    exit 1
fi

# Process json_to_command
if [ -f "src/json_to_command.template" ]; then
    cp src/json_to_command.template json_to_command
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" json_to_command
elif [ -f "src/json_to_command" ]; then
    cp src/json_to_command json_to_command
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" json_to_command
else
    echo "Error: Neither json_to_command.template nor json_to_command found in src/"
    exit 1
fi

# Process add_venv
if [ -f "src/add_venv.template" ]; then
    cp src/add_venv.template add_venv
    sed -i "s|<LOGDIR>|${default_logdir}|g" add_venv
    sed -i "s|<METDIR>|${metadataloc}|g" add_venv
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" add_venv
elif [ -f "src/add_venv" ]; then
    cp src/add_venv add_venv
    sed -i "s|<LOGDIR>|${default_logdir}|g" add_venv
    sed -i "s|<METDIR>|${metadataloc}|g" add_venv
    sed -i "s|<GROUPMETDIR>|${groupmetaloc}|g" add_venv
else
    echo "Error: Neither add_venv.template nor add_venv found in src/"
    exit 1
fi

# Move processed scripts to bin directory
echo "Moving processed scripts to bin directory..."
mv activate_venv bin/
mv list_venvs bin/
mv create_venv bin/
mv delete_venv bin/
mv utils.py bin/
mv json_to_command bin/
mv add_venv bin/

# Setup log directory and file
echo "Setting up logging..."
touch ${default_logdir}/venv.log
chmod uog+rw ${default_logdir}/venv.log

echo
echo "Setup completed successfully!"
echo
echo "Configuration used:"
echo "  User metadata location: $metadataloc"
echo "  Group metadata location: $groupmetaloc"
echo "  Binary directory: $default_bindir"
echo "  Log directory: $default_logdir"
echo
echo "To use ModuLair tools, add the following to your PATH:"
echo "  export PATH=\"${default_bindir}:\$PATH\""
echo
echo "Or run the tools directly from: ${default_bindir}"
echo
echo "Available tools:"
echo "  - create_venv: Create new virtual environments"
echo "  - list_venvs: List existing virtual environments"
echo "  - activate_venv: Generate activation commands (use with 'source')"
echo "  - delete_venv: Delete virtual environments"
echo "  - add_venv: Add existing virtual environments to management"
echo
