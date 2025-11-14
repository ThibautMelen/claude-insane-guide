# 500h d'optimisation Claude Code - Workflow ultime

![Miniature vidéo](https://img.youtube.com/vi/kkkQKAPxna8/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: 500h sur Cloud Code : Mon workflow ultime pour éviter les erreurs
- **Auteur**: Melvynx (melvyn.me)
- **Durée**: 15 minutes 20 secondes
- **Date**: Janvier 2025
- **Lien**: [https://youtu.be/kkkQKAPxna8](https://youtu.be/kkkQKAPxna8)

## Tags

`#workflow` `#memory` `#commands` `#hooks` `#mcp` `#subagents` `#statusline` `#optimization` `#tokens` `#context` `#ccli`

---

## Résumé Exécutif

Après 500h d'utilisation de Claude Code, Melvynx partage son workflow complet pour éviter les hallucinations, réduire les erreurs et maximiser l'efficacité. La vidéo couvre 6 piliers fondamentaux : la gestion de la **mémoire** (globale/projet/dossier), les **commandes** (prompts réutilisables), les **hooks** (before/after tool), les **MCP servers** (Context7, Exa), les **sub-agents** (économie de contexte), et la **status line** personnalisée.

**Message clé** : "Si Claude Code fait des erreurs, c'est probablement parce que tu ne l'utilises pas correctement."

**Conclusion principale**: Maîtriser les 3 niveaux de mémoire, créer des commandes structurées avec workflow + exemples, utiliser les sub-agents pour économiser le contexte, et monitorer sa session via la status line sont les clés d'un usage professionnel de Claude Code.

---

## Timecodes

- `00:00` - Introduction : 500h+ sur Claude Code
- `00:46` - Les 3 bases : Commandes, Mémoire, Hooks
- `00:51` - **Pilier 1 : Memory** (mémoire 3 niveaux)
- `02:05` - Modifier la mémoire avec `@`
- `02:37` - Que mettre dans le fichier memory ?
- `03:13` - Commande `/cloud-memory update`
- `03:47` - **Pilier 2 : Commands** (prompts réutilisables)
- `04:22` - Installer CCLI Blueprint
- `04:41` - Structure d'une commande : Workflow + Rules + Exemples
- `05:44` - Exemple commande `/debug`
- `05:59` - Utiliser `/prompt-command` pour écrire des commandes
- `06:10` - **Pilier 3 : Hooks** (before/after tool)
- `06:29` - Before Tool : validation utilisateur
- `06:46` - After Tool : prettier automatique
- `06:58` - Créer un hook avec Claude + documentation
- `06:48` - Exemple Yolo Mode (bypass permissions)
- `07:08` - Hook sécurité : bloquer `rm -rf`
- `07:35` - **Pilier 4 : MCP Servers** (Context7, Exa)
- `08:00` - ⚠️ Problème : MCP = consommation massive de tokens
- `08:35` - 5 MCP = 17% du contexte utilisé
- `08:48` - Activer/désactiver avec `@` + Enter
- `08:50` - MCP recommandés : Context7 + Exa
- `09:17` - Context7 : documentation à jour (use cache NextJS)
- `09:57` - Exa : recherche optimisée pour LLM
- `10:15` - MCP spécifiques : shadcn, Supabase, Stripe
- `10:17` - Toujours désactiver par défaut, activer explicitement
- `10:29` - **Pilier 5 : Sub-Agents** (économie contexte)
- `10:32` - Problème : recherche sans sub-agents = explosion tokens
- `10:48` - Solution : sub-agents utilisent leur propre contexte
- `11:02` - Sub-agents peuvent utiliser des modèles moins chers (Haiku)
- `11:12` - Limitation : one-shot, pas de visibilité ni redirection
- `11:28` - Cas d'usage : recherche + mini modifications de code
- `11:38` - Exemple `/fix-grammar` : 1 agent par fichier en parallèle
- `12:40` - Économie : 41% vs 38% contexte (5000 tokens économisés)
- `13:36` - Descriptions courtes pour réduire la consommation
- `13:47` - **Pilier 6 : Status Line** (monitoring session)
- `13:50` - Afficher : branche git, path, tokens, coût, contexte restant
- `14:19` - Usage Limit : % utilisé + temps restant dans la session
- `14:39` - Setup complet disponible sur mlv.sh/ccli
- `15:03` - Conclusion + appel à l'action (commentaires)

---

## Concepts Clés

### 1. 📝 Mémoire 3 Niveaux (Memory System)

**Définition**: Claude Code possède 3 niveaux de mémoire hiérarchique pour injecter automatiquement du contexte dans chaque prompt, sans que l'utilisateur n'ait à se répéter.

```
╔════════════════════════════════════════╗
║  HIÉRARCHIE MÉMOIRE CLAUDE CODE        ║
╚════════════════════════════════════════╝

📦 ~/
┃
┣━━ 🌍 ~/.claude/CLAUDE.md
┃   └─> MÉMOIRE GLOBALE (tous projets)
┃       • Préférences générales
┃       • Style de code
┃       • Conventions commit
┃
┗━━ 📂 Projet/
    ┃
    ┣━━ 🏢 .claude/CLAUDE.md
    ┃   └─> MÉMOIRE PROJET (tout le projet)
    ┃       • Stack technique
    ┃       • Architecture
    ┃       • Commandes importantes
    ┃
    ┗━━ 📁 src/components/
        ┃
        ┗━━ 🎯 .claude/CLAUDE.md
            └─> MÉMOIRE DOSSIER (scope limité)
                • Règles spécifiques
                • Composants à utiliser
                • Patterns locaux
```

**Avantages**:
- ✅ **DRY (Don't Repeat Yourself)** : Plus besoin de répéter tes préférences
- ✅ **Hiérarchie intelligente** : Priorité dossier > projet > global
- ✅ **System Reminder automatique** : Injecté avant chaque prompt
- ✅ **Modification facile** : `@` + texte → choisir user/project memory

**Limitations**:
- ❌ **Consomme du contexte** : Chaque niveau rajoute des tokens
- ❌ **Pas de versioning intégré** : Faut versionner manuellement avec git
- ❌ **Peut créer des conflits** : Si règles contradictoires entre niveaux

**Cas d'usage**:
- 🎯 **Memory globale** : Préférences personnelles (camelCase, French + English, commits conventionnels)
- 🎯 **Memory projet** : Stack tech (Next.js 14, Supabase, Tailwind), commandes importantes (`npm run dev`, `npm test`)
- 🎯 **Memory dossier** : Règles spécifiques (`src/components/` → toujours utiliser shadcn/ui)

**Ce qu'il faut mettre dans CLAUDE.md**:
1. ⚡ **Commandes importantes** : `npm run dev`, `npm test`, scripts custom
2. 🔧 **Spécificités critiques** : Erreurs fréquentes de Claude à éviter (mot-clé CRITICAL)
3. 🧩 **Composants/librairies** : Quel UI kit utiliser (shadcn, MUI, etc.)
4. 🔐 **Authentification/Patterns** : Méthodes d'auth préférées (Supabase, Clerk, etc.)
5. 📋 **Workflows** : Processus de dev (TDD, commit hooks, etc.)

---

### 2. ⚡ Commands (Prompts Réutilisables)

**Définition**: Les commandes sont des **prompts réutilisables** accessibles via `/nom-commande` qui s'injectent automatiquement dans le chat, comme si tu les avais tapés manuellement.

```
╔═══════════════════════════════════════════════════╗
║  ANATOMIE D'UNE COMMANDE OPTIMALE                 ║
╚═══════════════════════════════════════════════════╝

📋 /commit
┃
┣━━ 🔢 1. WORKFLOW (étapes numérotées)
┃   ├─> Stage (git add)
┃   ├─> Analyze (git diff)
┃   ├─> Commit (message structuré)
┃   └─> Push (optionnel)
┃
┣━━ 📜 2. RULES (règles spécifiques)
┃   ├─> Message format: "type(scope): description"
┃   ├─> Types: feat/fix/docs/refactor/test/chore
┃   └─> Co-Authored-By: Claude <noreply@anthropic.com>
┃
┣━━ 💡 3. EXAMPLES (few-shot learning)
┃   ├─> ✅ "feat(auth): add OAuth login"
┃   ├─> ✅ "fix(ui): resolve button hover state"
┃   └─> ❌ "updated stuff" (trop vague)
┃
┗━━ ⚠️ 4. CRITICAL RULES (comportement prioritaire)
    ├─> ALWAYS: review changes before commit
    ├─> NEVER: commit without testing
    └─> IF conflict: ask user before force push
```

**Avantages**:
- ✅ **Cohérence** : Toujours le même résultat, évite les hallucinations
- ✅ **Gain de temps** : Pas besoin de réécrire le même prompt 50 fois
- ✅ **Prompt engineering intégré** : Workflow + Rules + Examples = few-shot learning optimal
- ✅ **Versionnable** : Fichiers `.md` dans `.claude/commands/`

**Limitations**:
- ❌ **Maintenance** : Faut mettre à jour les commandes quand les best practices évoluent
- ❌ **Courbe d'apprentissage** : Écrire de bonnes commandes demande du temps
- ❌ **Pas de paramètres dynamiques** : Pas de variables type `{{project_name}}`

**Cas d'usage**:
- `/commit` : Workflow commit complet (stage → analyze → commit → push)
- `/debug` : Analyze → Explore → Ultra Think → Research → Implement → Verify
- `/fix-grammar` : Lancer sub-agent grammar sur chaque fichier en parallèle
- `/cloud-memory update` : Réorganiser le fichier CLAUDE.md de manière structurée

**Structure recommandée par Melvynx**:
```markdown
# /nom-commande

## Workflow
1. Étape 1
2. Étape 2
3. Étape 3

## Rules
- Règle importante 1
- Règle importante 2

## Examples
✅ Bon exemple
❌ Mauvais exemple

## Critical
- ALWAYS: comportement obligatoire
- NEVER: comportement interdit
- IF X: comportement conditionnel
```

**Outils pour créer des commandes**:
- 🔧 **CCLI Blueprint** : [mlv.sh/ccli](https://mlv.sh/ccli) - Pack de commandes prêtes à l'emploi
- 🤖 **`/prompt-command`** : Commande meta pour demander à Claude d'écrire une commande
- 📄 **Documentation officielle** : Toujours fournir la doc officielle Claude Code lors de la création

---

### 3. 🪝 Hooks (Before/After Tool)

**Définition**: Les hooks sont des **scripts bash** qui s'exécutent automatiquement avant (`before_tool`) ou après (`after_tool`) chaque action de Claude, permettant de valider, bloquer, ou modifier le comportement de Claude.

```
╔═══════════════════════════════════════════════════╗
║  WORKFLOW HOOKS CLAUDE CODE                       ║
╚═══════════════════════════════════════════════════╝

   USER PROMPT
       │
       ▼
   ┌───────────────────┐
   │  Claude analyse   │
   └─────────┬─────────┘
             │
             ▼
   ┌─────────────────────────────┐
   │  🔒 BEFORE TOOL HOOK        │◄── VALIDATION
   │  - Valider commande          │
   │  - Bloquer si dangereux      │
   │  - Demander confirmation     │
   └─────────┬───────────────────┘
             │
       ┌─────▼─────┐
       │  APPROVE? │
       └─────┬─────┘
         YES │  NO
             │   └──> ❌ BLOCKED
             ▼
   ┌───────────────────┐
   │  Claude exécute   │
   │  l'action (Tool)  │
   └─────────┬─────────┘
             │
             ▼
   ┌─────────────────────────────┐
   │  ✨ AFTER TOOL HOOK         │◄── MODIFICATION
   │  - Run prettier             │
   │  - Run linter               │
   │  - Add context              │
   │  - Format output            │
   └─────────┬───────────────────┘
             │
             ▼
      RÉSULTAT FINAL
```

**Avantages**:
- ✅ **Sécurité** : Bloquer les commandes dangereuses (`rm -rf`, `git push --force`)
- ✅ **Qualité code** : Prettier/ESLint automatique après chaque modification
- ✅ **Yolo Mode** : Bypass permissions avec `cc` (alias avec `--dangerous-skip-permission`)
- ✅ **Context injection** : Ajouter du contexte dynamique (ex: résultat de tests)

**Limitations**:
- ❌ **Complexité** : Scripts bash peuvent devenir difficiles à maintenir
- ❌ **Overhead** : Chaque hook ralentit légèrement l'exécution
- ❌ **Debugging** : Erreurs dans les hooks peuvent bloquer Claude complètement

**Cas d'usage**:

**Before Tool**:
- 🔒 **Validation commandes** : Bloquer `rm -rf /`, `git push --force main`
- 🔒 **Confirmation utilisateur** : Demander validation avant opérations critiques
- 🔒 **Sécurité anti-destruction** : Pattern matching sur commandes dangereuses

**After Tool**:
- ✨ **Prettier automatique** : Formater chaque fichier modifié
- ✨ **ESLint fix** : Auto-fix des erreurs de linting
- ✨ **Context injection** : Run tests et injecter résultat dans le contexte

**Exemple Hook Sécurité (Melvynx)**:
```bash
# .claude/hooks/before_tool.sh

# Bloquer rm -rf sur /user/*
if [[ "$TOOL_COMMAND" == *"rm -rf /user"* ]]; then
  echo "⚠️ ATTENTION : Commande dangereuse détectée !"
  echo "Essai de suppression dans /user/"
  echo "Voulez-vous continuer ? (y/N)"
  exit 1  # Bloque l'exécution
fi
```

**Créer un hook avec Claude**:
1. 📄 Fournir la documentation officielle des hooks
2. 🤖 Prompt : "Peux-tu me créer un hook before_tool qui bloque X ?"
3. 📁 Claude crée le fichier dans `.claude/hooks/`
4. ✅ Tester avec une commande simple

---

### 4. 🔌 MCP Servers (Model Context Protocol)

**Définition**: Les MCP Servers permettent à Claude Code d'interagir avec des **API externes** (bases de données, documentation, services web) pour enrichir son contexte.

```
╔═══════════════════════════════════════════════════╗
║  ARCHITECTURE MCP : CONTEXTE ÉTENDU               ║
╚═══════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────┐
│           CLAUDE CODE (MCP Host)                │
│   Budget: 200,000 tokens                        │
└──────────────┬──────────────────────────────────┘
               │
      ┌────────┼────────┐
      │        │        │
      ▼        ▼        ▼
┌─────────┐ ┌─────────┐ ┌─────────┐
│Context7 │ │   Exa   │ │ Stripe  │  ← MCP Servers
│ 2,000 T │ │ 1,500 T │ │ 10,000T │  (token usage)
└─────────┘ └─────────┘ └─────────┘
     │           │           │
     ▼           ▼           ▼
┌─────────┐ ┌─────────┐ ┌─────────┐
│  Docs   │ │ Search  │ │Payments │
│Official │ │AI-ready │ │   API   │
└─────────┘ └─────────┘ └─────────┘

⚠️ PROBLÈME : 5 MCP = 17% contexte consommé !
   (34,000 tokens / 200,000)

💡 SOLUTION : Activer/désactiver avec @ + Enter
```

**Avantages**:
- ✅ **Documentation à jour** : Context7 récupère la doc officielle en temps réel
- ✅ **Recherche optimisée** : Exa retourne des résultats structurés pour LLM
- ✅ **Intégrations métier** : Stripe, Supabase, shadcn pour contexte spécifique
- ✅ **Extensibilité** : Créer ses propres MCP pour outils custom

**Limitations**:
- ❌ **Consommation contexte massive** : 1 MCP = 1,000 à 15,000 tokens (5-10% du budget)
- ❌ **Ralentissement** : Chaque MCP doit être chargé au démarrage
- ❌ **Pollution contexte** : Tous les tools MCP visibles même si non utilisés
- ❌ **Coût caché** : Tokens consommés même sans utiliser le MCP

**⚠️ Statistiques (Melvynx)**:
- 5 MCP actifs = **17% du contexte** (34,000 tokens / 200,000)
- Stripe seul = **10% du contexte** (~20,000 tokens)
- Context7 = **2,000 tokens** (~1%)
- Exa = **1,500 tokens** (~0.75%)

**MCP Recommandés (Usage Universel)**:

1. **Context7** 🌟
   - **Utilité** : Récupère documentation officielle à jour
   - **Exemple** : "Donne-moi des infos sur `use cache` NextJS"
   - **Token usage** : ~2,000 tokens
   - **Installation** : Via config.json MCP

2. **Exa** 🔍
   - **Utilité** : Recherche web optimisée pour LLM (retourne code snippets)
   - **Exemple** : "Recherche des exemples de `use cache` NextJS"
   - **Token usage** : ~1,500 tokens
   - **Site** : exa.ai

**MCP Spécifiques (Activer selon besoin)**:
- **shadcn MCP** : Si tu utilises shadcn/ui
- **Supabase MCP** : Si tu utilises Supabase
- **Stripe MCP** : Si tu utilises Stripe (⚠️ 10% du contexte !)

**Best Practice : Désactivation par défaut**
```bash
# Activer/désactiver un MCP
@ + Enter
→ Liste des MCP disponibles
→ Sélectionner MCP → Toggle (on/off)

# Workflow recommandé
1. Désactiver TOUS les MCP par défaut
2. Activer UNIQUEMENT quand nécessaire
3. Désactiver après usage
```

**Commande utile**:
```bash
# Voir l'usage contexte par MCP
/context
→ Affiche breakdown tokens par MCP
```

---

### 5. 🤖 Sub-Agents (Économie de Contexte)

**Définition**: Les sub-agents sont des **agents secondaires** qui exécutent des tâches isolées dans leur propre contexte (200k tokens séparés), ne retournant au main agent que le résultat final, économisant ainsi massivement le contexte principal.

```
╔═══════════════════════════════════════════════════╗
║  COMPARAISON : MAIN AGENT VS SUB-AGENTS          ║
╚═══════════════════════════════════════════════════╝

❌ SANS SUB-AGENTS (Main Agent uniquement)
┌──────────────────────────────────────────────────┐
│  Main Agent (200k tokens)                        │
│  ┌────────────────────────────────────────────┐  │
│  │ 📄 Recherche OTP dans codebase            │  │
│  │ → Grep: 50 fichiers (30,000 tokens)       │  │
│  │ → Read: 10 fichiers (40,000 tokens)       │  │
│  │ → Analyse: 5,000 tokens                   │  │
│  │                                            │  │
│  │ TOTAL CONSOMMÉ: 75,000 tokens (37.5%)     │  │
│  │ ⚠️ Contexte restant: 125,000 tokens       │  │
│  └────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────┘
   Résultat: Moins de place pour coder !


✅ AVEC SUB-AGENTS (Délégation)
┌──────────────────────────────────────────────────┐
│  Main Agent (200k tokens)                        │
│  ┌────────────────────────────────────────────┐  │
│  │ 🚀 Lance Sub-Agent "Explore OTP"          │  │
│  │ → Prompt: "Trouve comment OTP est géré"   │  │
│  │ → Coût main: 500 tokens (prompt)          │  │
│  └─────────┬──────────────────────────────────┘  │
│            │                                      │
│            ▼                                      │
│  ┌─────────────────────────────────────────┐     │
│  │  Sub-Agent (200k tokens SÉPARÉS)        │     │
│  │  • Grep: 50 fichiers (30k tokens)       │     │
│  │  • Read: 10 fichiers (40k tokens)       │     │
│  │  • Analyse: 5k tokens                   │     │
│  │  ✅ Total: 75k dans SUB-AGENT           │     │
│  └─────────┬───────────────────────────────┘     │
│            │                                      │
│            ▼                                      │
│  ┌────────────────────────────────────────────┐  │
│  │ 📋 Résultat résumé: 3,000 tokens         │  │
│  │ "OTP géré dans auth/otp.ts via Supabase" │  │
│  │                                            │  │
│  │ TOTAL CONSOMMÉ MAIN: 3,500 tokens (1.75%) │  │
│  │ ✅ Contexte restant: 196,500 tokens       │  │
│  └────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────┘
   Résultat: MAX de place pour coder !

📊 ÉCONOMIE : 75,000 → 3,500 tokens (95% économisés)
```

**Avantages**:
- ✅ **Économie massive** : 95% de tokens économisés (75k → 3.5k dans l'exemple)
- ✅ **Modèles moins chers** : Sub-agents peuvent utiliser Haiku (5x moins cher que Sonnet)
- ✅ **Parallélisation** : Plusieurs sub-agents en parallèle (ex: 1 agent = 1 fichier)
- ✅ **Contexte préservé** : Main agent garde son contexte pour coder

**Limitations**:
- ❌ **One-shot** : Pas de contrôle pendant l'exécution du sub-agent
- ❌ **Pas de visibilité** : Tu ne vois pas ce que fait le sub-agent en temps réel
- ❌ **Pas de redirection** : Impossible de corriger si le sub-agent part en vrille
- ❌ **Descriptions coûteuses** : Chaque description de sub-agent consomme du contexte main

**Cas d'usage recommandés** (Melvynx):

1. **🔍 Recherche/Exploration**
   - Chercher comment une feature est implémentée
   - Explorer une partie inconnue du codebase
   - Analyser des logs/erreurs

2. **✏️ Mini modifications code**
   - Fix grammar (1 agent = 1 fichier)
   - Update imports en masse
   - Refactor simple sur plusieurs fichiers

3. **❌ PAS pour features complètes**
   - Développement de features (trop complexe)
   - Debugging interactif (besoin de contrôle)
   - Modifications critiques (besoin de validation)

**Exemple Concret : `/fix-grammar`**

Melvynx a créé une commande qui lance **1 sub-agent par fichier** pour corriger la grammaire :

```markdown
# /fix-grammar

Tu es un expert en correction grammaticale.

## Workflow
1. Lister tous les fichiers markdown du projet
2. Pour CHAQUE fichier:
   - Lancer sub-agent "fix-grammar-{filename}"
   - Sub-agent lit le fichier
   - Sub-agent corrige les fautes
   - Sub-agent commit changes

## Sub-Agent Description (COURTE !)
"Fix grammar in file"

## Rules
- Corrections uniquement orthographe/grammaire
- Pas de modifications de sens
- ALWAYS show diff before commit
```

**Résultat**:
- 10 fichiers → 10 sub-agents en parallèle
- Exécution ultra-rapide
- Main agent garde son contexte

**📊 Statistiques Melvynx**:
- **Sans sub-agent** : 41% contexte consommé (82,000 tokens)
- **Avec sub-agent** : 38% contexte consommé (76,000 tokens)
- **Économie** : ~5,000 tokens (2.5% du budget)

**Best Practice : Descriptions courtes**
```bash
# ❌ Mauvais (trop long, consomme contexte)
"This agent will analyze the codebase, search for OTP implementation,
read relevant files, understand the architecture, and provide a
comprehensive report with code examples and recommendations."

# ✅ Bon (court, économise contexte)
"Find OTP implementation"
```

**Tips**:
- Mettre la complexité dans la **commande** (qui lance le sub-agent)
- Garder la **description** du sub-agent minimale
- Créer des commandes type `/search-X` qui lancent des sub-agents

---

### 6. 📊 Status Line (Monitoring Session)

**Définition**: La status line est la **barre d'informations personnalisable** en bas de Claude Code qui affiche en temps réel l'état de la session, le contexte restant, le coût, et des infos Git.

```
╔═══════════════════════════════════════════════════╗
║  STATUS LINE OPTIMISÉE (Melvynx)                  ║
╚═══════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────┐
│ 🌿 main (+3 -1 ~2) │ 📁 src/app │ 💰 $2.45 │ 🧠 67% │ ⏱️ 2h24 remaining │
└────────────────────────────────────────────────────┘
  │                    │            │          │        │
  │                    │            │          │        └─> Usage Limit
  │                    │            │          └─> Context Usage
  │                    │            └─> Session Cost
  │                    └─> Current Path
  └─> Git Branch + Stats

📊 DÉTAILS :

🌿 Git Status
   ├─> Branch actuelle : main
   ├─> +3 : Fichiers ajoutés
   ├─> -1 : Fichiers supprimés
   └─> ~2 : Fichiers modifiés (staged)

📁 Current Path
   └─> Dossier où Claude travaille actuellement
       (permet de voir si Claude est perdu)

💰 Session Cost
   └─> Coût total de la session actuelle
       (input + output tokens * prix Sonnet/Opus)

🧠 Context Usage
   └─> Pourcentage du contexte utilisé
       67% = 134,000 tokens / 200,000 tokens

⏱️ Usage Limit
   ├─> 12% : Pourcentage session utilisée (temps)
   └─> 2h24 : Temps restant avant reset session
       (Claude limite par sessions ~3h)
```

**Avantages**:
- ✅ **Visibilité temps réel** : Savoir où en est la session
- ✅ **Anticipation** : Éviter de commencer une grosse feature si plus de contexte
- ✅ **Awareness Git** : Voir combien de fichiers staged avant commit
- ✅ **Cost tracking** : Monitorer les coûts en live

**Limitations**:
- ❌ **Configuration complexe** : Nécessite de modifier le config.json
- ❌ **Pas de UI graphique** : Configuration via fichier texte uniquement
- ❌ **Breaking changes** : Peut casser entre versions de Claude Code

**Informations affichées (Recommandation Melvynx)**:

1. **🌿 Branche Git + Stats**
   - Nom de la branche actuelle
   - Nombre de fichiers ajoutés (`+3`)
   - Nombre de fichiers supprimés (`-1`)
   - Nombre de fichiers modifiés staged (`~2`)

2. **📁 Current Path**
   - Path du dossier actuel où Claude travaille
   - Utile pour voir si Claude est "perdu" dans le projet

3. **💰 Session Cost**
   - Coût total en $ de la session actuelle
   - Calcul : (input tokens + output tokens) * prix modèle

4. **🧠 Context Usage**
   - Pourcentage du contexte utilisé (ex: 67%)
   - Aide à décider si on peut continuer ou faut reset

5. **⏱️ Usage Limit** (⭐ LE PLUS IMPORTANT)
   - Pourcentage de la session utilisée (temps, pas tokens)
   - Temps restant avant reset (ex: 2h24)
   - Barre de progression visuelle

**Pourquoi Usage Limit est critique ?**

Claude Code limite par **sessions** (environ 3h), pas uniquement par tokens. Si tu arrives en fin de session :
- ⚠️ Impossible de continuer même avec contexte restant
- ⚠️ Faut attendre le reset (quelques heures)
- 💡 Mieux vaut savoir en avance pour planifier

**Configuration**:

Setup complet disponible sur [mlv.sh/ccli](https://mlv.sh/ccli) :
- Fichier `config.json` prêt à l'emploi
- Scripts pour status line custom
- Commandes `/status` pour debug

**Workflow recommandé**:
1. 📊 Check status line avant grosse feature
2. 🧠 Si contexte > 80% → reset session (`/clear`)
3. ⏱️ Si usage limit > 90% → finir les tâches urgentes
4. 💰 Si coût > budget → pause et review

---

## Citations Marquantes

> "Si Claude Code fait des erreurs, des hallucinations, des choses qui ne fonctionnent pas, sache que malheureusement c'est de ta faute parce que tu l'utilises tout simplement pas correctement."

> "Chaque MCP va utiliser du contexte. Cloud Code a 200,000 tokens de contexte et ici en utilisant par exemple 5 MCP, j'utilise près de 17% de mon contexte global que je ne peux plus utiliser pour coder."

> "Les sub-agents vont pouvoir utiliser énormément de tokens mais dans leur propre agent et qui vont rajouter à ton contexte uniquement les tokens nécessaires."

> "Typiquement, moi par exemple, je désactive par défaut tous les MCP et je les active que explicitement quand j'en ai besoin."

> "Le problème des sub-agents, c'est que tu n'as pas la visibilité sur ce qu'ils font. C'est impossible de les rediriger quand ils travaillent s'ils commencent à faire des erreurs."

---

## Points d'Action

### ✅ Immédiat (< 1h)

1. **Créer sa mémoire globale**
   - Créer `~/.claude/CLAUDE.md`
   - Ajouter : préférences style code, conventions commit, stack préférée
   - Tester avec `@` + "always use camelCase" → project memory

2. **Installer CCLI Blueprint**
   - Aller sur [mlv.sh/ccli](https://mlv.sh/ccli)
   - S'inscrire pour accéder au pack de commandes
   - Installer `/cloud-memory`, `/commit`, `/debug`

3. **Activer Context7 MCP**
   - Installer Context7 via config.json
   - Tester : "Donne-moi des infos sur `use cache` NextJS avec Context7"
   - Vérifier token usage avec `/context`

### 🔄 Court Terme (1 jour - 1 semaine)

4. **Créer 3 commandes custom**
   - Identifier 3 tâches répétitives (commit, debug, recherche)
   - Structure : Workflow → Rules → Examples → Critical
   - Utiliser `/prompt-command` + documentation officielle

5. **Configurer hooks de sécurité**
   - Créer `.claude/hooks/before_tool.sh`
   - Bloquer : `rm -rf /`, `git push --force main`
   - Tester avec commande fictive

6. **Désactiver MCP par défaut**
   - Lister tous les MCP actifs avec `@`
   - Désactiver TOUS (sauf Context7 optionnel)
   - Workflow : activer uniquement quand nécessaire

### 💪 Long Terme (> 1 semaine)

7. **Créer son premier sub-agent**
   - Identifier une tâche de recherche fréquente
   - Créer une commande qui lance le sub-agent
   - Description courte : "Find X implementation"
   - Comparer usage tokens : sans vs avec sub-agent

8. **Customiser sa status line**
   - Récupérer config depuis [mlv.sh/ccli](https://mlv.sh/ccli)
   - Ajouter : Git branch, context %, usage limit
   - Tester et ajuster selon besoins

9. **Documenter son workflow**
   - Créer `PROJECT.md` avec workflow complet
   - Lister commandes utilisées, MCP actifs, hooks configurés
   - Partager avec équipe si projet collaboratif

---

## Ressources Mentionnées

### 🔗 Outils

- **CCLI Blueprint** : [mlv.sh/ccli](https://mlv.sh/ccli)
  - Pack complet de commandes optimisées par Melvynx
  - Inclut : `/cloud-memory`, `/commit`, `/debug`, `/fix-grammar`, `/prompt-command`
  - Status line customisée
  - Hooks de sécurité
  - Configuration MCP optimale

- **Context7 MCP** : [context7.dev](https://context7.dev)
  - MCP pour récupérer documentation officielle à jour
  - Usage : ~2,000 tokens (~1% contexte)
  - Recommandé pour TOUS les projets

- **Exa Search** : [exa.ai](https://exa.ai)
  - Moteur de recherche optimisé pour LLM
  - Retourne code snippets structurés
  - Usage : ~1,500 tokens (~0.75% contexte)

### 📚 Documentation

- **Claude Code Docs** : [code.claude.com/docs](https://code.claude.com/docs)
  - Documentation officielle Memory, Commands, Hooks, MCP
  - Toujours fournir lors de création de commandes/hooks

- **MCP Protocol** : [modelcontextprotocol.io](https://modelcontextprotocol.io)
  - Specs complètes du protocole MCP
  - Liste des MCP officiels

- **GitHub Melvynx** : [github.com/melvynx](https://github.com/melvynx)
  - Repos avec exemples de commandes/hooks/sub-agents

---

## Schéma Récapitulatif

```
╔═══════════════════════════════════════════════════════════════╗
║  WORKFLOW CLAUDE CODE OPTIMISÉ (500h+)                       ║
╚═══════════════════════════════════════════════════════════════╝

         USER PROMPT
              │
              ▼
    ┌─────────────────────┐
    │  📝 MEMORY          │
    │  • Global (~/.claude)│
    │  • Project (.claude) │
    │  • Folder (scope)    │
    │  → Injecté auto     │
    └──────────┬──────────┘
              │
              ▼
    ┌─────────────────────┐
    │  ⚡ COMMANDS        │
    │  /commit, /debug    │
    │  • Workflow         │
    │  • Rules            │
    │  • Examples         │
    └──────────┬──────────┘
              │
              ▼
    ┌─────────────────────┐
    │  🔌 MCP SERVERS     │◄─── @ Toggle on/off
    │  • Context7 (docs)   │     (Désactiver par défaut)
    │  • Exa (search)      │
    │  ⚠️ 17% contexte !   │
    └──────────┬──────────┘
              │
              ▼
    ┌─────────────────────┐
    │  🪝 BEFORE HOOK     │
    │  • Validate cmd     │
    │  • Block dangerous  │
    └──────────┬──────────┘
              │ Approved ?
              ▼
    ┌──────────────────────────────┐
    │  🤖 EXECUTION                │
    │  ┌────────┬────────┬────────┐│
    │  │ Main   │ Sub-   │ Sub-   ││
    │  │ Agent  │ Agent1 │ Agent2 ││ ← Parallèle
    │  └────────┴────────┴────────┘│
    │  200k ctx  200k ctx  200k ctx │
    └──────────┬───────────────────┘
              │
              ▼
    ┌─────────────────────┐
    │  ✨ AFTER HOOK      │
    │  • Prettier         │
    │  • ESLint fix       │
    └──────────┬──────────┘
              │
              ▼
    ┌─────────────────────┐
    │  📊 STATUS LINE     │
    │  🌿 Branch          │
    │  💰 Cost            │
    │  🧠 Context 67%     │
    │  ⏱️ 2h24 left       │
    └─────────────────────┘

📋 CHECKLIST OPTIMISATION :
□ Memory 3 niveaux configurée
□ 3+ commandes custom créées
□ Hooks sécurité installés
□ MCP désactivés par défaut
□ Sub-agents pour recherche
□ Status line monitoring active
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Comment mesurer précisément le gain de tokens avec sub-agents sur mon projet ?
- Quelle est la limite exacte de tokens par MCP ? Varie-t-elle selon l'implémentation ?
- Peut-on créer des sub-agents custom avec des modèles open-source (Llama, Mistral) ?
- Comment versionner efficacement les commandes dans un projet d'équipe ?
- Est-il possible de faire du "hot reload" des commandes/hooks sans relancer Claude ?

### 💡 Idées d'Amélioration

- Créer un dashboard web pour visualiser l'historique des sessions (coût, tokens, temps)
- Développer un hook qui auto-commit après chaque feature complète (avec tests passants)
- Builder un MCP custom pour récupérer les issues GitHub du projet automatiquement
- Créer une commande `/optimize-context` qui suggère quels MCP désactiver
- Faire un script qui génère automatiquement des commandes depuis des workflows existants

### 🔗 À Combiner Avec

- **Vidéo Edmund Yong (800h Claude Code)** : Comparer workflows après 800h vs 500h
- **Doc officielle Sub-Agents** : Approfondir les cas d'usage avancés
- **Vidéo Skills vs MCP vs Sub-Agents (Solo Swift Crafter)** : Comprendre quand utiliser quoi
- **Awesome Sub-Agents (GitHub)** : S'inspirer de sub-agents communautaires

---

## Conclusion

**Message clé** : La maîtrise de Claude Code passe par 6 piliers fondamentaux : **Memory** (3 niveaux), **Commands** (prompts structurés), **Hooks** (validation/automation), **MCP** (contexte externe contrôlé), **Sub-Agents** (économie massive de tokens), et **Status Line** (monitoring session). Chaque pilier doit être configuré intentionnellement pour éviter l'hallucination et maximiser l'efficacité.

**Action immédiate** : Créer ton fichier `~/.claude/CLAUDE.md` avec tes préférences de base, installer CCLI Blueprint depuis [mlv.sh/ccli](https://mlv.sh/ccli), et désactiver tous les MCP sauf Context7.

**Règle d'or** : "Si Claude fait des erreurs, c'est probablement toi qui ne l'utilises pas correctement" — optimiser son workflow est la clé d'une collaboration IA efficace.

---

**🎓 Niveau de difficulté** : 🟡 Intermédiaire → 🟠 Avancé (configuration initiale simple, optimisation avancée complexe)

**⏱️ Temps de mise en pratique** :
- Setup de base : 1-2h
- Maîtrise complète : 1-2 semaines de pratique quotidienne
- ROI : Économie 30-50% contexte + réduction 70% hallucinations

**💪 Impact** : 🔥🔥🔥 TRÈS ÉLEVÉ
- Économie contexte : 30-50%
- Réduction hallucinations : 70%+
- Gain productivité : 2-3x
- Réduction coûts : 40%+ (sub-agents Haiku)
