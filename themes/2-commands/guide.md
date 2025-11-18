# Commands - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs/slash-commands

---

## ⚡ CRITICAL: Commands = THE PRIMITIVE

> **"Prompt = Primitive. Everything else is composition."**
> — Dan, Skills vs Commands vs Sub-Agents vs MCP

### 🎯 Pour Commands: L'Essentiel

**Commands = THE PRIMITIVE** de tout l'écosystème Claude Code.

- 👤 **Manual Trigger** : YOU décidez WHEN (vs Skills = auto)
- ✅ **Start here ALWAYS** : Test & Validate BEFORE composer vers Skill
- 📝 **Pure Prompts** : Fichiers markdown réutilisables
- 🎯 **Golden Rule** : Command → Test → Skill IF needed (jamais skip)

**Équation** : `Everything = Prompts` (Skills/Agents/MCP = Prompts + wrappers)

### 📚 Framework Complet

**Voir [Core 4 & Fundamentals](../8-advanced/core-4-fundamentals.md) pour** :
- 📊 Tableau comparatif Dan (Triggered By, Context Efficiency, etc.)
- 🔥 Golden Rule workflow complet (5 étapes avec Mermaid)
- 📈 Progressive Disclosure (Skills vs MCP)
- 🏗️ Composition Hierarchy (Skills > MCP > Agents > Commands)
- 🤖 vs 👤 Distinction détaillée (Manual vs Auto trigger)

**Voir [Decision Trees](../8-advanced/decision-trees.md) pour** :
- 🎯 Framework 3 questions (Q1: Répétitif? Q2: Auto? Q3: External data?)
- 📋 Decision trees détaillés (quand utiliser Commands vs Skills vs Agents)
- 🔄 Scenarios réels et anti-patterns

### 🔑 Spécificités Commands

**Pourquoi Commands en PREMIER** :
1. ✅ Simple, testable, iterable
2. ✅ Validate workflow avant complexification
3. ✅ Explicit control (YOU decide when)
4. ✅ Debug facilement (un seul fichier)

**Quand utiliser** :
- ✅ One-off tasks
- ✅ Repeat workflows (with manual control)
- ✅ Orchestration (lance agents, agrège)
- ✅ Testing phase (avant Skill)

**Quand NE PAS utiliser** :
- ❌ Want auto-invoke → Use Skill
- ❌ Event-driven → Use Hook
- ❌ Just preferences → Use Memory

---

## 📚 Théorie

### Qu'est-ce que les Commandes Slash ?

Les **Commandes Slash** (Slash Commands) sont des **prompts complexes réutilisables** stockés dans des fichiers markdown et invocables via la syntaxe `/nom-commande`.

```
╔══════════════════════════════════════════╗
║     COMMANDES SLASH - VUE D'ENSEMBLE     ║
╚══════════════════════════════════════════╝

Terminal Claude Code:
┌────────────────────────────────────────┐
│ > /epct "Créer page contact"           │
└────────────────────────────────────────┘
              ▼
┌────────────────────────────────────────┐
│  📄 .claude/commands/epct.md           │
│  → Prompt complet chargé               │
│  → Workflow EPCT exécuté               │
│  → Feature créée automatiquement       │
└────────────────────────────────────────┘
```

**Source** : Formation Melvynx Claude Code 2.0

---

### 🎯 Problème Résolu

**Avant Commands** :
```
Chaque feature complexe :
├── "Explore le code pour comprendre l'architecture"
├── "Cherche la documentation de Vite"
├── "Propose un plan avant de coder"
├── "Implémente le code"
├── "Lance les tests"
└── [Répéter prompt long à CHAQUE fois] ❌
```

**Avec Commands** :
```
Une seule fois :
├── Créer .claude/commands/epct.md
├── Définir workflow complet
└── Sauvegarder

Toutes fois suivantes :
└── /epct "Ma feature" ✅
    → Workflow complet automatique !
```

---

### 🔧 Comment ça Marche

#### 📂 Structure des Commandes

**Deux Types** : Projet (partagées) vs Personnelles (globales)

```
╔════════════════════════════════════════════╗
║      TYPES DE COMMANDES SLASH              ║
╚════════════════════════════════════════════╝

📦 Commandes Projet (Partagées)
   .claude/commands/
   ┣━━ 📄 setup.md
   ┣━━ 📄 epct.md
   ┗━━ 📄 commit.md
   → Committées sur Git
   → Partagées avec équipe
   → Spécifiques au projet

🏠 Commandes Personnelles (Globales)
   ~/.claude/commands/
   ┣━━ 📄 debug.md
   ┣━━ 📄 prompt.md
   ┗━━ 📄 refactor.md
   → Locales à l'utilisateur
   → Non versionnées
   → Utilisables partout
```

**💡 Règle** :
- **Projet** (.claude/commands/) : Workflows spécifiques équipe
- **Personnel** (~/.claude/commands/) : Préférences individuelles

---

#### ⚡ Workflow Création de Commande

```
┌────────────────────────────────────────┐
│   WORKFLOW CRÉATION COMMANDE           │
└────────────────────────────────────────┘

1️⃣ Créer fichier
   ┌─────────────────┐
   │ .claude/        │
   │ commands/       │
   │ ma-commande.md  │
   └────────┬────────┘
            ▼
2️⃣ Rédiger prompt
   ┌─────────────────┐
   │ Demander à      │
   │ Claude de       │
   │ rédiger le      │
   │ prompt complet  │
   └────────┬────────┘
            ▼
3️⃣ Redémarrer Claude
   ┌─────────────────┐
   │ Ctrl+C          │
   │ puis 'claude'   │
   │                 │
   │ Commandes       │
   │ rechargées ✅   │
   └────────┬────────┘
            ▼
4️⃣ Utiliser
   ┌─────────────────┐
   │ /ma-commande    │
   │ [arguments]     │
   └─────────────────┘
```

**⚠️ Important** : Claude Code doit être **redémarré** après création/modification de commandes pour les charger.

---

### 📝 Anatomie d'une Commande

**Structure fichier** (.claude/commands/nom.md) :

```markdown
# Description de la commande (optionnel)

Prompt complet exécuté par Claude quand /nom est appelé.

Tu peux :
- Donner des instructions détaillées
- Définir un workflow en étapes
- Utiliser des variables : {argument}
- Référencer documentation externe (WebFetch)
- Invoquer des agents (Task tool)
- Combiner avec Memory (CLAUDE.md)

Exemple : "Explore le code, propose un plan, implémente, teste"
```

**Exemple Concret** - /epct.md :

```markdown
# EPCT Workflow : Explore-Plan-Code-Test

Quand l'utilisateur demande une nouvelle feature avec /epct "description", suis ce workflow :

## Phase 1 : 🔍 EXPLORE
- Recherche documentation pertinente (WebFetch si nécessaire)
- Lis les fichiers projet importants (Read, Grep)
- Comprends l'architecture existante
- Identifie les dépendances

## Phase 2 : 📋 PLAN
- Propose un plan structuré en étapes
- **STOP** : Demande validation utilisateur
- Pose des questions sur points ambigus
- Ajuste le plan selon feedback

## Phase 3 : 💻 CODE
- Implémente selon plan validé
- Respecte conventions CLAUDE.md
- Modifie/crée fichiers nécessaires
- Installe dépendances (npm install)

## Phase 4 : ✅ TEST
- Lis package.json pour tests existants
- Lance tests si configurés
- Vérifie linting (ESLint)
- Build de vérification

❌ Ne crée PAS de tests s'ils n'existent pas déjà.
✅ N'exécute QUE les tests existants.

Résultat attendu : Feature complète, testée, fonctionnelle.
```

---

### 📐 Structure Optimale (Melvynx 500h)

Après **500h d'utilisation**, Melvynx recommande une structure de commande **en 4 sections** pour maximiser la cohérence et éviter les hallucinations :

```
╔════════════════════════════════════════════════════════╗
║  ANATOMIE COMMANDE OPTIMALE (MELVYNX)                 ║
╚════════════════════════════════════════════════════════╝

📋 /ma-commande.md
┃
┣━━ 🔢 1. WORKFLOW (étapes numérotées)
┃   ├─> Étape 1
┃   ├─> Étape 2
┃   ├─> Étape 3
┃   └─> Étape N
┃
┣━━ 📜 2. RULES (règles spécifiques)
┃   ├─> Format de sortie
┃   ├─> Conventions à suivre
┃   └─> Contraintes techniques
┃
┣━━ 💡 3. EXAMPLES (few-shot learning)
┃   ├─> ✅ Bon exemple 1
┃   ├─> ✅ Bon exemple 2
┃   └─> ❌ Mauvais exemple
┃
┗━━ ⚠️ 4. CRITICAL RULES (priorité absolue)
    ├─> ALWAYS: comportement obligatoire
    ├─> NEVER: comportement interdit
    └─> IF X: comportement conditionnel
```

---

#### 🔢 Section 1 : WORKFLOW (Étapes Numérotées)

**Objectif** : Donner une **séquence claire** d'actions à Claude.

```markdown
# /commit

## Workflow

1. **Stage**: `git add .` pour stager tous les changements
2. **Analyze**: `git diff --staged` pour voir les modifications
3. **Commit**: Créer message selon format conventional commits
4. **Push**: `git push` pour envoyer au remote (optionnel)
```

**Pourquoi numéroté** : Claude suit mieux une liste ordonnée qu'un texte libre.

---

#### 📜 Section 2 : RULES (Règles Spécifiques)

**Objectif** : Préciser le **format** et les **conventions**.

```markdown
## Rules

**Message Format**:
- Pattern: `type(scope): description`
- Types autorisés: feat, fix, docs, refactor, test, chore
- Scope: optionnel mais recommandé
- Description: impératif présent ("add" pas "added")
- Max 72 caractères pour le titre

**Co-authorship**:
- ALWAYS add: `Co-Authored-By: Claude <noreply@anthropic.com>`
- Placé en footer du message de commit

**Validation**:
- NEVER commit si tests échouent
- NEVER commit si build échoue
```

**Astuce** : Utiliser **ALWAYS**, **NEVER**, **MUST** pour règles strictes.

---

#### 💡 Section 3 : EXAMPLES (Few-Shot Learning)

**Objectif** : Montrer **concrètement** ce qui est attendu (et ce qui ne l'est pas).

```markdown
## Examples

✅ **Bon**:
```
feat(auth): add OAuth login with Google

Implemented OAuth 2.0 flow for Google authentication.
Users can now sign in with their Google account.

Co-Authored-By: Claude <noreply@anthropic.com>
```

✅ **Bon**:
```
fix(ui): resolve button hover state bug

Button now properly changes color on hover.
Fixed CSS specificity issue.

Co-Authored-By: Claude <noreply@anthropic.com>
```

❌ **Mauvais**:
```
updated stuff
```
→ Trop vague, pas de type, pas de scope
```

**Pourquoi des exemples** : Claude apprend par pattern matching (few-shot learning). Plus il voit d'exemples, plus il est cohérent.

---

#### ⚠️ Section 4 : CRITICAL RULES (Priorité Absolue)

**Objectif** : Définir les **comportements non-négociables**.

```markdown
## Critical

**ALWAYS**:
- Review `git diff` before committing
- Ask user confirmation if > 10 files changed
- Include Co-Authored-By when AI-generated

**NEVER**:
- Commit without testing first (`npm test`)
- Commit with failing build (`npm run build`)
- Force push to main/master without explicit user request
- Skip pre-commit hooks (--no-verify)

**IF**:
- IF conflict detected → ask user before resolving
- IF push fails → show error and ask user
- IF no changes staged → inform user and abort
```

**Pourquoi CRITICAL** : Claude priorise ces règles sur tout le reste.

---

### 📋 Template Complet (Melvynx)

Copie ce template pour créer tes commandes :

```markdown
# /nom-commande

Description courte de la commande (1 ligne).

## Workflow

1. Étape 1
2. Étape 2
3. Étape 3

## Rules

**Format**:
- Règle 1
- Règle 2

**Conventions**:
- Règle A
- Règle B

## Examples

✅ **Bon Exemple 1**:
```
[exemple concret]
```

✅ **Bon Exemple 2**:
```
[autre exemple]
```

❌ **Mauvais Exemple**:
```
[contre-exemple]
```

## Critical

**ALWAYS**:
- Comportement obligatoire 1
- Comportement obligatoire 2

**NEVER**:
- Comportement interdit 1
- Comportement interdit 2

**IF X**:
- Condition → Action
```

---

### 🛠️ Commande `/prompt-command` (Meta-Commande)

Melvynx recommande d'utiliser Claude **lui-même** pour écrire des commandes optimales.

**Workflow** :

```bash
# 1. Créer fichier vide
touch .claude/commands/ma-nouvelle-commande.md

# 2. Dans Claude Code
/prompt-command

# Prompt : "Crée une commande /debug qui :
# - Analyse le code pour trouver la source d'un bug
# - Ultra Think phase pour réflexion approfondie
# - Recherche dans les logs/docs
# - Propose des solutions
# - Vérifie que ça fonctionne"

# 3. Claude génère la commande avec structure optimale
# 4. Sauvegarder dans .claude/commands/debug.md
# 5. Redémarrer Claude Code
```

**Avantage** : Claude connaît les best practices et génère des commandes **déjà optimisées**.

---

### 🎨 Exemples de Commandes Utiles

#### 1. /commit - Commit Conventionnel

```markdown
# Commit Conventionnel avec Analyse Git

1. Exécute `git status` pour voir fichiers modifiés
2. Exécute `git diff` pour voir changements
3. Analyse les modifications
4. Génère un message de commit conventionnel :
   - Type : feat/fix/docs/style/refactor/test/chore
   - Scope : composant/module affecté
   - Description : courte et claire
   - Body : détails si nécessaire

5. Demande confirmation avant commit
6. Exécute : git add . && git commit -m "message"

Format :
type(scope): description

body (optionnel)

Exemple :
feat(auth): add login with Google OAuth

Implement OAuth2 flow with Google provider
```

#### 2. /debug - Débogage Systématique

```markdown
# Debug Workflow Systématique

Quand l'utilisateur signale un bug avec /debug "description", suis ce processus :

1. **Reproduction**
   - Demande steps to reproduce
   - Vérifie logs/erreurs

2. **Investigation**
   - Explore code concerné (Grep, Read)
   - Identifie fichiers suspects
   - Analyse stack trace

3. **Hypothèses**
   - Liste causes possibles
   - Prioritise par probabilité

4. **Tests**
   - Teste chaque hypothèse
   - Ajoute logs temporaires si besoin

5. **Fix**
   - Propose solution
   - Implémente après validation
   - Vérifie que bug est résolu

6. **Prevention**
   - Suggère test pour éviter régression
```

#### 3. /prompt - Créer Nouvelles Commandes

```markdown
# Générateur de Commandes Slash

Aide l'utilisateur à créer une nouvelle commande slash personnalisée.

1. Demande :
   - Nom de la commande
   - Description de ce qu'elle doit faire
   - Arguments éventuels
   - Cas d'usage

2. Génère le fichier markdown :
   - Structure claire
   - Workflow en étapes
   - Exemples concrets
   - Best practices

3. Sauvegarde dans .claude/commands/nom.md

4. Rappelle de redémarrer Claude Code (Ctrl+C puis claude)

5. Donne exemple d'utilisation
```

#### 4. /refactor - Amélioration Code

```markdown
# Refactoring Workflow

Pour améliorer du code existant :

1. **Analyse**
   - Lis le fichier ciblé
   - Identifie code smells :
     * Duplication
     * Complexité excessive
     * Nommage peu clair
     * Fonctions trop longues

2. **Suggestions**
   - Propose améliorations concrètes
   - Explique le "pourquoi"
   - Estime impact/risque

3. **Validation**
   - Demande confirmation
   - Discute alternatives

4. **Application**
   - Refactor par étapes
   - Maintient fonctionnalité
   - Vérifie tests passent

5. **Documentation**
   - Update commentaires si nécessaire
   - Explique changements majeurs
```

---

### ✅ Avantages

```
✅ Réutilisabilité    → Prompt complexe = 1 commande simple
✅ Partage équipe     → Workflows standardisés via Git
✅ Autocomplétion     → Terminal et VS Code suggèrent commandes
✅ Documentation      → WebFetch pour récupérer docs externes
✅ Consistency        → Toute l'équipe utilise mêmes workflows
✅ Productivité       → Gain de temps énorme sur tâches répétitives
✅ Évolutif           → Ajouter/modifier commandes facilement
```

---

### ⚠️ Limitations

```
❌ Redémarrage requis   → Nouvelles commandes pas chargées à chaud
❌ Pas d'éditeur visuel → Edition manuelle fichiers markdown
❌ Debug complexe       → Si prompt mal formulé, résultats imprévisibles
❌ Pas de versioning    → Pas d'historique des commandes (utiliser Git)
```

---

### 🎯 Use Cases Concrets

#### 1. Workflow EPCT (Features Complexes)

```bash
# Situation : Ajouter authentification OAuth
claude
> /epct "Implémenter login Google OAuth"

# Résultat :
→ Explore : Recherche doc Google OAuth, lit fichiers auth existants
→ Plan : Propose architecture (route, middleware, UI)
→ Validation : Demande confirmation
→ Code : Implémente selon plan
→ Test : Lance tests auth existants
```

#### 2. Commits Conventionnels

```bash
# Situation : Commit après modifications
claude
> /commit

# Résultat :
→ Analyse git status + git diff
→ Génère : "feat(auth): add Google OAuth login"
→ Demande confirmation
→ Commit automatique
```

#### 3. Debugging Systématique

```bash
# Situation : Bug en production
claude
> /debug "Page 404 sur /dashboard après login"

# Résultat :
→ Demande logs/stack trace
→ Explore routing + auth middleware
→ Identifie cause (redirect incorrect)
→ Propose fix
→ Implémente après validation
```

#### 4. Création de Commandes

```bash
# Situation : Besoin d'une nouvelle commande
claude
> /prompt

# Dialogue :
Claude : "Quel nom pour la commande ?"
> deploy

Claude : "Que doit-elle faire ?"
> Déployer sur Vercel avec tests préalables

# Résultat :
→ Crée .claude/commands/deploy.md
→ Workflow : tests → build → vercel deploy
→ Rappelle de redémarrer Claude
```

---

## 📋 Cheatsheet

### Commandes Essentielles

| Commande | Description | Exemple |
|----------|-------------|---------|
| `/init` | Initialiser projet Claude Code | `/init` |
| `/epct` | Explore-Plan-Code-Test workflow | `/epct "page contact"` |
| `/commit` | Commit conventionnel | `/commit` |
| `/debug` | Débogage systématique | `/debug "erreur 500"` |
| `/prompt` | Créer nouvelle commande | `/prompt` |

### Gestion des Commandes

```bash
# Lister commandes disponibles
ls .claude/commands/
ls ~/.claude/commands/

# Créer nouvelle commande (projet)
touch .claude/commands/ma-commande.md
# → Éditer le fichier
# → Redémarrer Claude (Ctrl+C puis claude)

# Créer nouvelle commande (personnelle)
touch ~/.claude/commands/ma-commande.md
# → Éditer le fichier
# → Redémarrer Claude

# Éditer commande existante
vim .claude/commands/epct.md
# → Redémarrer Claude pour charger modifications

# Supprimer commande
rm .claude/commands/ancienne.md
```

### Structure Fichier Commande

```markdown
# Description (optionnel)

Prompt principal qui sera exécuté.

## Étapes (optionnel, mais recommandé)

1. Première action
2. Deuxième action
3. Etc.

## Variables

{argument} : Remplacé par argument passé à /commande

## Exemples

Donner exemples d'utilisation attendue.
```

### Workflow Typique

```bash
# 1. Créer fichier commande
echo "# Ma Commande\n\nInstructions ici..." > .claude/commands/test.md

# 2. Demander à Claude de rédiger prompt
claude
> "Rédige une commande /test qui fait X, Y, Z"

# 3. Redémarrer Claude
Ctrl+C
claude

# 4. Utiliser la commande
> /test "mon argument"

# 5. Itérer si nécessaire
> "Améliore /test pour aussi faire W"
# → Edit .claude/commands/test.md
# → Redémarrer
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **Prompts Réutilisables** : Transformer prompt complexe en `/commande`
✅ **Deux Scopes** : Projet (.claude/) vs Personnel (~/.claude/)
✅ **Partageable** : Commitez commands/ pour workflow équipe
✅ **Arguments** : Utiliser {variable} dans prompt
✅ **Redémarrage** : Obligatoire après création/modification
✅ **Autocomplétion** : Terminal suggère commandes disponibles

### Commandes Clés

| Action | Commande |
|--------|----------|
| Initialiser projet | `/init` |
| Lister commandes | `ls .claude/commands/` |
| Créer commande | `touch .claude/commands/nom.md` |
| Utiliser commande | `/nom [arguments]` |
| Redémarrer Claude | `Ctrl+C` puis `claude` |

### Différence avec Memory

| Aspect | Commands | Memory |
|--------|----------|--------|
| **Type** | Actions réutilisables | Instructions persistantes |
| **Fichier** | .claude/commands/*.md | .claude/CLAUDE.md |
| **Activation** | Manuelle (`/commande`) | Automatique (toujours) |
| **Utilité** | Workflows répétitifs | Context général projet |
| **Exemple** | `/epct "feature"` | "Use TypeScript strict" |
| **Quand** | Action spécifique | Background permanent |

**Commands** : Ce que tu **demandes explicitement** (foreground)
**Memory** : Ce que Claude **sait toujours** (background)

**Combinés** :
```bash
# Memory (automatic) :
"Use TypeScript, Tailwind, Zod validation"

# Command (manual) :
/epct "Créer page pricing"

# Résultat :
→ Feature avec TypeScript + Tailwind + Zod
  (Memory appliqué automatiquement dans Command)
```

---

## 📚 Ressources

### Documentation Officielle
- 📄 **Claude Slash Commands** : https://code.claude.com/docs/en/slash-commands
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### Articles & Guides
- 📝 **Commands Best Practices (Anthropic)** : https://www.anthropic.com/engineering/claude-code-best-practices
  - Structure optimale prompts réutilisables
  - Guidelines officielles
- 📝 **How I Use Claude Code Commands** : https://blog.sshh.io/p/how-i-use-every-claude-code-feature
  - Workflow quotidien avec commands essentielles

### Vidéos Recommandées
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw (30:00 - Commands)
  - Création de commandes optimales
  - Structure Workflow + Rules + Examples + Critical
- 🎥 **Melvynx - 500h Claude Code Workflow** : [Fiche complète](../../ressources/videos/500h-optimisation-workflow-melvynx.md)
  - Commande `/prompt-command` pour générer des commandes
  - Meta-commande pour automatiser création

### Repositories Communauté
- 🔗 **Weston Hobson Commands** : https://github.com/wshobson/commands
  - Collection communautaire de commandes
  - Commands pour Git, Testing, Deployment
  - Bonnes pratiques structuration
- 🔗 **Claude Code Commands Directory** : https://claudecodecommands.directory/
  - Catalogue communautaire de commands
  - Recherche par catégorie
  - Exemples production-ready

### Outils & Packs
- 🔧 **CCLI Blueprint (Melvynx)** : https://mlv.sh/ccli
  - Pack complet de commandes prêtes à l'emploi
  - `/commit`, `/debug`, `/cloud-memory`, `/prompt-command`
  - Structure optimale selon 500h d'expérience

### Ressources Internes
- 📋 [Cheatsheet Commands](./cheatsheet.md) - Référence rapide
- 🎓 [Exercices Commands](../exercises/commands/) - Créer vos commandes
- 🔗 [Memory](../1-memory/guide.md) - Quand utiliser Memory vs Commands
- 🔗 [Hooks](../3-hooks/guide.md) - Intégration Commands + Hooks
- 🔗 [Workflows](../8-workflows/guide.md) - Commands dans workflows EPCT

---

## Conclusion

Les **Commandes Slash** transforment des prompts complexes répétitifs en **workflows réutilisables en un mot**.

**Principe** : Write once, use everywhere.

**Setup recommandé** :
```
.claude/commands/         # Équipe (partagé Git)
├── epct.md              # Features complexes
├── commit.md            # Commits conventionnels
└── deploy.md            # Déploiement

~/.claude/commands/       # Personnel (local)
├── debug.md             # Débogage
├── prompt.md            # Créer commandes
└── refactor.md          # Amélioration code
```

**Quote Melvynx** :
> "Les commandes slash permettent d'injecter des prompts complexes et réutilisables. C'est un gain de temps énorme."
