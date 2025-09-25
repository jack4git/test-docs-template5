#!/bin/bash

# Test Setup Script
# Validates that the documentation repository is properly configured

echo "🔍 Testing Documentation Repository Setup..."
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track errors
errors=0

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if file exists
file_exists() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "${RED}✗${NC} $2"
        ((errors++))
        return 1
    fi
}

# Function to check if directory exists
dir_exists() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "${RED}✗${NC} $2"
        ((errors++))
        return 1
    fi
}

echo "=== Checking Prerequisites ==="

# Check Node.js
if command_exists node; then
    node_version=$(node -v)
    echo -e "${GREEN}✓${NC} Node.js installed: $node_version"
else
    echo -e "${RED}✗${NC} Node.js not installed"
    ((errors++))
fi

# Check npm
if command_exists npm; then
    npm_version=$(npm -v)
    echo -e "${GREEN}✓${NC} npm installed: $npm_version"
else
    echo -e "${RED}✗${NC} npm not installed"
    ((errors++))
fi

# Check Git
if command_exists git; then
    git_version=$(git --version | cut -d' ' -f3)
    echo -e "${GREEN}✓${NC} Git installed: $git_version"
else
    echo -e "${RED}✗${NC} Git not installed"
    ((errors++))
fi

# Check Git LFS
if command_exists git-lfs; then
    lfs_version=$(git-lfs version | cut -d' ' -f1)
    echo -e "${GREEN}✓${NC} Git LFS installed: $lfs_version"
else
    echo -e "${YELLOW}⚠${NC} Git LFS not installed (optional but recommended)"
fi

echo ""
echo "=== Checking Directory Structure ==="

# Check critical directories
dir_exists ".github" ".github directory"
dir_exists ".github/workflows" "GitHub workflows directory"
dir_exists ".github/DOCUMENTATION" "Meta-documentation directory"
dir_exists "docs" "Documentation directory"
dir_exists "scripts" "Scripts directory"
dir_exists "config" "Config directory"

echo ""
echo "=== Checking Configuration Files ==="

# Check essential files
file_exists "package.json" "package.json"
file_exists ".gitignore" ".gitignore"
file_exists ".gitattributes" ".gitattributes"
file_exists ".markdownlint.json" "Markdown lint config"
file_exists "cspell.json" "Spell check config"

echo ""
echo "=== Checking Meta-Documentation ==="

file_exists ".github/DOCUMENTATION/README.md" "Meta-docs index"
file_exists ".github/DOCUMENTATION/setup-guide.md" "Setup guide"
file_exists ".github/DOCUMENTATION/docs-as-code-strategy.md" "Strategy document"

echo ""
echo "=== Checking GitHub Actions ==="

file_exists ".github/workflows/validate.yml" "Validation workflow"

echo ""
echo "=== Checking npm Dependencies ==="

if [ -f "package-lock.json" ]; then
    echo -e "${GREEN}✓${NC} Dependencies installed (package-lock.json exists)"
else
    echo -e "${YELLOW}⚠${NC} Dependencies not installed. Run: npm install"
fi

echo ""
echo "================================"

if [ $errors -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed!${NC}"
    echo "Your documentation repository is properly configured."
    exit 0
else
    echo -e "${RED}❌ $errors check(s) failed${NC}"
    echo "Please review the errors above and fix them."
    exit 1
fi
