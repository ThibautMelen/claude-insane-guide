# 🎯 Decision Trees : Feature Selection Framework

> **Durée estimée** : 120 minutes
> **Niveau** : 🔴 Expert
> **Prérequis** : Connaissance de TOUS les thèmes (Memory, Commands, MCP, Hooks, Agents, Plugins, Skills)

## 📚 Introduction

Les decision trees permettent de **choisir la bonne feature Claude Code** pour chaque situation : Memory, Command, Hook, Skill, Agent, ou Plugin ?

**Problème résolu** :
- ❓ "Dois-je créer un command ou un plugin ?"
- ❓ "Quand utiliser Memory vs Command ?"
- ❓ "Hook vs Skill : quelle différence ?"
- ❓ "Agent ou sub-agent : lequel choisir ?"

---

## ⚡ CRITICAL: Framework de Décision Dan

> **"The prompt is the fundamental unit. Everything else is just a wrapper."**
> — Dan (Skills vs Commands vs Subagents vs MCP)

### 🎯 Pour Decision Trees: L'Essentiel

**Decision Trees = Framework 3 questions** pour choisir la bonne feature :

- **Q1: Répétitif?** → One-off = `/command` direct, Repeat = Continue Q2
- **Q2: Auto-invoke?** → NO = `/command` 👤, YES = `Skill` 🤖
- **Q3: External data?** → Add MCP si besoin, sinon Skill alone
- **+Parallel?** → Add Sub-Agents pour exécution parallèle
- **+Events?** → Add Hooks pour auto-trigger sur événements

**Quick Flow** :
```
Problem → /command (primitive) → Test → Works?
  ↓ YES
Repeat? NO → Done (keep /command)
  ↓ YES
Auto-invoke? NO → Done (keep /command)
  ↓ YES
Compose to Skill + Add MCP/Agents IF needed
```

### 📚 Framework Complet

**Voir [Core 4 & Fundamentals](core-4-fundamentals.md) pour** :
- 📊 Tableau comparatif Dan (toutes features)
- 🔥 Golden Rule workflow complet
- 📈 Progressive Disclosure (Skills vs MCP)
- 🏗️ Composition Hierarchy (comment features s'emboîtent)
- 🤖 vs 👤 Distinction détaillée

### 🔑 Spécificités Decision Trees

**Quand utiliser ce guide** :
- ✅ Choisir entre plusieurs features (Command vs Skill vs Hook)
- ✅ Architecturer workflow complexe (orchestration)
- ✅ Comprendre scopes (Personal, Project, Enterprise)
- ✅ Scenarios réels (avec anti-patterns)

**Les decision trees détaillés ci-dessous** :
1. 📋 Master Decision Tree (vue d'ensemble)
2. 1️⃣ Memory (conventions vs actions)
3. 2️⃣ Commands (workflows vs preferences)
4. 3️⃣ Hooks (manual vs auto-trigger)
5. 4️⃣ Skills (knowledge vs action)
6. 5️⃣ Plugins (distribute vs local)
7. 6️⃣ Agents (orchestrate vs execute)

**Progressivité recommandée** :
- Débutant : Master Tree + Quick Decision Framework (ligne 196)
- Intermédiaire : Decision trees 1-4 (Memory, Commands, Hooks, Skills)
- Avancé : Decision trees 5-6 + Scenarios + Anti-patterns

---

## 📐 Master Decision Tree

```
╔════════════════════════════════════════════╗
║      Claude Code Feature Selection         ║
╚════════════════════════════════════════════╝

START: What do you need?
    ↓
┌────────────────────────────────┐
│ Store preferences/conventions? │
└────────────────────────────────┘
    ↓
   YES → Use MEMORY (.claude/CLAUDE.md)
         Examples:
         - Code style (indent, quotes)
         - Commit message format
         - Tech stack preferences
         [See Decision Tree 1]
    ↓
    NO
    ↓
┌────────────────────────────────┐
│ Execute a workflow/task?       │
└────────────────────────────────┘
    ↓
   YES → ┌────────────────────────────────┐
         │ Is it REUSABLE across projects?│
         └────────────────────────────────┘
             ↓
            YES → Use COMMAND (/my-command)
                  Examples:
                  - /code-review
                  - /generate-locales
                  - /deploy
                  [See Decision Tree 2]
             ↓
            NO → Use direct Task (one-off)
    ↓
    NO
    ↓
┌────────────────────────────────┐
│ Automate reaction to event?    │
└────────────────────────────────┘
    ↓
   YES → Use HOOK (.claude/hooks/*.md)
         Examples:
         - before-commit (validate)
         - after-mcp-call (log)
         - subagent-stop (enrich)
         [See Decision Tree 3]
    ↓
    NO
    ↓
┌────────────────────────────────┐
│ Share knowledge/instructions?  │
└────────────────────────────────┘
    ↓
   YES → Use SKILL (.claude/skills/*.md)
         Examples:
         - @security-best-practices
         - @tech-stack-standards
         - @gdpr-compliance
         [See Decision Tree 4]
    ↓
    NO
    ↓
┌────────────────────────────────┐
│ Distribute workflow to others? │
└────────────────────────────────┘
    ↓
   YES → Use PLUGIN (package)
         Examples:
         - @fix-grammar (npm package)
         - @code-review-policy (company)
         [See Decision Tree 5]
    ↓
    NO
    ↓
┌────────────────────────────────┐
│ Parallel/delegated execution?  │
└────────────────────────────────┘
    ↓
   YES → Use AGENT (Task tool)
         Examples:
         - @fix-grammar agent
         - @generate-locale agent
         [See Decision Tree 6]
```

---

## 1️⃣ Decision Tree: Memory

```
╔════════════════════════════════════════════╗
║      When to Use MEMORY?                   ║
╚════════════════════════════════════════════╝

Question 1: What do you want to store?
    ↓
    ├─→ Preferences (code style, tools)
    │       ↓
    │   Use: USER Memory (~/.claude/CLAUDE.md)
    │   Scope: All your projects
    │   Examples:
    │   - Indent: 2 spaces
    │   - Commit format: conventional
    │   - Preferred tools: ESLint, Prettier
    │
    ├─→ Project-specific config
    │       ↓
    │   Use: PROJECT Memory (.claude/CLAUDE.md)
    │   Scope: Current project only
    │   Examples:
    │   - Tech stack: Next.js 14 + Supabase
    │   - API endpoints
    │   - Deployment config
    │
    └─→ Team/company standards
            ↓
        Use: ENTERPRISE Memory (workspace)
        Scope: Entire organization
        Examples:
        - Security policies
        - Approved MCP servers
        - Code review rules

Question 2: Is it a CONVENTION or ACTION?
    ↓
    ├─→ CONVENTION (how to do things)
    │       ↓
    │   Use: MEMORY ✅
    │   Examples:
    │   - "Always use TypeScript strict mode"
    │   - "Commit messages: <type>(<scope>): <msg>"
    │
    └─→ ACTION (execute task)
            ↓
        Use: COMMAND ❌ (not Memory)
        Examples:
        - "Run tests before commit" → /test-and-commit
        - "Generate docs" → /generate-docs
```

### Memory Quick Reference

| Use Case | Memory Type | Example |
|----------|------------|---------|
| **Personal preferences** | User | Indent style, commit format |
| **Project config** | Project | Tech stack, API endpoints |
| **Team standards** | Enterprise | Security policies, approved tools |
| **Conventions** | Memory ✅ | "How we do things" |
| **Actions** | Command ❌ | "Execute this workflow" |

---

## 2️⃣ Decision Tree: Commands

```
╔════════════════════════════════════════════╗
║      When to Use COMMAND?                  ║
╚════════════════════════════════════════════╝

Question 1: Is it a WORKFLOW or PREFERENCE?
    ↓
    ├─→ PREFERENCE (static config)
    │       ↓
    │   Use: MEMORY ❌
    │
    └─→ WORKFLOW (execute steps)
            ↓
        Continue...

Question 2: Is it REUSABLE across projects?
    ↓
    ├─→ NO (one-off task)
    │       ↓
    │   Use: Direct Task tool ❌
    │   Or just type instruction
    │
    └─→ YES (reusable)
            ↓
        Continue...

Question 3: Does it need USER INPUT?
    ↓
    ├─→ YES (arguments, options)
    │       ↓
    │   Use: COMMAND with args ✅
    │   Example: /generate-locales ar,de,fr
    │
    └─→ NO (always same)
            ↓
        ┌────────────────────────────────┐
        │ Does it AUTO-TRIGGER on event? │
        └────────────────────────────────┘
            ↓
            ├─→ YES → Use HOOK ❌
            │   Example: before-commit auto-runs
            │
            └─→ NO → Use COMMAND ✅
                Example: /code-review (manual)

Question 4: ORCHESTRATION or EXECUTION?
    ↓
    ├─→ ORCHESTRATION (coordinate agents)
    │       ↓
    │   Use: COMMAND ✅
    │   Example: /generate-locales
    │   - Validates args
    │   - Launches @generate-locale agents
    │   - Aggregates results
    │
    └─→ EXECUTION (do the work)
            ↓
        Use: AGENT (called by command) ❌
        Example: @generate-locale
        - Receives locale code
        - Fetches data
        - Generates file
```

### Command vs Other Features

| Feature | Command | Alternative |
|---------|---------|-------------|
| **Store conventions** | ❌ | Memory ✅ |
| **Auto-trigger on event** | ❌ | Hook ✅ |
| **Share knowledge** | ❌ | Skill ✅ |
| **Execute workflow** | ✅ | - |
| **Coordinate agents** | ✅ | - |
| **Take arguments** | ✅ | - |

---

## 3️⃣ Decision Tree: Hooks

```
╔════════════════════════════════════════════╗
║      When to Use HOOK?                     ║
╚════════════════════════════════════════════╝

Question 1: MANUAL or AUTO-TRIGGER?
    ↓
    ├─→ MANUAL (user runs it)
    │       ↓
    │   Use: COMMAND ❌
    │   Example: /code-review
    │
    └─→ AUTO-TRIGGER (on event)
            ↓
        Use: HOOK ✅
        Continue...

Question 2: Which EVENT to react to?
    ↓
    ├─→ before-commit
    │       ↓
    │   Use: .claude/hooks/before-commit.md
    │   Examples:
    │   - Scan for secrets
    │   - Validate commit message
    │   - Run tests
    │
    ├─→ before-mcp-call
    │       ↓
    │   Use: .claude/hooks/before-mcp-call.md
    │   Examples:
    │   - Check MCP whitelist
    │   - Detect PII
    │   - Log API request
    │
    ├─→ after-mcp-call
    │       ↓
    │   Use: .claude/hooks/after-mcp-call.md
    │   Examples:
    │   - Log response
    │   - Track API usage
    │   - Cache result
    │
    ├─→ subagent-stop
    │       ↓
    │   Use: .claude/hooks/subagent-stop.md
    │   Examples:
    │   - Validate agent output
    │   - Enrich metadata
    │   - Pass context to next agent
    │
    └─→ command-complete
            ↓
        Use: .claude/hooks/command-complete.md
        Examples:
        - Generate report
        - Archive logs
        - Notify admins

Question 3: VALIDATE or ENRICH?
    ↓
    ├─→ VALIDATE (block if fail)
    │       ↓
    │   Use: before-* hooks ✅
    │   Examples:
    │   - before-commit: Block if secrets found
    │   - before-mcp-call: Block if PII detected
    │
    └─→ ENRICH (add data)
            ↓
        Use: after-* or subagent-stop hooks ✅
        Examples:
        - subagent-stop: Add metadata
        - after-mcp-call: Cache result
```

### Hook vs Other Features

| Feature | Hook | Alternative |
|---------|------|-------------|
| **Manual trigger** | ❌ | Command ✅ |
| **Auto-trigger** | ✅ | - |
| **Validate/block** | ✅ | - |
| **Enrich data** | ✅ | - |
| **Share knowledge** | ❌ | Skill ✅ |

---

## 4️⃣ Decision Tree: Skills

```
╔════════════════════════════════════════════╗
║      When to Use SKILL?                    ║
╚════════════════════════════════════════════╝

Question 1: KNOWLEDGE or ACTION?
    ↓
    ├─→ ACTION (execute workflow)
    │       ↓
    │   Use: COMMAND ❌
    │
    └─→ KNOWLEDGE (instructions, context)
            ↓
        Use: SKILL ✅
        Continue...

Question 2: WHO needs this knowledge?
    ↓
    ├─→ Single agent/command
    │       ↓
    │   ┌────────────────────────────────┐
    │   │ Inline in command/agent ❓     │
    │   │ or Extract to skill? ❓        │
    │   └────────────────────────────────┘
    │       ↓
    │   IF >50 lines OR reused → Skill ✅
    │   ELSE → Inline ✅
    │
    └─→ Multiple agents/commands
            ↓
        Use: SKILL ✅
        Examples:
        - @security-best-practices
          Used by: @code-review, @deploy, @audit
        - @tech-stack-standards
          Used by: @setup-project, @onboard-dev

Question 3: STATIC or DYNAMIC?
    ↓
    ├─→ STATIC (never changes)
    │       ↓
    │   Use: SKILL ✅
    │   Examples:
    │   - OWASP Top 10 (security)
    │   - GDPR requirements
    │   - Company policies
    │
    └─→ DYNAMIC (varies by project)
            ↓
        Use: MEMORY ❌
        Examples:
        - Tech stack (changes per project)
        - API endpoints (project-specific)

Question 4: Scope of knowledge?
    ↓
    ├─→ UNIVERSAL (all projects)
    │       ↓
    │   Use: USER skill (~/.claude/skills/)
    │   Examples:
    │   - @git-best-practices
    │   - @security-fundamentals
    │
    ├─→ PROJECT-SPECIFIC
    │       ↓
    │   Use: PROJECT skill (.claude/skills/)
    │   Examples:
    │   - @api-documentation
    │   - @database-schema
    │
    └─→ TEAM/COMPANY
            ↓
        Use: ENTERPRISE skill (workspace)
        Examples:
        - @acme-security-policy
        - @team-conventions
```

### Skill vs Other Features

| Feature | Skill | Alternative |
|---------|-------|-------------|
| **Execute workflow** | ❌ | Command ✅ |
| **Store preferences** | ❌ | Memory ✅ |
| **Auto-trigger** | ❌ | Hook ✅ |
| **Share knowledge** | ✅ | - |
| **Reusable context** | ✅ | - |

---

## 5️⃣ Decision Tree: Plugins

```
╔════════════════════════════════════════════╗
║      When to Use PLUGIN?                   ║
╚════════════════════════════════════════════╝

Question 1: DISTRIBUTE or KEEP LOCAL?
    ↓
    ├─→ KEEP LOCAL (just me)
    │       ↓
    │   Use: COMMAND (.claude/commands/) ❌
    │
    └─→ DISTRIBUTE (share with others)
            ↓
        Use: PLUGIN ✅
        Continue...

Question 2: Distribution scope?
    ↓
    ├─→ PUBLIC (npm, GitHub)
    │       ↓
    │   Use: PUBLIC PLUGIN ✅
    │   Examples:
    │   - @fix-grammar (npm)
    │   - @code-review-toolkit (GitHub)
    │   Install: npm install -g @pkg/plugin
    │
    ├─→ COMPANY-WIDE (private)
    │       ↓
    │   Use: ENTERPRISE PLUGIN ✅
    │   Examples:
    │   - @acme-security-scanner
    │   - @compliance-checker
    │   Install: Symlink from workspace
    │
    └─→ TEAM (few people)
            ↓
        ┌────────────────────────────────┐
        │ Git repo sharing sufficient? ❓ │
        └────────────────────────────────┘
            ↓
           YES → Share commands via git ❌
           NO → Package as plugin ✅

Question 3: COMPLEX or SIMPLE?
    ↓
    ├─→ SIMPLE (1 command)
    │       ↓
    │   ┌────────────────────────────────┐
    │   │ Really need plugin packaging? ❓│
    │   └────────────────────────────────┘
    │       ↓
    │   Probably NO → Share command file ❌
    │
    └─→ COMPLEX (commands + skills + hooks)
            ↓
        Use: PLUGIN ✅
        Structure:
        - package.json (metadata)
        - commands/ (workflows)
        - skills/ (knowledge)
        - hooks/ (automation)
        - README.md (docs)

Question 4: DEPENDENCIES?
    ↓
    ├─→ NO DEPENDENCIES
    │       ↓
    │   Can be simple command sharing ❌
    │
    └─→ HAS DEPENDENCIES (npm, MCP servers)
            ↓
        Use: PLUGIN ✅
        Manage via package.json
```

### Plugin vs Other Features

| Feature | Plugin | Alternative |
|---------|--------|-------------|
| **Local use only** | ❌ | Command ✅ |
| **Distribute publicly** | ✅ | - |
| **Complex dependencies** | ✅ | - |
| **Version control** | ✅ | Git (commands) |
| **Multiple features bundled** | ✅ | Separate files ❌ |

---

## 6️⃣ Decision Tree: Agents (Sub-Agents)

```
╔════════════════════════════════════════════╗
║      When to Use AGENT?                    ║
╚════════════════════════════════════════════╝

Question 1: ORCHESTRATE or EXECUTE?
    ↓
    ├─→ ORCHESTRATE (coordinate)
    │       ↓
    │   Use: COMMAND ❌
    │   Example: /generate-locales
    │   - Validates args
    │   - Launches agents
    │   - Aggregates results
    │
    └─→ EXECUTE (do the work)
            ↓
        Use: AGENT ✅
        Example: @generate-locale
        Continue...

Question 2: PARALLEL or SEQUENTIAL?
    ↓
    ├─→ SEQUENTIAL (one after another)
    │       ↓
    │   ┌────────────────────────────────┐
    │   │ Really need separate agent? ❓  │
    │   └────────────────────────────────┘
    │       ↓
    │   Probably NO → Direct execution ❌
    │
    └─→ PARALLEL (simultaneous)
            ↓
        Use: AGENTS (Task tool) ✅
        Example: Fix 10 files in parallel

Question 3: ISOLATED or SHARED STATE?
    ↓
    ├─→ SHARED STATE (agents communicate)
    │       ↓
    │   ⚠️ COMPLEX → Avoid if possible
    │   Alternative: Pass via SubagentStop hook
    │
    └─→ ISOLATED (independent tasks)
            ↓
        Use: AGENTS ✅
        Perfect use case

Question 4: How to define agent?
    ↓
    ├─→ INLINE (one-time use)
    │       ↓
    │   Use: Task tool with prompt string
    │   Example:
    │   Task({
    │     task: 'Fix grammar in file.md',
    │     context: {...}
    │   })
    │
    ├─→ REUSABLE (many calls)
    │       ↓
    │   Use: SKILL as agent ✅
    │   Example: @generate-locale skill
    │   Called via: Task({ subagent_type: '@generate-locale' })
    │
    └─→ DISTRIBUTED (share with others)
            ↓
        Use: PLUGIN with agent ✅
        Example: @fix-grammar plugin
```

### Agent vs Other Features

| Feature | Agent | Alternative |
|---------|-------|-------------|
| **Orchestrate workflow** | ❌ | Command ✅ |
| **Execute in parallel** | ✅ | - |
| **Isolated tasks** | ✅ | - |
| **Sequential tasks** | ❌ | Direct execution ✅ |
| **Reusable** | ✅ | Skill (as agent) |

---

## 🎯 Scenario-Based Decision Guide

### Scenario 1: "I want to enforce code style"

```
Decision Flow:
1. CONVENTION or ACTION? → CONVENTION
2. Use: MEMORY ✅

Implementation:
.claude/CLAUDE.md:
## Code Style
- Indentation: 2 spaces
- Quotes: Single
- Line length: 100 chars
```

### Scenario 2: "I want to review PRs before merge"

```
Decision Flow:
1. WORKFLOW or PREFERENCE? → WORKFLOW
2. REUSABLE? → YES
3. AUTO-TRIGGER? → NO (manual)
4. Use: COMMAND ✅

Implementation:
.claude/commands/code-review.md:
- Validate changes
- Run security scan
- Generate report
```

### Scenario 3: "I want to block commits with secrets"

```
Decision Flow:
1. MANUAL or AUTO? → AUTO-TRIGGER
2. Event: before-commit
3. Use: HOOK ✅

Implementation:
.claude/hooks/before-commit.md:
- Scan for secret patterns
- Block if found
- Log to audit
```

### Scenario 4: "I want to share security best practices"

```
Decision Flow:
1. KNOWLEDGE or ACTION? → KNOWLEDGE
2. Multiple users? → YES
3. Static or dynamic? → STATIC
4. Use: SKILL ✅

Implementation:
.claude/skills/security-best-practices.md:
- OWASP Top 10
- Secure coding patterns
- Common vulnerabilities
```

### Scenario 5: "I want to distribute my workflow to team"

```
Decision Flow:
1. DISTRIBUTE? → YES (team)
2. COMPLEX? → YES (commands + skills + hooks)
3. Use: PLUGIN ✅

Implementation:
my-plugin/
├── package.json
├── commands/
├── skills/
├── hooks/
└── README.md
```

### Scenario 6: "I want to process 50 files in parallel"

```
Decision Flow:
1. ORCHESTRATE or EXECUTE? → Both
2. PARALLEL? → YES
3. Use: COMMAND (orchestrate) + AGENTS (execute) ✅

Implementation:
/fix-grammar (command):
- Validates files
- Launches @fix-grammar agents (parallel)
- Aggregates results

@fix-grammar (agent/skill):
- Receives file path
- Fixes grammar
- Returns result
```

---

## 🎯 Quick Reference Table

| Need | Feature | File Location | Example |
|------|---------|--------------|---------|
| **Store preferences** | Memory | `.claude/CLAUDE.md` | Indent style, commit format |
| **Execute workflow** | Command | `.claude/commands/*.md` | `/code-review`, `/deploy` |
| **Auto-trigger** | Hook | `.claude/hooks/*.md` | `before-commit.md` |
| **Share knowledge** | Skill | `.claude/skills/*.md` | `@security-best-practices` |
| **Distribute** | Plugin | `npm package` | `@fix-grammar` |
| **Parallel execution** | Agent | Skill or inline | `@generate-locale` |

---

## 🎯 Anti-Patterns (What NOT to Do)

### ❌ Anti-Pattern 1: Using Memory for Actions

```
BAD ❌:
.claude/CLAUDE.md:
## Deployment
- Run: npm run build
- Run: docker build
- Run: deploy to AWS

Why bad? Memory is for CONVENTIONS, not ACTIONS.

GOOD ✅:
Create command: /deploy
```

### ❌ Anti-Pattern 2: Using Command for Static Knowledge

```
BAD ❌:
.claude/commands/security-guide.md:
(Just documentation, no workflow)

Why bad? Commands are for WORKFLOWS, not knowledge.

GOOD ✅:
Create skill: @security-best-practices
```

### ❌ Anti-Pattern 3: Manual Hook Trigger

```
BAD ❌:
User runs: /before-commit

Why bad? Hooks are AUTO-TRIGGERED, not manual.

GOOD ✅:
Hook triggers automatically on git commit.
```

### ❌ Anti-Pattern 4: Plugin for Single Command

```
BAD ❌:
Create full plugin for one simple command.

Why bad? Over-engineering, use command file.

GOOD ✅:
Share command file via git, or inline in project.
```

### ❌ Anti-Pattern 5: Sequential Agents

```
BAD ❌:
Launch agent 1 → Wait → Launch agent 2 → Wait

Why bad? Agents are for PARALLEL, not sequential.

GOOD ✅:
Direct execution in command (no agents).
```

---

## 🎯 Feature Orchestration (Combining Multiple)

### Pattern 1: Command + Agents + Skill

```
Use Case: Generate 50 locale docs

COMMAND (/generate-locales):
- Orchestrates workflow
- Validates args
- Launches agents

AGENTS (@generate-locale):
- Execute in parallel
- Read from SKILL

SKILL (@locale-template):
- Shared knowledge
- Template structure
```

### Pattern 2: Hook + Skill + Memory

```
Use Case: Enforce security policies

HOOK (before-commit):
- Auto-triggers on commit
- Reads from SKILL

SKILL (@security-policy):
- Security patterns
- Validation rules

MEMORY (Enterprise):
- Company-specific overrides
```

### Pattern 3: Plugin + Commands + Hooks + Skills

```
Use Case: Distributed code review toolkit

PLUGIN (@code-review-toolkit):
- Bundles all components

COMMANDS:
- /code-review
- /security-audit

HOOKS:
- before-commit (validate)
- subagent-stop (enrich)

SKILLS:
- @owasp-top-10
- @code-quality-standards
```

---

## 🎓 Points Clés

### 🔥 Fondamentaux (Dan's Philosophy)

1. **Prompt = Primitive** : Tout se réduit à des prompts (tokens in/out)
2. **Command = Base** : Toujours commencer par /command, valider, PUIS composer vers Skill si besoin
3. **👤 vs 🤖 Trigger** : Manual (Commands) vs Auto (Skills, Hooks)
4. **Q1 → Q2 → Q3** : Répétitif? Auto? External data? → Détermine la feature
5. **Progressive Disclosure** : Skills chargent context progressivement (efficace), MCP dump tout (inefficace)
6. **Composition Hierarchy** : Skills (top) > MCP > Sub-Agents > Commands (primitive)
7. **Skills Dual Role** : Knowledge Base (comme CLAUDE.md étendu) + Composition Layer (orchestre features)

### 📋 Features Overview

1. **Memory** : Conventions, préférences (static config)
2. **Command** : Workflows, orchestration (execute tasks) - **THE PRIMITIVE**
3. **Hook** : Automation, réaction aux événements (auto-trigger)
4. **Skill** : Knowledge + Composition (auto-invoked, agent-first)
5. **Plugin** : Distribution, packaging (share with others)
6. **Agent** : Parallel execution, isolation (delegate work)
7. **MCP** : External data sources (APIs, DBs)
8. **Orchestration** : Combiner features pour workflows complexes

### 🎯 Decision Flow (Simple)

```
Problem → /command (primitive) → Test → Works?
  ↓ YES
Repeat? NO → Done (keep as /command)
  ↓ YES
Auto-invoke? NO → Done (keep as /command)
  ↓ YES
Compose to Skill → External data? → Add MCP if needed
```

---

## 📚 Ressources

### 🎯 COMMENCEZ ICI

⭐ **[Core 4 & Fundamentals](core-4-fundamentals.md)** - La base AVANT tout : Prompt = Primitive

### Documentation Interne

**Guides par Feature** :
- 📄 [Memory Guide](../1-memory/guide.md) - Conventions et préférences
- 📄 [Commands Guide](../2-commands/guide.md) - Le primitive (LISEZ EN PREMIER)
- 📄 [Hooks Guide](../3-hooks/guide.md) - Auto-trigger sur événements
- 📄 [Skills Guide](../4-skills/guide.md) - Knowledge Base + Composition
- 📄 [MCP Guide](../5-mcp/guide.md) - External data sources
- 📄 [Agents Guide](../6-agents/guide.md) - Parallel execution
- 📄 [Plugins Guide](../7-plugins/guide.md) - Distribution

**Patterns Avancés** :
- 📄 [Command/Agent/Skill Pattern](../../workflow-pattern-orchestration/patterns/command-agent-skill.md) - Orchestration complète
- 📄 [Core 4 & Fundamentals](core-4-fundamentals.md) - Framework Dan complet

### Documentation Externe

**Claude Code Official** :
- 📄 [Claude Code Docs](https://code.claude.com/docs) - Documentation officielle
- 📄 [Memory](https://code.claude.com/docs/memory) - CLAUDE.md usage
- 📄 [Commands](https://code.claude.com/docs/slash-commands) - Slash commands
- 📄 [Skills](https://code.claude.com/docs/skills) - Agent Skills
- 📄 [MCP](https://modelcontextprotocol.io/) - Model Context Protocol

**Vidéos & Ressources** :
- 🎥 [Dan - Skills vs Commands vs Subagents vs MCP](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) - **ANALYSE COMPLÈTE**
- 🎥 [NetworkChuck - Terminal AI](../../ressources/videos/networkchuck-terminal-ai.md) - Workflow terminal
- 🎥 [Edmund Yong - 800h Claude Code](../../ressources/videos/edmund-yong-800h-claude-code.md) - Best practices

### Repos Communauté

- 🔗 [Awesome Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Collection d'agents
- 🔗 [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Setup complet
- 🔗 [Weston Hobson Commands](https://github.com/wshobson/commands) - Commands collection

---

## 💡 Tips de Lecture

**Si vous êtes perdu** :

1. 📚 **Start** : [Core 4 & Fundamentals](core-4-fundamentals.md) - Comprendre la philosophie
2. 📊 **Framework** : Lisez la section "CRITICAL: Framework de Décision Dan" ci-dessus
3. 🎯 **Quick Decision** : Utilisez le tableau "Quick Decision Framework" (ligne 196)
4. 📖 **Deep Dive** : Parcourez les decision trees détaillés ci-dessous

**Le plus important** : TOUJOURS commencer par /command (primitive), tester, puis composer vers Skill QUE si besoin d'auto-invocation.
