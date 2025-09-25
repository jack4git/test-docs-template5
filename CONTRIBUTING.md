# Contributing to {{COMPANY_NAME}} Documentation

Thank you for your interest in contributing to our documentation! This guide will help you get started.

## Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please be respectful and professional in all interactions.

## How to Contribute

### Reporting Issues

1. Check if the issue already exists
2. Use the appropriate [issue template](.github/ISSUE_TEMPLATE/)
3. Provide as much detail as possible
4. Include examples or screenshots when relevant

### Making Changes

#### Small Changes (Typos, Minor Updates)

1. Click the "Edit" button on GitHub
2. Make your changes
3. Submit a pull request with a clear description

#### Larger Changes

1. **Discuss First**: For significant changes, open an issue first to discuss
2. **Fork & Clone**: Fork the repository and clone locally
3. **Branch**: Create a feature branch from `main`
   ```bash
   git checkout -b docs/your-change-description
   ```
4. **Write**: Make your documentation changes
5. **Test**: Run validation locally
   ```bash
   npm install  # First time only
   npm run validate
   ```
6. **Commit**: Use clear, descriptive commit messages
   ```bash
   git commit -m "docs: add deployment troubleshooting guide"
   ```
7. **Push**: Push to your fork
8. **PR**: Submit a pull request

## Documentation Standards

### File Organization

- Place documents in the appropriate directory
- Use lowercase with hyphens for file names: `deployment-guide.md`
- Include assets in the same directory's `assets/` folder

### Writing Style

- **Be Clear**: Write for your audience's knowledge level
- **Be Concise**: Get to the point quickly
- **Be Complete**: Include all necessary information
- **Use Examples**: Show, don't just tell
- **Active Voice**: "Configure the server" not "The server should be configured"

### Markdown Guidelines

- Use ATX-style headers (`#` not underlines)
- Include a single H1 at the top of each document
- Use fenced code blocks with language specification
- Prefer reference-style links for repeated URLs
- Keep lines under 120 characters when possible

### Required Sections

Every document should include:
- **Title** (H1)
- **Purpose/Overview** section
- **Last Updated** date at the bottom
- **Owner** or point of contact

### Code Examples

- Test all code examples
- Include language specification in code blocks
- Provide context and expected output
- Use placeholders like `{{VARIABLE}}` for user-specific values

## Review Process

### What We Look For

1. **Technical Accuracy**: Is the information correct?
2. **Clarity**: Is it easy to understand?
3. **Completeness**: Is anything missing?
4. **Consistency**: Does it follow our standards?
5. **Links**: Do all links work?

### Review Timeline

- Simple fixes: 1-2 business days
- New documentation: 3-5 business days
- Large changes: 5-10 business days

## Tools and Setup

### Required Tools

- Git
- Node.js v20+
- Text editor (VS Code recommended)

### Recommended Extensions

For VS Code:
- Markdown All in One
- markdownlint
- Code Spell Checker
- Mermaid Markdown Syntax Highlighting

### Local Development

```bash
# Install dependencies
npm install

# Run linting
npm run lint

# Check spelling
npm run spell

# Validate links
npm run links

# Run all checks
npm run validate

# Preview locally (if MkDocs is configured)
npm run serve
```

## Getting Help

- **Questions**: Open a [discussion](https://github.com/{{GITHUB_ORG}}/{{REPO_NAME}}/discussions)
- **Issues**: Use [issue templates](.github/ISSUE_TEMPLATE/)
- **Slack**: {{SLACK_CHANNEL}}
- **Email**: {{DOCS_EMAIL}}

## Recognition

We value all contributions! Contributors will be:
- Listed in our [Contributors](#) section
- Thanked in release notes
- Invited to our documentation community events

## License

By contributing, you agree that your contributions will be licensed under the same license as this repository.

---

Thank you for helping improve our documentation! 📚
