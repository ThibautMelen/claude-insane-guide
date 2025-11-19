# Core 4 & Fundamentals - La Base de Tout

> **La fondation absolue de Claude Code** - Sans ça, vous êtes perdu
>
> **Source** : [Dan - Skills vs Commands vs Sub-Agents vs MCP](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md)

---

## 🎯 Pourquoi Ce Guide

**Message critique de Dan** :

> "The prompt is the fundamental unit of knowledge work and programming. If you don't know how to build and manage prompts, you will lose."

Ce guide explique les **4 éléments fondamentaux** de TOUT agent coding et **pourquoi le prompt (slash command) est la primitive absolue** que vous DEVEZ maîtriser avant tout.

**Sans comprendre ça** : ❌ Over-engineering, ❌ Confusion features, ❌ Perdu dans l'écosystème

**Avec ce guide** : ✅ Fondations solides, ✅ TOUT = prompts, ✅ Progression claire

---

## 📐 The Core 4 : Foundation of All Agents

### Définition

**The Core 4** = Les 4 éléments fondamentaux présents dans TOUT agent coding :

```
╔═══════════════════════════════════════════════════════╗
║              THE CORE 4 ELEMENTS                      ║
╚═══════════════════════════════════════════════════════╝

1️⃣ CONTEXT    : Ce que l'agent sait
   ├─ CLAUDE.md (Memory)
   ├─ Conversation history
   ├─ Codebase files
   ├─ Skills resources
   └─ MCP data sources

2️⃣ MODEL      : Quel LLM utiliser
   ├─ Haiku   : Fast & Cheap
   ├─ Sonnet  : Balanced (default)
   └─ Opus    : Powerful & Expensive

3️⃣ PROMPT ⭐   : Instructions (THE PRIMITIVE)
   ├─ Slash Commands    : /commit, /epct
   ├─ Agent prompts     : .claude/agents/*.md
   ├─ Skill prompts     : .claude/skills/*/SKILL.md
   └─ Inline prompts    : Direct conversation

**📚 Règles d'Or Application** :
- [Orchestration Principles](../../agentic-workflow/orchestration-principles.md) - Anthropic official rules

4️⃣ TOOLS      : Ce que l'agent peut faire
   ├─ Built-in : Read, Write, Edit, Bash, Grep
   ├─ Task     : Launch sub-agents
   ├─ MCP      : External integrations
   └─ Custom   : Your own via MCP

🎯 Master The Core 4 → Master ALL Features
```

**Pourquoi c'est critique** :
- Skill confused? → Break down to Core 4
- MCP not working? → Check Context + Tools
- Agent hallucinating? → Verify Prompt + Context
- Choosing feature? → Analyze which Core 4 element changes

---

## 🔥 The Prompt is the Fundamental Unit

### L'Équation Fondamentale

```
╔═══════════════════════════════════════════════════════╗
║         EVERYTHING = PROMPTS (Equation)               ║
╚═══════════════════════════════════════════════════════╝

Skill    = Prompts + Composition
MCP      = Prompts + External Data
Agent    = Prompts + Isolated Context
Command  = Prompts (pure, THE PRIMITIVE)

DONC → EVERYTHING = Prompts (Tokens IN → LLM → Tokens OUT)

🎯 Master prompts = Débloquer TOUT
```

**Dan's Warning** :

> "If you avoid understanding how to write great prompts, you will not progress as an agentic engineer in 2025, 2026 and beyond."

**Start Simple, Compose Later** :

```
Problem → /command (simple prompt) → Test → Works?
  ↓ YES
Repeat? NO → Done (keep /command)
  ↓ YES
Auto-invoke? NO → Done (keep /command)
  ↓ YES
Compose to Skill (ONLY if needed)
```

**Golden Rule** : ALWAYS start with `/command`, validate, THEN compose IF needed. NEVER skip.

---

## 📊 Tableau Comparatif Complet

> **Source** : Dan's video screenshot (12:00:20)

| Feature | Triggered By | Context Efficiency | Parallelizable | Role |
|---------|-------------|-------------------|----------------|------|
| **💬 /command** | 👤 **Engineer** | 🟢 High | ❌ No | **THE PRIMITIVE** |
| **🤖 Skill** | 🤖 **Agent** | 🟢 High (Progressive) | ❌ No | **Knowledge + Composition** |
| **🔌 MCP** | 🔀 **Both** | 🔴 Low (explosion) | ❌ No | **External Data** |
| **🧑‍💼 Sub-Agent** | 🔀 **Both** | 🟢 High | ✅ **YES** | **Parallel Executor** |
| **🎣 Hook** | 🤖 **Auto** | 🟢 High | ❌ No | **Validator** |
| **🔌 Plugin** | 🔀 **Both** | 🟢 High | ❌ No | **Distribution** |

### Key Insights

```
╔═══════════════════════════════════════════════════════╗
║           INSIGHTS DU TABLEAU                         ║
╚═══════════════════════════════════════════════════════╝

1️⃣ TRIGGERED BY = LA DISTINCTION CLÉ
   ├─ 👤 Manual (Command)  : YOU decide WHEN
   ├─ 🤖 Auto (Skill, Hook): AGENT decides WHEN
   └─ 🔀 Both (MCP, Agent) : Context dependent

2️⃣ CONTEXT EFFICIENCY
   ├─ MCP    : 🔴 LOW (loads 50K+ tokens upfront)
   └─ Others : 🟢 HIGH (progressive disclosure)

3️⃣ PARALLELIZABLE
   └─ Sub-Agent : ONLY ONE parallelizable (concurrent tasks)

4️⃣ COMPOSITION
   └─ ALL can use Prompts/Skills/MCP/Agents
```

---

## 🏗️ Composition Hierarchy

### La Hiérarchie Complète

```
╔═══════════════════════════════════════════════════════╗
║           COMPOSITION HIERARCHY                       ║
╚═══════════════════════════════════════════════════════╝

🏆 SKILLS (TOP LEVEL)
   ├─> Can use MCP Servers
   ├─> Can use Sub-Agents
   ├─> Can use Slash Commands
   └─> Can use Other Skills

🔌 MCP SERVERS
   └─> Can use Slash Commands

🤖 SUB-AGENTS
   └─> Can use Slash Commands

⚡ SLASH COMMANDS (THE PRIMITIVE)
   └─> Base de tout, tous l'utilisent

🎯 Skills NE REMPLACE PAS ces features
   Skills LES COMPOSE ensemble
```

**Principe** : Skills = Couche de composition qui orchestre tous les autres features.

---

## 🎯 Agent-First vs Manual Trigger

### La Distinction Critique

```
╔═══════════════════════════════════════════════════════╗
║         AUTOMATIC vs MANUAL (Decision)                ║
╚═══════════════════════════════════════════════════════╝

🤖 SKILL (Agent-First)
   ├─ Agent decides WHEN
   ├─ "Set it and forget it"
   ├─ Context-driven
   └─ Example: PDF extraction auto on "PDF"

👤 COMMAND (Manual)
   ├─ YOU decide WHEN
   ├─ Explicit control
   ├─ Human decision
   └─ Example: /commit (you decide when)
```

### Decision Framework

```
Question 1: Repeat workflow?
├─ NO  → /command (one-off)
└─ YES → Continue Q2

Question 2: Want AUTOMATIC trigger?
├─ NO  → /command (manual control)
└─ YES → Skill (agent-first)

Question 3: Need external data?
└─ YES → Skill + MCP

Special Cases:
├─ Parallel? → Sub-Agents
├─ Events?   → Hooks
└─ Distribute? → Plugins
```

---

## 📚 Skills: Knowledge Base + Composition

### Double Rôle des Skills

**Skills = BOTH** knowledge base ET composition layer :

```
╔═══════════════════════════════════════════════════════╗
║         SKILLS DUAL ROLE                              ║
╚═══════════════════════════════════════════════════════╝

📚 KNOWLEDGE BASE (Like extended CLAUDE.md)
   ├─ Skeleton.md (structure templates)
   ├─ Sources.yaml (data source mapping)
   ├─ Best-practices.md (guidelines)
   ├─ Validation-rules.md (quality checks)
   └─ Examples/ (reference files)

🏗️ COMPOSITION LAYER (Orchestrates features)
   ├─ Uses /commands
   ├─ Uses MCP servers
   ├─ Uses Sub-Agents
   └─ Uses Other Skills

EXAMPLE: locale-technical-knowledge
├─ Knowledge: ISO codes, formats, standards
└─ Composition: /generate-locale + Context7 MCP + agents
```

**Résultat** : Skill = Knowledge Repository + Workflow Orchestrator

---

## 📈 Progressive Disclosure

### Skills vs MCP : Context Window

```
╔═══════════════════════════════════════════════════════╗
║     PROGRESSIVE DISCLOSURE = HUGE ADVANTAGE           ║
╚═══════════════════════════════════════════════════════╝

🔌 MCP SERVERS (Context Explosion)
├─ Load ALL tools at startup
├─ Load ALL schemas upfront
├─ 🔥 50K+ tokens immediately
├─ Can have 2-3 MCP max
└─ ❌ Context explosion risk

🏆 SKILLS (Progressive Disclosure)
├─ Level 1: Metadata (~100 tokens)
├─ Level 2: SKILL.md IF triggered (~2K tokens)
├─ Level 3: Resources IF needed (~5K tokens)
├─ Can have 10+ skills
└─ ✅ 100x less context than MCP

🎯 Use Skills for shared knowledge (efficient)
   Use MCP with Skills for external data (progressive)
```

---

## 🎯 Dan's Golden Rule

### Start Simple → Compose Later

```
╔═══════════════════════════════════════════════════════╗
║         DAN'S GOLDEN RULE (5 Steps)                   ║
╚═══════════════════════════════════════════════════════╝

1. Start with /command (simple prompt)
   └─> Don't create Skill immediately

2. Test & Validate
   └─> Run, check, iterate until perfect

3. Works?
   ├─ NO  → Go back to step 1
   └─ YES → Continue

4. Repeat Workflow?
   ├─ NO  → Keep as /command (DONE!)
   └─ YES → Continue

5. Compose to Skill
   └─> NOW create Skill (validated workflow)

❌ BAD: Create Skill directly (complexity too early)
✅ GOOD: Start /command → Validate → Compose IF needed

🎯 "Don't give away the prompt" - Dan
```

---

## 🧭 When to Use What: Quick Reference

| Use Case | Feature | Why |
|----------|---------|-----|
| **One-off task** | `/command` | Explicit control, simple |
| **Repeat (manual)** | `/command` | You decide when |
| **Repeat (auto)** | `Skill` | Agent decides when |
| **Domain knowledge** | `Skill` | Knowledge base + auto |
| **External data** | `MCP` | Live integrations |
| **Parallel tasks** | `Sub-Agent` | Isolated contexts |
| **Compose commands** | `Skill` | Orchestration layer |
| **Auto-react events** | `Hooks` | Lifecycle triggers |
| **Distribute** | `Plugins` | Package & share |

---

## 🎓 Key Takeaways

```
╔═══════════════════════════════════════════════════════╗
║              KEY TAKEAWAYS (MEMORIZE)                 ║
╚═══════════════════════════════════════════════════════╝

1️⃣ The Core 4 = Context + Model + Prompt + Tools
   └─> Master these = Master everything

2️⃣ Prompt is THE PRIMITIVE
   └─> Everything reduces to prompts (tokens in/out)

3️⃣ Skills > MCP > Sub-Agents > Commands (Hierarchy)
   └─> Skills COMPOSE, don't replace

4️⃣ Agent-First (Skill) vs Manual (Command)
   └─> THE key distinction (auto vs manual)

5️⃣ Start /command → Validate → Compose to Skill
   └─> Golden Rule, NEVER skip steps
```

### What to Do Next

**1. Master Commands First** :
- Read [Commands Guide](../2-commands/guide.md)
- Practice writing simple /commands
- Iterate until prompts are perfect

**2. Understand When to Use What** :
- Read [Decision Trees](./decision-trees.md)
- Practice decision framework (Q1, Q2, Q3)
- Ask: Auto or Manual? Repeat or One-off?

**3. Then Learn Composition** :
- Read [Skills Guide](../4-skills/guide.md)
- Learn how Skills compose commands
- Practice: /command → Skill migration

**4. Never Forget** :
- Prompt = THE PRIMITIVE
- Everything else = wrapper around prompts
- Master prompts = Master Claude Code

---

## 📚 Ressources

### Documentation Officielle
- [Claude Code Docs](https://code.claude.com/docs)
- [Skills Documentation](https://docs.claude.com/en/docs/claude-code/skills)
- [Slash Commands](https://code.claude.com/docs/slash-commands)

### Vidéos Essentielles
- [Dan - Skills vs Commands vs Sub-Agents vs MCP](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) ⭐ **THE REFERENCE**
- [Formation Claude Code 2.0 - Melvynx](../../ressources/videos/formation-claude-code-2-0-melvynx.md)
- [800h Claude Code - Edmund Yong](../../ressources/videos/800h-claude-code-edmund-yong.md)

### Guides Internes
- [QUICK START](../../QUICK-START.md) ⭐ **Start here** (5 min)
- [Commands Guide](../2-commands/guide.md)
- [Skills Guide](../4-skills/guide.md)
- [Decision Trees](./decision-trees.md)
- [Pattern Command/Agent/Skill](../../workflow-pattern-orchestration/patterns/command-agent-skill.md)

---

**🎯 Next** : [Decision Trees - Framework Complet](./decision-trees.md)
