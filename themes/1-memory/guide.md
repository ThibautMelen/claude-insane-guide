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

### 🏗️ Hiérarchie - Pyramide de Priorité

**Ordre de priorité** : 🏢 Enterprise > 📁 Project > 👤 User

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

- 📄 **Claude Code Memory** : https://code.claude.com/docs/memory
- 🎥 **Edmund Yong - 800h Claude Code** : https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- 📄 **Voir aussi** : [Commands](../commands/guide.md) | [Plugins](../plugins/guide.md)

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
