# Using This Template

## Quick Start

1. **Create Repository**: Click "Use this template" button on GitHub
2. **Name Repository**: Choose a descriptive name for your documentation repository
3. **Automatic Setup**: GitHub Actions will automatically:
   - Replace template variables with your repository information
   - Remove example content and this instruction file
   - Install dependencies and set up the repository
   - Create a setup issue with next steps

4. **Manual Setup** (only if automatic setup fails):
   ```bash
   git clone https://github.com/YOUR-ORG/your-new-repo.git
   cd your-new-repo
   npm install
   npm run init
   ```

## What's Included

### Structure
- 📁 Complete documentation directory structure
- 📝 Document templates for policies, procedures, and architecture
- 🎯 Example documents showing best practices
- 🔧 Configuration files for linting and validation

### Automation
- ✅ GitHub Actions for CI/CD
- 🔍 Markdown linting and formatting
- 📝 Spell checking
- 🔗 Link validation
- 📄 PDF generation capability

### Meta-Documentation
- Setup guide for maintaining the repository
- Docs-as-code strategy and philosophy
- Contributing guidelines
- Issue and PR templates

## Customization

The `npm run init` script will:
- Replace all `{{VARIABLE}}` placeholders with your values
- Personalize the repository for your organization
- Remove example content (optional)
- Set up your documentation structure

### Variables to Replace

| Variable | Description | Example |
|----------|-------------|---------|
| `{{COMPANY_NAME}}` | Your organization name | "Acme Corp" |
| `{{REPO_NAME}}` | Repository name | "acme-docs" |
| `{{GITHUB_ORG}}` | GitHub organization | "acme-corp" |
| `{{DOCS_EMAIL}}` | Documentation team email | "docs@acme.com" |
| `{{SLACK_CHANNEL}}` | Support Slack channel | "#docs-help" |

## Post-Setup Steps

After the automatic setup completes, you'll receive a GitHub issue with next steps:

1. **Configure GitHub Settings**
   - Set up branch protection rules in Settings → Branches
   - Add team members and permissions in Settings → Manage access
   - Enable GitHub Pages for publishing (optional)

2. **Start Documenting**
   - Add your actual documentation in the `docs/` folder
   - Use the templates in `docs/templates/` for consistency
   - Follow the guidelines in the setup guide

3. **Optional Customization**
   - Review and customize README.md if needed
   - Modify document templates for your organization
   - Set up additional GitHub Actions workflows

## Directory Structure

```
.github/
├── DOCUMENTATION/      # Meta-docs about the repo
├── workflows/          # GitHub Actions
└── ISSUE_TEMPLATE/     # Issue templates

docs/
├── policies/          # Company policies
├── procedures/        # Operating procedures
├── architecture/      # Technical documentation
├── guides/            # How-to guides
├── references/        # API and references
└── templates/         # Document templates

scripts/               # Build and utility scripts
config/               # Tool configurations
```

## Available Commands

```bash
npm run lint        # Fix markdown issues
npm run spell       # Check spelling
npm run links       # Validate links
npm run validate    # Run all checks
npm run init        # Personalize template
```

## Getting Help

### Documentation
- [Setup Guide](.github/DOCUMENTATION/setup-guide.md)
- [Docs-as-Code Strategy](.github/DOCUMENTATION/docs-as-code-strategy.md)
- [Contributing Guide](CONTRIBUTING.md)

### Support
- Create an issue in this template repository
- Check the [Discussions](https://github.com/YOUR-ORG/docs-as-code-template/discussions) section

## License

This template is provided under the MIT License. You may choose any license for your derivative documentation repository.

---

*Remember to delete this file after successfully initializing your repository!*
