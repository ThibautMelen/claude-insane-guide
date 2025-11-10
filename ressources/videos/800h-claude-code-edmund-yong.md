# 800+ hours of Learning Claude Code in 8 minutes

![Miniature Vidéo](https://img.youtube.com/vi/Ffh9OeJ7yxw/maxresdefault.jpg)

**Auteur**: Edmund Yong
**Durée**: 8 minutes
**Date**: 27 octobre 2025
**Sponsorisé par**: Anthropic
**URL**: https://www.youtube.com/watch?v=Ffh9OeJ7yxw

---

## 📋 Résumé

Edmund Yong partage **800+ heures d'expérience** avec Claude Code condensées en 8 minutes. Cette vidéo révèle les **workflows privés, features cachées et setups optimisés** pour développer en solo de manière ultra-productive.

**Public cible**: Solo developers, startup founders, développeurs en entreprise tech

**Promesse**: Arrêter de se battre contre Claude et commencer à shipper rapidement.

---

## 🎯 Concepts Clés Couverts

- **Memory** (.claude/CLAUDE.md) - Persistance des instructions
- **Commands** (custom prompts) - Automatisation DRY
- **MCP Servers** - Connexion aux outils externes
- **Sub-Agents** - Tâches parallèles
- **Plugins** - Cloner des setups optimisés
- **Mindset** - Best practices pour coder avec AI

---

## 📑 Timestamps avec Liens

| Temps | Sujet | Lien Direct |
|-------|-------|-------------|
| [00:00](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=0s) | Introduction - 800 Hours Later | Début |
| [00:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=38s) | **D.R.Y.** (Don't Repeat Yourself) | Memory + Commands |
| [02:04](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=124s) | **Favorite MCP Servers** | Context7, Supabase, etc. |
| [03:52](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=232s) | **Build & Ship in PARALLEL** | Sub-Agents |
| [06:06](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=366s) | **Clone CRACKED Setups** | Plugins |
| [06:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=398s) | **How to EXCEL at Coding with AI** | Mindset |

---

## 🔑 Fonctionnalité 1: Memory (.claude/CLAUDE.md)

### [00:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=38s) - Arrêter de Se Répéter

**Problème**: Répéter les mêmes instructions à chaque session Claude.

**Solution**: La **Memory** de Claude Code.

### Comment ça Marche

```
Session Claude
    ↓
Presse #️⃣ (hash key)
    ↓
Ajoute instructions/contexte
    ↓
Choisir scope:
├── Local (projet actuel)
└── Global (toutes sessions)
    ↓
Sauvegardé dans .claude/CLAUDE.md
```

### Fichier .claude/CLAUDE.md

**C'est quoi?**

Le fichier `.claude/CLAUDE.md` est le **fichier central de mémoire** où Claude stocke:
- Instructions persistantes
- Contexte du projet
- Préférences de comportement

**Emplacement**:
```
.claude/ (projet - NORME OFFICIELLE)
└── CLAUDE.md           # Memory locale

~/.claude/
└── CLAUDE.md           # Memory globale
```

**Exemple de contenu**:
```markdown
# Project Context

This is a Next.js 14 app with:
- TypeScript strict mode
- Tailwind CSS
- Supabase backend

## Coding Preferences

- Always use functional components
- Include proper error handling
- Add TypeScript interfaces for all data
- Follow Airbnb style guide
```

**Édition Manuelle**:

Tu peux **éditer directement** .claude/CLAUDE.md:
```bash
# Ouvrir et modifier
code .claude/CLAUDE.md

# Supprimer une instruction
# → Supprimer la ligne dans le fichier

# Ajouter contexte
# → Écrire directement dans le .md
```

### Équivalents Autres AIs

| AI | Fichier Mémoire | Usage |
|----|----------------|-------|
| **Claude** | `.claude/CLAUDE.md` | Instructions projet/global |
| **Gemini** | `gemini.md` | Contexte persistant Gemini |
| **ChatGPT/Atlas** | `agent.md` | Memory ChatGPT |
| **Codex** | `agents.md` | Instructions Codex |

**Principe Universel**: La "memory" = fichier `.md` accessible, éditable, réutilisé entre sessions.

### Avantages

✅ **Contrôle total** sur la mémoire
✅ **Édition facile** (juste un fichier .md)
✅ **Gestion personnalisée** pour optimiser workflows
✅ **Persistance** entre sessions
✅ **Scope flexible** (local vs global)

### Documentation Officielle

📄 **Claude Code Memory Docs**: https://code.claude.com/docs/memory

---

## 🤖 Fonctionnalité 2: Commands (Prompts Personnalisés)

### [00:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=38s) - Custom Command Library

**Problème**: Taper les mêmes prompts encore et encore pour tâches répétitives.

**Exemple de tâches répétitives**:
- Créer nouveau API endpoint avec middleware custom + error handling + types
- Lancer TypeScript linter et fixer toutes les erreurs
- Générer composant React avec props typées
- Setup test suite pour nouvelle feature

**Solution**: Bibliothèque de **Custom Commands**.

### Qu'est-ce qu'une Command?

Une **command** = **prompt pré-écrit** sauvegardé en fichier `.md` dans un dossier dédié.

**C'est une "macro" d'instructions** pour automatiser workflows sans retaper manuellement.

### Structure

```
.claude/
└── commands/
    ├── create-endpoint.md
    ├── fix-linter.md
    ├── generate-test.md
    └── frontend/
        ├── new-component.md
        └── add-route.md
```

### Créer une Command

**Étape 1**: Créer le dossier
```bash
mkdir -p .claude/commands
```

**Étape 2**: Créer fichier .md
```bash
touch .claude/commands/create-endpoint.md
```

**Étape 3**: Écrire le prompt
```markdown
<!-- .claude/commands/create-endpoint.md -->

Create a new API endpoint with:

1. Express route handler in src/api/
2. Custom middleware for authentication
3. Proper error handling with try/catch
4. TypeScript interfaces for request/response
5. Input validation with Zod
6. JSDoc comments

Include unit tests.
```

**Étape 4**: Utiliser
```bash
claude
→ /create-endpoint "user registration"
```

### Commands avec Arguments

**Les rendre paramétrables** pour différents scénarios:

```markdown
<!-- .claude/commands/create-endpoint.md -->

Create a new {METHOD} endpoint at /api/{ROUTE} with:
- Authentication middleware
- Error handling
- TypeScript types
- Tests

{ADDITIONAL_REQUIREMENTS}
```

**Utilisation**:
```bash
/create-endpoint "POST /api/users - User registration with email verification"
```

### Organisation

**Par domaine** (recommandation Edmund):
```
.claude/commands/
├── frontend/
│   ├── new-component.md
│   ├── add-route.md
│   └── setup-state.md
├── backend/
│   ├── create-endpoint.md
│   ├── add-middleware.md
│   └── database-migration.md
├── testing/
│   ├── unit-test.md
│   ├── e2e-test.md
│   └── fix-failing-tests.md
└── maintenance/
    ├── fix-linter.md
    ├── optimize-code.md
    └── update-deps.md
```

**Bénéfice**: Facile à trouver avec autocomplétion `/` + sous-dossiers.

### Pack de Commands Utiles

**Edmund utilise**: https://github.com/wshobson/commands

**Contenu**: Commands prêtes à l'emploi pour tasks quotidiennes de dev.

**Installation**:
```bash
# Cloner le repo
git clone https://github.com/wshobson/commands.git

# Copier commands dans ton projet
cp -r commands/* .claude/commands/
```

**Exemples de commands incluses**:
- Debugging helpers
- Code refactoring patterns
- Documentation generation
- Test suite creation
- Performance optimization

### Différence avec Autres Concepts

| Concept | Description | Exemple |
|---------|-------------|---------|
| **Commands** | Prompts réutilisables en .md | `/create-endpoint` |
| **Skills** | Capacités intégrées (varie selon plateforme) | Analyse code, debugging |
| **Plugins** | Bundles de config importables | Cloner setup complet |
| **Sub-agents** | Instances Claude isolées pour tâches parallèles | @ui-reviewer |
| **MCP Servers** | Connexions aux services externes | Context7, Supabase |

**Résumé**: Commands = macros pour accélérer workflow sans retaper prompts.

### Documentation Officielle

📄 **Claude Code Slash Commands Docs**: https://code.claude.com/docs/slash-commands

---

## 🔌 Fonctionnalité 3: MCP Servers

### [02:04](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=124s) - Favorite MCP Servers

**Problème**: Claude Code a besoin d'accéder à:
- Documentation à jour (frameworks évoluent constamment)
- Bases de données (query, migrations)
- Browser (debugging frontend)
- APIs externes (Stripe, Vercel)

**Solution**: **MCP Servers** - connecter Claude à outils externes.

### Qu'est-ce qu'un MCP Server?

**Définition simple** (Edmund):

> "A way to connect AI agents to external tools and services"

**MCP Server** = service qui donne à Claude **plus de capacités**:
- Connexion à database
- Appel à custom API
- Exécution code sur serveur remote
- Contrôle du browser
- Accès à docs à jour

### MCP Servers Favoris d'Edmund

#### 1. **Context7** ⭐ **MUST-HAVE**

**URL**: MCP server pour documentation

**Utilité**: Référencer **docs à jour** des libraries populaires.

**Problème résolu**:
```
Avant Context7:
├── Google search docs
├── Copy-paste dans prompt
├── Espérer que c'est la bonne version
└── Perte de temps

Avec Context7:
├── "Use context7 NextJS 14 routing"
└── Claude fetch automatiquement latest docs
```

**Utilisation**:
```bash
claude
→ "Use context7 to reference latest Supabase Auth docs and implement login"
```

**Magic**: Juste ajouter **"Use context7"** dans le prompt!

**Avantages**:
- ✅ Docs toujours à jour
- ✅ Pas de copy-paste manuel
- ✅ Centralisé (1 seul MCP pour toutes les libs)

#### 2. **Supabase MCP**

**Utilité**: Interagir avec database Supabase directement.

**Capacités**:
- Query data depuis l'app
- Apply migrations
- Create new tables
- Update schemas

**Exemple**:
```bash
claude
→ "Using Supabase MCP, create a 'posts' table with user_id, title, content, created_at"
```

**Résultat**: Table créée directement dans Supabase, pas besoin d'aller dans le dashboard.

#### 3. **Chrome Dev Tools + Playwright MCP**

**Utilité**: Debugging et testing frontend autonome.

**Capacités**:
- Contrôler le browser
- Inspect DOM
- Lire console logs
- Exécuter tests E2E
- Prendre screenshots

**Workflow**:
```bash
claude
→ @ui-reviewer (sub-agent connecté à Playwright MCP)
→ "Inspect homepage UI and give feedback on usability"
```

**Résultat**:
- Claude ouvre le browser
- Navigate l'app
- Inspect éléments
- Donne feedback design + usability

**Use case**: Edmund utilise ça pour **UI/UX review automatique**.

#### 4. **Stripe MCP**

**Utilité**: Intégrer paiements sans quitter Claude.

**Capacités**:
- Create payment intents
- Setup webhooks
- Manage subscriptions
- Test payments

**Exemple**:
```bash
claude
→ "Using Stripe MCP, setup monthly subscription for $20/month"
```

#### 5. **Vercel MCP**

**Utilité**: Gérer projets Vercel.

**Capacités**:
- Lookup latest docs
- Change project settings
- Deploy updates
- Check build logs

**Exemple**:
```bash
claude
→ "Use Vercel MCP to check why latest deployment failed"
```

### Où Trouver MCP Servers

**Repos recommandés par Edmund**:

1. **Awesome MCP Servers**
   - Collection communautaire
   - Serveurs vérifiés

2. **Anthropic MCP Registry**
   - Serveurs officiels
   - Documentation complète

3. **GitHub Topic: #mcp-server**
   - Nouveaux serveurs
   - Expérimentaux

**Installation MCP** (générique):
```bash
# Ajouter dans settings Claude Code
# Ou via plugin qui inclut MCP configs
```

### Avantages MCP Servers

✅ **Données à jour** (Context7 pour docs)
✅ **Actions directes** (Supabase migrations)
✅ **Automation** (Playwright testing)
✅ **Intégrations** (Stripe, Vercel)
✅ **Pas de context switching** (tout dans Claude)

---

## 🚀 Fonctionnalité 4: Sub-Agents (Tâches Parallèles)

### [03:52](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=232s) - Build & Ship in PARALLEL

**Avant Sub-Agents** (workflow séquentiel d'Edmund):

```
1. Créer frontend UI components
    ↓ (attendre)
2. Écrire API endpoints
    ↓ (attendre)
3. Run database migrations
    ↓
Feature complète
```

**Problème**: Lent, séquentiel, inefficace.

**Avec Sub-Agents** (workflow parallèle):

```
Session principale (orchestration)
├── @frontend-agent: UI components
├── @api-agent: Endpoints          } En parallèle
└── @db-agent: Migrations
    ↓
Feature complète en fraction du temps
```

### Qu'est-ce qu'un Sub-Agent?

**Définition Edmund**:

> "Isolated Claude instances that can work in parallel with each other and feed crucial information back to the main orchestrator agent"

**Caractéristiques**:
- ✅ **Context window isolé** (pas de pollution)
- ✅ **System prompt séparé**
- ✅ **Tool permissions scopées**
- ✅ **Travail en parallèle**
- ✅ **Retourne résultats à agent principal**

### ❌ Mauvaise Utilisation: Rôles Humains

**Ce que les gens font** (et qui ne marche PAS):

```yaml
# ❌ BAD: Assigner rôles humains
@frontend-developer:
  role: "You are a senior frontend developer"
  task: "Brainstorm and build UI autonomously"

@product-manager:
  role: "You are a PM"
  task: "Define features and prioritize"

@designer:
  role: "You are a UX designer"
  task: "Design the app"
```

**Résultat selon Edmund**:
> "I spent a good couple hours trying to work with agents this way. And the results were pretty bad compared to just using Claude Code with no agent specific instructions."

**Pourquoi ça marche pas**:
- Sub-agents **ne sont pas** des humains
- Pas capables de brainstorming autonome
- Pas de réflexion stratégique
- Pas de "real human thinking"

### ✅ Bonne Utilisation: Tâches Spécifiques

**Ce qui marche** (Edmund's approach):

> "Define sub agents for **tasks, not roles**"

**Exemples de bonnes tâches**:
- ✅ Cleaning up et optimizing code
- ✅ Generating documentation
- ✅ Gathering research data from web
- ✅ UI/UX review
- ✅ Running tests
- ✅ Code analysis

### Exemple Concret: @ui-reviewer

**Setup** (Edmund's sub-agent):

```yaml
# .claude/agents/ui-reviewer.md
---
systemPrompt: |
  Review UI/UX of web app components.

  Process:
  1. Open app in browser via Playwright
  2. Inspect UI components
  3. Analyze design and usability
  4. Provide actionable feedback

  Focus on:
  - Visual hierarchy
  - Accessibility
  - Responsive design
  - User flow
tools:
  - playwright_mcp  # Connecté à Playwright MCP
---

# UI Reviewer

Reviews UI/UX and provides design feedback.
```

**Utilisation**:
```bash
claude
→ @ui-reviewer "Review homepage"
```

**Résultat**:
- Ouvre browser
- Inspect homepage
- Donne feedback concret sur design/usability

**Avantage**:
- ✅ Tâche spécifique bien définie
- ✅ Utilise MCP (Playwright) pour exécution
- ✅ Pas de pollution du context window principal
- ✅ Output de qualité

### Créer un Sub-Agent

**Process** (selon Edmund):

1. **Use /agents command**
   ```bash
   /agents
   ```

2. **Create new agent**
   - Cliquer "Create a new agent"

3. **Choose scope**
   - **Project**: Spécifique au projet actuel
   - **Personal**: Global (tous projets)

4. **Generate with Claude**
   - "Generate with Claude"
   - Décrire la tâche en langage naturel

5. **Customize tool permissions**
   - Sélectionner tools nécessaires
   - Principe du moindre privilège

6. **Save**

**Invoke** (utiliser):
```bash
# Option 1: Natural language
"Use the UI reviewer agent to check the dashboard"

# Option 2: @ symbol
@ui-reviewer "Check dashboard"
```

### Pourquoi Ça Marche

**Avantages** (Edmund):

✅ **Offloading smaller tasks** → Libère context window principal
✅ **Isolated context** → Chaque agent démarre fresh
✅ **Scoped permissions** → Sécurité (agent read-only si besoin)
✅ **Higher quality output** → Focus sur tâche spécifique
✅ **Parallel execution** → Plus rapide

**Quote Edmund**:
> "They still saved me a lot of time and effort on tasks it's actually good at"

### Best Practice Sub-Agents

**DO**:
- ✅ Define pour **tâches spécifiques**
- ✅ Connect to **relevant MCP servers**
- ✅ Give **clear system prompts**
- ✅ Scope **tool permissions**

**DON'T**:
- ❌ Assign "human roles" (PM, designer, dev)
- ❌ Expect autonomous brainstorming
- ❌ Give too many permissions
- ❌ Use for tasks that need main context

---

## 📦 Fonctionnalité 5: Plugins (Cloner Setups)

### [06:06](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=366s) - Clone CRACKED Setups

**Problème**: Setup manuel de:
- Commands
- Sub-agents
- MCP servers
- Memory configs

**= Beaucoup de travail!**

**Solution**: **Plugins** - bundles de setups complets.

### Qu'est-ce qu'un Plugin?

**Définition**:

> "Plugins allow users to bundle up their setups into a single package"

**Plugin** = package qui contient:
- Commands
- Sub-agents
- MCP server configs
- Memory templates
- Tool permissions

**Résultat**: **Cloner un workflow complet** d'un power user en 1 commande.

### Plugin d'Edmund

**GitHub**: https://github.com/edmund-io/edmunds-claude-code

**Installation**:
```bash
# Commande pour ajouter plugin marketplace d'Edmund
# (voir repo pour commande exacte)
```

**Contenu** (typiquement):
- ✅ Commands library (create-endpoint, fix-linter, etc.)
- ✅ Sub-agents (ui-reviewer, code-optimizer, etc.)
- ✅ MCP configs (Context7, Supabase, Playwright, etc.)
- ✅ Memory templates (coding preferences)

**Usage**:

```bash
# Après installation marketplace
claude
→ Browse plugins
→ Pick and choose ce dont tu as besoin
→ Install
```

**Flexibilité**:
> "Feel free to add only what you need"

Tu n'es **pas obligé** de tout installer, juste ce qui t'intéresse.

### Avantages Plugins

✅ **Gain de temps** - Pas de setup manuel
✅ **Best practices** - Apprendre de power users
✅ **Modularité** - Pick & choose
✅ **Partage** - Publish ton propre setup
✅ **Communauté** - Découvrir workflows optimisés

### Créer Son Propre Plugin

**Étapes** (probable):
1. Organiser ton setup (commands, agents, MCPs)
2. Bundler dans plugin format
3. Publish sur GitHub
4. Partager avec communauté

**Résultat**: Autres devs peuvent clone ton workflow optimisé!

---

## 🧠 Fonctionnalité 6: Mindset & Best Practices

### [06:38](https://www.youtube.com/watch?v=Ffh9OeJ7yxw&t=398s) - How to EXCEL at Coding with AI

**Edmund partage le mindset** adopté après 800h d'usage.

### Règle 1: Garbage In = Garbage Out

**Quote**:
> "If you can't write a prompt that clearly instructs the AI on what to do, then you don't actually know what you want, and the AI definitely won't either."

**Implication**:

**Mauvais prompt** = résultat médiocre, même avec meilleur AI.

**Solution**: **Apprendre prompt engineering basique**.

**Bénéfices** (Edmund):
- ✅ Force à **décomposer problèmes** en petits morceaux
- ✅ **Clarifie ses propres pensées**
- ✅ Meilleurs résultats de Claude

### Règle 2: Utiliser Plan Mode

**Si l'idée est vague** dans ta tête:

```bash
claude
→ Shift+Tab (Plan Mode)
→ "I want to build user authentication"

Claude pose questions clarifiantes:
- Email/password ou OAuth?
- JWT ou sessions?
- Password reset flow?
- 2FA required?

→ Q&A session
→ Idée clarifiée
→ THEN let it write code
```

**Avantage**: Être **sur la même page** avant code generation.

**Edmund**:
> "I will use Claude's plan mode to have a quick Q&A session and make it ask me clarifying questions so we can be on the same page before I let it write any code."

### Règle 3: Humans Own the Code

**Quote**:
> "AI generates code, but humans own it."

**Process recommandé**:

**Avant push to production**:
```bash
# 1. Nouvelle session (fresh context)
claude (new session)

# 2. Demander review
→ "Review all files you recently touched and check for:
   - Security vulnerabilities
   - Performance issues
   - Error handling gaps
   - Edge cases missed"

# 3. Fix issues trouvés

# 4. THEN push
```

**Responsabilité humaine**:

❌ **Ne PAS laisser AI te rendre lazy** sur:
- Security
- Performance
- Error handling

**Quote Edmund**:
> "Don't let the AI make you lazy about the fundamentals like security, performance, or error handling, because given enough time, if you keep ignoring these things, it will eventually lead to vulnerabilities and bugs"

### Règle 4: Speed ≠ Everything

**Quote**:
> "Speed means nothing if your app is buggy or insecure"

**Balance**:
- ✅ Shipper vite avec AI
- ✅ MAIS review constamment
- ✅ Maintenir qualité

**Mindset**: AI accélère, mais **humain valide**.

### Résumé Best Practices

| Practice | Description |
|----------|-------------|
| **Clear prompts** | Décomposer problèmes, clarifier pensées |
| **Plan Mode** | Q&A avec Claude avant code |
| **Code review** | Toujours review avant production |
| **Own the code** | Responsabilité humaine sur qualité |
| **Security first** | Ne jamais ignorer fundamentals |
| **Constant validation** | Review réguliers, pas juste à la fin |

---

## 🔗 Ressources Mentionnées

### Repos GitHub

1. **Edmund's Claude Code Setup**
   - URL: https://github.com/edmund-io/edmunds-claude-code
   - Contenu: Plugin marketplace avec commands, agents, MCPs
   - Usage: Cloner setup complet d'Edmund

2. **Useful Commands Library**
   - URL: https://github.com/wshobson/commands
   - Contenu: Commands pour tasks quotidiennes
   - Usage: Bibliothèque de prompts réutilisables

### Documentation Officielle

1. **Claude Code Memory**
   - URL: https://code.claude.com/docs/memory
   - Sujet: Fichier .claude/CLAUDE.md, scope local/global

2. **Slash Commands**
   - URL: https://code.claude.com/docs/slash-commands
   - Sujet: Créer custom commands

3. **Sub-Agents**
   - URL: https://code.claude.com/docs/sub-agents
   - Sujet: Agents isolés pour tâches parallèles

4. **Plugins**
   - URL: (docs Anthropic)
   - Sujet: Bundler et partager setups

### Essayer Claude Code

**Max Plan**: http://clau.de/edmund (lien sponsorisé)

### Autres Startups Edmund

1. **Transcribr.io** - Service de transcription
2. **Easy Folders** - Extension Chrome pour ChatGPT

---

## 💡 Insights Clés à Retenir

### Memory (.claude/CLAUDE.md)

✅ Fichier central de mémoire persistante
✅ Scope local (projet) ou global (tous projets)
✅ Éditable manuellement
✅ Équivalents: gemini.md, agent.md (ChatGPT)

### Commands

✅ Prompts réutilisables en .md
✅ Peuvent accepter arguments
✅ Organisés par domaine (frontend/, backend/, etc.)
✅ Automatisent tâches répétitives
✅ ≠ Skills, Plugins, Sub-agents, MCP

### MCP Servers

✅ Connectent Claude à outils externes
✅ **Context7** = must-have (docs à jour)
✅ Supabase, Playwright, Stripe, Vercel = favoris
✅ Éliminent context switching

### Sub-Agents

✅ Définis pour **tâches**, pas rôles
✅ Context isolé = pas de pollution
✅ Connecter à MCP pertinents
✅ Travail en parallèle = plus rapide
✅ ❌ Pas pour brainstorming autonome

### Plugins

✅ Bundle complet de setup
✅ Cloner workflows de power users
✅ Pick & choose ce dont tu as besoin
✅ Économie de temps setup

### Mindset

✅ Clear prompts = clear results
✅ Plan Mode pour clarifier idées vagues
✅ Toujours review code AI
✅ Humans own the code
✅ Security & performance > speed

---

## 🎯 Workflow Complet d'Edmund (800h)

### Setup Initial

```bash
# 1. Installer Plugin Edmund
# Ajoute: commands, sub-agents, MCPs

# 2. Configurer Memory
claude
→ #️⃣ (hash)
→ Ajouter préférences coding
→ Save to .claude/CLAUDE.md (global)

# 3. Organiser Commands
.claude/commands/
├── frontend/
├── backend/
├── testing/
└── maintenance/
```

### Développer une Feature

```bash
# 1. Plan Mode (si idée vague)
Shift+Tab
→ Q&A avec Claude pour clarifier

# 2. Workflow Parallèle
claude
→ "Build user auth feature using:"
→ @frontend-agent: UI components
→ @api-agent: Endpoints (use Context7 for latest docs)
→ @db-agent: Migrations (use Supabase MCP)

# 3. Review UI
@ui-reviewer "Check auth flow UX"

# 4. Review Code
New session:
→ "Review all auth-related files for security"

# 5. Fix Issues

# 6. Push
```

### Maintenance

```bash
# Commands pour tasks répétitives
/fix-linter
/optimize-code
/update-deps
/generate-docs
```

---

## 📊 Comparaison Concepts

| Concept | Type | Fichier | Utilité | Exemple |
|---------|------|---------|---------|---------|
| **Memory** | Mémoire | .claude/CLAUDE.md | Persistance instructions | Coding preferences |
| **Commands** | Prompts | .claude/commands/*.md | Automatiser tâches | /create-endpoint |
| **Sub-Agents** | Agents | .claude/agents/*.md | Tâches parallèles | @ui-reviewer |
| **Plugins** | Bundles | Package | Cloner setups | edmund's plugin |
| **MCP Servers** | Intégrations | Config | Connect externes | Context7, Supabase |
| **Skills** | Capacités | (intégré) | Features natives | Code analysis |

---

## 🚀 Pour Aller Plus Loin

### Niveau 1: Débutant (Setup de base)

1. ✅ Essayer Claude Code Max plan
2. ✅ Configurer memory (.claude/CLAUDE.md)
3. ✅ Installer plugin Edmund
4. ✅ Tester commands de base

### Niveau 2: Intermédiaire (Optimisation)

1. ✅ Créer custom commands pour tes tasks répétitives
2. ✅ Setup Context7 MCP
3. ✅ Créer premier sub-agent
4. ✅ Pratiquer Plan Mode

### Niveau 3: Avancé (Production)

1. ✅ Workflow parallèle avec multiple sub-agents
2. ✅ Connecter MCPs spécifiques (Supabase, Stripe, etc.)
3. ✅ Créer ton propre plugin
4. ✅ Code review systématique avant push

---

## 🎬 Citation Finale

> "After spending over 800 hours in Claude Code, I've discovered ways to actually make this thing work for me, not against me."
>
> — **Edmund Yong**

**Takeaway**: Les 800h d'Edmund montrent qu'avec le bon setup (memory, commands, MCPs, sub-agents, plugins) et le bon mindset (clear prompts, reviews, ownership), Claude Code devient un **outil de productivité 10x** pour solo developers.

---

## 📝 Notes Personnelles

<!-- Ajoutez vos expériences après avoir regardé la vidéo -->

**Commands créées**:
-
-

**Sub-agents testés**:
-
-

**MCP Servers installés**:
-
-

**Insights personnels**:
-
-
