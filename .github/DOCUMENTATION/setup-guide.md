# Documentation Repository Setup Guide

> **Note:** This document should be placed in `.github/DOCUMENTATION/setup-guide.md` in your documentation repository, alongside the [Docs-as-Code Strategy](./docs-as-code-strategy.md). Together, these form the meta-documentation that explains how to use and maintain the documentation system.

## Pre-Setup Checklist

Before using the template:
- [ ] Decide on repository name and location in your organization
- [ ] Ensure GitHub account and organization access with repository creation permissions
- [ ] Install Git locally (for development and contributions)
- [ ] Install Node.js v20+ (for running validation tools and scripts)
- [ ] Install VS Code or Obsidian (for content editing)
- [ ] Identify initial documents to migrate to the new system
- [ ] Schedule team training session for docs-as-code approach

**Note:** Git LFS is pre-configured in the template. You only need to install `git lfs` locally if you plan to add binary files (images, PDFs) to the repository.

## Using the GitHub Template

### Creating Your Repository

This documentation system is available as a GitHub template. Instead of manual setup:

1. **Use the Template**
   - Go to the [docs-as-code-template](https://github.com/cto4ai/docs-as-code-template) repository
   - Click "Use this template" button
   - Choose "Create a new repository"
   - Name your repository following these conventions:
     - **Standalone docs**: `docs`, `documentation`, `knowledge-base`
     - **Product-specific**: `product-name-docs`, `api-documentation`
     - **Internal**: `internal-docs`, `company-handbook`, `team-playbook`

2. **Automatic Setup**
   After creating your repository from the template, GitHub Actions will automatically:
   - Install Node.js dependencies
   - Replace all template variables with your repository information
   - Remove example content and template instruction files
   - Create a personalized setup issue with next steps
   - Remove the initialization workflow (it only runs once)

3. **What You Get**
   Your new repository will be immediately ready with:
   - Personalized README.md with your repository name
   - All placeholder variables replaced
   - Working GitHub Actions workflows for validation
   - Clean directory structure ready for your content
   - Setup issue with customization guidance

### Automatic Variable Replacement

The GitHub Actions workflow automatically replaces template variables using your repository information:

| Variable | Replaced With | Example |
|----------|---------------|---------|
| `{{COMPANY_NAME}}` | Repository name (formatted) | "My Docs" (from "my-docs") |
| `{{REPO_NAME}}` | Repository name | "my-docs" |
| `{{GITHUB_ORG}}` | Repository owner | "your-org" |
| `{{DOCS_EMAIL}}` | Default placeholder | "docs@example.com" |
| `{{SLACK_CHANNEL}}` | Default placeholder | "#docs-help" |

**Advanced Customization** (optional): The automatic setup provides sensible defaults. If you need different values, you can manually edit files in your personalized repository or run `npm run init` for interactive customization of all template variables.

## Included Configuration Files

The template includes pre-configured files that you may want to customize:

### `.gitignore`

```gitignore
# Generated files
*.pdf
*.docx
*.html
docs/exports/
build/
dist/
site/

# OS files
.DS_Store
Thumbs.db
*.swp
*~

# IDE files
.vscode/
.idea/
*.iml

# Dependency directories
node_modules/
venv/
.env

# Temporary files
*.tmp
*.bak
*.log
.cache/

# But track specific PDFs if needed
!docs/templates/*.pdf
!docs/external/*.pdf
```

### `.gitattributes`

```gitattributes
# Auto detect text files and perform LF normalization
* text=auto

# Explicitly declare text files
*.md text
*.yml text
*.yaml text
*.json text
*.txt text
*.sh text eol=lf

# Graphics
*.png binary filter=lfs diff=lfs merge=lfs
*.jpg binary filter=lfs diff=lfs merge=lfs
*.jpeg binary filter=lfs diff=lfs merge=lfs
*.gif binary filter=lfs diff=lfs merge=lfs
*.svg text

# Documents (if you must store them)
*.pdf binary filter=lfs diff=lfs merge=lfs
*.docx binary filter=lfs diff=lfs merge=lfs

# Diff settings for better readability
*.md diff=markdown
```

### `.markdownlint.json`

```json
{
  "default": true,
  "MD013": {
    "line_length": 120,
    "code_blocks": false,
    "tables": false
  },
  "MD024": {
    "siblings_only": true
  },
  "MD033": {
    "allowed_elements": ["details", "summary", "img", "br"]
  },
  "MD041": false,
  "MD045": false,
  "MD046": {
    "style": "fenced"
  }
}
```

### `package.json` (for tooling)

```json
{
  "name": "company-docs",
  "version": "1.0.0",
  "description": "Company Documentation Repository",
  "scripts": {
    "lint": "markdownlint-cli2 'docs/**/*.md' --fix",
    "spell": "cspell 'docs/**/*.md'",
    "links": "markdown-link-check docs/**/*.md",
    "build:pdf": "node scripts/build-pdf.js",
    "build:html": "mkdocs build",
    "serve": "mkdocs serve",
    "validate": "npm run lint && npm run spell && npm run links",
    "pre-commit": "npm run validate",
    "test:setup": "bash scripts/test-setup.sh"
  },
  "devDependencies": {
    "@mermaid-js/mermaid-cli": "^10.6.1",
    "markdownlint-cli2": "^0.11.0",
    "markdown-link-check": "^3.11.2",
    "cspell": "^8.3.2"
  }
}
```

### `cspell.json`

```json
{
  "version": "0.2",
  "language": "en",
  "words": [
    "kubectl",
    "terraform",
    "mermaid",
    "github",
    "gitlab",
    "cicd",
    "pandoc",
    "mkdocs"
  ],
  "dictionaries": [
    "en_US",
    "companies",
    "softwareTerms",
    "typescript",
    "python"
  ],
  "ignorePaths": [
    "node_modules/**",
    ".git/**",
    "*.pdf",
    "*.png",
    "*.jpg"
  ]
}
```

### `.github/dependabot.yml`

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
    
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

## Template Structure

The template includes this complete directory structure:

```
.
├── README.md                      # Repository overview (customizable)
├── CONTRIBUTING.md                # Contribution guidelines (customizable)
├── LICENSE.md                     # MIT License (change if needed)
├── CHANGELOG.md                   # Version history
├── TEMPLATE_INSTRUCTIONS.md       # Delete after initialization
├──
├── .github/                       # GitHub-specific configuration
│   ├── DOCUMENTATION/            # Meta-documentation (included)
│   │   ├── setup-guide.md       # This setup guide
│   │   └── docs-as-code-strategy.md  # Documentation philosophy
│   ├── workflows/                # GitHub Actions (pre-configured)
│   │   ├── validate.yml         # Markdown validation
│   │   ├── build.yml            # Document building
│   │   └── deploy.yml           # Deployment automation
│   ├── ISSUE_TEMPLATE/          # Issue templates (customizable)
│   │   ├── bug-report.md
│   │   ├── doc-request.md
│   │   └── doc-fix.md
│   ├── PULL_REQUEST_TEMPLATE/   # PR templates (customizable)
│   │   └── pull_request_template.md
│   └── dependabot.yml           # Dependency updates
│
├── docs/                          # Documentation content structure
│   ├── examples/                 # Example documents (delete after review)
│   │   ├── policy-example.md
│   │   └── procedure-example.md
│   │
│   ├── templates/                # Document templates (customize as needed)
│   │   ├── policy-template.md
│   │   ├── procedure-template.md
│   │   └── architecture-template.md
│   │
│   └── assets/                   # Shared assets directory
│       └── images/              # For binary images (use sparingly)
│
├── config/                       # Tool configurations (included)
│   ├── .markdownlint.json       # Markdown linting rules
│   ├── cspell.json              # Spell checking configuration
│   └── .gitattributes           # Git LFS configuration
│
├── scripts/                      # Utility scripts (included)
│   └── init.js                  # Template initialization script
│
└── package.json                  # Node.js dependencies and scripts
```

### What You Need to Add

After template initialization, you'll typically add:

- **Content directories**: `docs/policies/`, `docs/procedures/`, `docs/architecture/`, etc.
- **Your actual documentation**: Replace examples with real content
- **Custom templates**: Modify included templates for your organization
- **Additional workflows**: Customize GitHub Actions as needed

## Post-Template Setup Steps

### 1. Customize Configuration Files

The template includes pre-configured files that you should review and customize:

**Update package.json:**
- Change the `name`, `description`, and other metadata fields
- Add any additional dependencies your team needs

**Review .markdownlint.json:**
- Adjust markdown linting rules to match your team's style preferences
- The defaults are sensible for most teams

**Customize cspell.json:**
- Add your organization's terminology to the `words` array
- Include product names, technologies, and domain-specific terms

### 2. Set Up GitHub Repository Settings

After pushing your customized template:

**Branch Protection:**
- Enable branch protection on `main` branch
- Require pull request reviews (recommended: 1-2 reviewers)
- Require status checks to pass
- Include administrators in restrictions

**Team Permissions:**
- Add documentation writers with `Write` access
- Add reviewers with `Triage` access for issue management
- Set up CODEOWNERS file for automated review assignments

**GitHub Pages (Optional):**
- Enable GitHub Pages in repository settings
- Set source to GitHub Actions
- Your site will be available at `https://[your-org].github.io/[repo-name]`

### 3. Content Migration Strategy

If migrating existing documentation:

1. **Export from existing systems** (Confluence, SharePoint, etc.)
2. **Convert to Markdown** using pandoc or manual conversion
3. **Replace static diagrams** with Mermaid where possible
4. **Test all internal links** and update paths as needed
5. **Set up redirects** from old locations to new ones
6. **Archive legacy documentation** after verification

## Repository README Template

```markdown
# [Company Name] Documentation

Welcome to our centralized documentation repository. This repository contains all technical and operational documentation for [Company Name].

## 📚 Quick Navigation

| Section | Description | Primary Audience |
|---------|-------------|------------------|
| [Policies](./docs/policies/) | Company policies and governance | All staff |
| [Procedures](./docs/procedures/) | Standard operating procedures | Operations team |
| [Architecture](./docs/architecture/) | System design and technical specs | Engineering |
| [Guides](./docs/guides/) | How-to guides and tutorials | All technical staff |
| [References](./docs/references/) | API docs, glossaries, references | Developers |

## 📖 Repository Documentation

- [How this repo is structured](./.github/DOCUMENTATION/setup-guide.md)
- [Our docs-as-code approach](./.github/DOCUMENTATION/docs-as-code-strategy.md)
- [Contributing guidelines](./CONTRIBUTING.md)

## 🚀 Getting Started

### For Readers

Browse documentation directly on GitHub - all diagrams and formatting will render automatically.

### For Contributors

1. **Clone the repository**
   ```bash
   git clone https://github.com/company/documentation.git
   cd documentation
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create a new branch**
   ```bash
   git checkout -b doc/your-change-description
   ```

4. **Validate your changes**
   ```bash
   npm run validate
   ```

5. **Submit a pull request**

See [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed guidelines.

## 🛠️ Tools and Setup

### Required Tools
- Git
- Node.js (v20+)
- Pandoc (for PDF generation)

### Recommended IDE Setup
- VS Code with extensions:
  - Markdown All in One
  - Markdown Preview Mermaid Support
  - markdownlint

## 📋 Documentation Standards

- **Format**: GitHub Flavored Markdown
- **Diagrams**: Mermaid (preferred) or SVG
- **Style Guide**: [Our Writing Guide](./docs/guides/writing-guide.md)
- **Templates**: Available in [docs/templates/](./docs/templates/)

## 🔄 Build Status

[![Documentation Build](https://github.com/company/documentation/actions/workflows/build.yml/badge.svg)](https://github.com/company/documentation/actions/workflows/build.yml)
[![Link Check](https://github.com/company/documentation/actions/workflows/validate.yml/badge.svg)](https://github.com/company/documentation/actions/workflows/validate.yml)

## 📞 Support

- **Questions**: Open a [Discussion](https://github.com/company/documentation/discussions)
- **Issues**: Report in [Issues](https://github.com/company/documentation/issues)
- **Contact**: documentation-team@company.com

## 📄 License

This documentation is licensed under [CC BY-SA 4.0](./LICENSE.md).
```

## CONTRIBUTING.md Template

```markdown
# Contributing to Documentation

Welcome! This repository follows docs-as-code principles, treating documentation with the same rigor as source code.

## 📚 Required Reading

Before contributing, please review these guides:
- **[Repository Setup Guide](./.github/DOCUMENTATION/setup-guide.md)** - Understand how this repo is structured
- **[Docs-as-Code Strategy](./.github/DOCUMENTATION/docs-as-code-strategy.md)** - Learn our documentation philosophy

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/company/documentation.git
   cd documentation
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b doc/your-change-description
   ```

4. **Make your changes**
   - Follow our [Markdown standards](./.github/DOCUMENTATION/docs-as-code-strategy.md#markdown-standards)
   - Use [Mermaid diagrams](./.github/DOCUMENTATION/docs-as-code-strategy.md#mermaid-diagram-examples) for visuals
   - Run validation before committing

5. **Validate your changes**
   ```bash
   npm run validate  # Runs linting, spell check, and link verification
   ```

6. **Commit with a clear message**
   ```bash
   git add .
   git commit -m "docs: update security policy with MFA requirements"
   ```

7. **Push and create a pull request**
   ```bash
   git push origin doc/your-change-description
   ```

## 📝 Documentation Standards

- **Format**: GitHub Flavored Markdown
- **Diagrams**: Mermaid (preferred), SVG when necessary
- **Images**: Minimize use, optimize before committing
- **Links**: Use relative paths for internal links

## 🔍 Review Process

All documentation changes require:
1. Automated validation passing (CI checks)
2. Peer review via pull request
3. Approval from designated reviewers

## 💡 Tips for Non-Technical Contributors

If you're not comfortable with Git command line:
- **Option 1**: Use [Obsidian with Git plugin](./.github/DOCUMENTATION/docs-as-code-strategy.md#obsidian-for-non-technical-contributors)
- **Option 2**: Edit directly on GitHub using the web interface
- **Option 3**: Ask for help in #docs-help on Slack

## ❓ Getting Help

- **Slack**: #docs-help channel
- **Office Hours**: Thursdays 2-3 PM
- **Email**: documentation-team@company.com

Thank you for contributing to our documentation!
```

## Branch Strategy

### Branch Protection Rules

Configure on GitHub under Settings → Branches:

```yaml
main:
  - Require pull request reviews (1-2 reviewers)
  - Dismiss stale reviews on new commits
  - Require status checks (CI/CD must pass)
  - Require branches to be up to date
  - Include administrators in restrictions
  - No force pushes
  - No deletions
```

### Branch Naming Convention

```
main                    # Production documentation
├── doc/policy-update   # Documentation changes
├── fix/broken-links    # Fixes
├── feature/new-section # New documentation sections
└── release/v2.0        # Version releases (if applicable)
```

## GitHub Actions Workflows

### `.github/workflows/validate.yml`

```yaml
name: Validate Documentation

on:
  pull_request:
    paths:
      - 'docs/**'
      - '.github/workflows/validate.yml'

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Markdown Lint
        run: npm run lint
      
      - name: Spell Check
        run: npm run spell
      
      - name: Check Links
        run: npm run links
      
      - name: Validate Mermaid Syntax
        run: |
          find docs -name "*.md" -exec \
            npx mmdc -i {} -o /tmp/test.svg -q \;

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Check for secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
      
      - name: Check for sensitive data
        run: |
          # Custom script to check for PII, credentials, etc.
          ./scripts/check-sensitive.sh
```

### `.github/workflows/build.yml`

```yaml
name: Build Documentation

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Build Environment
        run: |
          sudo apt-get update
          sudo apt-get install -y pandoc texlive-xetex
          npm ci
      
      - name: Generate PDF Documentation
        run: |
          npm run build:pdf
      
      - name: Generate Static Site
        run: |
          pip install mkdocs mkdocs-material mkdocs-mermaid2-plugin
          mkdocs build
      
      - name: Upload Artifacts
        uses: actions/upload-artifact@v4
        with:
          name: documentation-build
          path: |
            site/
            exports/*.pdf
          retention-days: 30
      
      - name: Deploy to GitHub Pages
        if: github.ref == 'refs/heads/main'
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./site
```

## Access Control

### Teams and Permissions

```yaml
Teams:
  documentation-admins:
    permission: admin
    members: [lead-tech-writer, docs-manager]
  
  documentation-writers:
    permission: write
    members: [tech-writers, developers]
  
  documentation-reviewers:
    permission: triage
    members: [subject-matter-experts, qa-team]
  
  everyone:
    permission: read
    members: [all-company-members]
```

### CODEOWNERS

Create `.github/CODEOWNERS`:

```
# Default owners for everything
* @documentation-team

# Policy documents require executive review
/docs/policies/ @executive-team @legal-team

# Architecture docs require tech lead review
/docs/architecture/ @tech-leads @architecture-team

# Templates are owned by documentation team
/docs/templates/ @documentation-admins

# CI/CD workflows require DevOps review
/.github/workflows/ @devops-team
```

## Issue and PR Templates

### `.github/ISSUE_TEMPLATE/doc-request.md`

```markdown
---
name: Documentation Request
about: Request new documentation or major updates
title: '[DOC] '
labels: documentation, needs-triage
assignees: ''
---

## Documentation Request

### Type of Documentation
- [ ] Policy
- [ ] Procedure
- [ ] Technical Guide
- [ ] Architecture
- [ ] API Reference
- [ ] Other: ___________

### Description
<!-- Describe what documentation is needed and why -->

### Target Audience
<!-- Who will use this documentation? -->

### Priority
- [ ] Critical (blocking work)
- [ ] High (needed within 1 week)
- [ ] Medium (needed within 1 month)
- [ ] Low (nice to have)

### Additional Context
<!-- Add any other context, examples, or references -->
```

### `.github/PULL_REQUEST_TEMPLATE/pull_request_template.md`

```markdown
## Description
<!-- Provide a brief description of the changes -->

## Type of Change
- [ ] New documentation
- [ ] Update existing documentation
- [ ] Fix (spelling, grammar, formatting)
- [ ] Structural change (reorganization)

## Checklist
- [ ] Markdown linting passes (`npm run lint`)
- [ ] Spell check passes (`npm run spell`)
- [ ] All links are valid (`npm run links`)
- [ ] Mermaid diagrams render correctly
- [ ] Reviewed for sensitive information
- [ ] Updated table of contents (if needed)
- [ ] Added/updated metadata (if applicable)

## Related Issues
<!-- Link any related issues: Fixes #123 -->

## Preview
<!-- If applicable, add screenshots or describe visual changes -->

## Review Requirements
<!-- Note any special review requirements -->
- Technical Review Required: Yes/No
- Legal Review Required: Yes/No
- Executive Review Required: Yes/No
```

## MkDocs Configuration

### `mkdocs.yml`

```yaml
site_name: Company Documentation
site_url: https://docs.company.com
repo_url: https://github.com/company/documentation
repo_name: company/documentation
edit_uri: edit/main/docs/

theme:
  name: material
  features:
    - navigation.instant
    - navigation.tracking
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.suggest
    - search.highlight
    - content.code.copy
    - content.action.edit
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode

plugins:
  - search
  - mermaid2:
      version: 10.6.1
  - git-revision-date-localized:
      enable_creation_date: true
  - tags
  - print-site

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tabbed:
      alternate_style: true
  - pymdownx.emoji:
      emoji_index: !!python/name:material.extensions.emoji.twemoji
      emoji_generator: !!python/name:material.extensions.emoji.to_svg
  - attr_list
  - md_in_html
  - footnotes
  - toc:
      permalink: true
      toc_depth: 3

nav:
  - Home: index.md
  - Getting Started: getting-started.md
  - Policies:
      - Overview: policies/_index.md
      - Code of Conduct: policies/code-of-conduct.md
      - Security: policies/security.md
  - Procedures:
      - Overview: procedures/_index.md
      - Incident Response: procedures/incident-response.md
  - Architecture:
      - Overview: architecture/_index.md
      - System Overview: architecture/system-overview.md
  - Guides:
      - Overview: guides/_index.md
      - Writing Guide: guides/writing-guide.md
  - References:
      - Glossary: references/glossary.md
      - API: references/api-reference.md

extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/company
    - icon: fontawesome/brands/slack
      link: https://company.slack.com/docs
  version:
    provider: mike
    default: latest
```

## Security Considerations

### Secrets Management

1. **Never commit secrets** - Use environment variables
2. **Use `.gitleaks.toml`** for secret scanning:

```toml
[allowlist]
paths = [
  '''docs/examples/''',
  '''tests/fixtures/'''
]

[extend]
useDefault = true
```

3. **Pre-commit hooks** - `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
  
  - repo: https://github.com/zricethezav/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
```

### Sensitive Information Guidelines

Document in `CONTRIBUTING.md`:
- No real customer data
- No internal IP addresses
- No actual API keys/tokens
- No employee PII
- Use example.com for domains
- Use RFC1918 IPs (10.x, 172.16.x, 192.168.x)

## Monitoring and Analytics

### Documentation Metrics

Track in GitHub Insights and custom dashboards:
- PR velocity (time to merge)
- Number of contributors
- Most edited pages (may need updates)
- Broken link frequency
- Search queries (from site analytics)
- Page views and user journeys

### Automated Reporting

Create monthly reports:
```yaml
# .github/workflows/monthly-report.yml
name: Monthly Documentation Report

on:
  schedule:
    - cron: '0 0 1 * *'  # First day of month

jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Generate metrics
        run: |
          ./scripts/generate-metrics.sh > metrics.md
      
      - name: Send report
        run: |
          # Send to Slack, email, etc.
```

## Migration Strategy

### From Confluence/SharePoint

```bash
#!/bin/bash
# scripts/migrate-confluence.sh

# Export from Confluence
confluence-cli export --space DOCS --format markdown

# Clean and convert
for file in exports/*.md; do
  # Remove Confluence-specific markup
  sed -i 's/{[^}]*}//g' "$file"
  
  # Fix image paths
  sed -i 's|!.*attachments/|![](./assets/images/|g' "$file"
  
  # Validate
  markdownlint "$file" --fix
done

# Organize into structure
./scripts/organize-docs.py

# Create PR
git checkout -b migration/confluence
git add docs/
git commit -m "Migrate documentation from Confluence"
```

## Meta-Documentation Strategy

### Purpose

Meta-documentation explains how to use and maintain the documentation repository itself. In this template, meta-documentation is pre-included and clearly separated from actual documentation content.

### Template Includes Meta-Documentation

The template automatically includes meta-documentation in `.github/DOCUMENTATION/`:

```
.github/
└── DOCUMENTATION/
    ├── setup-guide.md              # This repository setup guide (included)
    └── docs-as-code-strategy.md   # Documentation philosophy and practices (included)
```

**You may optionally add:**
- `README.md` - Index and overview of your customized meta-docs
- Additional guides specific to your organization's needs

### Why This Location Works Well

1. **Clear separation** - Meta-docs don't mix with actual content in `/docs`
2. **GitHub integration** - `.github` folders render nicely on GitHub
3. **Developer convention** - Developers expect repo configuration in `.github`
4. **Template consistency** - All template-based repos use the same structure
5. **Protection** - Less likely to be accidentally modified during content updates

### Alternative Approaches

If you need different visibility:

```bash
# Option 1: Root-level (maximum visibility)
/DOCUMENTATION/
├── setup-guide.md
└── strategy.md

# Option 2: Inside docs with underscore prefix
/docs/_meta/
├── setup-guide.md
└── strategy.md
```

### Making Meta-Docs Discoverable

1. **Reference in README.md**:
   ```markdown
   ## 📖 Repository Documentation
   - [How this repo is structured](./.github/DOCUMENTATION/setup-guide.md)
   - [Our docs-as-code approach](./.github/DOCUMENTATION/docs-as-code-strategy.md)
   ```

2. **Link from CONTRIBUTING.md**:
   ```markdown
   ## Required Reading
   - [Repository Setup Guide](./.github/DOCUMENTATION/setup-guide.md)
   - [Docs-as-Code Strategy](./.github/DOCUMENTATION/docs-as-code-strategy.md)
   ```

3. **Create index in `.github/DOCUMENTATION/README.md`**:
   ```markdown
   # Repository Meta-Documentation
   
   This directory contains documentation about the repository itself:
   
   - **[setup-guide.md](./setup-guide.md)** - How to set up and structure a docs repo
   - **[docs-as-code-strategy.md](./docs-as-code-strategy.md)** - Our documentation philosophy
   
   These guides are for contributors and maintainers of this repository.
   ```

### Versioning Meta-Documentation

- Include version numbers in meta-docs (e.g., "Version: 1.1.0")
- Tag significant changes to the structure
- Keep a CHANGELOG for meta-documentation updates
- Note in README which version of the setup guide is implemented

## Rollout Plan

### Phase 1: Template Setup (Day 1)
- [ ] Use GitHub template to create repository (automatic setup begins)
- [ ] Wait for GitHub Actions to complete initialization (~2-3 minutes)
- [ ] Review the setup issue created with personalized next steps
- [ ] Configure GitHub repository settings and branch protection
- [ ] Review and customize any auto-generated configurations if needed

### Phase 2: Content Setup (Week 1)
- [ ] Review included example documents
- [ ] Customize document templates for your organization
- [ ] Create initial directory structure for your content
- [ ] Set up team permissions and CODEOWNERS
- [ ] Test CI/CD workflows

### Phase 3: Content Migration (Weeks 2-3)
- [ ] Migrate high-priority documentation
- [ ] Convert existing content to Markdown format
- [ ] Replace static diagrams with Mermaid where possible
- [ ] Set up redirects from old documentation locations
- [ ] Validate all links and content

### Phase 4: Team Adoption (Weeks 4-6)
- [ ] Conduct team training sessions
- [ ] Create organization-specific documentation workflows
- [ ] Set up Obsidian for non-technical contributors
- [ ] Document common processes and troubleshooting
- [ ] Gather feedback and iterate

### Phase 5: Optimization (Ongoing)
- [ ] Monitor usage patterns and metrics
- [ ] Refine templates and workflows based on feedback
- [ ] Automate repetitive documentation tasks
- [ ] Improve search, navigation, and discoverability
- [ ] Keep template and tools updated

## Troubleshooting Guide

### Common Issues

**Mermaid diagrams not rendering**
- Check syntax at mermaid.live
- Ensure proper fence markers
- Verify Mermaid plugin is installed

**Build failures**
- Run `npm run validate` locally
- Check GitHub Actions logs
- Ensure all dependencies are installed

**Large repository size**
- Implement Git LFS for binaries
- Clean history with BFG Repo-Cleaner
- Archive old documentation separately

**Slow CI/CD pipelines**
- Cache dependencies
- Parallelize jobs
- Only build changed documents

## Testing Your Setup

### `scripts/test-setup.sh`

```bash
#!/bin/bash

echo "🔍 Testing Documentation Repository Setup..."
echo "========================================="

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
PASSED=0
FAILED=0

# Function to test command existence
test_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}✓${NC} $2 is installed"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $2 is not installed - $3"
        ((FAILED++))
    fi
}

# Function to test file existence
test_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $2 exists"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $2 is missing"
        ((FAILED++))
    fi
}

# Function to test directory existence
test_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $2 exists"
        ((PASSED++))
    else
        echo -e "${RED}✗${NC} $2 is missing"
        ((FAILED++))
    fi
}

echo ""
echo "1. Checking Required Tools..."
echo "------------------------------"
test_command git "Git" "Install from https://git-scm.com"
test_command node "Node.js" "Install from https://nodejs.org (v20+)"
test_command npm "npm" "Comes with Node.js installation"
test_command pandoc "Pandoc" "Install from https://pandoc.org"

echo ""
echo "2. Checking Repository Structure..."
echo "------------------------------------"
test_dir "docs" "docs directory"
test_dir "docs/policies" "policies directory"
test_dir "docs/procedures" "procedures directory"
test_dir "docs/architecture" "architecture directory"
test_dir "docs/guides" "guides directory"
test_dir "docs/templates" "templates directory"
test_dir ".github/workflows" "GitHub workflows directory"
test_dir "scripts" "scripts directory"
test_dir "config" "config directory"

echo ""
echo "3. Checking Essential Files..."
echo "-------------------------------"
test_file "README.md" "README.md"
test_file "CONTRIBUTING.md" "CONTRIBUTING.md"
test_file ".gitignore" ".gitignore"
test_file ".gitattributes" ".gitattributes"
test_file "package.json" "package.json"
test_file ".markdownlint.json" ".markdownlint.json"
test_file "cspell.json" "cspell.json"
test_file ".github/dependabot.yml" "dependabot.yml"

echo ""
echo "4. Checking Node.js Version..."
echo "-------------------------------"
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -ge 20 ]; then
    echo -e "${GREEN}✓${NC} Node.js version is v20 or higher"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠${NC} Node.js version is below v20 (current: v$NODE_VERSION)"
    ((FAILED++))
fi

echo ""
echo "5. Checking Git LFS..."
echo "-----------------------"
if git lfs version &> /dev/null; then
    echo -e "${GREEN}✓${NC} Git LFS is installed"
    ((PASSED++))
    
    # Check if Git LFS is initialized in this repo
    if [ -f ".gitattributes" ] && grep -q "filter=lfs" .gitattributes; then
        echo -e "${GREEN}✓${NC} Git LFS is configured"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Git LFS not configured in .gitattributes"
        ((FAILED++))
    fi
else
    echo -e "${RED}✗${NC} Git LFS is not installed"
    ((FAILED++))
fi

echo ""
echo "6. Checking npm Dependencies..."
echo "--------------------------------"
if [ -f "package.json" ]; then
    if [ -d "node_modules" ]; then
        echo -e "${GREEN}✓${NC} npm dependencies are installed"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} npm dependencies not installed - run 'npm install'"
        ((FAILED++))
    fi
fi

echo ""
echo "7. Testing Documentation Tools..."
echo "----------------------------------"
if [ -f "package.json" ] && [ -d "node_modules" ]; then
    # Test markdown linting
    if npm run lint -- --dry-run &> /dev/null; then
        echo -e "${GREEN}✓${NC} Markdown linting is working"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Markdown linting needs configuration"
        ((FAILED++))
    fi
    
    # Test spell checking
    if command -v cspell &> /dev/null; then
        echo -e "${GREEN}✓${NC} Spell checking is available"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} Spell checking not configured"
        ((FAILED++))
    fi
fi

echo ""
echo "8. Checking GitHub Configuration..."
echo "------------------------------------"
# Check if it's a git repository
if [ -d ".git" ]; then
    echo -e "${GREEN}✓${NC} Git repository initialized"
    ((PASSED++))
    
    # Check for remote
    if git remote -v | grep -q origin; then
        echo -e "${GREEN}✓${NC} Git remote configured"
        ((PASSED++))
    else
        echo -e "${YELLOW}⚠${NC} No Git remote configured"
        ((FAILED++))
    fi
else
    echo -e "${RED}✗${NC} Not a Git repository"
    ((FAILED++))
fi

echo ""
echo "========================================="
echo "Test Results:"
echo "-----------------------------------------"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed! Your documentation repository is ready.${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some tests failed. Please address the issues above.${NC}"
    exit 1
fi
```

Run this test script to verify your setup:
```bash
chmod +x scripts/test-setup.sh
npm run test:setup
```

## Alternative Modern Frameworks

While MkDocs with Material theme is excellent, consider these modern alternatives:

### Astro Starlight

**Pros:**
- Built on Astro's modern framework
- Excellent performance with partial hydration
- Built-in i18n support
- Great for technical documentation
- TypeScript support out of the box

**Setup:**
```bash
npm create astro@latest -- --template starlight

# Configuration in astro.config.mjs
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  integrations: [
    starlight({
      title: 'My Documentation',
      social: {
        github: 'https://github.com/company/docs',
      },
      sidebar: [
        {
          label: 'Guides',
          items: [
            { label: 'Getting Started', link: '/guides/getting-started/' },
          ],
        },
      ],
    }),
  ],
});
```

### Docusaurus 3

**Pros:**
- React-based with MDX support
- Excellent versioning capabilities
- Built-in search (Algolia integration)
- Great plugin ecosystem
- Strong community support

**Setup:**
```bash
npx create-docusaurus@latest my-docs classic

# Configuration in docusaurus.config.js
module.exports = {
  title: 'Company Documentation',
  tagline: 'All our technical documentation',
  url: 'https://docs.company.com',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'company',
  projectName: 'documentation',
  
  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/company/docs/edit/main/',
          showLastUpdateTime: true,
          showLastUpdateAuthor: true,
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
  
  themes: ['@docusaurus/theme-mermaid'],
  markdown: {
    mermaid: true,
  },
};
```

### Choosing a Framework

| Feature | MkDocs Material | Astro Starlight | Docusaurus 3 |
|---------|-----------------|-----------------|--------------|
| Language | Python | JavaScript | JavaScript |
| Build Speed | Fast | Very Fast | Moderate |
| Learning Curve | Low | Medium | Medium |
| Customization | Themes/Plugins | Full Control | Themes/Plugins |
| Search | Built-in | Built-in | Algolia |
| Versioning | Plugin | Manual | Built-in |
| i18n | Plugin | Built-in | Built-in |
| MDX Support | No | Yes | Yes |
| Best For | Simple Docs | Modern Sites | Complex Docs |

## Additional Resources

- [GitHub Docs as Code](https://github.com/github/docs)
- [Write the Docs Template](https://www.writethedocs.org/guide/writing/templates/)
- [The Documentation System](https://documentation.divio.com/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)

---

*This guide is a living document. Submit improvements via pull request.*

**Last Updated:** 2025-09-24  
**Version:** 1.2.0