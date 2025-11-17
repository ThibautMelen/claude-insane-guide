# Understanding Claude Code's Full Stack: MCP, Skills, Subagents, and Hooks Explained

**Source** : alexop.dev
**Auteur** : Alexander Opalic
**Date** : 9 novembre 2025
**URL** : https://alexop.dev/posts/understanding-claude-code-full-stack/
**Durée de lecture** : 15 minutes

---

## 🎯 Résumé Exécutif

Cet article présente **Claude Code comme un framework d'orchestration d'agents IA**, pas seulement un outil de codage. Alexander Opalic structure l'explication de façon hiérarchique : des fondations (MCP, Memory) aux capacités avancées (Skills, Hooks, Subagents, Plugins). Il démontre comment combiner ces composants pour créer des workflows automatisés puissants, avec un exemple concret de développement task-based. L'insight clé : Claude Code est un outil d'**automatisation informatique générale**, pas uniquement pour le code.

**Pertinence Claude Code** : Ce guide offre une vision complète du "full stack" Claude Code, permettant de comprendre comment chaque composant s'interconnecte et quand utiliser chacun. Essentiel pour maîtriser l'orchestration d'agents et éviter les pièges (context pollution, token overflow).

---

## 📋 Table des Matières

- [Concepts Clés](#-concepts-clés)
  - [1. MCP - Universal Adapter](#1-mcp---universal-adapter)
  - [2. Memory Hierarchy (CLAUDE.md)](#2-memory-hierarchy-claudemd)
  - [3. Architecture Full Stack](#3-architecture-full-stack)
  - [4. Context Management](#4-context-management)
  - [5. Decision Framework](#5-decision-framework)
- [Comparaison des Features](#-comparaison-des-features)
- [Workflow Task-Based](#-workflow-task-based)
- [Citations Marquantes](#-citations-marquantes)
- [Exemples Pratiques](#-exemples-pratiques)
- [Points d'Action](#-points-daction)
- [Ressources](#-ressources)

---

## 🎯 Concepts Clés

### 1. MCP - Universal Adapter

Le **Model Context Protocol** fonctionne comme un adaptateur universel connectant Claude à des systèmes externes.

**Principe** :
- Connecte Claude à : databases, APIs, GitHub, cloud platforms, outils tiers
- Installation via MCP servers dans config
- Accès via slash commands : `/mcp__playwright__create-test`
- ⚠️ **Coût en tokens** : chaque MCP server consomme du contexte

**Schéma** :
```
╔═══════════════════════════════════════════════════════════╗
║            MCP - UNIVERSAL ADAPTER ARCHITECTURE           ║
╚═══════════════════════════════════════════════════════════╝

                      CLAUDE CODE
                           │
                           │ MCP Protocol
                           ▼
        ┌──────────────────────────────────────┐
        │      MCP Servers (Adapters)          │
        └──────────────────────────────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  Databases   │  │     APIs     │  │    GitHub    │
│              │  │              │  │              │
│ • PostgreSQL │  │ • REST       │  │ • Issues     │
│ • MongoDB    │  │ • GraphQL    │  │ • PRs        │
│ • Redis      │  │ • WebSockets │  │ • Actions    │
└──────────────┘  └──────────────┘  └──────────────┘

        ▼                  ▼                  ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│Cloud Services│  │  Dev Tools   │  │  3rd Party   │
│              │  │              │  │              │
│ • AWS        │  │ • Playwright │  │ • Slack      │
│ • GCP        │  │ • Docker     │  │ • Jira       │
│ • Azure      │  │ • Git        │  │ • Notion     │
└──────────────┘  └──────────────┘  └──────────────┘

USAGE :
/mcp__playwright__create-test  ──> Playwright MCP
/mcp__github__create-issue     ──> GitHub MCP
/mcp__postgres__query          ──> Database MCP
```

**Avantages** :
- Connexion universelle : un protocole pour tout
- Extensibilité : nouveaux MCP servers ajoutables
- Standardisation : API cohérente pour tous les systèmes

**Limitations** :
- **Consommation de tokens** : chaque server charge du contexte
- Configuration initiale : nécessite setup dans config.json
- Dépendance externe : servers doivent être disponibles

**Cas d'usage** :
- Intégration database pour query/update
- Automation GitHub (issues, PRs, releases)
- Testing E2E avec Playwright
- Cloud deployment (AWS, GCP)

---

### 2. Memory Hierarchy (CLAUDE.md)

Les fichiers **CLAUDE.md** établissent un contexte permanent via un chargement hiérarchique.

**Principe** :
- 4 niveaux de mémoire chargés dans l'ordre
- Contenu : standards, patterns, commandes, conventions
- ❌ **Ne pas mettre** : documentation complète, code examples exhaustifs

**Schéma hiérarchie** :
```
╔═══════════════════════════════════════════════════════════╗
║              MEMORY HIERARCHY (CLAUDE.md)                 ║
╚═══════════════════════════════════════════════════════════╝

        NIVEAU 1 : ENTERPRISE
        ╔═══════════════════════╗
        ║  /enterprise/         ║  ◄─── Standards globaux
        ║  CLAUDE.md            ║       (toute l'entreprise)
        ╚═══════════════════════╝
                  │
                  ▼
        NIVEAU 2 : USER
        ┌───────────────────────┐
        │  ~/.claude/           │  ◄─── Préférences perso
        │  CLAUDE.md            │       (tous projets)
        └───────────────────────┘
                  │
                  ▼
        NIVEAU 3 : PROJECT
        ┌───────────────────────┐
        │  project-root/        │  ◄─── Config projet
        │  .claude/CLAUDE.md    │       (spécifique projet)
        └───────────────────────┘
                  │
                  ▼
        NIVEAU 4 : DIRECTORY
        ┌───────────────────────┐
        │  subdir/              │  ◄─── Context local
        │  .claude/CLAUDE.md    │       (sous-dossier)
        └───────────────────────┘

ORDRE DE CHARGEMENT :
1. Enterprise → 2. User → 3. Project → 4. Directory

PRINCIPE : Spécificité croissante
(Global) ──────────────────────> (Local)
```

**Que mettre dans CLAUDE.md** :
```markdown
✅ À INCLURE :
- Development commands (npm run, docker compose)
- Coding standards (ESLint, Prettier)
- Architecture patterns (MVC, Clean Architecture)
- Tech stack principal (Next.js, Supabase)
- Conventions naming (camelCase, PascalCase)
- Git workflow (branches, commits)

❌ À ÉVITER :
- Documentation complète API
- Tous les code examples
- Tutoriels step-by-step
- Contenu changeant fréquemment
```

**Avantages** :
- Context permanent : pas besoin de répéter
- Hiérarchie flexible : override possible à chaque niveau
- Team alignment : standards partagés

**Limitations** :
- Coût en tokens : chargé à chaque conversation
- Maintenance : nécessite updates réguliers

**Cas d'usage** :
- Onboarding : nouveaux devs connaissent standards
- Cohérence : même workflow pour toute l'équipe
- Automation : Claude connaît les commandes projet

---

### 3. Architecture Full Stack

Claude Code = **framework d'orchestration d'agents**, avec 7 composants interconnectés.

**Schéma complet** :
```
╔═══════════════════════════════════════════════════════════╗
║         CLAUDE CODE FULL STACK ARCHITECTURE               ║
╚═══════════════════════════════════════════════════════════╝

LAYER 1 : FOUNDATIONS (External Connections)
┌─────────────────────────────────────────────────────────┐
│                    MCP SERVERS                          │
│  Universal adapters pour systèmes externes              │
│  • Databases, APIs, GitHub, Cloud, Dev Tools            │
└─────────────────────────────────────────────────────────┘

LAYER 2 : MEMORY (Static Context)
┌─────────────────────────────────────────────────────────┐
│                   CLAUDE.md FILES                       │
│  Hiérarchie : Enterprise → User → Project → Directory   │
│  • Standards, patterns, conventions, commands           │
└─────────────────────────────────────────────────────────┘

LAYER 3 : MANUAL WORKFLOWS (User-Triggered)
┌─────────────────────────────────────────────────────────┐
│                 SLASH COMMANDS                          │
│  Workflows explicites déclenchés manuellement           │
│  • /commit, /review, /scaffold, /deploy                │
└─────────────────────────────────────────────────────────┘

LAYER 4 : AUTONOMOUS BEHAVIORS (Auto-Triggered)
┌──────────────────────┬──────────────────────────────────┐
│      SKILLS          │          HOOKS                   │
│  Context-aware auto  │  Event-driven automation         │
│  • Style enforcement │  • PreToolUse, PostToolUse       │
│  • Auto-docs         │  • UserPromptSubmit, SessionStart│
└──────────────────────┴──────────────────────────────────┘

LAYER 5 : PARALLEL EXECUTION (Isolated Context)
┌─────────────────────────────────────────────────────────┐
│                    SUBAGENTS                            │
│  Specialized AI personalities, isolated contexts        │
│  • Security auditor, Test writer, Refactor specialist  │
└─────────────────────────────────────────────────────────┘

LAYER 6 : DISTRIBUTION (Team Standardization)
┌─────────────────────────────────────────────────────────┐
│                     PLUGINS                             │
│  Bundled packages : commands + hooks + skills + meta    │
│  • Shared configs, Team standards, Best practices       │
└─────────────────────────────────────────────────────────┘

FLOW :
MCP → Memory → Commands → Skills/Hooks → Subagents → Plugins
(External) → (Context) → (Manual) → (Auto) → (Parallel) → (Shared)
```

**Ordre de construction** :
1. **MCP** : Connexions externes
2. **Memory** : Context permanent
3. **Commands** : Workflows manuels
4. **Skills/Hooks** : Behaviors automatiques
5. **Subagents** : Exécution parallèle
6. **Plugins** : Distribution team

**Citation clé** :
> "I'm going to explain the features in the order they build on each other—from external connections (MCP) through memory systems (CLAUDE.md) to increasingly autonomous behaviors."
> — Alexander Opalic

---

### 4. Context Management

La gestion du contexte est **critique** pour éviter le context pollution et le token overflow.

**Principe** :
- Chaque composant consomme des tokens
- Context pollution : mélanger des tâches non liées
- Solution : Subagents avec contexte isolé

**Schéma Context Pollution** :
```
╔═══════════════════════════════════════════════════════════╗
║              CONTEXT POLLUTION vs ISOLATION               ║
╚═══════════════════════════════════════════════════════════╝

PROBLÈME : CONTEXT POLLUTION
┌─────────────────────────────────────────────────────────┐
│          MAIN AGENT (Single Context)                    │
├─────────────────────────────────────────────────────────┤
│  Task A: Security audit                                 │
│    • Scanning 100+ files                                │
│    • Finding 50+ vulnerabilities                        │
│    • Generating detailed reports                        │
│                                                          │
│  Task B: Feature planning (POLLUTED!)                   │
│    • All security findings still in context             │
│    • Token window saturated                             │
│    • Claude confused by irrelevant info                 │
└─────────────────────────────────────────────────────────┘
        ❌ Context polluted, performance degraded


SOLUTION : SUBAGENT ISOLATION
┌─────────────────────────────────────────────────────────┐
│          MAIN AGENT (Clean Context)                     │
├─────────────────────────────────────────────────────────┤
│  Task B: Feature planning                               │
│    • Only planning-relevant info                        │
│    • Clear focus                                        │
│    • Fast responses                                     │
└─────────────────────────────────────────────────────────┘
                           │
                           │ Delegates
                           ▼
┌─────────────────────────────────────────────────────────┐
│       SUBAGENT (Isolated Context)                       │
├─────────────────────────────────────────────────────────┤
│  Task A: Security audit                                 │
│    • Dedicated context window                           │
│    • All findings isolated                              │
│    • Returns summary only to main agent                 │
└─────────────────────────────────────────────────────────┘
        ✅ Contexts isolated, optimal performance
```

**Best Practices** :
- Utiliser Subagents pour tâches volumineuses
- Limiter le nombre de MCP servers chargés
- Garder CLAUDE.md concis (standards, pas docs complètes)
- Nettoyer le contexte entre phases de travail

**Avantages isolation** :
- Performance : contexte ciblé, réponses rapides
- Focus : Claude non distrait par info non pertinente
- Parallélisme : plusieurs subagents simultanés

**Cas d'usage** :
- Security audit pendant feature planning
- Test generation isolée du refactoring
- Documentation update sans polluer debug context

---

### 5. Decision Framework

Quand utiliser chaque composant ? Framework de décision clair.

**Schéma de décision** :
```
╔═══════════════════════════════════════════════════════════╗
║              DECISION FRAMEWORK (When to Use)             ║
╚═══════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────┐
│  QUESTION : Type de connaissance ?                      │
└────────┬────────────────────────────────────────────────┘
         │
    Static knowledge                  Dynamic workflow
    (applies always)                  (specific action)
         │                                    │
         ▼                                    ▼
   ┌──────────┐                        ┌──────────┐
   │CLAUDE.md │                        │ COMMAND  │
   └──────────┘                        │ or SKILL │
                                       └──────────┘

┌─────────────────────────────────────────────────────────┐
│  QUESTION : Qui déclenche ?                             │
└────────┬────────────────────────────────────────────────┘
         │
    Manual trigger                     Automatic trigger
    (explicit)                         (context-aware)
         │                                    │
         ▼                                    ▼
   ┌──────────┐                        ┌──────────┐
   │ COMMAND  │                        │  SKILL   │
   └──────────┘                        │ or HOOK  │
                                       └──────────┘

┌─────────────────────────────────────────────────────────┐
│  QUESTION : Besoin d'isolation ?                        │
└────────┬────────────────────────────────────────────────┘
         │
    No isolation                       Isolated context
    (shared context)                   (prevent pollution)
         │                                    │
         ▼                                    ▼
   ┌──────────┐                        ┌──────────┐
   │ MAIN     │                        │SUBAGENT  │
   │ AGENT    │                        └──────────┘
   └──────────┘

┌─────────────────────────────────────────────────────────┐
│  QUESTION : Besoin système externe ?                    │
└────────┬────────────────────────────────────────────────┘
         │
    No external                        External system
    (files only)                       (DB, API, Cloud)
         │                                    │
         ▼                                    ▼
   ┌──────────┐                        ┌──────────┐
   │ Built-in │                        │   MCP    │
   │  Tools   │                        │  SERVER  │
   └──────────┘                        └──────────┘

┌─────────────────────────────────────────────────────────┐
│  QUESTION : Besoin standardisation team ?               │
└────────┬────────────────────────────────────────────────┘
         │
    Personal use                       Team sharing
    (local only)                       (distribute)
         │                                    │
         ▼                                    ▼
   ┌──────────┐                        ┌──────────┐
   │ .claude/ │                        │  PLUGIN  │
   │  local   │                        └──────────┘
   └──────────┘
```

**Résumé des usages** :

| Composant | Quand l'utiliser ? |
|-----------|-------------------|
| **CLAUDE.md** | Static knowledge : architecture, conventions, standards |
| **Commands** | Explicit workflows : code review, commit, scaffold |
| **Skills** | Automatic behaviors : style enforcement, auto-docs |
| **Hooks** | Event-driven automation : linting, validation, approval |
| **Subagents** | Parallel execution ou isolated work (prevent pollution) |
| **MCP** | External systems : databases, APIs, cloud platforms |
| **Plugins** | Team standardization : shared configs, best practices |

---

## 📊 Comparaison des Features

Tableau comparatif des composants (source : article) :

| Aspect | Skill | MCP | Subagent | Slash Command |
|--------|-------|-----|----------|---------------|
| **Triggered By** | Agent (auto) | Both | Both | Engineer (manual) |
| **Context Efficiency** | High | Low | High | High |
| **Parallelizable** | ❌ | ❌ | ✅ | ❌ |
| **Specializable** | ✅ | ✅ | ✅ | ✅ |
| **Tool Permissions** | ✅ | ❌ | ✅ | ✅ |

**Insights** :
- **Skills** : Haute efficacité contexte, auto-triggered
- **MCP** : Basse efficacité (coût tokens), mais connexions externes
- **Subagents** : Seul composant parallelizable ✅
- **Commands** : Contrôle manuel, haute efficacité

**Quand privilégier quoi** :
- **Auto-behaviors** : Skills > Hooks (si pas event-driven)
- **External systems** : MCP obligatoire
- **Parallel work** : Subagents uniquement
- **Manual control** : Commands > Skills

---

## 🔄 Workflow Task-Based

Exemple concret de workflow multi-phases avec isolation de contexte.

**Architecture du workflow** :
```
╔═══════════════════════════════════════════════════════════╗
║          TASK-BASED DEVELOPMENT WORKFLOW                  ║
╚═══════════════════════════════════════════════════════════╝

PHASE 1 : SETUP (Project Initialization)
┌─────────────────────────────────────────────────────────┐
│  • CLAUDE.md establishes standards                      │
│  • /load-context initializes chat                       │
│  • Skills auto-update documentation                     │
│  • Hooks enforce linting on save                        │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 2 : PLANNING (Architecture Design)
┌─────────────────────────────────────────────────────────┐
│  MAIN AGENT (Planning Context)                          │
│  • Design solution architecture                         │
│  • Break down into tasks                                │
│  • Output: detailed-task-file.md                        │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Context closed
                          ▼
PHASE 3 : IMPLEMENTATION (Fresh Context)
┌─────────────────────────────────────────────────────────┐
│  NEW CHAT (Clean Context)                               │
│  1. Load previous plan (detailed-task-file.md)          │
│  2. Launch SUBAGENT for execution                       │
│  3. SKILLS handle documentation automatically           │
│  4. HOOKS maintain quality (tests, linting)             │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Parallel execution
                          ▼
┌──────────────────────┬──────────────────────────────────┐
│   SUBAGENT 1         │       SUBAGENT 2                 │
│   (Feature A)        │       (Feature B)                │
│   Isolated context   │       Isolated context           │
└──────────────────────┴──────────────────────────────────┘
                          │
                          ▼
                   RESULTS MERGED
               (Context pollution avoided)
```

**Détails phases** :

**Phase 1 - Setup** :
- `CLAUDE.md` : Standards chargés (conventions, commands)
- `/load-context` : Command pour initialiser chat
- Skills actifs : documentation auto-update
- Hooks actifs : linting enforcement

**Phase 2 - Planning** :
- Main agent conçoit solution
- Design architecture
- Breakdown en tâches atomiques
- Output : `tasks/feature-x.md` (plan détaillé)
- **Context closed** après planning

**Phase 3 - Implementation** :
- **Fresh context** : nouvelle conversation
- Load plan précédent via Read
- Subagent lancé pour exécution
- Skills : handle docs automatiquement
- Hooks : maintain quality standards

**Avantages architecture** :
- ✅ Pas de context pollution (phases séparées)
- ✅ Focus optimal (contexte ciblé par phase)
- ✅ Automated quality (skills + hooks)
- ✅ Parallel execution (subagents indépendants)

**Cas d'usage** :
- Large features nécessitant planning détaillé
- Multiple tasks parallèles
- Maintien qualité automatique pendant dev

---

## 💬 Citations Marquantes

> "Claude Code is, with hindsight, poorly named. It's not purely a coding tool: it's a tool for general computer automation."
> — Simon Willison (cité par Alexander Opalic)

*Claude Code transcende le codage : automation informatique générale.*

---

> "I'm going to explain the features in the order they build on each other—from external connections (MCP) through memory systems (CLAUDE.md) to increasingly autonomous behaviors."
> — Alexander Opalic

*Approche pédagogique : comprendre les fondations avant les behaviors avancés.*

---

> "Context window management is critical—each MCP server consumes tokens."
> — Alexander Opalic

*Warning : MCP coûteux en tokens, choisir judicieusement les servers.*

---

> "Subagents enable parallel execution of independent tasks while preventing 'context poisoning'."
> — Alexander Opalic

*Subagents = solution au context pollution, permettant parallélisme.*

---

> "Agent Skills are particularly powerful for style enforcement, documentation updates, test coverage requirements, and framework pattern adherence."
> — Alexander Opalic

*Skills excellents pour automated quality enforcement.*

---

## 💻 Exemples Pratiques

### Exemple 1 : MCP Integration (Playwright)

**Problème** :
Besoin d'automatiser tests E2E avec Playwright.

**Solution** :

**1. Installer MCP Playwright** :
```json
// ~/.config/claude-code/config.json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-playwright"]
    }
  }
}
```

**2. Utiliser via Slash Command** :
```
/mcp__playwright__create-test

Prompt: "Create E2E test for login flow"
```

**3. Claude génère** :
```typescript
import { test, expect } from '@playwright/test';

test('login flow', async ({ page }) => {
  await page.goto('https://app.example.com/login');

  await page.fill('input[name="email"]', 'user@example.com');
  await page.fill('input[name="password"]', 'secure123');

  await page.click('button[type="submit"]');

  await expect(page).toHaveURL('https://app.example.com/dashboard');
});
```

**Explication** :
- MCP Playwright connecte Claude à l'API Playwright
- Slash command déclenche la génération
- Claude génère test adapté au context projet

---

### Exemple 2 : Memory Hierarchy (CLAUDE.md)

**Problème** :
Onboarding nouveaux devs : ils doivent connaître standards projet.

**Solution** :

**Structure hiérarchique** :

**User Level** (`~/.claude/CLAUDE.md`) :
```markdown
# Personal Preferences

**Coding Style** :
- TypeScript strict mode
- Single quotes
- 2 spaces indentation

**Git Workflow** :
- Conventional commits
- Always squash PRs
```

**Project Level** (`.claude/CLAUDE.md`) :
```markdown
# Project: E-Commerce Platform

**Tech Stack** :
- Next.js 14 (App Router)
- Supabase (Auth + Database)
- Tailwind CSS
- Vercel deployment

**Development Commands** :
- `npm run dev` : Start dev server
- `npm run test` : Run tests
- `npm run build` : Production build

**Architecture** :
- `/app` : Next.js pages
- `/components` : Reusable UI
- `/lib` : Utils and helpers
- `/supabase` : Database schema + migrations

**Conventions** :
- Components: PascalCase (`UserProfile.tsx`)
- Functions: camelCase (`getUserData`)
- API routes: kebab-case (`/api/user-profile`)
```

**Explication** :
- User level : préférences perso (partagées entre projets)
- Project level : config spécifique projet
- Claude charge automatiquement les deux
- Nouveaux devs ont immédiatement le context

---

### Exemple 3 : Subagent pour Security Audit

**Problème** :
Audit de sécurité volumeux polluant le context du main agent.

**Solution** :

**Main Agent** (planning) :
```markdown
User: "Plan new authentication feature and audit security"

Claude (Main Agent):
1. I'll design the authentication architecture
2. I'll launch a security subagent to audit existing code

Launching subagent...
```

**Subagent** (isolated context) :
```markdown
Task: Security audit of authentication layer

Files analyzed:
- lib/auth.ts
- api/auth/login.ts
- middleware/auth.ts

Findings:
1. ⚠️ Password hashing: using bcrypt (good)
2. ❌ Missing rate limiting on login endpoint
3. ❌ JWT tokens don't expire
4. ✅ HTTPS enforced
5. ⚠️ Session storage: localStorage (XSS vulnerable)

Recommendations:
- Add rate limiting: express-rate-limit
- Set JWT expiration: 1 hour
- Move tokens to httpOnly cookies
```

**Main Agent** (receives summary) :
```markdown
Subagent completed security audit.

Summary: 3 critical issues found
- Missing rate limiting
- No JWT expiration
- Insecure token storage

I'll now design the auth feature addressing these issues...
```

**Explication** :
- Subagent analyse 100+ files en isolation
- Main agent reçoit uniquement le summary
- Context du main agent reste clean pour planning
- Parallélisme : audit pendant design

---

## ✅ Points d'Action

### Immédiat (< 1h)

- [ ] Lire votre `~/.claude/CLAUDE.md` et identifier ce qui devrait être au project level
- [ ] Vérifier les MCP servers installés : `ls ~/.config/claude-code/config.json`
- [ ] Tester la commande `/load-context` pour initialiser un chat
- [ ] Créer un simple slash command pour une tâche récurrente

### Court terme (1-7 jours)

- [ ] Restructurer vos CLAUDE.md en hiérarchie (User → Project → Directory)
- [ ] Installer 1-2 MCP servers pertinents pour votre workflow (Playwright, GitHub, Database)
- [ ] Créer un skill pour automated documentation update
- [ ] Configurer un hook `PostToolUse` pour linting automatique
- [ ] Expérimenter avec un subagent pour une tâche volumineuse

### Long terme (> 1 semaine)

- [ ] Implémenter le workflow task-based complet (Setup → Planning → Implementation)
- [ ] Créer un plugin bundlant vos best practices team
- [ ] Optimiser votre token usage : auditer MCP servers, réduire CLAUDE.md
- [ ] Documenter votre architecture full stack Claude Code pour votre équipe
- [ ] Contribuer vos skills/commands à un repo communautaire

---

## 📚 Ressources

### Documentation Officielle
- 📄 [Claude Code Docs](https://code.claude.com/docs) - Guide officiel complet
- 📄 [MCP Documentation](https://modelcontextprotocol.io/) - Protocol specs
- 📄 [Skills Repository](https://github.com/anthropics/skills) - Official skills by Anthropic

### Articles Connexes
- 📄 [Skills Deep Dive](../../ressources/articles/skills-deep-dive-architecture-lee.md) - Architecture interne Skills
- 📄 [Memory Guide](../../themes/1-memory/guide.md) - CLAUDE.md best practices
- 📄 [Commands Guide](../../themes/2-commands/guide.md) - Slash commands creation
- 📄 [Hooks Guide](../../themes/3-hooks/guide.md) - Event-driven automation
- 📄 [MCP Guide](../../themes/7-mcp/guide.md) - Model Context Protocol

### Ressources Communauté
- 🔗 [Obra's Superpowers](https://github.com/obra/superpowers) - TDD-focused workflow skills
- 🔗 [Awesome Claude Code Cheat Sheet](https://github.com/VoltAgent/awesome-claude-code) - Community resources
- 🔗 [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Complete setup example

### Vidéos Recommandées
- 🎥 [IndyDevDan - Agent Skills](https://www.youtube.com/watch?v=xxx) - Skills tutorial
- 🎥 [NetworkChuck - Claude Code Workflow](https://www.youtube.com/watch?v=xxx) - Complete workflow

---

**Tags** : `#architecture` `#full-stack` `#orchestration` `#mcp` `#memory` `#skills` `#hooks` `#subagents` `#plugins` `#workflow` `#context-management` `#best-practices`

**Niveau** : 🟠 Avancé

**Temps de pratique estimé** : 3-4 heures (lecture + expérimentation)
