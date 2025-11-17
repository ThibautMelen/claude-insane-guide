# Memory - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs/memory

## 📚 Théorie

### Qu'est-ce que la Memory?

La **Memory** de Claude Code est un système de **persistance d'instructions** stockées dans un fichier `.claude/CLAUDE.md` (project) ou `~/.claude/CLAUDE.md` (global).

**Source**: Vidéo Edmund Yong ([00:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=38s))

---

### 🎯 Problème Résolu

**Avant Memory**:
```
Chaque session Claude:
├── "Utilise TypeScript strict"
├── "Suis Airbnb style guide"
├── "Toujours include error handling"
├── "Add JSDoc comments"
└── [Répéter à CHAQUE session] ❌
```

**Avec Memory**:
```
Une seule fois:
├── Add to Memory (#️⃣)
└── Sauvé dans .claude/CLAUDE.md
    ↓
Toutes sessions suivantes:
└── Instructions appliquées automatiquement ✅
```

---

### 🔧 Comment ça Marche

#### ⚡ Quick Start avec /init

```bash
# 🚀 Initialiser un nouveau projet
claude
/init

# → Crée automatiquement .claude/CLAUDE.md
# → Template pré-rempli avec structure de base
# → Prêt à personnaliser !
```

**💡 Tip** : `/init` crée le fichier CLAUDE.md initial. Ensuite, utilisez `/memory` pour l'éditer.

#### 🔄 Commande `/cloud-memory` (Melvynx - CCLI)

Pour **optimiser et réorganiser automatiquement** ton fichier CLAUDE.md :

```bash
/cloud-memory update

# Sélectionner : .claude/CLAUDE.md
# Prompt : "Regroupe les éléments qui ont un rapport ensemble afin d'avoir un meilleur fichier"

# → Claude analyse et restructure automatiquement
# → Regroupe par thématiques
# → Améliore la lisibilité
# → Élimine les redondances
```

**Utilité** :
- Maintenir la mémoire organisée à long terme
- Éviter l'accumulation de règles éparpillées
- Identifier règles contradictoires
- Optimiser la consommation de tokens

**Source** : [CCLI Blueprint](https://mlv.sh/ccli) - Pack de commandes Melvynx

#### ➕ Ajout Rapide

```bash
claude

# Dans le chat:
→ Presse #️⃣ (hash key)
→ "Always use TypeScript strict mode"
→ Choose scope:
   ├── Local (ce projet seulement)
   └── Global (tous projets)
→ Sauvegardé dans .claude/CLAUDE.md
```

#### 📁 Structure Fichier CLAUDE.md

**Emplacements**:

```
.claude/ (projet - NORME OFFICIELLE)
└── CLAUDE.md           # Memory locale

~/.claude/
└── CLAUDE.md           # Memory globale
```

**Exemple de contenu**:

```markdown
# Project Context

This is a Next.js 14 app using:
- TypeScript (strict mode)
- Tailwind CSS
- Supabase backend
- Vercel deployment

## Coding Preferences

- Use functional components (React)
- Include proper error handling with try/catch
- Add TypeScript interfaces for all data structures
- Follow Airbnb JavaScript style guide
- Write JSDoc comments for functions
- Use Zod for runtime validation
- Prefer composition over inheritance

## File Structure

- Components in src/components/
- API routes in src/app/api/
- Types in src/types/
- Utils in src/lib/

## Testing

- Jest for unit tests
- Playwright for E2E
- Minimum 80% coverage required
```

---

### 📋 Que Mettre dans CLAUDE.md ? (Recommandations Melvynx 500h)

Après **500h d'utilisation**, Melvynx recommande de structurer la mémoire ainsi :

#### 1. ⚡ **Commandes Importantes à Lancer**

```markdown
## Commandes Importantes

**Dev**:
- `npm run dev` : Démarre serveur développement (port 3000)
- `npm run build` : Build production
- `npm test` : Lance tous les tests

**Database**:
- `npm run db:push` : Sync schema Prisma → Supabase
- `npm run db:studio` : Ouvre Prisma Studio

**Déploiement**:
- `vercel --prod` : Déployer en production
```

**Pourquoi** : Claude peut suggérer ces commandes dans son workflow automatiquement.

---

#### 2. 🔴 **Spécificités CRITICAL (Erreurs Fréquentes)**

Utilise le mot-clé **CRITICAL** pour marquer les règles que Claude **oublie souvent** :

```markdown
## ⚠️ CRITICAL Rules

**CRITICAL**: ALWAYS use `"use client"` directive for components with hooks (useState, useEffect).

**CRITICAL**: NEVER expose API keys in client-side code. Use environment variables server-side only.

**CRITICAL**: Database queries MUST use Prisma client, NEVER raw SQL (security).

**CRITICAL**: All forms MUST have Zod validation BEFORE database operations.
```

**Pourquoi** : Le mot CRITICAL attire l'attention de Claude sur les règles prioritaires.

---

#### 3. 🧩 **Composants & Librairies à Utiliser**

```markdown
## Composants Préférés

**UI Library**: shadcn/ui
- Toujours utiliser composants shadcn/ui existants
- Ne JAMAIS créer de boutons custom (utiliser Button from shadcn)
- Variants: default, destructive, outline, ghost

**Icons**: lucide-react
- Import: `import { Icon } from 'lucide-react'`
- Ne pas utiliser heroicons ou autres

**Forms**: react-hook-form + Zod
- Toujours combiner les deux
- Pattern: Controller + zodResolver

**Date Handling**: date-fns (pas moment.js)
```

**Pourquoi** : Évite que Claude utilise des librairies non installées ou crée des composants custom inutiles.

---

#### 4. 🔐 **Méthodes d'Authentification & Patterns**

```markdown
## Authentification

**Provider**: Supabase Auth

**Patterns**:
- Server Components: `createServerClient()` from @supabase/ssr
- Client Components: `createClientClient()` from @supabase/ssr
- Middleware: Check auth in middleware.ts

**Session Management**:
- NEVER store tokens in localStorage (use cookies only)
- Refresh tokens handled automatically by Supabase client

**Protected Routes**:
- Use middleware.ts to redirect unauthenticated users
- Pattern: Check session → redirect to /login if null
```

**Pourquoi** : Sécurité et cohérence dans toute l'application.

---

#### 5. 🔄 **Workflows de Développement**

```markdown
## Development Workflow

**Feature Development**:
1. Create feature branch: `git checkout -b feat/feature-name`
2. Implement feature with tests
3. Run `npm test` → doit passer
4. Run `npm run build` → doit passer
5. Commit avec conventional commits: `feat(scope): description`
6. Push et créer PR

**Testing Workflow**:
1. Write test FIRST (TDD)
2. Implement feature
3. Run test until green
4. Refactor if needed
5. Coverage minimum: 80%

**Commit Workflow**:
- Format: `type(scope): description`
- Types: feat, fix, docs, refactor, test, chore
- Always add Co-Authored-By: Claude <noreply@anthropic.com> when AI-generated
```

**Pourquoi** : Claude suit automatiquement ces workflows dans ses suggestions.

---

#### 📊 Structure Optimale CLAUDE.md (Template Melvynx)

```markdown
# Mémoire du Projet - [Nom Projet]

## ⚡ Commandes Importantes
[Commandes npm, scripts custom]

## 🔴 CRITICAL Rules
[Règles prioritaires que Claude oublie souvent]

## 🧩 Stack Technique
[Tech stack détaillée]

## 🎨 Composants & Librairies
[UI library, icons, forms, etc.]

## 🔐 Authentification
[Provider, patterns, session management]

## 📁 Architecture
[Structure fichiers, conventions nommage]

## 🔄 Workflows
[Dev workflow, testing, commits, déploiement]

## 📚 Ressources
[Liens documentation, repos importants]
```

**💡 Pro Tip** : Utiliser `/cloud-memory update` tous les mois pour réorganiser automatiquement.

---

### 🔄 Comment la Mémoire est Injectée ? (System Reminder)

À chaque fois que tu envoies un prompt, Claude Code injecte automatiquement ta mémoire sous forme de **System Reminder**.

**Visualisation du processus** :

```
╔═══════════════════════════════════════════════════════════╗
║  INJECTION AUTOMATIQUE DE LA MÉMOIRE                      ║
╚═══════════════════════════════════════════════════════════╝

TON PROMPT :
┌────────────────────────────────────────┐
│ "Create a new user endpoint"           │
└────────────────────────────────────────┘
               │
               ▼
    ┌──────────────────────────┐
    │  Claude Code Process     │
    └──────────────────────────┘
               │
               ▼
PROMPT ENRICHI ENVOYÉ À CLAUDE :
┌────────────────────────────────────────────────────────┐
│ <system-reminder>                                      │
│                                                        │
│ # Global Instructions (~/.claude/CLAUDE.md)           │
│ - Always use TypeScript strict mode                   │
│ - Prefer async/await over .then                       │
│ - Use conventional commits                            │
│                                                        │
│ # Project Instructions (.claude/CLAUDE.md)            │
│ - Stack: Next.js 14 + Supabase                        │
│ - CRITICAL: Use Zod validation for all forms          │
│ - All API routes in src/app/api/                      │
│                                                        │
│ </system-reminder>                                     │
│                                                        │
│ User prompt: "Create a new user endpoint"             │
└────────────────────────────────────────────────────────┘
               │
               ▼
    ┌──────────────────────────┐
    │  Claude génère code      │
    │  en respectant memory    │
    └──────────────────────────┘
```

**Ce qui se passe en coulisses** :

1. **Lecture automatique** : Claude Code lit tous les fichiers CLAUDE.md (global + projet)
2. **Fusion hiérarchique** : Combine selon priorité (projet > global)
3. **Injection invisible** : Ajoute avant ton prompt sous forme `<system-reminder>`
4. **Application** : Claude répond en tenant compte de TOUTE la mémoire

**Exemple Concret** :

Si tu as dans ta mémoire :
```markdown
## CRITICAL Rules
- ALWAYS use Zod validation for forms
- NEVER expose API keys client-side
```

Et que tu demandes :
```
"Create a login form"
```

Claude va **automatiquement** :
- ✅ Ajouter Zod validation au formulaire
- ✅ Gérer les API keys côté serveur uniquement
- ✅ Sans que tu aies à le répéter !

**💡 Astuce** : Tu peux voir la mémoire injectée en regardant les messages "system-reminder" dans les conversations.

---

### 🏗️ Hiérarchie - 3 Niveaux de Mémoire (Melvynx)

Selon **Melvynx** (500h d'expérience), Claude Code a **3 niveaux de mémoire hiérarchique** en pratique :

```
╔═══════════════════════════════════════════════════════════╗
║  HIÉRARCHIE MÉMOIRE CLAUDE CODE (3 NIVEAUX)              ║
╚═══════════════════════════════════════════════════════════╝

📦 ~/
┃
┣━━ 🌍 ~/.claude/CLAUDE.md
┃   └─> MÉMOIRE GLOBALE (tous projets)
┃       • Préférences générales
┃       • Style de code personnel
┃       • Conventions commit
┃       • Outils favoris
┃
┗━━ 📂 mon-projet/
    ┃
    ┣━━ 🏢 .claude/CLAUDE.md
    ┃   └─> MÉMOIRE PROJET (tout le projet)
    ┃       • Stack technique
    ┃       • Architecture globale
    ┃       • Commandes importantes
    ┃       • CRITICAL rules projet
    ┃
    ┗━━ 📁 src/components/
        ┃
        ┗━━ 🎯 .claude/CLAUDE.md
            └─> MÉMOIRE DOSSIER (scope limité)
                • Règles spécifiques au dossier
                • Composants à utiliser (ex: shadcn)
                • Patterns locaux
                • Conventions nommage

🔄 ORDRE DE PRIORITÉ (du plus spécifique au plus général) :
   DOSSIER > PROJET > GLOBAL
```

**Comment ça fonctionne** :

```
┌───────────────────────────────────────────────────────┐
│  Quand tu travailles dans src/components/Button.tsx  │
└───────────────────────────────────────────────────────┘
                     │
                     ▼
┌───────────────────────────────────────────────────────┐
│  Claude lit (dans l'ordre) :                          │
│                                                       │
│  1️⃣ ~/.claude/CLAUDE.md                              │
│     → "Use TypeScript strict"                        │
│     → "Conventional commits"                         │
│                                                       │
│  2️⃣ mon-projet/.claude/CLAUDE.md                     │
│     → "Stack: Next.js 14 + Tailwind"                 │
│     → "CRITICAL: Use Zod validation"                 │
│                                                       │
│  3️⃣ mon-projet/src/components/.claude/CLAUDE.md      │
│     → "ALWAYS use shadcn/ui components"              │
│     → "Never create custom buttons"                  │
│                                                       │
│  ✅ Résultat: TOUTES les règles sont appliquées      │
│     (la plus spécifique gagne en cas de conflit)     │
└───────────────────────────────────────────────────────┘
```

**💡 Exemple de conflit (priorité)** :

```
🌍 Global (~/.claude/CLAUDE.md):
   "Use spaces (2)"

🏢 Projet (projet/.claude/CLAUDE.md):
   "Use tabs"

🎯 Dossier (projet/src/.claude/CLAUDE.md):
   "Use spaces (4)"

✅ RÉSULTAT dans projet/src/ → spaces (4)
   (Dossier gagne car plus spécifique)
```

---

### 📚 Hiérarchie Complète (4 Niveaux Officiels)

Claude Code supporte techniquement **4 niveaux** (mais le niveau Enterprise est rare en pratique) :

```
        ╔═══════════════════════════════════════╗
        ║  🏢 ENTERPRISE (Priorité Maximale)   ║
        ║  /Library/.../ClaudeCode/CLAUDE.md   ║
        ║  ✓ Géré par IT/DevOps                ║
        ║  ✓ Policies entreprise               ║
        ╚═══════════════════════════════════════╝
                      ▼ Override
        ┌────────────────────────────────────────┐
        │  📁 PROJECT (Équipe)                   │
        │  ./.claude/CLAUDE.md                   │
        │  ✓ Partagé via Git                     │
        │  ✓ Standards du projet                 │
        └────────────────────────────────────────┘
                      ▼ Override
        ┌────────────────────────────────────────┐
        │  👤 USER (Personnel)                   │
        │  ~/.claude/CLAUDE.md                   │
        │  ✓ Préférences personnelles            │
        │  ✓ Styles favoris                      │
        └────────────────────────────────────────┘
                      ▼
        ┌────────────────────────────────────────┐
        │  ⚠️  LOCAL (DÉPRÉCIÉ)                  │
        │  ./CLAUDE.local.md                     │
        │  ❌ Utiliser imports à la place        │
        └────────────────────────────────────────┘
```

**⚡ Règle d'or** : Le niveau le plus **spécifique** (bas de la pyramide) gagne en cas de conflit.

```
💡 Exemple concret:
┌──────────────────────────────────┐
│ 👤 User:    "Use spaces (2)"     │
│ 📁 Project: "Use tabs"           │
│                                  │
│ ✅ Résultat → TABS (Project win)│
└──────────────────────────────────┘
```

---

### 🔗 Imports & Modularité

Tu peux importer d'autres fichiers markdown dans ta mémoire :

```markdown
# .claude/CLAUDE.md

@~/.claude/preferences.md
@.claude/config/style.md
@.claude/config/standards.md

# Références directes dans les instructions
Voir @README pour overview et @package.json pour npm commands.

# Instructions Additionnelles
- git workflow @docs/git-instructions.md
- Préférences perso @~/.claude/my-project-instructions.md
```

**Visualisation** :

```
┌────────────────────────────────┐
│  📊 Limite : 5 niveaux max     │
│                                │
│  CLAUDE.md                     │
│    └─> config/style.md (1)    │
│         └─> shared/ts.md (2)  │
│              └─> ... (3-5)    │
└────────────────────────────────┘
```

**Utilité** :
- Réutiliser configurations communes
- Organiser mémoire en modules
- Partager standards entre projets
- Chemins relatifs et absolus supportés

### 🆕 Nouvelles Fonctionnalités 2025

**Quick Add avec `#`** :
- Commencer ton message par `#` pour ajouter rapidement en mémoire
- Exemple : `# Toujours utiliser Vitest pour les tests`
- Claude ajoute automatiquement dans le bon fichier CLAUDE.md

**Commandes Améliorées** :
- `/memory` : Éditer directement les fichiers de mémoire
- `/init` : Bootstrap un CLAUDE.md avec template intelligent
- Auto-détection du contexte projet pour suggestions

---

### 🌍 Équivalents Autres AIs

**Principe universel**: La "memory" = fichier `.md` éditable.

```
┌─────────────────────────────────────────────────────┐
│  🤖 AI          📁 Fichier         📝 Description   │
├─────────────────────────────────────────────────────┤
│  Claude Code    .claude/CLAUDE.md  Persistant ⭐    │
│  Gemini CLI     gemini.md          Context sessions │
│  ChatGPT        agent.md           Custom GPTs      │
│  Codex          agents.md          Instructions     │
└─────────────────────────────────────────────────────┘
```

#### 🔄 Workflow Multi-AI (NetworkChuck)

```
        🗂️ mon-projet/
        ┣━━ 📁 .claude/
        ┃   ┗━━ CLAUDE.md     🤖 Memory Claude
        ┣━━ 📄 gemini.md       💎 Memory Gemini
        ┗━━ 📄 agent.md        💬 Memory ChatGPT

        ╔═══════════════════════════════════════╗
        ║  Tous travaillent sur MÊME codebase  ║
        ║  ✓ Sync automatique                  ║
        ║  ✓ Spécialisation par AI             ║
        ╚═══════════════════════════════════════╝
```

**🎯 Workflow Collaboratif** :

```
Terminal 1              Terminal 2               Terminal 3
┌─────────────┐         ┌─────────────┐          ┌─────────────┐
│ 💎 Gemini   │────────>│ 🤖 Claude   │─────────>│ 💬 ChatGPT  │
│ Research    │         │ Implement   │          │ Review      │
└─────────────┘         └─────────────┘          └─────────────┘
      │                        │                        │
      └────────────────────────┴────────────────────────┘
                    ↓ Tous modifient ↓
            ┌─────────────────────────────┐
            │  📦 MÊME PROJET             │
            │  src/ docs/ tests/          │
            └─────────────────────────────┘
```

**💡 Exemple concret** :

```bash
# 📊 1. RESEARCH (Gemini)
gemini               # Lit gemini.md
→ "Research best auth libraries for Next.js"
→ Résultat: NextAuth.js vs Clerk

# 🏗️ 2. IMPLEMENT (Claude)
claude               # Lit .claude/CLAUDE.md
→ "Implement NextAuth.js based on gemini's research"
→ Code créé

# ✅ 3. REVIEW (ChatGPT)
chatgpt              # Lit agent.md
→ "Review auth implementation for security"
→ Suggestions
```

---

### ✅ Avantages

```
✅ Contrôle total      → Tu possèdes le fichier
✅ Éditable facilement → Juste un .md
✅ Gestion personnalisée → Optimise comme tu veux
✅ Persistance         → Pas besoin de répéter
✅ Scope flexible      → Local ou global
✅ Versionable         → Commit dans Git
✅ Partageable         → Team peut utiliser même memory
```

---

### 🎯 Use Cases Concrets

#### 1. Préférences de Coding

```markdown
# Memory (Global - ~/.claude/CLAUDE.md)

## Code Style
- Always use async/await (not .then)
- Prefer const over let
- Use early returns
- Destructure props

## Error Handling
- Always wrap async in try/catch
- Log errors with context
- Never swallow errors
```

#### 2. Architecture Projet

```markdown
# Memory (Local - .claude/CLAUDE.md)

## Project Architecture

This is a monorepo with:
- apps/web (Next.js)
- apps/api (Express)
- apps/mobile (React Native)
- packages/ui (Shared components)
- packages/types (TypeScript types)

## Data Flow
- API → Database (PostgreSQL)
- Web → API (REST)
- Mobile → API (GraphQL)
```

#### 3. Guidelines Équipe

```markdown
# Memory (Local - Team)

## Development Process
- Follow team's PR template
- Run tests before commit (npm test)
- Use conventional commits
- Request review from 2 team members

## Code Review Checklist
- Security vulnerabilities
- Performance issues
- Test coverage > 80%
- Documentation updated
```

---

### 📋 Best Practices

#### DO ✅

**1. Ajouter préférences coding globales**
```bash
~/.claude/CLAUDE.md:
- Style personnel
- Tools favoris
- General workflows
```

**2. Context projet spécifique (local)**
```bash
.claude/CLAUDE.md:
- Tech stack
- Architecture
- Project-specific rules
```

**3. Guidelines équipe partagées**
```bash
git add .claude/CLAUDE.md
git commit -m "Add team coding guidelines"
→ Team utilise mêmes règles
```

**4. Versionner dans Git (local memory)**
```bash
# .gitignore
# NE PAS ignorer .claude/ folder
# ✅ Include dans repo pour team
```

**5. Éditer manuellement si besoin**
```bash
# Ajuster rapidement sans UI
vim .claude/CLAUDE.md
```

#### DON'T ❌

**1. Trop d'instructions (pollution)**
```markdown
# ❌ BAD: Trop verbeux
- Use TypeScript
- Use strict mode
- Use ESLint
- Use Prettier
[... 50 lignes]
```

**2. Instructions contradictoires**
```markdown
# ❌ BAD: Conflit
- Use spaces (2)
- Use tabs
→ Claude confus!
```

**3. Secrets/credentials (sécurité)**
```markdown
# ❌ NEVER: Secrets dans memory
- Database URL: postgresql://user:pass@host/db
- API Key: sk-1234567890
→ JAMAIS mettre secrets!
```

**4. Oublier de sync avec équipe**
```bash
# ❌ BAD: Memory locale pas partagée
→ Team n'a pas mêmes guidelines
```

---

### 🔄 Workflow Recommandé

#### Setup Initial

**1. Memory Globale** (~/.claude/CLAUDE.md):
```markdown
# Personal Coding Preferences

## Style
- TypeScript strict mode
- Functional programming preferred
- Early returns

## Tools
- ESLint + Prettier
- Jest for testing
- Git conventional commits
```

**2. Memory Locale** (.claude/CLAUDE.md):
```markdown
# Project: MyApp

## Tech Stack
- Next.js 14
- Supabase
- Tailwind

## Rules
- All components in src/components/
- API routes use Zod validation
- Tests required for features
```

#### Usage Quotidien

```bash
# Memory active automatiquement ✅

# Pas besoin de répéter instructions
claude
→ "Create new user endpoint"
→ Claude applique automatiquement:
   - TypeScript strict (global)
   - Zod validation (local)
   - Tests required (local)
```

#### Maintenance

**Mensuelle**:
- [ ] Review .claude/CLAUDE.md (local + global)
- [ ] Supprimer instructions obsolètes
- [ ] Ajouter nouvelles préférences découvertes
- [ ] Vérifier cohérence local/global

**À chaque nouveau projet**:
- [ ] Créer .claude/CLAUDE.md local
- [ ] Définir tech stack
- [ ] Ajouter project-specific rules
- [ ] Commit dans Git

#### Partage avec Équipe

**Memory partagée** (recommandé):
```bash
# Versionner dans Git
git add .claude/CLAUDE.md
git commit -m "Add team coding guidelines"
git push

# Team clone → même memory ✅
```

**Documentation**:
```markdown
# README.md

## Memory (.claude/CLAUDE.md)

This project uses Claude Code memory for consistent coding practices.

Guidelines are in `.claude/CLAUDE.md`:
- Tech stack definitions
- Coding conventions
- Testing requirements

All developers should have Claude Code configured to read this file.
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **4 Niveaux hiérarchiques** : Enterprise > Project > User > Local  
✅ **Automatique** : Memory appliquée sans intervention  
✅ **Éditable** : Fichiers .md modifiables manuellement  
✅ **Versionable** : Peut être commité dans Git  
✅ **Imports** : Réutiliser configurations (max 5 niveaux)  
✅ **Scope flexible** : Local (projet) ou Global (tous projets)  

### Commandes Clés

| Action | Commande |
|--------|----------|
| Initialiser projet | `/init` |
| Ajouter mémoire | `# ma règle` (touche #️⃣) |
| Éditer mémoire | `/memory` |
| Vérifier projet | `cat .claude/CLAUDE.md` |
| Vérifier global | `cat ~/.claude/CLAUDE.md` |
| Import | `@chemin/fichier.md` |

### Différence avec Commands

| Aspect | Memory | Commands |
|--------|--------|----------|
| **Type** | Mémoire persistante | Prompts réutilisables |
| **Fichier** | .claude/CLAUDE.md | .claude/commands/*.md |
| **Activation** | Automatique | Manuelle (`/command`) |
| **Utilité** | Instructions toujours actives | Tâches répétitives |
| **Exemple** | "Use TypeScript strict" | `/create-endpoint` |
| **Quand** | Context général | Action spécifique |

**Memory**: Ce que Claude **sait toujours** (background)  
**Commands**: Ce que tu **demandes explicitement** (foreground)

**Combinés**:
```bash
# Memory (automatic):
"Use TypeScript, Zod validation, tests required"

# Command (manual):
/create-endpoint "POST /api/users"

# Résultat:
→ Endpoint TypeScript + Zod + tests
  (Memory appliqué + Command exécuté)
```

---

## 📚 Ressources

### Documentation Officielle
- 📄 **Claude Code Memory** : https://code.claude.com/docs/en/memory
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### Articles & Guides
- 📝 **Memory Best Practices (Anthropic)** : https://www.anthropic.com/engineering/claude-code-best-practices
  - Structurer sa mémoire pour productivité maximale
  - Guidelines officielles d'Anthropic
- 📝 **How I Use Claude Code (sshh.io)** : https://blog.sshh.io/p/how-i-use-every-claude-code-feature
  - Workflow complet avec Memory comme fondation

### Vidéos Recommandées
- 🎥 **Edmund Yong - 800h Claude Code** : https://www.youtube.com/watch?v=Ffh9OeJ7yxw
  - Quote: "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
  - Démonstration Memory 3 niveaux (00:38-15:00)
- 🎥 **Melvynx - 500h Claude Code Workflow** : [Fiche complète](../../ressources/videos/500h-optimisation-workflow-melvynx.md)
  - 3 niveaux mémoire, `/cloud-memory`, structure CRITICAL
  - Maintenance automatique CLAUDE.md

### Repositories Communauté
- 🔗 **Edmund Yong Setup** : https://github.com/edmund-io/edmunds-claude-code
  - CLAUDE.md production avec best practices
  - Structure hiérarchique exemplaire
  - Imports et modularité

### Outils & Packs
- 🔧 **CCLI Blueprint (Melvynx)** : https://mlv.sh/ccli
  - Pack complet de commandes optimisées
  - Inclut `/cloud-memory update` pour maintenance automatique
  - Status line personnalisée
  - Hooks de sécurité

### Ressources Internes
- 📋 [Cheatsheet Memory](./cheatsheet.md) - Référence rapide
- 🎓 [Exercices Memory](../exercises/memory/) - Pratique guidée
- 🔗 [Commands](../2-commands/guide.md) - Complémentarité Memory/Commands
- 🔗 [Best Practices](../9-best-practices/guide.md) - Optimisation workflow

---

## Conclusion

**Memory (.claude/CLAUDE.md)** est la **fondation** d'un workflow Claude Code efficace.

**Principe**: Écrire une fois, appliquer partout.

**Setup recommandé** (Norme officielle):
```
~/.claude/CLAUDE.md          # Global (préférences perso)
    +
.claude/CLAUDE.md            # Local (projet spécifique)
    =
Workflow cohérent et optimisé
```

**Quote Edmund Yong** (800h d'expérience):
> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
