---
# Document Identity
name: "askuserquestion-ultimate-guide"
title: "AskUserQuestion: The Ultimate Guide"
subtitle: "Interactive Decision Making in Claude Code"
description: "Comprehensive guide to building type-safe, interactive dialogs using the AskUserQuestion tool in Claude Code"

# Version Control
version: "1.1.0"
last_updated: "2025-11-08"
status: "stable"
changelog: "./CHANGELOG.md"

# Authorship
authors:
  - name: "Claude Code Documentation Team"
    role: "Primary Author"
maintainers:
  - "Community Contributors"

# Audience & Scope
audience:
  - "Claude Code users"
  - "JavaScript/TypeScript developers"
  - "UI/UX designers"
  - "Automation engineers"

difficulty: "beginner-to-advanced"

# Time Estimates
estimated_time:
  quick_start: "15 minutes"
  intermediate: "30 minutes"
  full_guide: "45 minutes"
  mastery: "2-3 hours practice"

# Prerequisites
prerequisites:
  required:
    - tool: "Claude Code"
      version: ">=1.0.0"
      install_url: "https://docs.claude.com/claude-code"
    - skill: "Basic async/await"
      level: "beginner"
  recommended:
    - "TypeScript interfaces"
    - "UI/UX design principles"
    - "Decision tree patterns"

# Success Criteria
success_criteria:
  beginner:
    - "Can create single-question dialogs"
    - "Understand option structure"
    - "Handle basic responses"
  intermediate:
    - "Build multi-step workflows"
    - "Implement conditional branching"
    - "Validate user input"
  advanced:
    - "Create 10+ step wizards"
    - "Optimize token usage"
    - "Handle complex edge cases"

# Taxonomy
tags:
  - "claude-code"
  - "interactive-ui"
  - "dialog-design"
  - "user-input"
  - "type-safety"
  - "workflow-automation"
  - "prompt-engineering"

categories:
  - "Tool Documentation"
  - "Best Practices"
  - "Tutorial"

# Related Resources
related_docs:
  internal:
    - title: "Claude Code Overview"
      url: "https://docs.claude.com/claude-code"
    - title: "Prompt Engineering"
      url: "https://docs.claude.com/prompt-engineering"
  external:
    - title: "Inquirer.js"
      url: "https://github.com/SBoudrias/Inquirer.js"
      reason: "CLI prompts comparison"
    - title: "Conversational UI Design"
      url: "https://www.botpress.com/blog/conversation-design"
      reason: "Design principles"

# Technical Metadata
api:
  tool_name: "AskUserQuestion"
  version: "1.0"
  platforms:
    - "macOS"
    - "Linux"
    - "Windows"

# License
license: "MIT"
usage: "Free for all Claude Code users"

# Search Keywords
keywords:
  - "AskUserQuestion"
  - "Claude Code dialogs"
  - "interactive prompts"
  - "user input validation"
  - "type-safe UI"
  - "decision trees"
  - "workflow wizards"
---

# AskUserQuestion: The Ultimate Guide

> **Interactive Decision Making in Claude Code**
> A comprehensive exploration of dialogue-driven workflows, advanced patterns, and pushing the boundaries of user interaction.

---

## Before You Begin

### Prerequisites

Before diving into this guide, ensure you have:

- ✅ **Claude Code installed and configured** (version 1.0.0 or higher)
  - [Installation guide](https://docs.claude.com/claude-code)
- ✅ **Basic understanding of async/await patterns** in JavaScript/TypeScript
  - Familiarity with Promises and asynchronous code
- ⚡ **Recommended (but not required):**
  - TypeScript interfaces knowledge
  - UI/UX design principles
  - Decision tree patterns

### What You'll Learn

By the end of this guide, you will be able to:

1. ✅ **Create type-safe user interactions** with structured dialogs
2. ✅ **Build complex multi-step wizards** for project setup and configuration
3. ✅ **Implement conditional branching logic** based on user choices
4. ✅ **Optimize dialog performance** and token usage
5. ✅ **Avoid common anti-patterns** and pitfalls

### Success Criteria

You'll know you've mastered `AskUserQuestion` when you can:

**Beginner Level (15 minutes):**
- ✅ Can create single-question dialogs
- ✅ Understand option structure and validation
- ✅ Handle basic response types

**Intermediate Level (30 minutes):**
- ✅ Build multi-step workflows with 4+ questions
- ✅ Implement conditional branching based on answers
- ✅ Validate user input and handle edge cases

**Advanced Level (45+ minutes):**
- ✅ Create 10+ step wizards with progress tracking
- ✅ Optimize token usage for long conversations
- ✅ Handle complex edge cases and error scenarios

### Quick Navigation

**Just starting?**
→ [Basic Usage](#basic-usage) - Start here for your first dialog

**Need a specific pattern?**
→ [Advanced Patterns](#advanced-patterns) - 5 battle-tested patterns

**Building a wizard?**
→ [Real-World Examples](#real-world-examples) - Complete implementations

**Troubleshooting?**
→ [Anti-Patterns](#anti-patterns) - Common mistakes to avoid

**Want to compare?**
→ [Comparison with Alternatives](#comparison-with-alternatives) - vs CLI prompts, text Q&A

---

## Table of Contents

1. [Introduction](#introduction)
2. [Technical Specifications](#technical-specifications)
3. [Core Concepts](#core-concepts)
4. [Design Principles](#design-principles)
5. [Basic Usage](#basic-usage)
6. [Advanced Patterns](#advanced-patterns)
7. [Use Cases & Scenarios](#use-cases--scenarios)
8. [Performance & Optimization](#performance--optimization)
9. [Limitations & Workarounds](#limitations--workarounds)
10. [Best Practices](#best-practices)
11. [Anti-Patterns](#anti-patterns)
12. [Real-World Examples](#real-world-examples)
13. [Comparison with Alternatives](#comparison-with-alternatives)
14. [Future Possibilities](#future-possibilities)

**🔥 NEW: For advanced multi-dialog patterns & decision trees, see [Advanced-Patterns-Multi-Dialog.md](./Advanced-Patterns-Multi-Dialog.md)**

---

## Introduction

`AskUserQuestion` is Claude Code's native tool for creating **interactive, structured dialogues** during code execution. Unlike traditional text-based Q&A, it provides:

- ✅ **Type-safe selections** with validation
- ✅ **Rich descriptions** for informed decisions
- ✅ **Multi-select capabilities** for complex configurations
- ✅ **Native UI integration** with Claude Code interface
- ✅ **Automatic "Other" option** for flexibility

### Why It Matters

```
Traditional Approach          AskUserQuestion Approach
─────────────────            ────────────────────────
❌ "What DB?"                 ✅ Structured options with trade-offs
❌ "postgres"                 ✅ PostgreSQL (ACID, relations, mature)
❌ (typo = failure)           ✅ MongoDB (flexible, scalable, NoSQL)
❌ No context                 ✅ Supabase (Postgres + Auth + realtime)
❌ Manual parsing             ✅ PlanetScale (MySQL, serverless, branching)
                              ✅ Type-safe response handling
```

---

## Technical Specifications

### API Parameters

| Parameter | Type | Required | Constraints | Description |
|-----------|------|----------|-------------|-------------|
| `questions` | `Array<Question>` | ✅ | 1-4 items | Array of question objects |
| `question` | `string` | ✅ | - | The question text |
| `header` | `string` | ✅ | **≤12 chars** | Short label (chip/tag) |
| `options` | `Array<Option>` | ✅ | 2-4 items | Available choices |
| `multiSelect` | `boolean` | ✅ | - | Allow multiple selections |
| `label` | `string` | ✅ | 1-5 words | Option display text |
| `description` | `string` | ✅ | - | Option explanation |

### Constraints Matrix

```
┌──────────────────┬──────────┬──────────┬────────────┐
│ Parameter        │ Minimum  │ Maximum  │ Optimal    │
├──────────────────┼──────────┼──────────┼────────────┤
│ Questions/call   │ 1        │ 4        │ 2-3        │
│ Options/question │ 2        │ 4        │ 3          │
│ Header length    │ 1 char   │ 12 chars │ 6-10 chars │
│ Label length     │ 1 word   │ 5 words  │ 1-2 words  │
│ Description      │ -        │ ~200chr* │ 50-100 chr │
└──────────────────┴──────────┴──────────┴────────────┘
* No hard limit but keep concise for UX
```

### Response Format

```typescript
interface Response {
  [questionText: string]: string | string[];  // string[] if multiSelect
}

// Example
{
  "Which framework?": "Next.js",
  "Enable features?": ["Auth", "DB", "Email"]  // multiSelect
}
```

---

## Core Concepts

### 1. Progressive Disclosure

Show complexity **gradually** to avoid overwhelming users:

```
Level 1: What type of app?
         ↓
Level 2: Which framework? (filtered by Level 1)
         ↓
Level 3: Deployment target? (optimized for Level 2)
         ↓
Level 4: Add-ons? (compatible with 1-3)
```

### 2. Decision Trees

#### Linear Pattern
```
Q1 → Q2 → Q3 → Q4
Simple, predictable, best for setup wizards
```

#### Branching Pattern
```
        Q1
       /  \
      /    \
    Q2a    Q2b
    |       |
   Q3a     Q3b
Complex, conditional, best for troubleshooting
```

#### Hybrid Pattern
```
Q1 ──→ Q2 (always)
 │
 ├──→ Q3a (if Q1 = "Advanced")
 │
 └──→ Q3b (if Q1 = "Simple")
      │
      └──→ Q4 (merge point)
Best for flexible workflows
```

### 3. Context Retention

> **Key Principle:** Claude retains ALL previous answers within the conversation.

You can reference earlier decisions:

```javascript
// Question 1
"Choose framework" → Answer: "Next.js"

// Question 5 (later)
// Access answer via conversation context
"Since you chose Next.js earlier, use App Router or Pages Router?"
```

---

## Design Principles

Based on 2025 UX research, apply these principles:

### 1. Clarity Over Brevity

```diff
- ❌ "Type?"
+ ✅ "What type of application are you building?"

- ❌ Options: ["A", "B", "C"]
+ ✅ Options: ["REST API", "GraphQL API", "Full-stack App"]
```

### 2. Contextual Awareness

```javascript
// ❌ BAD: No context
{
  question: "Use TypeScript?",
  options: ["Yes", "No"]
}

// ✅ GOOD: Provide context
{
  question: "Use TypeScript? (Detected: JavaScript project)",
  header: "TypeScript",
  options: [
    {
      label: "Migrate to TS",
      description: "Add tsconfig.json, rename files, gradual adoption"
    },
    {
      label: "Use JSDoc",
      description: "Type safety via comments, no build step"
    },
    {
      label: "Keep pure JS",
      description: "No types, faster iteration, less tooling"
    }
  ]
}
```

### 3. Smart Defaults

Guide users toward **best practices** through option ordering:

```javascript
options: [
  { label: "Recommended", description: "..." },  // ← Default mental anchor
  { label: "Alternative 1", description: "..." },
  { label: "Alternative 2", description: "..." },
  { label: "Custom", description: "..." }         // ← "Other" auto-added
]
```

### 4. Feedback Loops

Always **confirm** complex multi-step configurations:

```
Questions 1-4: Collect preferences
    ↓
Question 5: "Confirm setup? [Shows summary of Q1-4]"
    ↓
If No → Return to specific question
If Yes → Execute
```

---

## Basic Usage

### Example 1: Single Question

```javascript
{
  questions: [{
    question: "Which testing framework should we use?",
    header: "Testing",
    multiSelect: false,
    options: [
      {
        label: "Vitest",
        description: "Fast, Vite-native, modern API, best for Vite projects"
      },
      {
        label: "Jest",
        description: "Mature, huge ecosystem, slower but battle-tested"
      },
      {
        label: "Playwright",
        description: "E2E testing, cross-browser, component testing support"
      }
    ]
  }]
}
```

**Response:**
```json
{
  "Which testing framework should we use?": "Vitest"
}
```

### Example 2: Multi-Select

```javascript
{
  questions: [{
    question: "Which features do you want to enable?",
    header: "Features",
    multiSelect: true,  // ← Key difference
    options: [
      { label: "Authentication", description: "NextAuth.js with OAuth" },
      { label: "Database", description: "Prisma + PostgreSQL" },
      { label: "Payments", description: "Stripe integration" },
      { label: "Analytics", description: "Vercel Analytics" }
    ]
  }]
}
```

**Response:**
```json
{
  "Which features do you want to enable?": ["Authentication", "Database", "Analytics"]
}
```

### Example 3: Multiple Questions

```javascript
{
  questions: [
    {
      question: "Which frontend framework?",
      header: "Frontend",
      multiSelect: false,
      options: [
        { label: "React", description: "Component-based, huge ecosystem" },
        { label: "Vue", description: "Progressive, easier learning curve" },
        { label: "Svelte", description: "Compiled, no virtual DOM, fast" }
      ]
    },
    {
      question: "Which styling solution?",
      header: "Styling",
      multiSelect: false,
      options: [
        { label: "Tailwind", description: "Utility-first, rapid prototyping" },
        { label: "CSS Modules", description: "Scoped styles, zero runtime" },
        { label: "Styled Comps", description: "CSS-in-JS, dynamic theming" }
      ]
    },
    {
      question: "Which state manager?",
      header: "State",
      multiSelect: false,
      options: [
        { label: "Zustand", description: "Minimal, hooks-based, 1KB" },
        { label: "Redux TK", description: "Official, DevTools, middleware" },
        { label: "Jotai", description: "Atomic, bottom-up, flexible" }
      ]
    }
  ]
}
```

**Response:**
```json
{
  "Which frontend framework?": "React",
  "Which styling solution?": "Tailwind",
  "Which state manager?": "Zustand"
}
```

---

## Advanced Patterns

> **Note:** This section couvre 5 patterns fondamentaux. Pour des patterns multi-dialogues complexes (10+ steps, decision trees, parallel batching), consultez **[Advanced-Patterns-Multi-Dialog.md](./Advanced-Patterns-Multi-Dialog.md)**.

### Pattern 1: Conditional Branching

```python
# Step 1: Ask initial question
response_1 = AskUserQuestion(
  "What's your deployment target?",
  options=["Vercel", "AWS", "Self-hosted"]
)

# Step 2: Branch based on answer
if response_1 == "AWS":
    response_2 = AskUserQuestion(
      "Which AWS service?",
      options=["Lambda", "ECS", "EC2", "Amplify"]
    )
elif response_1 == "Vercel":
    response_2 = AskUserQuestion(
      "Enable Vercel features?",
      multiSelect=True,
      options=["Edge Functions", "Image Optimization", "Analytics", "Cron Jobs"]
    )
else:  # Self-hosted
    response_2 = AskUserQuestion(
      "Containerization?",
      options=["Docker Compose", "Kubernetes", "Bare metal"]
    )
```

### Pattern 2: Validation & Retry

```python
while True:
    response = AskUserQuestion(
      "Select monorepo tool",
      options=["Turborepo", "Nx", "Lerna", "pnpm workspaces"]
    )

    # Validate compatibility
    if response == "Turborepo" and not has_vercel_account():
        confirm = AskUserQuestion(
          "Turborepo works best with Vercel. Continue anyway?",
          options=["Yes, continue", "Choose different tool"]
        )
        if confirm == "Choose different tool":
            continue  # Ask again

    break  # Valid choice
```

### Pattern 3: Summary Confirmation

```python
# Collect all preferences
answers = {}

answers["framework"] = AskUserQuestion("Framework?", ...)
answers["database"] = AskUserQuestion("Database?", ...)
answers["auth"] = AskUserQuestion("Auth method?", ...)
answers["hosting"] = AskUserQuestion("Hosting?", ...)

# Generate summary
summary = f"""
Configuration Summary:
- Framework: {answers['framework']}
- Database: {answers['database']}
- Auth: {answers['auth']}
- Hosting: {answers['hosting']}
"""

# Confirm
confirmation = AskUserQuestion(
  f"{summary}\n\nProceed with this setup?",
  options=[
    {"label": "Yes, create", "description": "Generate project with these settings"},
    {"label": "Restart", "description": "Start configuration from beginning"},
    {"label": "Modify", "description": "Change specific settings"}
  ]
)

if confirmation == "Modify":
    modify_what = AskUserQuestion(
      "What do you want to change?",
      multiSelect=True,
      options=["Framework", "Database", "Auth", "Hosting"]
    )
    # Re-ask selected questions
```

### Pattern 4: Feature Matrix Selection

```python
# Advanced: Combine multiple dimensions
config = AskUserQuestion([
  {
    question: "Select environment features",
    header: "Environment",
    multiSelect: true,
    options: [
      {"label": "Docker", "description": "Containerization"},
      {"label": "Hot reload", "description": "Fast development iteration"},
      {"label": "Debug mode", "description": "Source maps + verbose logs"},
      {"label": "Mock APIs", "description": "Local API mocking"}
    ]
  },
  {
    question: "Select deployment optimizations",
    header: "Deploy",
    multiSelect: true,
    options: [
      {"label": "Minify", "description": "Reduce bundle size"},
      {"label": "Tree shake", "description": "Remove dead code"},
      {"label": "Code split", "description": "Lazy load routes"},
      {"label": "Compress", "description": "Brotli/gzip compression"}
    ]
  }
])

# Build feature matrix
matrix = {
  "dev": config["Select environment features"],
  "prod": config["Select deployment optimizations"]
}
```

### Pattern 5: Version Migration Wizard

```python
# Complex migration scenario
current_version = detect_version()  # e.g., "Next.js 13"
target_version = "Next.js 15"

# Step 1: Impact assessment
response_1 = AskUserQuestion(
  f"Migrate from {current_version} to {target_version}?",
  options=[
    {"label": "Full migration", "description": "All breaking changes, might break app"},
    {"label": "Safe migration", "description": "Only non-breaking updates"},
    {"label": "Analyze first", "description": "Show what will change"},
    {"label": "Cancel", "description": "Stay on current version"}
  ]
)

if response_1 == "Analyze first":
    breaking_changes = analyze_breaking_changes()
    show_report(breaking_changes)

    # Ask again with more context
    response_1 = AskUserQuestion(
      f"Found {len(breaking_changes)} breaking changes. Proceed?",
      options=["Full migration", "Safe migration", "Cancel"]
    )

if response_1 == "Full migration":
    # Step 2: Migration strategy
    response_2 = AskUserQuestion(
      "How should we handle breaking changes?",
      multiSelect=True,
      options=[
        {"label": "Auto-fix", "description": "Apply codemods automatically"},
        {"label": "Manual review", "description": "Show diff for each change"},
        {"label": "Create TODOs", "description": "Comment code with migration tasks"},
        {"label": "Backup first", "description": "Git commit before changes"}
      ]
    )

    # Step 3: Confirmation
    execute_migration(response_2)
```

---

## Use Cases & Scenarios

### Scenario 1: New Project Initialization

**Context:** User wants to create a new project from scratch.

```javascript
// Question sequence
const setup = async () => {
  // Q1: Project type (determines all future questions)
  const projectType = await ask({
    question: "What type of project are you building?",
    header: "Project",
    options: [
      { label: "Web App", description: "Full-stack or frontend application" },
      { label: "API", description: "Backend service/REST API/GraphQL" },
      { label: "Library", description: "Reusable package/component library" },
      { label: "CLI Tool", description: "Command-line application" }
    ]
  });

  // Q2: Language (filtered by project type)
  const language = await ask({
    question: "Which language?",
    header: "Language",
    options: getLanguageOptions(projectType)  // Conditional
  });

  // Q3: Framework (filtered by type + language)
  const framework = await ask({
    question: "Which framework?",
    header: "Framework",
    options: getFrameworkOptions(projectType, language)
  });

  // Q4: Features (multi-select, smart defaults)
  const features = await ask({
    question: "Which features to include?",
    header: "Features",
    multiSelect: true,
    options: getFeaturesForStack(framework)
  });

  return { projectType, language, framework, features };
};
```

**Decision Tree:**
```
Web App
├─ TypeScript
│  ├─ Next.js → [Auth, DB, Email, Payments, Analytics]
│  ├─ Remix → [Auth, DB, Email]
│  └─ Astro → [CMS, Blog, Analytics]
├─ JavaScript
│  └─ ...
└─ Python
   └─ Django → [Admin, ORM, Auth, REST]

API
├─ TypeScript
│  ├─ Express → [DB, Auth, Rate limiting]
│  ├─ Fastify → [DB, Validation, Swagger]
│  └─ tRPC → [DB, Auth, Type safety]
└─ ...
```

### Scenario 2: Debugging Workflow

**Context:** User encounters an error and needs guided troubleshooting.

```javascript
// Error detected: "Module not found: 'react'"
const debug = async (error) => {
  // Q1: Quick fix or deep dive?
  const approach = await ask({
    question: "Module 'react' not found. How to proceed?",
    header: "Error Fix",
    options: [
      { label: "Quick fix", description: "npm install react (most common)" },
      { label: "Diagnose", description: "Investigate root cause" },
      { label: "Clean install", description: "rm -rf node_modules && npm install" },
      { label: "Check config", description: "Verify package.json and dependencies" }
    ]
  });

  if (approach === "Diagnose") {
    // Q2: Diagnostic steps
    const checks = await ask({
      question: "Which diagnostic steps to run?",
      header: "Diagnostics",
      multiSelect: true,
      options: [
        { label: "Check package.json", description: "Verify react is listed" },
        { label: "Check node_modules", description: "Verify react is installed" },
        { label: "Check npm/yarn", description: "Verify package manager" },
        { label: "Check lockfile", description: "Verify package-lock.json" }
      ]
    });

    const results = runDiagnostics(checks);

    // Q3: Based on results, suggest fix
    const fix = await ask({
      question: `Diagnostics complete. ${results}. Recommended fix?`,
      header: "Fix",
      options: generateFixOptions(results)
    });
  }
};
```

### Scenario 3: Code Refactoring

**Context:** User wants to refactor code with multiple options.

```javascript
const refactor = async () => {
  // Q1: Scope
  const scope = await ask({
    question: "What do you want to refactor?",
    header: "Refactor",
    options: [
      { label: "Single file", description: "Focused refactoring" },
      { label: "Component tree", description: "Component + children" },
      { label: "Module", description: "Entire feature/module" },
      { label: "Full codebase", description: "Project-wide refactor" }
    ]
  });

  // Q2: Type of refactoring
  const type = await ask({
    question: "What type of refactoring?",
    header: "Type",
    multiSelect: true,
    options: [
      { label: "Extract", description: "Extract functions/components" },
      { label: "Inline", description: "Inline small functions" },
      { label: "Rename", description: "Improve naming" },
      { label: "Simplify", description: "Reduce complexity" }
    ]
  });

  // Q3: Safety level
  const safety = await ask({
    question: "Refactoring safety level?",
    header: "Safety",
    options: [
      { label: "Conservative", description: "Only safe, proven refactorings" },
      { label: "Balanced", description: "Safe + some improvements" },
      { label: "Aggressive", description: "All possible improvements" }
    ]
  });

  // Q4: Confirmation with preview
  const preview = generateRefactoringPreview(scope, type, safety);
  const confirm = await ask({
    question: `Preview:\n${preview}\n\nApply refactoring?`,
    header: "Confirm",
    options: [
      { label: "Apply all", description: "Execute all changes" },
      { label: "Apply selective", description: "Choose which changes" },
      { label: "Cancel", description: "Don't refactor" }
    ]
  });
};
```

### Scenario 4: Dependency Management

**Context:** Update dependencies with conflict resolution.

```javascript
const updateDeps = async () => {
  // Scan for outdated packages
  const outdated = scanOutdated();  // {react: "17.0" → "18.2", ...}

  // Q1: Update strategy
  const strategy = await ask({
    question: `Found ${outdated.length} outdated packages. Update strategy?`,
    header: "Strategy",
    options: [
      { label: "Patch only", description: "17.0.1 → 17.0.2 (safest)" },
      { label: "Minor", description: "17.0 → 17.1 (safe, new features)" },
      { label: "Major", description: "17 → 18 (breaking changes possible)" },
      { label: "Latest", description: "Update to latest regardless" }
    ]
  });

  const toUpdate = filterByStrategy(outdated, strategy);

  // Q2: Which packages to update?
  const selected = await ask({
    question: "Select packages to update:",
    header: "Packages",
    multiSelect: true,
    options: toUpdate.map(pkg => ({
      label: pkg.name,
      description: `${pkg.current} → ${pkg.latest} (${pkg.type})`
    }))
  });

  // Q3: Test after update?
  const testing = await ask({
    question: "Run tests after update?",
    header: "Testing",
    options: [
      { label: "Run all tests", description: "Full test suite (safest)" },
      { label: "Run affected", description: "Only tests for updated packages" },
      { label: "Skip tests", description: "Update without testing (risky)" }
    ]
  });

  // Execute update
  await executeUpdate(selected, testing);
};
```

### Scenario 5: Performance Optimization

**Context:** Optimize application performance with guided steps.

```javascript
const optimize = async () => {
  // Run performance audit
  const audit = runAudit();  // Lighthouse, Bundle analyzer, etc.

  // Q1: Optimization priorities
  const priorities = await ask({
    question: "Which metrics to optimize?",
    header: "Metrics",
    multiSelect: true,
    options: [
      { label: "Load time", description: `Current: ${audit.loadTime}ms → Target: <2s` },
      { label: "Bundle size", description: `Current: ${audit.bundleSize}MB → Target: <500KB` },
      { label: "Interactivity", description: `TTI: ${audit.tti}ms → Target: <3s` },
      { label: "Memory", description: `Heap: ${audit.heap}MB → Reduce leaks` }
    ]
  });

  // Q2: For each priority, suggest optimizations
  for (const priority of priorities) {
    const techniques = await ask({
      question: `Optimize ${priority}. Select techniques:`,
      header: priority,
      multiSelect: true,
      options: getOptimizationTechniques(priority, audit)
    });

    applyOptimizations(priority, techniques);
  }

  // Q3: Measure improvement
  const retest = await ask({
    question: "Optimizations applied. Re-run audit?",
    header: "Audit",
    options: [
      { label: "Yes, compare", description: "Show before/after comparison" },
      { label: "No, trust", description: "Skip verification" }
    ]
  });

  if (retest === "Yes, compare") {
    const newAudit = runAudit();
    showComparison(audit, newAudit);
  }
};
```

### Scenario 6: Git Workflow Assistance

**Context:** Complex Git operations with safety checks.

```javascript
const gitWorkflow = async () => {
  const status = getGitStatus();

  // Q1: What to do?
  const action = await ask({
    question: "Git operation?",
    header: "Git",
    options: [
      { label: "Commit", description: `Stage ${status.modified} files` },
      { label: "Branch", description: "Create/switch branch" },
      { label: "Merge", description: "Merge branch into current" },
      { label: "Rebase", description: "Rebase current branch (advanced)" }
    ]
  });

  if (action === "Merge") {
    const branches = getBranches();

    // Q2: Which branch to merge?
    const branch = await ask({
      question: "Merge which branch into current?",
      header: "Branch",
      options: branches.map(b => ({
        label: b.name,
        description: `${b.commits} commits ahead, ${b.behind} behind`
      }))
    });

    // Check for conflicts
    const conflicts = checkMergeConflicts(branch);

    if (conflicts.length > 0) {
      // Q3: Conflict resolution strategy
      const strategy = await ask({
        question: `Found ${conflicts.length} conflicts. Resolution strategy?`,
        header: "Conflicts",
        options: [
          { label: "Manual", description: "Show conflicts, resolve manually" },
          { label: "Ours", description: "Keep current branch changes" },
          { label: "Theirs", description: "Accept incoming branch changes" },
          { label: "Abort", description: "Cancel merge" }
        ]
      });

      if (strategy === "Manual") {
        for (const conflict of conflicts) {
          const resolution = await ask({
            question: `Conflict in ${conflict.file}:\n${conflict.preview}`,
            header: "Resolve",
            options: [
              { label: "Keep current", description: "Use this version" },
              { label: "Use incoming", description: "Use their version" },
              { label: "Edit manually", description: "Open in editor" }
            ]
          });

          resolveConflict(conflict, resolution);
        }
      }
    }
  }
};
```

### Scenario 7: API Design Wizard

**Context:** Design a new API with best practices.

```javascript
const designAPI = async () => {
  // Q1: API style
  const style = await ask({
    question: "What API style?",
    header: "API Style",
    options: [
      { label: "REST", description: "Resource-based, HTTP verbs, cacheable" },
      { label: "GraphQL", description: "Query language, single endpoint, typed" },
      { label: "tRPC", description: "Type-safe RPC, end-to-end TypeScript" },
      { label: "gRPC", description: "Binary protocol, high performance, streaming" }
    ]
  });

  // Q2: Authentication
  const auth = await ask({
    question: "Authentication method?",
    header: "Auth",
    options: [
      { label: "JWT", description: "Stateless, scalable, industry standard" },
      { label: "Session", description: "Server-side, more secure, simpler" },
      { label: "OAuth", description: "Third-party login, social auth" },
      { label: "API Keys", description: "Simple, machine-to-machine" }
    ]
  });

  // Q3: Features (conditional based on style)
  const features = await ask({
    question: "API features to implement?",
    header: "Features",
    multiSelect: true,
    options: getAPIFeatures(style)  // Different for REST vs GraphQL
  });

  // Q4: Rate limiting & security
  const security = await ask({
    question: "Security & rate limiting?",
    header: "Security",
    multiSelect: true,
    options: [
      { label: "Rate limiting", description: "Prevent abuse, per-user limits" },
      { label: "CORS", description: "Cross-origin resource sharing" },
      { label: "Input validation", description: "Zod/Joi schema validation" },
      { label: "Logging", description: "Request/response logging" }
    ]
  });

  // Generate API structure
  generateAPI({ style, auth, features, security });
};
```

---

## Performance & Optimization

### Response Time

```
┌─────────────────────────────────────────┐
│ AskUserQuestion Performance Profile     │
├─────────────────────────────────────────┤
│ Tool invocation:        ~50ms           │
│ UI render:              ~100ms          │
│ User read time:         2-10s           │
│ User decision:          1-5s            │
│ Response return:        ~50ms           │
├─────────────────────────────────────────┤
│ Total (excl. user):     ~200ms          │
│ Total (incl. user):     3-15s           │
└─────────────────────────────────────────┘
```

### Optimization Strategies

#### 1. Batch Questions

```javascript
// ❌ SLOW: Sequential questions (4 round-trips)
const q1 = await ask(...);  // Wait
const q2 = await ask(...);  // Wait
const q3 = await ask(...);  // Wait
const q4 = await ask(...);  // Wait
// Total: 4 × (user time) = 12-60s

// ✅ FAST: Batched questions (1 round-trip)
const [q1, q2, q3, q4] = await ask([
  { question: "..." },
  { question: "..." },
  { question: "..." },
  { question: "..." }
]);
// Total: 1 × (user time) = 3-15s
```

#### 2. Smart Defaults

Pre-select most common option:

```javascript
// ❌ Forces user decision every time
options: ["Option A", "Option B", "Option C"]

// ✅ Guides toward best practice
options: [
  { label: "Recommended: Option A", description: "..." },  // Mental anchor
  { label: "Option B", description: "..." },
  { label: "Option C", description: "..." }
]
```

#### 3. Progressive Loading

Don't ask for everything upfront:

```javascript
// ❌ Overwhelming: 4 questions immediately
ask([Q1, Q2, Q3, Q4])

// ✅ Progressive: Start simple, drill down
ask([Q1])  // Start
if (Q1.answer === "Advanced") {
  ask([Q2, Q3, Q4])  // Only if needed
}
```

#### 4. Memoization

Cache expensive computations:

```javascript
// Cache results
const optionsCache = new Map();

function getOptions(context) {
  const key = JSON.stringify(context);

  if (!optionsCache.has(key)) {
    optionsCache.set(key, computeExpensiveOptions(context));
  }

  return optionsCache.get(key);
}
```

---

## Limitations & Workarounds

### Limitation 1: Maximum 4 Questions

**Problem:** Need to ask 10+ questions for complex setup.

**Workarounds:**

#### A) Multi-stage approach
```javascript
// Stage 1: High-level (4 questions)
const stage1 = await ask([Q1, Q2, Q3, Q4]);

// Stage 2: Drill-down (4 more questions)
const stage2 = await ask([Q5, Q6, Q7, Q8]);

// Stage 3: Finalization (2 questions)
const stage3 = await ask([Q9, Q10]);
```

#### B) Multi-select consolidation
```javascript
// ❌ 6 yes/no questions
const useAuth = await ask("Enable auth?");
const useDB = await ask("Enable DB?");
const useEmail = await ask("Enable email?");
// ... 3 more

// ✅ 1 multi-select question
const features = await ask({
  question: "Which features to enable?",
  multiSelect: true,
  options: ["Auth", "DB", "Email", "Payments", "Analytics", "i18n"]
});
```

### Limitation 2: Maximum 4 Options

**Problem:** Need to choose from 10+ frameworks.

**Workarounds:**

#### A) Categorize first
```javascript
// Step 1: Category (4 options max)
const category = await ask({
  question: "Framework category?",
  options: ["React-based", "Vue-based", "Standalone", "Other"]
});

// Step 2: Specific framework (filtered)
const framework = await ask({
  question: `Which ${category} framework?`,
  options: getFrameworks(category)  // Now < 4 options
});
```

#### B) Popularity-based filtering
```javascript
// Step 1: Tier selection
const tier = await ask({
  question: "Framework preference?",
  options: [
    { label: "Popular", description: "Top 4 most used" },
    { label: "Emerging", description: "New & trending" },
    { label: "Specialized", description: "Niche use cases" },
    { label: "Show all", description: "See full list" }
  ]
});

// Step 2: Filtered list
const options = filterByTier(tier);
```

### Limitation 3: Header ≤12 Characters

**Problem:** Need descriptive header.

**Workarounds:**

```javascript
// ❌ Too long
header: "Authentication Method"  // 21 chars

// ✅ Abbreviated
header: "Auth"  // 4 chars

// ✅ Acronym
header: "Auth Method"  // 11 chars

// ✅ Put detail in question
header: "Auth",
question: "Which authentication method do you prefer?"
```

### Limitation 4: No Dynamic Option Generation

**Problem:** Options depend on external API call.

**Workarounds:**

```javascript
// ❌ Can't do this
options: await fetchOptionsFromAPI()

// ✅ Fetch first, then ask
const availableOptions = await fetchOptionsFromAPI();
const answer = await ask({
  question: "...",
  options: availableOptions
});
```

### Limitation 5: No Nested Multi-Select

**Problem:** Want to group options hierarchically.

**Workarounds:**

```javascript
// ❌ Can't do nested
{
  "Frontend": {
    "React": ["Next.js", "Remix", "Gatsby"],
    "Vue": ["Nuxt", "Vite", "Quasar"]
  }
}

// ✅ Sequential questions
const category = await ask("Category?", ["React", "Vue", "Svelte"]);
const framework = await ask("Framework?", frameworksFor[category]);
```

---

## Best Practices

### 1. Descriptive Questions

```javascript
// ❌ Vague
question: "Choose one"

// ✅ Clear
question: "Which database do you want to use for this project?"
```

### 2. Informative Descriptions

```javascript
// ❌ Redundant
{
  label: "PostgreSQL",
  description: "PostgreSQL database"
}

// ✅ Adds value
{
  label: "PostgreSQL",
  description: "ACID compliant, robust JSON support, mature ecosystem, self-hosted"
}
```

### 3. Logical Ordering

```javascript
// ❌ Random order
options: ["Advanced", "Simple", "Custom", "Recommended"]

// ✅ Logical order
options: [
  "Recommended",  // Default/best practice first
  "Simple",       // Complexity ascending
  "Advanced",
  "Custom"        // Most flexible last
]
```

### 4. Consistent Headers

```javascript
// ❌ Inconsistent
headers: ["Framework Selection", "DB", "auth method", "DEPLOY"]

// ✅ Consistent
headers: ["Framework", "Database", "Auth", "Deployment"]
```

### 5. Avoid Yes/No for Complex Decisions

```javascript
// ❌ Binary when nuance exists
question: "Use TypeScript?",
options: ["Yes", "No"]

// ✅ Provide spectrum
question: "Type checking strategy?",
options: [
  { label: "Full TypeScript", description: "Strict mode, all files .ts" },
  { label: "TypeScript + JS", description: "Mixed, gradual adoption" },
  { label: "JSDoc", description: "Type hints in comments" },
  { label: "None", description: "Pure JavaScript" }
]
```

### 6. Show Impact/Consequences

```javascript
{
  label: "Microservices",
  description: "Complex setup, better scalability, harder debugging, high DevOps overhead"
}
```

### 7. Use Multi-Select for Non-Exclusive Choices

```javascript
// ❌ Forces single choice when multiple make sense
question: "Which testing type?",
multiSelect: false,
options: ["Unit", "Integration", "E2E"]

// ✅ Allow comprehensive testing
question: "Which testing types to implement?",
multiSelect: true,
options: [
  { label: "Unit", description: "Fast, isolated, test functions" },
  { label: "Integration", description: "Test module interactions" },
  { label: "E2E", description: "Test full user flows" }
]
```

### 8. Provide Context in Questions

```javascript
// ❌ No context
question: "Which one?"

// ✅ Rich context
question: "You're building a Next.js app with 100k+ users. Which database offers the best scalability?"
```

### 9. Validation After Answer

```javascript
const answer = await ask(...);

// Validate
if (answer === "MongoDB" && requires_transactions) {
  const confirm = await ask({
    question: "Warning: MongoDB transactions require replica set. Continue?",
    options: [
      { label: "Yes, I have replica set", description: "Continue with MongoDB" },
      { label: "No, choose different DB", description: "Back to DB selection" }
    ]
  });
}
```

### 10. Summary at the End

```javascript
// After all questions
const summary = generateSummary(allAnswers);

await ask({
  question: `Configuration complete:\n${summary}\n\nProceed?`,
  options: ["Yes, create project", "No, reconfigure"]
});
```

---

## Anti-Patterns

### ❌ Anti-Pattern 1: Too Many Sequential Questions

```javascript
// BAD: 10 sequential calls
const q1 = await ask("Q1?");
const q2 = await ask("Q2?");
// ... 8 more
// User frustration: "Why didn't you ask all at once?"
```

**Fix:** Batch related questions:
```javascript
const [q1, q2, q3, q4] = await ask([...]);
const [q5, q6] = await ask([...]);  // Second batch
```

### ❌ Anti-Pattern 2: Unclear Options

```javascript
// BAD: What do these mean?
options: ["Option A", "Option B", "Option C"]
```

**Fix:** Descriptive labels:
```javascript
options: [
  { label: "REST API", description: "..." },
  { label: "GraphQL", description: "..." },
  { label: "tRPC", description: "..." }
]
```

### ❌ Anti-Pattern 3: Asking for Known Information

```javascript
// BAD: You already know this from package.json
const hasReact = await ask("Do you use React?", ["Yes", "No"]);
```

**Fix:** Detect automatically:
```javascript
const hasReact = detectFramework() === "React";
if (hasReact) {
  // Configure React-specific options
}
```

### ❌ Anti-Pattern 4: No Escape Hatch

```javascript
// BAD: Forces choice even if user wants neither
options: ["PostgreSQL", "MySQL", "MongoDB"]
// What if user wants SQLite?
```

**Fix:** "Other" is auto-added, or provide explicit option:
```javascript
options: [
  { label: "PostgreSQL", description: "..." },
  { label: "MySQL", description: "..." },
  { label: "MongoDB", description: "..." },
  { label: "Other/None", description: "Skip database setup" }
]
```

### ❌ Anti-Pattern 5: Ignoring User Context

```javascript
// BAD: Same questions for everyone
await ask("Which database?", ["PostgreSQL", "MongoDB", "MySQL"]);
```

**Fix:** Adapt to context:
```javascript
// Detect existing setup
const existing = detectExistingDB();

if (existing) {
  await ask(
    `Detected ${existing}. What to do?`,
    ["Keep existing", "Replace with new", "Add additional"]
  );
} else {
  await ask("Which database?", [...]);
}
```

### ❌ Anti-Pattern 6: Modal Fatigue

```javascript
// BAD: Interrupting flow constantly
while (true) {
  const action = await ask("What now?", [...]);
  // Execute
  // Ask again
}
```

**Fix:** Batch actions:
```javascript
const actions = await ask({
  question: "Which actions to perform?",
  multiSelect: true,
  options: ["Action 1", "Action 2", "Action 3"]
});

// Execute all at once
for (const action of actions) {
  execute(action);
}
```

### ❌ Anti-Pattern 7: Poor Error Handling

```javascript
// BAD: Assume answer is always valid
const answer = await ask(...);
database.connect(answer);  // Crashes if invalid
```

**Fix:** Validate and handle errors:
```javascript
const answer = await ask(...);

try {
  await database.connect(answer);
} catch (error) {
  const retry = await ask(
    `Failed to connect: ${error.message}. Retry?`,
    ["Retry", "Choose different", "Skip"]
  );
}
```

---

## Real-World Examples

### Example 1: Monorepo Setup

```javascript
/**
 * Complete monorepo configuration wizard
 * Handles: structure, tools, packages, CI/CD
 */

const setupMonorepo = async () => {
  // Stage 1: Structure & Tooling (4 questions)
  const stage1 = await ask([
    {
      question: "Monorepo structure?",
      header: "Structure",
      multiSelect: false,
      options: [
        {
          label: "App-focused",
          description: "apps/* (main), packages/* (shared libs)"
        },
        {
          label: "Package-focused",
          description: "packages/* (libs), examples/* (demos)"
        },
        {
          label: "Hybrid",
          description: "apps/*, packages/*, tools/*"
        }
      ]
    },
    {
      question: "Which monorepo tool?",
      header: "Tool",
      multiSelect: false,
      options: [
        {
          label: "Turborepo",
          description: "Vercel, fast caching, simple setup"
        },
        {
          label: "Nx",
          description: "Powerful, plugins, complex projects"
        },
        {
          label: "pnpm workspaces",
          description: "Simple, fast, no extra tooling"
        },
        {
          label: "Lerna",
          description: "Classic, publishing-focused"
        }
      ]
    },
    {
      question: "Package manager?",
      header: "Pkg Manager",
      multiSelect: false,
      options: [
        { label: "pnpm", description: "Fast, disk efficient, strict" },
        { label: "npm", description: "Standard, widely supported" },
        { label: "yarn", description: "Fast, Plug'n'Play option" }
      ]
    },
    {
      question: "Initial packages to create?",
      header: "Packages",
      multiSelect: true,
      options: [
        { label: "ui", description: "Shared UI components" },
        { label: "utils", description: "Shared utilities" },
        { label: "config", description: "Shared configs (TS, ESLint)" },
        { label: "types", description: "Shared TypeScript types" }
      ]
    }
  ]);

  // Stage 2: Apps & Features (3 questions)
  const stage2 = await ask([
    {
      question: "Which apps to scaffold?",
      header: "Apps",
      multiSelect: true,
      options: [
        { label: "web", description: "Main web app (Next.js)" },
        { label: "docs", description: "Documentation site (Nextra)" },
        { label: "api", description: "Backend API (Express/Fastify)" },
        { label: "admin", description: "Admin dashboard" }
      ]
    },
    {
      question: "Development features?",
      header: "Dev Features",
      multiSelect: true,
      options: [
        { label: "Hot reload", description: "Watch mode for packages" },
        { label: "Dev containers", description: "Docker dev environment" },
        { label: "Storybook", description: "Component development" },
        { label: "Changesets", description: "Version management" }
      ]
    },
    {
      question: "CI/CD setup?",
      header: "CI/CD",
      multiSelect: true,
      options: [
        { label: "GitHub Actions", description: "Test + build on push" },
        { label: "Changesets bot", description: "Auto-versioning PRs" },
        { label: "Deploy preview", description: "Preview deployments" },
        { label: "Turborepo cache", description: "Remote caching" }
      ]
    }
  ]);

  // Generate configuration
  const config = {
    ...stage1,
    ...stage2
  };

  // Confirmation
  const summary = `
  Monorepo Configuration:
  ━━━━━━━━━━━━━━━━━━━━━━
  Structure: ${config["Monorepo structure?"]}
  Tool: ${config["Which monorepo tool?"]}
  Package Manager: ${config["Package manager?"]}

  Packages: ${config["Initial packages to create?"].join(", ")}
  Apps: ${config["Which apps to scaffold?"].join(", ")}

  Features:
  ${config["Development features?"].map(f => `  ✓ ${f}`).join("\n")}

  CI/CD:
  ${config["CI/CD setup?"].map(c => `  ✓ ${c}`).join("\n")}
  `;

  const confirm = await ask({
    question: summary + "\n\nProceed with setup?",
    header: "Confirm",
    multiSelect: false,
    options: [
      { label: "Yes, create", description: "Generate monorepo structure" },
      { label: "Modify", description: "Change configuration" },
      { label: "Cancel", description: "Abort setup" }
    ]
  });

  if (confirm === "Yes, create") {
    await generateMonorepo(config);
  } else if (confirm === "Modify") {
    return setupMonorepo();  // Restart
  }
};
```

### Example 2: Database Migration Assistant

```javascript
/**
 * Intelligent database migration helper
 * Detects schema changes, suggests migrations, handles conflicts
 */

const migrationAssistant = async () => {
  // Detect changes
  const changes = detectSchemaChanges();

  if (changes.length === 0) {
    console.log("No schema changes detected.");
    return;
  }

  // Q1: Review changes
  const review = await ask({
    question: `Detected ${changes.length} schema changes:\n${formatChanges(changes)}\n\nHow to proceed?`,
    header: "Changes",
    multiSelect: false,
    options: [
      {
        label: "Auto-migrate",
        description: "Generate & apply migration automatically"
      },
      {
        label: "Review first",
        description: "Show migration SQL before applying"
      },
      {
        label: "Manual",
        description: "I'll write migration myself"
      },
      {
        label: "Ignore",
        description: "Skip these changes"
      }
    ]
  });

  if (review === "Ignore") return;

  // Generate migration
  const migration = generateMigration(changes);

  if (review === "Review first") {
    console.log("Generated migration:\n", migration.sql);

    const proceed = await ask({
      question: "Apply this migration?",
      header: "Apply",
      multiSelect: false,
      options: [
        { label: "Apply", description: "Execute migration" },
        { label: "Edit", description: "Modify SQL first" },
        { label: "Cancel", description: "Don't apply" }
      ]
    });

    if (proceed === "Edit") {
      migration.sql = await editInEditor(migration.sql);
    } else if (proceed === "Cancel") {
      return;
    }
  }

  // Safety checks
  const safety = await ask([
    {
      question: "Backup database before migration?",
      header: "Backup",
      multiSelect: false,
      options: [
        { label: "Yes, backup", description: "Create snapshot (recommended)" },
        { label: "Skip backup", description: "Risky, faster" }
      ]
    },
    {
      question: "Run migration in transaction?",
      header: "Transaction",
      multiSelect: false,
      options: [
        {
          label: "Yes",
          description: "Rollback on error (safer, not all DBs support)"
        },
        {
          label: "No",
          description: "Faster but can't rollback"
        }
      ]
    },
    {
      question: "Test data handling?",
      header: "Data",
      multiSelect: false,
      options: [
        { label: "Preserve all", description: "Keep existing data" },
        { label: "Transform", description: "Apply data migrations" },
        { label: "Clear", description: "Delete conflicting data (danger)" }
      ]
    }
  ]);

  // Execute
  try {
    if (safety["Backup database before migration?"] === "Yes, backup") {
      await createBackup();
    }

    await applyMigration(migration, safety);

    console.log("✓ Migration applied successfully");
  } catch (error) {
    console.error("✗ Migration failed:", error);

    const rollback = await ask({
      question: "Migration failed. Rollback?",
      header: "Rollback",
      multiSelect: false,
      options: [
        { label: "Rollback", description: "Restore backup" },
        { label: "Keep changes", description: "Debug manually" }
      ]
    });

    if (rollback === "Rollback") {
      await restoreBackup();
    }
  }
};
```

### Example 3: Component Generator

```javascript
/**
 * React component generator with best practices
 */

const generateComponent = async () => {
  // Q1-4: Component basics
  const basics = await ask([
    {
      question: "Component type?",
      header: "Type",
      multiSelect: false,
      options: [
        {
          label: "Functional",
          description: "Modern, hooks, recommended"
        },
        {
          label: "Class",
          description: "Legacy, lifecycle methods"
        }
      ]
    },
    {
      question: "Component category?",
      header: "Category",
      multiSelect: false,
      options: [
        { label: "UI", description: "Presentational, reusable" },
        { label: "Layout", description: "Page structure" },
        { label: "Feature", description: "Business logic" },
        { label: "Page", description: "Route component" }
      ]
    },
    {
      question: "Styling approach?",
      header: "Styling",
      multiSelect: false,
      options: [
        { label: "Tailwind", description: "Utility classes" },
        { label: "CSS Modules", description: "Scoped CSS" },
        { label: "Styled", description: "CSS-in-JS" },
        { label: "None", description: "No styles" }
      ]
    },
    {
      question: "Include features?",
      header: "Features",
      multiSelect: true,
      options: [
        { label: "Props", description: "TypeScript prop types" },
        { label: "State", description: "useState hooks" },
        { label: "Effects", description: "useEffect hooks" },
        { label: "Tests", description: "Jest + Testing Library" }
      ]
    }
  ]);

  // Conditional Q5-6 based on features
  let advanced = {};

  if (basics["Include features?"].includes("Props")) {
    advanced.props = await ask({
      question: "Props definition style?",
      header: "Props Style",
      multiSelect: false,
      options: [
        { label: "Interface", description: "interface Props { ... }" },
        { label: "Type", description: "type Props = { ... }" },
        { label: "Inline", description: "FC<{ ... }>" }
      ]
    });
  }

  if (basics["Include features?"].includes("Tests")) {
    advanced.testCoverage = await ask({
      question: "Test coverage level?",
      header: "Tests",
      multiSelect: true,
      options: [
        { label: "Rendering", description: "Component renders" },
        { label: "Props", description: "Props handling" },
        { label: "Interactions", description: "User events" },
        { label: "Accessibility", description: "a11y checks" }
      ]
    });
  }

  // Generate
  const component = generateComponentCode({
    ...basics,
    ...advanced
  });

  // Preview
  console.log("Generated component:\n", component);

  // Q7: Finalize
  const finalize = await ask({
    question: "Save component?",
    header: "Save",
    multiSelect: false,
    options: [
      { label: "Save", description: "Write to file" },
      { label: "Copy", description: "Copy to clipboard" },
      { label: "Edit", description: "Modify before saving" },
      { label: "Cancel", description: "Discard" }
    ]
  });

  if (finalize === "Save") {
    const path = await getComponentPath(basics["Component category?"]);
    await writeFile(path, component);
  } else if (finalize === "Edit") {
    const edited = await editInEditor(component);
    await writeFile(getComponentPath(), edited);
  }
};
```

---

## Comparison with Alternatives

### vs. Text-Based Questions

```
┌─────────────────────┬──────────────────┬─────────────────┐
│ Feature             │ AskUserQuestion  │ Text Question   │
├─────────────────────┼──────────────────┼─────────────────┤
│ Type safety         │ ✅ Guaranteed     │ ❌ Manual parse │
│ Typos               │ ✅ Impossible     │ ❌ Frequent     │
│ Descriptions        │ ✅ Built-in       │ ❌ Extra msg    │
│ Multi-select        │ ✅ Native         │ ❌ Complex      │
│ UI/UX               │ ✅ Native UI      │ ⚠️ Plain text   │
│ Validation          │ ✅ Automatic      │ ❌ Manual       │
│ "Other" option      │ ✅ Auto-added     │ ❌ Manual       │
│ Option limit        │ ⚠️ 2-4           │ ✅ Unlimited    │
│ Free-form text      │ ❌ Limited*       │ ✅ Full         │
└─────────────────────┴──────────────────┴─────────────────┘
* "Other" allows free text input
```

### vs. CLI Prompts (inquirer.js, prompts)

```
┌─────────────────────┬──────────────────┬─────────────────┐
│ Feature             │ AskUserQuestion  │ CLI Prompts     │
├─────────────────────┼──────────────────┼─────────────────┤
│ Integration         │ ✅ Native Claude  │ ⚠️ External lib │
│ Setup               │ ✅ Zero config    │ ❌ npm install  │
│ Context aware       │ ✅ Full history   │ ⚠️ Limited      │
│ Prompt types        │ ⚠️ 2 types       │ ✅ 10+ types    │
│ Async/Await         │ ✅ Yes            │ ✅ Yes          │
│ Conditional logic   │ ✅ Full control   │ ✅ Full control │
│ Validation          │ ✅ Built-in       │ ✅ Extensive    │
│ Theming             │ ❌ Fixed UI       │ ✅ Customizable │
└─────────────────────┴──────────────────┴─────────────────┘
```

### vs. Configuration Files

```
┌─────────────────────┬──────────────────┬─────────────────┐
│ Feature             │ AskUserQuestion  │ Config Files    │
├─────────────────────┼──────────────────┼─────────────────┤
│ Interactive         │ ✅ Yes            │ ❌ No           │
│ Discoverable        │ ✅ Guided         │ ❌ Must know    │
│ Reproducible        │ ⚠️ Manual        │ ✅ Automatic    │
│ Version control     │ ❌ No             │ ✅ Yes          │
│ Team sharing        │ ❌ Manual         │ ✅ Easy         │
│ Flexibility         │ ✅ Dynamic        │ ⚠️ Static       │
│ Learning curve      │ ✅ Low            │ ⚠️ Medium       │
└─────────────────────┴──────────────────┴─────────────────┘
```

**Best Approach:** Hybrid

```javascript
// 1. Try to load config
const config = loadConfig(".myapp.json");

if (config) {
  // Use config
  setup(config);
} else {
  // Interactive setup
  const answers = await askUserQuestions(...);

  // Save for next time
  const save = await ask("Save configuration?", ["Yes", "No"]);
  if (save === "Yes") {
    saveConfig(".myapp.json", answers);
  }
}
```

---

## Future Possibilities

### Potential Enhancements

#### 1. Nested Multi-Select

```javascript
// Not currently possible, but imagine:
{
  question: "Configure features",
  header: "Features",
  multiSelect: "nested",  // New capability
  options: [
    {
      label: "Authentication",
      children: [
        { label: "OAuth", description: "..." },
        { label: "JWT", description: "..." },
        { label: "Sessions", description: "..." }
      ]
    },
    {
      label: "Database",
      children: [
        { label: "PostgreSQL", description: "..." },
        { label: "MongoDB", description: "..." }
      ]
    }
  ]
}
```

#### 2. Conditional Options

```javascript
{
  question: "Which database?",
  options: [
    {
      label: "PostgreSQL",
      description: "...",
      followUp: {  // New capability
        question: "PostgreSQL version?",
        options: ["14", "15", "16"]
      }
    }
  ]
}
```

#### 3. Input Validation

```javascript
{
  question: "Project name?",
  type: "text",  // New: free text input
  validate: (input) => {
    if (!/^[a-z0-9-]+$/.test(input)) {
      return "Must be lowercase, alphanumeric, hyphens only";
    }
    return true;
  }
}
```

#### 4. Visual Previews

```javascript
{
  question: "Choose theme",
  options: [
    {
      label: "Dark",
      description: "...",
      preview: "🌙 [Visual preview of dark theme]"  // New capability
    }
  ]
}
```

#### 5. Saved Presets

```javascript
{
  question: "Project setup?",
  presets: [  // New capability
    {
      label: "Last used",
      description: "Next.js + PostgreSQL + Tailwind (2024-01-15)"
    },
    {
      label: "Team default",
      description: "Standard company stack"
    }
  ],
  options: [/* custom options */]
}
```

#### 6. Undo/History

```javascript
// During multi-step workflow
{
  question: "...",
  allowUndo: true,  // New capability
  history: [
    "Step 1: Chose Next.js",
    "Step 2: Chose PostgreSQL",
    "Step 3: Chose Tailwind"
  ]
}
// User can go back to any step
```

---

## Conclusion

`AskUserQuestion` is a powerful tool for creating **intelligent, interactive workflows** in Claude Code. Key takeaways:

### ✅ When to Use
- Multi-option decisions (2-4 choices)
- Complex configurations requiring user input
- Workflow branching based on preferences
- Feature toggles and setup wizards
- Anything requiring structured, type-safe input

### ⚠️ When to Avoid
- Simple yes/no (ask in chat)
- More than 4 options (categorize first)
- Free-form text input (use "Other" option)
- Information you can detect automatically
- Micro-decisions (batch them)

### 🚀 Pro Tips
1. **Batch questions** to minimize round-trips
2. **Provide rich descriptions** to inform decisions
3. **Order options logically** (recommended first)
4. **Use multi-select** for non-exclusive choices
5. **Validate answers** and handle edge cases
6. **Summarize and confirm** before executing
7. **Leverage context** from previous answers
8. **Think in decision trees**, not linear flows

---

## Additional Resources

### Internal Documentation
- **[Advanced-Patterns-Multi-Dialog.md](./Advanced-Patterns-Multi-Dialog.md)** - 🔥 NEW: Multi-dialog patterns & decision trees
- **[AskUserQuestion-Optimizations-Anthropic-2025.md](./AskUserQuestion-Optimizations-Anthropic-2025.md)** - Optimizations guide
- Claude Code Tool API Reference
- Conversation Context & Memory
- Best Practices for AI Workflows

### External Inspiration
- [Inquirer.js](https://github.com/SBoudrias/Inquirer.js) - CLI prompts library
- [Plop.js](https://plopjs.com/) - Micro-generator framework
- [Yeoman](https://yeoman.io/) - Scaffolding tool
- [Create T3 App](https://create.t3.gg/) - Interactive setup wizard

### Related Patterns
- Progressive disclosure in UX design
- Decision trees in conversational AI
- Wizard patterns in software interfaces
- Command-line interface design

---

**Version:** 1.0.0
**Last Updated:** 2025-11-08
**Author:** Claude Code Documentation Team

---

> **Feedback?** Found an edge case or have a creative use case? Share it to improve this guide!
