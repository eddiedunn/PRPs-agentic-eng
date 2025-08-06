
#!/bin/bash

# sync_prps.sh
# ---------------------------------------------
# Seed an existing repo with PRPs resources from a source repo.
#
# Usage:
#   ./sync_prps.sh
#
# This script is intended to be copied into an existing repo to seed it
# by copying templates, scripts, ai_docs, and .claude/commands
# from the source repo (../../eddiedunn/PRPs-agentic-eng) into the current repo.
#
# Make sure you have read permissions for the source repo.
#
# To make this script executable, run:
#   chmod +x ./sync_prps.sh
# ---------------------------------------------

# Set the source repo path
SRC_PATH="../../eddiedunn/PRPs-agentic-eng"

echo "Syncing resources from $SRC_PATH..."

# Sync .claude directory
mkdir -p .claude
cp -r "$SRC_PATH/.claude/"* .claude/ 2>/dev/null || :

# Sync PRPs subfolders
mkdir -p PRPs/templates
mkdir -p PRPs/scripts
mkdir -p PRPs/ai_docs

cp -r "$SRC_PATH/PRPs/templates" PRPs/
cp -r "$SRC_PATH/PRPs/scripts" PRPs/
cp "$SRC_PATH/README.md" PRPs/
cp -r "$SRC_PATH/PRPs/ai_docs" PRPs/

echo "Sync complete."
