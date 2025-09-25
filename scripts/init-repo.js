#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const inquirer = require('inquirer');
const { execSync } = require('child_process');

async function init() {
  console.log('🚀 Documentation Repository Initialization\n');
  
  // Gather information
  const answers = await inquirer.prompt([
    {
      name: 'companyName',
      message: 'Company/Organization name:',
      default: 'ACME Corp'
    },
    {
      name: 'repoName',
      message: 'Repository name:',
      default: path.basename(process.cwd())
    },
    {
      name: 'docsEmail',
      message: 'Documentation team email:',
      default: 'docs@example.com'
    },
    {
      name: 'slackChannel',
      message: 'Slack channel for support:',
      default: '#docs-help'
    },
    {
      name: 'githubOrg',
      message: 'GitHub organization:',
      default: 'acme-corp'
    },
    {
      name: 'includeObsidian',
      type: 'confirm',
      message: 'Include Obsidian instructions for non-technical users?',
      default: true
    },
    {
      name: 'includeAI',
      type: 'confirm',
      message: 'Include AI assistance guidelines?',
      default: true
    }
  ]);
  
  // Replace placeholders in all files
  const replacements = {
    '{{COMPANY_NAME}}': answers.companyName,
    '{{REPO_NAME}}': answers.repoName,
    '{{DOCS_EMAIL}}': answers.docsEmail,
    '{{SLACK_CHANNEL}}': answers.slackChannel,
    '{{GITHUB_ORG}}': answers.githubOrg,
    '[Company Name]': answers.companyName
  };
  
  console.log('\n📝 Personalizing files...');
  replaceInFiles('.', replacements);
  
  // Remove optional sections
  if (!answers.includeObsidian) {
    console.log('Removing Obsidian documentation...');
    // Remove Obsidian section from docs-as-code-strategy.md
  }
  
  if (!answers.includeAI) {
    console.log('Removing AI assistance section...');
    // Remove AI section from docs-as-code-strategy.md
  }
  
  // Clean up example content
  console.log('Cleaning example content...');
  fs.rmSync('docs/examples', { recursive: true, force: true });
  
  console.log('\n✅ Initialization complete!');
  console.log('\nNext steps:');
  console.log('1. Review the personalized files');
  console.log('2. Commit changes: git add . && git commit -m "Personalize template"');
  console.log('3. Push to repository: git push');
  console.log('4. Configure branch protection rules in GitHub settings');
  console.log('5. Start documenting!');
}

function replaceInFiles(dir, replacements) {
  const files = fs.readdirSync(dir);
  
  files.forEach(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    
    if (stat.isDirectory() && !file.startsWith('.git') && file !== 'node_modules') {
      replaceInFiles(filePath, replacements);
    } else if (stat.isFile() && (file.endsWith('.md') || file.endsWith('.json') || file.endsWith('.yml'))) {
      let content = fs.readFileSync(filePath, 'utf8');
      
      Object.entries(replacements).forEach(([placeholder, value]) => {
        content = content.replace(new RegExp(placeholder.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g'), value);
      });
      
      fs.writeFileSync(filePath, content);
    }
  });
}

// Run initialization
init().catch(console.error);
