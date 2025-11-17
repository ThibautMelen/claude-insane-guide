# Understanding Claude Code's Full Stack: MCP, Skills, Subagents, and Hooks Explained

**Source** : [alexop.dev - Understanding Claude Code's Full Stack](https://alexop.dev/posts/understanding-claude-code-full-stack/)
**Auteur** : Alexander Opalic
**Date** : 9 novembre 2025
**Type** : Article pratique / Guide technique
**Niveau** : 🟢 Intermédiaire → 🔴 Avancé (Architecture complète)

---

## 🎯 Résumé Exécutif

Article **communauté** expliquant l'architecture complète de Claude Code dans **l'ordre des dépendances** : MCP (fondation) → Core Features → Plugins → Skills. Approche pratique avec exemples concrets et decision guides.

**Impact** : Clarification de l'architecture complète et introduction de nouveaux concepts pratiques ("context poisoning", Skills vs CLAUDE.md, gray area decision guide).

**Citation clé** :
> "Claude Code is, with hindsight, poorly named. It's not purely a coding tool: it's a tool for general computer automation."
> — Simon Willison

---

## 📚 Architecture Complète (Stack Layers)

### Vue d'ensemble

```
╔═══════════════════════════════════════════════════════════╗
║           CLAUDE CODE FULL STACK (4 LAYERS)              ║
╚═══════════════════════════════════════════════════════════╝

LAYER 4 : AGENT SKILLS
          ├─> Auto-invoked based on task context
          ├─> Model-driven selection
          └─> Automatic behaviors

              ▲
              │
LAYER 3 : PLUGINS
          ├─> Distributable bundles
          ├─> Commands + Hooks + Skills
          └─> Shareable configurations

              ▲
              │
LAYER 2 : CORE FEATURES
          ├─> CLAUDE.md (memory)
          ├─> Slash Commands (explicit workflows)
          ├─> Subagents (specialized AI)
          └─> Hooks (event-driven automation)

              ▲
              │
LAYER 1 : MODEL CONTEXT PROTOCOL (MCP)
          ├─> Foundation for external connections
          ├─> Universal adapter (GitHub, DBs, APIs)
          └─> Tools/Resources/Prompts exposure
```

---

## 🔑 Concepts Clés

### 1. Model Context Protocol (MCP) - Foundation Layer

**Définition** : Protocole universel pour connecter Claude Code aux systèmes externes.

```
╔═══════════════════════════════════════════════════════════╗
║                  MCP CONNECTION FLOW                      ║
╚═══════════════════════════════════════════════════════════╝

┌─────────────┐                    ┌─────────────┐
│ Claude Code │◄──────────────────►│ MCP Server  │
│             │   1. Connect       │ (GitHub)    │
│             │   2. Authenticate  │             │
│             │   3. Get caps      │             │
└─────────────┘                    └─────────────┘
       │
       │ 4. Display /mcp__github__* commands
       ▼
┌─────────────────────────────────────────────────────┐
│ Available Commands:                                 │
│ /mcp__github__create_issue                         │
│ /mcp__github__list_repos                           │
│ /mcp__github__create_pr                            │
└─────────────────────────────────────────────────────┘
```

**Installation** :
```bash
# Install server
claude mcp add playwright npx @playwright/mcp@latest

# Use it
/mcp__playwright__create-test [args]
```

**⚠️ GOTCHA** : MCP servers expose leurs propres tools - ils n'héritent PAS de Read, Write, Bash de Claude sauf si explicitement fournis.

**🚨 Context Window Management** : Chaque MCP server consomme du context. Monitor avec `/context`, remove si inutilisés.

---

### 2. Core Features - Building Blocks

#### 2.1) CLAUDE.md - Project Memory

**Structure hiérarchique** :

```
╔═══════════════════════════════════════════════════════════╗
║           CLAUDE.md HIERARCHY (4 LEVELS)                  ║
╚═══════════════════════════════════════════════════════════╝

LEVEL 1 : Enterprise CLAUDE.md (if configured)
          ├─> Organization-wide standards
          └─> Corporate guidelines

              ↓ (inherits + overrides)

LEVEL 2 : User ~/.claude/CLAUDE.md
          ├─> Personal preferences
          └─> Cross-project settings

              ↓ (inherits + overrides)

LEVEL 3 : Project ./CLAUDE.md
          ├─> Project-wide conventions
          └─> Architecture patterns

              ↓ (inherits + overrides)

LEVEL 4 : Directory-specific CLAUDE.md
          ├─> src/components/CLAUDE.md
          └─> Component-specific patterns
```

**Exemple concret** :
```markdown
# CLAUDE.md

## Project Overview
Personal blog built on AstroPaper - Astro-based blog theme with TypeScript.

**Tech Stack**: Astro 5, TypeScript, React, TailwindCSS

## Development Commands
```bash
npm run dev              # Build + Pagefind + dev server (localhost:4321)
npm run build            # Production build
npm run lint             # ESLint for .astro, .ts, .tsx
\```
```

**What goes in** : Common commands, coding standards, architectural patterns. **Keep it concise** - reference guide, not documentation.

**Ressource** : [CLAUDE.md creation guide](https://alexop.dev/prompts/claude/claude-create-md)

---

#### 2.2) Slash Commands - Explicit Workflows

**Flow d'exécution** :

```
┌─────────────────────────────────────────────────────────┐
│          SLASH COMMAND EXECUTION FLOW                   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. User types: /my-command args                       │
│              ↓                                          │
│  2. Pre-execution Bash Steps (if allowed-tools)        │
│              ↓                                          │
│  3. Markdown prompt expansion                          │
│              ↓                                          │
│  4. Claude processes with context                      │
│              ↓                                          │
│  5. Result returned                                    │
└─────────────────────────────────────────────────────────┘
```

**Structure exemple** :
```markdown
---
description: Create new slash commands
argument-hint: [name] [purpose]
allowed-tools: Bash(mkdir:*), Bash(tee:*)
---

# /create-command

Generate slash command files with proper structure.

**Inputs:** `$1` = name, `$2` = purpose
**Outputs:** `STATUS=WROTE PATH=.claude/commands/{name}.md`

## Process

1. Validate arguments ($ARGUMENTS or $1, $2)
2. Create .claude/commands/{name}.md
3. Use @file syntax for inlining code
4. Return structured output
```

**Key Features** :
- `$ARGUMENTS` ou `$1`, `$2` pour arguments
- `@file` syntax pour inline code
- `allowed-tools: Bash(...)` pour pre-execution scripts
- XML-tagged prompts pour reliable outputs

**When to use** : Repeatable workflows you trigger on demand — code reviews, commit messages, scaffolding.

**Ressource** : [Slash command creation guide](https://alexop.dev/prompts/claude/claude-create-command)

---

#### 2.3) Subagents - Specialized AI Personalities

**Parallel Execution Flow** :

```
╔═══════════════════════════════════════════════════════════╗
║              SUBAGENT PARALLEL EXECUTION                  ║
╚═══════════════════════════════════════════════════════════╝

Main Context
     │
     ├─────────────────┬─────────────────┐
     │                 │                 │
     ▼                 ▼                 ▼
┌─────────┐     ┌─────────┐     ┌─────────┐
│ SubA    │     │ SubB    │     │ SubC    │
│ Security│     │ Tests   │     │ Refactor│
│ Analysis│     │ Gen     │     │         │
└─────────┘     └─────────┘     └─────────┘
     │                 │                 │
     └─────────────────┴─────────────────┘
                      │
                      ▼
              ┌─────────────┐
              │   Results   │
              │  Aggregated │
              └─────────────┘
```

**Structure exemple** :
```markdown
---
name: security-auditor
description: Analyzes code for security vulnerabilities
tools: Read, Grep, Bash # Controls what this personality can access
model: sonnet # Optional: sonnet, opus, haiku, inherit
---

You are a security-focused code auditor.

Identify vulnerabilities (XSS, SQL injection, CSRF, etc.)
Check dependencies and packages
Verify auth/authorization
Review data validation

Provide severity levels: Critical, High, Medium, Low.
Focus on OWASP Top 10.
```

**💪 CONCEPT CLÉ : Context Poisoning**

```
╔═══════════════════════════════════════════════════════════╗
║                   CONTEXT POISONING                       ║
╚═══════════════════════════════════════════════════════════╝

❌ WITHOUT SUBAGENTS:
   Main Context (200k tokens)
   ├─> Initial discussion (10k tokens)
   ├─> Security deep dive (50k tokens) 🔴 POLLUTION
   ├─> Test generation (40k tokens) 🔴 POLLUTION
   ├─> Refactoring details (60k tokens) 🔴 POLLUTION
   └─> Final discussion cluttered with noise

✅ WITH SUBAGENTS:
   Main Context (20k tokens)
   ├─> Initial discussion (10k tokens)
   ├─> Delegation to subagents (3k tokens)
   └─> Results aggregation (7k tokens)

   Subagent A (isolated 50k tokens) ✅ ISOLATED
   Subagent B (isolated 40k tokens) ✅ ISOLATED
   Subagent C (isolated 60k tokens) ✅ ISOLATED
```

**Definition** : "Context poisoning" = when detailed implementation work clutters your main conversation. Subagents prevent this by isolating deep dives in separate context windows.

**Best Practices** :
- One expertise area per subagent
- Grant minimal tool access
- Use `haiku` for simple tasks, `sonnet` for complex analysis
- Run independent work in parallel

**Ressource** : [Subagent creation guide](https://alexop.dev/prompts/claude/claude-create-agent)

---

#### 2.4) Hooks - Event-Driven Automation

**Lifecycle Events Flow** :

```
┌─────────────────────────────────────────────────────────┐
│              HOOKS LIFECYCLE EVENTS                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Lifecycle Event → Hook 1 → Hook 2 → Hook 3           │
│        │              │        │        │              │
│        ▼              ▼        ▼        ▼              │
│  PreToolUse      Command  Prompt   Block/Continue     │
│  PostToolUse        │        │                         │
│  UserPromptSubmit   │        └─> LLM decides           │
│  Notification       └─> Shell command (fast)           │
│  Stop                                                   │
│  SubagentStop                                          │
│  SessionStart                                          │
└─────────────────────────────────────────────────────────┘
```

**Available Events** :
- `PreToolUse` : Avant chaque tool use
- `PostToolUse` : Après chaque tool use
- `UserPromptSubmit` : Quand user soumet message
- `Notification` : Notifications système
- `Stop` : Quand session stop
- `SubagentStop` : Quand subagent stop
- `SessionStart` : Au démarrage

**Two Modes** :
1. **Command** : Run shell commands (fast, predictable)
2. **Prompt** : Let Claude decide with LLM (flexible, context-aware)

**Exemple : Auto-lint after file edits**

`.claude/settings.json` :
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/run-oxlint.sh"
          }
        ]
      }
    ]
  }
}
```

`.claude/hooks/run-oxlint.sh` :
```bash
#!/usr/bin/env bash
file_path="$(jq -r '.tool_input.file_path // ""')"

if [[ "$file_path" =~ \.(js|jsx|ts|tsx|vue)$ ]]; then
  pnpm lint:fast
fi
```

**Common Uses** :
- Auto-format after edits
- Require approval for bash commands
- Validate writes
- Initialize sessions

**Ressource** : [Hook creation guide](https://alexop.dev/prompts/claude/claude-create-hook)

---

### 3. Plugins - Shareable Configurations

**Plugin Structure** :

```
╔═══════════════════════════════════════════════════════════╗
║                    PLUGIN ANATOMY                         ║
╚═══════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────┐
│ Plugin                                                  │
│                                                         │
│ ┌─────────────┐                                        │
│ │ Metadata    │  name, version, author, description    │
│ └─────────────┘                                        │
│        │                                                │
│        ├────► Commands                                 │
│        │       ├─> /create-skill                       │
│        │       └─> /generate-agent                     │
│        │                                                │
│        ├────► Hooks                                    │
│        │       ├─> PostToolUse (auto-lint)            │
│        │       └─> UserPromptSubmit (validate)        │
│        │                                                │
│        └────► Skills                                   │
│                ├─> tdd-workflow                        │
│                └─> code-review                         │
└─────────────────────────────────────────────────────────┘
```

**Basic Structure (.mcp.json)** :
```json
{
  "name": "skills-toolkit",
  "version": "1.0.0",
  "description": "Complete toolkit for creating and managing Skills",
  "author": "John Conneely",
  "contents": {
    "skills": ["skills/skill-best-practices"],
    "agents": ["agents/skill-creator.md"],
    "commands": ["commands/create-skill.md"]
  }
}
```

**When to Use** :
- Share team configurations
- Package domain workflows
- Distribute opinionated patterns
- Install community tooling

**How it Works** : Install plugin → components merge seamlessly. Hooks combine, commands appear in autocomplete, skills activate automatically.

**Ressource** : [Plugin creation guide](https://alexop.dev/prompts/claude/claude-create-plugin)

---

### 4. Agent Skills - Automatic Task-Driven Capabilities

**Skill Discovery Flow** :

```
╔═══════════════════════════════════════════════════════════╗
║               SKILL AUTO-INVOCATION FLOW                  ║
╚═══════════════════════════════════════════════════════════╝

┌─────────────────┐
│ Task context    │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ Available skills (personal / project / plugin)         │
│ ├─> ~/.claude/skills/                                  │
│ ├─> .claude/skills/                                    │
│ └─> plugin/skills/                                     │
└────────┬────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ Match SKILL.md description?                            │
│ ├─> YES → Continue                                     │
│ └─> NO → Skip skill                                    │
└────────┬────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────────────────┐
│ Check allowed-tools                                    │
│ ├─> OK → Run skill                                     │
│ └─> BLOCKED → Request approval or skip                │
└────────┬────────────────────────────────────────────────┘
         │
         ▼
┌─────────────────┐
│ Return result   │
└─────────────────┘
```

**Structure Minimale** :
```markdown
---
name: git-commit-style
description: Enforce conventional commit message format when creating commits
allowed-tools: Bash(git:*)
---

When generating commit messages:

1. Use conventional commits format: type(scope): message
2. Types: feat, fix, docs, refactor, test, chore
3. Keep first line under 72 characters
4. Add body for complex changes

Example:
feat(auth): add JWT token validation

- Implement token expiration check
- Add refresh token logic
```

**How Claude Discovers** : Quand vous donnez une tâche à Claude, il review les descriptions de skills disponibles. Si une description match le task context, Claude charge les instructions complètes et les applique. **Transparent - pas d'invocation explicite**.

**Where to Put** :
- `~/.claude/skills/` — Personal, all projects
- `.claude/skills/` — Project-specific
- Inside plugins — Distributable

**Ressource Officielle** : [Anthropic Skills Repository](https://github.com/anthropics/skills)

**💪 ADVANCED : obra/superpowers Library**

```
╔═══════════════════════════════════════════════════════════╗
║              OBRA/SUPERPOWERS PHILOSOPHY                  ║
╚═══════════════════════════════════════════════════════════╝

RIGOROUS, SPEC-DRIVEN DEVELOPMENT

┌─────────────────────────────────────────────────────────┐
│ TDD Workflows                                           │
│ ├─> RED-GREEN-REFACTOR enforcement                     │
│ ├─> Test before implementation                         │
│ └─> Verification with evidence                         │
└─────────────────────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────────────────────┐
│ Systematic Debugging                                    │
│ ├─> Four phases: Reproduce → Isolate → Fix → Verify   │
│ └─> No shortcuts                                       │
└─────────────────────────────────────────────────────────┘
              ↓
┌─────────────────────────────────────────────────────────┐
│ Code Review Processes                                   │
│ ├─> Automated quality gates                            │
│ └─> Block completion without proof                     │
└─────────────────────────────────────────────────────────┘
```

**What It Provides** :
- TDD workflows (RED-GREEN-REFACTOR)
- Systematic debugging (4 phases)
- Code review processes
- Git worktree management
- Brainstorming frameworks

**Philosophy** : Test before implementation. Verify with evidence. Debug systematically. Plan before coding. **No shortcuts.**

**Use When** : You want Claude to be more disciplined about development practices, especially for production code.

**Ressource** : [obra/superpowers](https://github.com/obra/superpowers)

---

## 🔀 Skills vs CLAUDE.md Comparison

```
╔═══════════════════════════════════════════════════════════╗
║           SKILLS VS CLAUDE.MD COMPARISON                  ║
╚═══════════════════════════════════════════════════════════╝

CLAUDE.md (Monolithic Memory)
┌─────────────────────────────────────────────────────────┐
│ Project Overview                                        │
│ Development Commands                                    │
│ Coding Standards                                        │
│ Architecture Patterns                                   │
│ Framework Guidelines                                    │
│ Testing Approach                                        │
│ ... (6,000+ words loaded EVERY time)                   │
└─────────────────────────────────────────────────────────┘
     ↓
  ⚠️ Context Window Always Full
  ⚠️ No Conditional Loading
  ⚠️ Hard to Maintain at Scale

SKILLS (Modular Chunks)
┌───────────────┐  ┌───────────────┐  ┌───────────────┐
│ Vue Patterns  │  │ Test Strategy │  │ Git Workflow  │
│ (500 words)   │  │ (600 words)   │  │ (400 words)   │
│ ✅ Loaded only│  │ ✅ Loaded only│  │ ✅ Loaded only│
│ when relevant │  │ when testing  │  │ when git task │
└───────────────┘  └───────────────┘  └───────────────┘
     ↓
  ✅ Context Window Efficient (Progressive Disclosure)
  ✅ Conditional Loading (Task-Driven)
  ✅ Easy to Maintain (Modular)
```

**Key Insight** : Think of skills as modular chunks of a CLAUDE.md file. Instead of Claude reviewing a massive document every time, skills let Claude access specific expertise **only when needed**.

**Trade-off** :
- **CLAUDE.md** : Always loaded, good for project-wide constants
- **Skills** : Loaded on-demand, better for specialized expertise

---

## 🤔 Skills vs Commands: The Gray Area

**Decision Guide** :

```
╔═══════════════════════════════════════════════════════════╗
║          SKILLS VS COMMANDS DECISION GUIDE                ║
╚═══════════════════════════════════════════════════════════╝

Example Use Case: Git Worktree Management

Option 1: SKILL
┌─────────────────────────────────────────────────────────┐
│ ✅ Make it a SKILL if:                                  │
│ You want Claude to AUTOMATICALLY consider git          │
│ worktrees whenever relevant to conversation.            │
│                                                         │
│ Behavior: Claude proactively suggests worktree usage   │
│ when discussing feature branches, parallel work, etc.  │
└─────────────────────────────────────────────────────────┘

Option 2: COMMAND
┌─────────────────────────────────────────────────────────┐
│ ✅ Make it a COMMAND if:                                │
│ You want EXPLICIT CONTROL over when worktree           │
│ logic runs (e.g., /create-worktree feature-branch).    │
│                                                         │
│ Behavior: Claude only uses worktree when you           │
│ explicitly trigger /create-worktree.                   │
└─────────────────────────────────────────────────────────┘
```

**Rule of Thumb** :
- **Automatic activation** → Skill
- **Manual control** → Command

**The overlap is REAL** — choose based on whether you prefer automatic activation or manual control.

---

## 🔄 Putting It All Together

### Real-World Example: Task-Based Development Workflow

```
╔═══════════════════════════════════════════════════════════╗
║         TASK-BASED MULTI-CHAT WORKFLOW                    ║
╚═══════════════════════════════════════════════════════════╝

SETUP PHASE
┌─────────────────────────────────────────────────────────┐
│ CLAUDE.md: Implementation standards                    │
│ ├─> "Don't commit until I approve"                     │
│ └─> "Write tests first"                                │
│                                                         │
│ /load-context: Initialize new chats with project state│
│                                                         │
│ update-documentation skill: Auto-activates after impl  │
│                                                         │
│ Hook: PostToolUse → Trigger linting after edits       │
└─────────────────────────────────────────────────────────┘

PLANNING PHASE (Chat 1 - Main Context)
┌─────────────────────────────────────────────────────────┐
│ Main Agent:                                             │
│ 1. Analyze bug report / feature request                │
│ 2. Plan approach                                        │
│ 3. Output detailed task file with strategy             │
│ 4. Keep context clean (no implementation details)      │
└─────────────────────────────────────────────────────────┘
              ↓
         Save plan.md

IMPLEMENTATION PHASE (Chat 2 - Fresh Context)
┌─────────────────────────────────────────────────────────┐
│ Fresh Context:                                          │
│ 1. /load-context (restore project state)               │
│ 2. Load plan.md from Chat 1                            │
│ 3. Implementation subagent executes plan               │
│ 4. update-documentation skill auto-activates           │
│ 5. Hooks enforce linting on edits                      │
│ 6. /resolve-task marks completion                      │
└─────────────────────────────────────────────────────────┘

WHY THIS WORKS:
✅ Main context stays focused on planning
✅ Heavy implementation in isolated context (no poisoning)
✅ Skills handle documentation automatically
✅ Hooks enforce quality standards
✅ No context pollution between phases
```

**Pattern Benefits** :
1. **Separation of Concerns** : Planning vs Implementation
2. **Context Efficiency** : Fresh context for heavy work
3. **Automatic Behaviors** : Skills + Hooks enforce quality
4. **Auditability** : Each chat has clear purpose

---

## 📊 Decision Guide: Choosing the Right Tool

### Feature Comparison Table

```
╔═══════════════════════════════════════════════════════════╗
║              FEATURE COMPARISON MATRIX                    ║
╚═══════════════════════════════════════════════════════════╝
```

| Category | Skill | MCP | Subagent | Slash Command |
|----------|-------|-----|----------|---------------|
| **Triggered By** | Agent | Both | Both | Engineer |
| **Context Efficiency** | High | Low | High | High |
| **Context Persistence** | ✅ | ✅ | ✅ | ✅ |
| **Parallelizable** | ❌ | ❌ | ✅ | ❌ |
| **Specializable** | ✅ | ✅ | ✅ | ✅ |
| **Sharable** | ✅ | ✅ | ✅ | ✅ |
| **Modularity** | High | High | Mid | Mid |
| **Tool Permissions** | ✅ | ❌ | ✅ | ✅ |
| **Can Use Prompts** | ✅ | ✅ | ✅ | ✅ |
| **Can Use Skills** | ✅ | Kind of | ✅ | ✅ |
| **Can Use MCP Servers** | ✅ | ✅ | ✅ | ✅ |
| **Can Use Subagents** | ✅ | ✅ | ✅ | ❌ |

**Source** : Adapté de [IndyDevDan's video "I finally CRACKED Claude Agent Skills"](https://www.youtube.com/watch?v=kFpLzCVLA20&t=1027s)

---

### Real-World Use Cases

| Use Case | Best Tool | Why |
|----------|-----------|-----|
| "Always use Pinia for state management" | `CLAUDE.md` | Persistent context, all conversations |
| Generate standardized commit messages | Slash Command | Explicit action, triggered when ready |
| Check Jira + security analysis simultaneously | Subagents | Parallel execution, isolated contexts |
| Run linter after every file edit | Hook | Automatic reaction to lifecycle event |
| Share team's Vue testing patterns | Plugin | Distributable package (commands + skills) |
| Query PostgreSQL for reports | MCP | External system integration |
| Detect style violations during edits | Skill | Automatic behavior, task-driven |
| Create React components from templates | Slash Command | Manual workflow, repeatable structure |
| "Never use `any` type in TypeScript" | Hook | Automatic enforcement after changes |
| Auto-format code on save | Hook | Event-driven automation |
| Connect to GitHub for issue management | MCP | External API integration |
| Run comprehensive test suite in parallel | Subagent | Isolated, resource-intensive work |
| Deploy to staging environment | Slash Command | Manual trigger with safeguards |
| Enforce TDD workflow automatically | Skill | Context-aware automatic behavior |
| Initialize projects with team standards | Plugin | Shareable, complete configuration |

---

## 🎓 Points Clés à Retenir

### Architecture Layers

```
✅ LAYER 1: MCP (Foundation)
   - Universal protocol for external connections
   - GitHub, databases, APIs, tools
   - Context window consumption monitoring required

✅ LAYER 2: Core Features (Building Blocks)
   - CLAUDE.md: Hierarchical project memory
   - Slash Commands: Explicit workflows on demand
   - Subagents: Specialized AI, parallel execution
   - Hooks: Event-driven automation

✅ LAYER 3: Plugins (Distribution)
   - Bundle Commands + Hooks + Skills
   - Shareable team configurations
   - Seamless component merging

✅ LAYER 4: Skills (Automatic Behaviors)
   - Auto-invoked based on task context
   - Progressive disclosure (context efficiency)
   - Modular expertise chunks
```

### New Concepts Introduced

```
✅ CONTEXT POISONING
   - Definition: Detailed work clutters main conversation
   - Solution: Use subagents for isolated deep dives
   - Benefit: Keep main context clean and focused

✅ SKILLS VS CLAUDE.MD
   - CLAUDE.md: Monolithic, always loaded
   - Skills: Modular, loaded on-demand
   - Trade-off: Persistent vs Conditional loading

✅ GRAY AREA (Skills vs Commands)
   - Same functionality, different triggers
   - Skill: Automatic activation when relevant
   - Command: Manual control when you decide
   - Choose based on preference: auto vs explicit
```

### Triggering Mechanisms

```
✅ AUTOMATIC TRIGGERING:
   - Skills: Based on description matching
   - Subagents: When Claude determines relevance
   - Hooks: On lifecycle events

✅ MANUAL TRIGGERING:
   - Slash Commands: /command-name [args]
   - MCP Tools: /mcp__server__tool [args]

✅ PERSISTENT LOADING:
   - CLAUDE.md: Loaded at startup, always available
```

---

## 🔗 Ressources Connexes

**Documentation Officielle** :
- 📄 [Anthropic Skills Repository](https://github.com/anthropics/skills)
- 📄 [Model Context Protocol](https://modelcontextprotocol.io/)

**Ressources Communauté** :
- 📄 [alexop.dev/prompts/claude/](https://alexop.dev/prompts/claude/) - 8 templates création (skills, commands, agents, hooks, plugins)
- 📄 [obra/superpowers](https://github.com/obra/superpowers) - Comprehensive skills library (TDD, debugging, collaboration)
- 📄 [alexanderop/claude-code-builder](https://github.com/alexanderop/claude-code-builder) - Plugin avec 7 slash commands

**Articles Connexes** :
- 📄 [What Is MCP?](https://alexop.dev/posts/what-is-model-context-protocol-mcp/)
- 📄 [Building My First Claude Code Plugin](https://alexop.dev/posts/building-my-first-claude-code-plugin/)
- 📄 [XML-Tagged Prompts Framework](https://alexop.dev/posts/xml-tagged-prompts-framework-reliable-ai-responses/)

**Quick Reference** :
- 📄 [Awesome Claude Code Cheat Sheet](https://awesomeclaude.ai/code-cheatsheet)

---

## 💡 Citation Clé

> "Skills are like modular chunks of a CLAUDE.md file. Instead of Claude reviewing a massive document every time, skills let Claude access specific expertise only when needed."
>
> — Alexander Opalic (alexop.dev)

---

**Tags** : `#claude-code` `#architecture` `#mcp` `#skills` `#subagents` `#commands` `#hooks` `#plugins` `#context-poisoning` `#orchestration`
