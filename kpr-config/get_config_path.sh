#!/bin/bash

# Get script's own directory and move up to the parent directory
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
CONFIG_PATH=$(dirname "$SCRIPT_DIR")

# Output the path
echo "$CONFIG_PATH"