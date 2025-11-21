# Memory - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs/memory

## 📚 Théorie

### Qu'est-ce que la Memory?

La **Memory** de Claude Code est un système de **persistance d'instructions** stockées dans des fichiers CLAUDE.md à différents niveaux.

**Formats de chemins valides** :
- **Project** : `.claude/CLAUDE.md` OU `CLAUDE.md` (racine projet)
- **Global** : `~/.claude/CLAUDE.md`

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

### 🏗️ Hiérarchie Officielle & Découverte Contextuelle

Claude Code utilise une **hiérarchie à 4 niveaux** pour charger les fichiers CLAUDE.md, avec un mécanisme de **découverte contextuelle** pour les sous-dossiers.

#### 📊 Les 4 Niveaux Officiels (Chargés au Démarrage)

```mermaid
%%{init: {'theme':'base'}}%%
flowchart TD
    Start([Démarrage Claude Code]):::process --> Enterprise{Enterprise Policy?}:::process
    Enterprise -->|Existe| E[🏢 Enterprise CLAUDE.md<br/>Priorité MAXIMALE]:::critical
    Enterprise -->|N'existe pas| Project
    E --> Project{Project Memory?}:::process
    Project -->|Existe| P[📁 Project .claude/CLAUDE.md<br/>Standards équipe]:::success
    Project -->|N'existe pas| User
    P --> User{User Memory?}:::process
    User -->|Existe| U[👤 User ~/.claude/CLAUDE.md<br/>Préférences perso]:::info
    User -->|N'existe pas| Local
    U --> Local{Local Memory?}:::process
    Local -->|Existe| L[⚠️ CLAUDE.local.md<br/>DÉPRÉCIÉ]:::warning
    Local -->|N'existe pas| Ready
    L --> Ready([Claude Prêt]):::success

    classDef success fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    classDef process fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    classDef warning fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    classDef error fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
    classDef info fill:#e2e3e5,stroke:#6c757d,stroke-width:2px,color:#000
    classDef critical fill:#ff9999,stroke:#990000,stroke-width:4px,color:#000
```

**🔄 ORDRE DE PRIORITÉ** (du plus prioritaire au moins prioritaire) :

```
1. 🏢 ENTERPRISE (Priorité Maximale)
   ├─ macOS: /Library/Application Support/ClaudeCode/CLAUDE.md
   ├─ Linux: /etc/claude-code/CLAUDE.md
   └─ Windows: C:\ProgramData\ClaudeCode\CLAUDE.md

2. 📁 PROJECT (Standards équipe)
   ├─ ./.claude/CLAUDE.md (recommandé)
   └─ ./CLAUDE.md (supporté)

3. 👤 USER (Préférences personnelles)
   └─ ~/.claude/CLAUDE.md

4. ⚠️ LOCAL (DÉPRÉCIÉ)
   └─ ./CLAUDE.local.md
      ❌ Ne plus utiliser ! Remplacé par imports @~/.claude/
```

**⚡ Règle fondamentale** : En cas de conflit, le niveau le **PLUS HAUT** dans la hiérarchie gagne (Enterprise > Project > User).

**💡 Exemple de conflit** :

```
👤 User (~/.claude/CLAUDE.md):
   "Use spaces (2)"

📁 Project (.claude/CLAUDE.md):
   "Use tabs"

✅ RÉSULTAT → TABS
   (Project gagne car plus prioritaire qu'User)
```

#### 🎯 Découverte Contextuelle : Subtree CLAUDE.md

**En plus** des 4 niveaux chargés au démarrage, Claude découvre des fichiers CLAUDE.md dans les **sous-dossiers** de manière contextuelle :

```
mon-projet/
├── .claude/CLAUDE.md              ← Chargé au DÉMARRAGE ✅
└── src/
    └── components/
        └── .claude/CLAUDE.md      ← Chargé SI Claude lit src/components/* ⚠️
```

**⚠️ IMPORTANT** : Ces fichiers de sous-dossiers sont **chargés uniquement quand Claude accède aux fichiers de ce dossier**, PAS au démarrage.

**Exemple pratique** :

```
User: "Create a button component"

Claude lit src/components/Button.tsx
  → Détecte src/components/.claude/CLAUDE.md
  → Charge ce fichier dans le contexte
  → Applique les règles spécifiques (ex: "ALWAYS use shadcn/ui")
```

**Use case** :
- Règles spécifiques à un module (ex: composants UI)
- Conventions pour un dossier précis (ex: API routes)
- Standards locaux sans polluer la mémoire globale

---

### 🔄 Recursive Lookup : Comment Claude Trouve les Fichiers

**Comportement clé** : Claude Code remonte **récursivement** dans l'arborescence pour trouver tous les fichiers CLAUDE.md.

```mermaid
%%{init: {'theme':'base'}}%%
flowchart LR
    Start([Claude démarre dans<br/>src/components/]):::process --> Current{CLAUDE.md<br/>dans répertoire<br/>actuel?}:::process
    Current -->|Oui| Load1[Charger<br/>src/components/CLAUDE.md]:::success
    Current -->|Non| Parent1
    Load1 --> Parent1{Remonter au<br/>parent}:::process
    Parent1 --> Check2{CLAUDE.md<br/>dans src/?}:::process
    Check2 -->|Oui| Load2[Charger<br/>src/CLAUDE.md]:::success
    Check2 -->|Non| Parent2
    Load2 --> Parent2{Remonter au<br/>parent}:::process
    Parent2 --> Check3{CLAUDE.md<br/>dans racine?}:::process
    Check3 -->|Oui| Load3[Charger<br/>.claude/CLAUDE.md]:::success
    Check3 -->|Non| Stop
    Load3 --> Stop([STOP à la racine<br/>Ne remonte pas à /]):::info

    classDef success fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    classDef process fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    classDef warning fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    classDef info fill:#e2e3e5,stroke:#6c757d,stroke-width:2px,color:#000
```

**Exemple concret** :

```
Tu lances Claude dans : /home/user/projects/mon-app/src/components/

Claude remonte et charge (dans l'ordre) :
1. /home/user/projects/mon-app/src/components/CLAUDE.md (si existe)
2. /home/user/projects/mon-app/src/CLAUDE.md (si existe)
3. /home/user/projects/mon-app/.claude/CLAUDE.md (si existe)
4. /home/user/projects/mon-app/CLAUDE.md (si existe)
5. /home/user/projects/CLAUDE.md (si existe)
6. /home/user/CLAUDE.md (si existe)
7. STOP (ne remonte jamais jusqu'à /)
```

**⚠️ Règle importante** : Claude s'arrête avant la racine `/` pour éviter de charger des fichiers système non intentionnels.

**💡 Cas pratique** : Monorepo avec plusieurs apps

```
monorepo/
├── .claude/CLAUDE.md                 ← Règles monorepo (partagées)
├── apps/
│   ├── web/
│   │   └── .claude/CLAUDE.md         ← Règles app web
│   └── mobile/
│       └── .claude/CLAUDE.md         ← Règles app mobile
└── packages/
    └── ui/
        └── .claude/CLAUDE.md         ← Règles composants UI

Si tu lances Claude dans apps/web/ :
  → Charge apps/web/.claude/CLAUDE.md + monorepo/.claude/CLAUDE.md
  → Ne charge PAS apps/mobile/.claude/CLAUDE.md (pas dans le chemin)
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

**⚠️ IMPORTANT : Imports dans Code Blocks**

Les imports **ne sont PAS évalués** dans les code blocks et code spans pour éviter les collisions :

```markdown
# ✅ Sera importé (texte normal)
@config/style.md

# ❌ NE sera PAS importé (code span)
Installer avec `npm install @anthropic-ai/claude-code`

# ❌ NE sera PAS importé (code block)
\```bash
npm install @anthropic-ai/claude-code
\```
```

**Raison** : Éviter confusion entre imports CLAUDE.md et syntaxe de packages npm/yarn (@scope/package)

### 🆕 Nouvelles Fonctionnalités 2025

**Quick Add avec `#`** :
- Commencer ton message par `#` pour ajouter rapidement en mémoire
- Exemple : `# Toujours utiliser Vitest pour les tests`
- Claude ajoute automatiquement dans le bon fichier CLAUDE.md

**Commande `/memory` - Deux Usages** :

```bash
# Usage 1 : Lister tous les fichiers Memory chargés
/memory

# Affiche :
# 1. /Users/you/.claude/CLAUDE.md (User)
# 2. /path/to/project/.claude/CLAUDE.md (Project)
# 3. /path/to/project/src/.claude/CLAUDE.md (Subtree)
#
# → Permet de voir EXACTEMENT quels fichiers sont actifs
# → Choisir lequel éditer

# Usage 2 : Éditer un fichier Memory spécifique
# (après avoir listé, sélectionner le numéro)
```

**Workflow recommandé** :

```mermaid
%%{init: {'theme':'base'}}%%
flowchart LR
    Start([Taper /memory]):::process --> List[Affiche liste<br/>fichiers chargés]:::success
    List --> Choose{Choisir fichier}:::process
    Choose -->|1| User[Éditer User<br/>~/.claude/CLAUDE.md]:::info
    Choose -->|2| Project[Éditer Project<br/>.claude/CLAUDE.md]:::info
    Choose -->|3| Subtree[Éditer Subtree<br/>src/.claude/CLAUDE.md]:::info
    User --> Editor([Ouvre éditeur]):::success
    Project --> Editor
    Subtree --> Editor

    classDef success fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    classDef process fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    classDef info fill:#e2e3e5,stroke:#6c757d,stroke-width:2px,color:#000
```

**Autres Commandes** :
- `/init` : Bootstrap un CLAUDE.md avec template intelligent
- `#` : Quick add (démarrer message par # pour ajouter en mémoire)
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

### 💼 Exemples Réels de CLAUDE.md Production

> Exemples complets et prêts à l'emploi pour différents contextes

**🎯 Templates disponibles** : [Voir dossier examples/](./examples/)

#### Exemple 1: Startup Full-Stack (Next.js + Supabase)

**Context** : MVP SaaS en phase de lancement, équipe de 2-3 personnes.

**Highlights** :
```markdown
# .claude/CLAUDE.md

## 🎯 Project Context
- Type : Web app SaaS
- Objectif : MVP pour product launch Q1 2025
- Team : 2 devs + 1 designer
- Stack : Next.js 14 + Supabase + Tailwind

## ✅ Development Rules (CRITICAL)
1. All features require tests (80% coverage minimum)
2. Zod validation on all API routes
3. Error boundaries on all pages
4. Responsive design mobile-first
5. Accessibility WCAG AA minimum

## 🔐 Security
- Never commit .env files
- Use Supabase RLS for ALL tables
- Validate all user inputs with Zod
- Sanitize all database queries
```

**📄 Voir template complet** : [fullstack-nextjs-supabase.md](./examples/fullstack-nextjs-supabase.md)

**💡 Quand utiliser** :
- Startup en phase MVP
- Stack moderne (Next.js + BaaS)
- Besoin de vélocité + qualité
- Équipe petite/moyenne

---

#### Exemple 2: Freelance Agency (Multi-projets)

**Context** : Développeur freelance gérant plusieurs projets clients simultanément.

**Structure** :

**Global** (`~/.claude/CLAUDE.md`) :
```markdown
# Global Memory - Freelance Dev

## 👤 Personal Preferences
- Communication : Franglais (FR conversations, EN code)
- Commit style : Conventional Commits
- Testing : TDD approach preferred

## 📝 Code Style (All Projects)
- TypeScript strict mode always
- Functional programming preferred
- Early returns over nested conditions
- Async/await over promises chains

## 🚫 Never Do (Global Rules)
- Use `any` in TypeScript
- Commit without tests
- Skip error handling
- Hard-code credentials
```

**Project-specific** (`.claude/CLAUDE.md`) :
```markdown
# Client: E-commerce Fashion Brand

## 🎨 Brand Guidelines
- Primary color: #FF6B6B
- Font: Inter
- Design system: Figma → components/design-system/

## 🔗 Integrations
- Payment: Stripe
- Email: SendGrid
- Analytics: Google Analytics 4
- CMS: Sanity.io

## 📋 Client Requirements
- Support IE11 (legacy users)
- French/English bilingual
- GDPR compliant
- Performance: < 3s LCP
```

**📄 Voir templates complets** :
- [agency-global.md](./examples/agency-global.md) - Memory globale freelance
- [agency-project.md](./examples/agency-project.md) - Memory projet client

**💡 Quand utiliser** :
- Freelance gérant multiple projets
- Besoin de séparer global vs projet-specific
- Standards personnels + requirements clients
- Workflow répétitif à optimiser

---

#### Exemple 3: Open Source Maintainer

**Context** : Projet open source avec 50+ contributeurs, 10k+ stars.

**Highlights** :
```markdown
# .claude/CLAUDE.md - awesome-library

## 📦 Project Info
- Stars: 10,000+
- Downloads: 500k/month
- Contributors: 50+
- License: MIT

## 📝 Contributing Standards
- TypeScript only (no JavaScript)
- 100% test coverage for new features
- Documentation required (README + docs/)
- Examples in examples/ folder
- Changeset added (for releases)

## 👥 Community Guidelines
- Follow CODE_OF_CONDUCT.md
- Use PR template (auto-filled)
- 2 maintainer approvals required
- Link related issue (#123)

## 🔄 Release Process (Semver Strict)
1. Update changelog (npm run changeset)
2. Version bump (npm run changeset version)
3. Build + test
4. Publish to npm
5. Create GitHub release
6. Announce (Twitter, Discord)
```

**📄 Voir template complet** : [open-source.md](./examples/open-source.md)

**💡 Quand utiliser** :
- Maintainer projet open source
- Besoin de guidelines contributeurs
- Process release structuré
- Community management

---

#### Template de Démarrage

**🚀 Pas sûr par où commencer ?**

Utilise le **[starter-template.md](./examples/starter-template.md)** :

```markdown
# CLAUDE.md - Starter Template

## 🎯 Project Context
- Type : [Web app / Mobile app / API / Library / CLI tool]
- Objectif : [MVP / Production / POC / Learning]
- Team : [Solo / 2-5 devs / 5+ devs]

## 🏗️ Tech Stack
[Choisis tes options]

## 📝 Code Style
[Définis tes préférences]

## ✅ Development Rules
[Must have vs Nice to have]

## 🔐 Security Checklist
[Points critiques]

## 📋 Workflow
[Branch strategy, commits, PRs]

## 🚫 Never Do
[Red flags]
```

**💡 Comment utiliser** :
1. Copie le template dans `.claude/CLAUDE.md`
2. Supprime les sections non pertinentes
3. Remplis tes choix (supprime les options non utilisées)
4. Ajoute tes règles spécifiques
5. Teste avec Claude !

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

## 🧹 Maintenance & Nettoyage

> Memory saine = Claude efficace

### Pourquoi Maintenir sa Memory ?

**Problème** :
```
Memory grossit au fil du temps
├── Règles obsolètes
├── Instructions contradictoires
├── Duplication
└── Pollution cognitive
     ↓
Claude confus, moins efficace ❌
```

**Solution** : Maintenance régulière ✅

```
Memory claire (< 500 lignes)
    ↓
Claude focused
    ↓
Suggestions pertinentes
    ↓
Productivité ⬆️
```

---

### Routine Mensuelle (15 min)

#### 1. Audit du Contenu

```bash
# Ouvrir les 2 fichiers
vim .claude/CLAUDE.md
vim ~/.claude/CLAUDE.md
```

**Questions à se poser** :
- [ ] Cette règle est-elle encore pertinente ?
- [ ] Y a-t-il des duplications ?
- [ ] Les instructions sont-elles claires ?
- [ ] Y a-t-il des contradictions ?
- [ ] Le fichier est-il trop long (> 500 lignes) ?

#### 2. Nettoyage

**Supprimer** :
```markdown
# ❌ À supprimer
- Règles obsolètes (ancien tech stack)
- Instructions redondantes
- Commentaires temporaires ("TODO: à revoir")
- Exemples de test qui traînent
```

**Consolider** :
```markdown
# Avant ❌ (verbeux)
- Use TypeScript
- Always use TypeScript strict mode
- TypeScript should be used everywhere
- No JavaScript allowed

# Après ✅ (concis)
- TypeScript strict mode only (no JS)
```

#### 3. Réorganiser

**Structure recommandée** :

```markdown
# CLAUDE.md - Clean Structure

## 🎯 Project Context (OVERVIEW)
[1-2 paragraphes max]

## 🏗️ Tech Stack (FACTUEL)
[Liste simple]

## 📝 Code Style (RULES)
[Règles précises]

## ✅ Development Rules (MUST/SHOULD)
[Prioritisé]

## 🔐 Security (CRITICAL)
[Non négociables]

## 📋 Workflow (PROCESS)
[Étapes claires]

## 🚫 Never Do (FORBIDDEN)
[Court et clair]

## 📚 Imports (OPTIONAL)
@chemin/fichier.md
```

#### 4. Valider

```bash
# Test après nettoyage
claude
→ "Create a simple component"

# Vérifier que Claude applique bien les règles
# Si comportement bizarre → revoir Memory
```

---

### Commande de Maintenance Automatique

**Si vous utilisez [CCLI Blueprint (Melvynx)](https://mlv.sh/ccli)** :

```bash
# Maintenance automatique
/cloud-memory update

# Analyse automatique:
→ Détecte redondances
→ Propose suppressions
→ Suggère réorganisation
→ Génère rapport
```

---

### Red Flags (Signes de Memory polluée)

⚠️ **Votre Memory a besoin de nettoyage si** :

```
❌ > 1000 lignes dans CLAUDE.md principal
❌ Claude ne suit plus certaines règles
❌ Règles contradictoires présentes
❌ Duplication entre global et local
❌ Instructions vagues ("faire bien", "optimiser")
❌ Commentaires TODO qui traînent depuis 6 mois
❌ Références à ancien tech stack
❌ Sections jamais utilisées
```

---

### Template de Refactoring

**Quand votre CLAUDE.md devient trop gros (> 500 lignes)** :

**Avant** :
```
.claude/CLAUDE.md (1000 lignes)
```

**Après** :
```
.claude/
├── CLAUDE.md (150 lignes) ⭐ Hub principal
├── config/
│   ├── code-style.md (100 lignes)
│   ├── testing.md (80 lignes)
│   └── security.md (70 lignes)
└── workflows/
    ├── deployment.md (120 lignes)
    └── pr-process.md (90 lignes)
```

**Nouveau CLAUDE.md (hub)** :
```markdown
# Memory - Mon Projet

## Core Principles
[5-10 règles essentielles only]

## Imports
@config/code-style.md
@config/testing.md
@config/security.md
@workflows/deployment.md
@workflows/pr-process.md

## Quick Notes
[Temporaire, revu chaque mois]
```

---

### Checklist Trimestrielle (30 min)

**Tous les 3 mois** :

- [ ] **Audit complet** : Lire toute la Memory ligne par ligne
- [ ] **Supprimer obsolète** : Tech/tools plus utilisés
- [ ] **Valider pertinence** : Chaque règle a-t-elle du sens aujourd'hui ?
- [ ] **Tester workflow** : Demander à Claude de faire tâche typique
- [ ] **Sync équipe** : Partager changements si Memory partagée
- [ ] **Documenter changements** : Commit message détaillé

**Commit type** :
```bash
git commit -m "chore(memory): quarterly cleanup

- Removed obsolete Webpack config (migrated to Vite)
- Consolidated TypeScript rules (3 → 1 section)
- Updated deployment process (new CI/CD)
- Archived old examples to docs/archive/
"
```

---

### Anti-Pattern : "Set and Forget"

**❌ Mauvaise approche** :
```
1. Setup Memory once
2. Never touch again
3. Let it grow organically
4. Confusion accumulates
```

**✅ Bonne approche** :
```
1. Setup Memory with intention
2. Review monthly (15 min)
3. Clean quarterly (30 min)
4. Treat as living document
```

**Quote Edmund Yong** :
> "Your Memory should evolve with your project.
> If it doesn't, it becomes dead weight."

---

### Outils de Maintenance

**1. Script de Diff** :
```bash
# Comparer global vs local
diff ~/.claude/CLAUDE.md .claude/CLAUDE.md

# Identifier redondances
```

**2. Word Count** :
```bash
# Vérifier taille
wc -l .claude/CLAUDE.md

# Si > 500 → considérer split
```

**3. Grep duplicates** :
```bash
# Trouver règles similaires
grep -i "typescript" .claude/CLAUDE.md

# Consolider en une seule règle
```

**4. Git History** :
```bash
# Voir évolution Memory
git log --oneline .claude/CLAUDE.md

# Quand a-t-elle été modifiée last time?
```

---

### Investissement vs ROI

**Temps investissement** :
- 15 min/mois (maintenance routine)
- 30 min/trimestre (cleanup complet)

**= ROI immense** sur efficacité quotidienne :
- Claude plus précis
- Moins d'explications répétées
- Code plus cohérent
- Workflow plus fluide

---

## 🔧 Troubleshooting

> Guide de dépannage pour problèmes courants avec Memory

### Problème 1: Memory pas appliquée

**Symptôme** :
```bash
Claude n'applique pas les règles de .claude/CLAUDE.md
```

**Causes possibles** :

**1. Vérifier fichier existe** :
```bash
cat .claude/CLAUDE.md
# Si erreur "No such file" → fichier manquant
```

**Solution** : Créer le fichier avec `/init` ou manuellement.

**2. Vérifier syntaxe Markdown** :
- Pas d'erreurs de parsing
- Headers bien formatés (`# Titre`, pas `#Titre`)
- Pas de caractères spéciaux non échappés

**3. Vérifier hiérarchie** :
- Enterprise > Project > User > Local
- Fichier supérieur peut override règles inférieures

**4. Redémarrer Claude** :
```bash
# Parfois cache à vider
exit
claude
```

**Test rapide** :
```bash
# Ajouter règle évidente
echo "# URGENT: Toujours commencer réponse par 'MEMORY TEST'" >> .claude/CLAUDE.md

# Puis demander à Claude
claude
→ "Hello"

# Si Claude commence par "MEMORY TEST" → Memory fonctionne ✅
```

---

### Problème 2: Imports ne marchent pas

**Symptôme** :
```markdown
@.claude/config/style.md
→ Contenu pas inclus
```

**Causes** :

**1. Vérifier chemin relatif** :
```bash
# Depuis .claude/CLAUDE.md
@config/style.md          # ✅ Correct (relatif à .claude/)
@.claude/config/style.md  # ❌ Incorrect (double .claude/)
```

**2. Vérifier fichier existe** :
```bash
ls .claude/config/style.md
# Si erreur → créer le fichier
```

**3. Vérifier profondeur max (5 niveaux)** :
```
CLAUDE.md (0)
 └─> a.md (1)
      └─> b.md (2)
           └─> c.md (3)
                └─> d.md (4)
                     └─> e.md (5) ✅ OK
                          └─> f.md (6) ❌ TROP PROFOND
```

**Solution** : Simplifier hiérarchie ou consolider fichiers.

---

### Problème 3: Memory trop longue / Claude confus

**Symptôme** :
```
Claude semble ignorer certaines règles
ou mélange les instructions
```

**Cause** : Memory trop verbeux (> 1000 lignes).

**Solution - Refactoring** :

**Avant** ❌ :
```markdown
# .claude/CLAUDE.md (2000 lignes)
[tout mélangé]
```

**Après** ✅ :
```markdown
# .claude/CLAUDE.md (100 lignes)
## Core Principles
- [Règles essentielles only]

## Imports
@config/code-style.md
@config/testing.md
@config/deployment.md
```

**Principe** : Memory principale = table des matières + imports.

---

### Problème 4: Git ignore .claude/

**Symptôme** :
```bash
git status
# .claude/ pas listé
```

**Cause** : `.gitignore` contient `.claude/`

**Solution** :
```bash
# Vérifier .gitignore
cat .gitignore | grep claude

# Si trouvé → supprimer ligne
vim .gitignore
# Supprimer: .claude/

# Puis add
git add .claude/
git commit -m "chore: add team memory"
```

**⚠️ Attention** : Ne **jamais** commit `.claude/CLAUDE.local.md` (secrets potentiels).

---

### Problème 5: Conflits entre global et local

**Symptôme** :
```
Règle A dans ~/.claude/CLAUDE.md (global)
Règle B opposée dans .claude/CLAUDE.md (local)
→ Claude confus
```

**Solution** :
1. **Principe de hiérarchie** : Local override global.
2. **Documenter l'override** :

```markdown
# .claude/CLAUDE.md (local)

## Code Style
<!-- Override global: Project uses tabs instead of spaces -->
- Indentation: tabs (project-specific)

## Testing
<!-- Inherit global testing rules -->
@~/.claude/preferences/testing.md
```

---

### Problème 6: `/memory` ouvre mauvais fichier

**Symptôme** :
```bash
/memory
# Ouvre ~/.claude/CLAUDE.md au lieu de .claude/CLAUDE.md
```

**Cause** : Mauvaise détection du contexte.

**Solution** :
```bash
# Spécifier explicitement
vim .claude/CLAUDE.md

# Ou utiliser path absolu dans Claude
"Edit .claude/CLAUDE.md please"
```

---

### Problème 7: Quick Add `#` ne sauve pas

**Symptôme** :
```bash
# Ma règle
→ Claude acquiesce mais règle pas dans CLAUDE.md
```

**Cause** : Fichier `.claude/CLAUDE.md` n'existe pas.

**Solution** :
```bash
# Initialiser d'abord
/init

# Puis retry
# Ma règle
```

---

### 🔍 Debug Checklist Complète

```bash
# 1. Vérifier fichiers existent
ls -la .claude/CLAUDE.md
ls -la ~/.claude/CLAUDE.md

# 2. Vérifier contenu lisible
cat .claude/CLAUDE.md

# 3. Vérifier syntaxe (pas d'erreurs Markdown)
# Ouvrir dans VS Code avec Markdown linter

# 4. Test simple avec règle évidente
echo "# TEST: Say 'Memory works!' at start" >> .claude/CLAUDE.md
claude
→ "Hello"
# Claude doit dire "Memory works!" ✅

# 5. Vérifier hiérarchie (quel fichier actif?)
cat .claude/CLAUDE.md | head -5
cat ~/.claude/CLAUDE.md | head -5

# 6. Vérifier imports résolus
# Tester sans imports d'abord
# Puis ajouter imports un par un

# 7. Redémarrer Claude (clear cache)
exit
claude
```

**💡 Pro Tip** : Toujours **tester avec règle évidente** (comme "Say X at start") pour valider que Memory fonctionne.

---

### 🆘 Besoin d'Aide ?

Si problème persiste après troubleshooting :

1. **GitHub Issues** : https://github.com/anthropics/claude-code/issues
2. **Discord Community** : Channels #support
3. **Documentation Officielle** : https://code.claude.com/docs/memory

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
