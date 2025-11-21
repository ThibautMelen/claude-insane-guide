# Nomenclature Claude Code - Termes et Hiérarchie

> Clarification des termes spécifiques à **Claude Code** : Command, Subagent, Skill, Hook, MCP

---

## ⚠️ **Disclaimer Important**

Ce guide présente un **framework opinionné** pour organiser vos projets Claude Code. Les concepts comme "COORDINATOR AGENT", "SUBCOMMAND" et la "hiérarchie à 3 niveaux" sont des **patterns proposés** par ce guide, **pas des spécifications officielles Claude Code**.

**Terminologie officielle Claude Code** :
- ✅ **Subagents** (fichiers `.md` dans `.claude/agents/`)
- ✅ **Custom slash commands** (fichiers `.md` dans `.claude/commands/`)
- ✅ **Skills** (dossiers dans `.claude/skills/`)
- ✅ **Hooks** (configuration dans `settings.json`)

📖 **Documentation officielle** : [https://docs.anthropic.com/en/docs/claude-code](https://docs.anthropic.com/en/docs/claude-code)

---

## 🎯 Pourquoi Cette Nomenclature ?

L'écosystème Claude Code utilise une **terminologie spécifique** qui diffère parfois de l'industrie. Ce guide clarifie :

- ✅ **Command** vs **Agent** vs **Skill**
- ✅ **Agent** (Claude Code) vs **Autonomous Agent** (Anthropic Pattern 6)
- ✅ **Orchestrator** (industrie) vs **Command** (Claude Code)
- ✅ Hiérarchie stricte et règles d'or

---

## 📊 Hiérarchie Recommandée (Pattern Proposé)

```
╔═══════════════════════════════════════════════════════════╗
║    HIÉRARCHIE RECOMMANDÉE (2-3 niveaux, pattern proposé) ║
╚═══════════════════════════════════════════════════════════╝

NIVEAU 0 : USER
   ↓ (invoque via /command)
NIVEAU 1 : COMMAND (custom slash command qui orchestre)
   ↓ (délègue via Task tool)
NIVEAU 2 : COORDINATOR SUBAGENT (optionnel, pattern avancé)
   ↓ (délègue via Task tool)
NIVEAU 3 : WORKER SUBAGENT (tâche atomique)
   ↓ (retourne résultat)
NIVEAU 2 ou 1 : Agrégation résultats


COMPOSANTS TRANSVERSAUX :
├── SKILL (auto-invoqué par LLM reasoning, any level)
├── HOOK (automation bash/LLM, triggered by events)
└── MCP (external tools, accessible by all)
```

**⚠️ RÈGLE OFFICIELLE CLAUDE CODE** : Les subagents **ne peuvent pas spawner d'autres subagents** selon la documentation officielle. Le pattern "COORDINATOR SUBAGENT" ci-dessus est une **approche avancée** où le command délègue la coordination à un subagent spécialisé, mais cela reste une orchestration via le command parent.

---

## 📖 Définitions Composants

### 🔹 COMMAND (Orchestrateur Principal)

**Définition** : Point d'entrée **user-triggered** qui orchestre un workflow complet. Responsable de la **stratégie globale**.

**Caractéristiques** :
- ✅ Invoqué par user via `/command`
- ✅ Décide **strategy** : quels agents, combien, quand
- ✅ Lance agents via **Task tool**
- ✅ Agrège résultats
- ✅ Gère erreurs et retry logic
- ❌ **JAMAIS exécute directement** (délègue aux agents)

**Responsabilités** :
```
COMMAND
├─ 1. Analyser requête user
├─ 2. Planifier stratégie (quels agents nécessaires ?)
├─ 3. Lancer agents (Task tool, parallel si possible)
├─ 4. Monitorer exécution
├─ 5. Agréger résultats
├─ 6. Gérer erreurs (retry, fallback)
└─ 7. Retourner résultat structuré au user
```

**Exemples** :
```markdown
# .claude/commands/epct.md (EPCT Workflow)
Command orchestre : Explore → Plan → Code → Test
- Explore : Lance @explore-agent
- Plan : Lance @plan-agent
- Code : Lance 3 agents parallel (@frontend, @backend, @tests)
- Test : Lance @test-agent

# .claude/commands/generate-locales.md (200 locales)
Command orchestre : 10 waves × 20 agents parallel
- Wave 1 : Agents 1-20
- Wave 2 : Agents 21-40
- ...
- Aggregate : Compile results, validate quality
```

**Analogie industrie** :
- **Claude Code "Command"** = **Orchestrator** (Anthropic/Azure)
- **Claude Code "Command"** = **Manager** (hierarchical pattern)

---

### 🔹 SUBCOMMAND (Pattern Proposé - Sous-Orchestrateur)

> ⚠️ **Note** : "SUBCOMMAND" n'est **pas un type officiel** Claude Code. C'est simplement un **custom slash command** qui orchestre d'autres subagents. La doc officielle ne fait pas cette distinction.

**Définition** : Custom slash command **spécialisé** pour une phase d'un workflow parent. Orchestre subagents pour **sa phase** uniquement.

**Caractéristiques** :
- ✅ Invoqué par **Command parent** (via SlashCommand tool)
- ✅ Orchestre subagents pour une **phase spécifique**
- ✅ Retourne résultat structuré au parent
- ❌ **Ne gère PAS** la stratégie globale

**Exemple** :
```markdown
# .claude/commands/ci-cd.md (Parent Command)
Command orchestre :
1. /build (Subcommand)
2. /test (Subcommand)
3. /deploy (Subcommand)

# .claude/commands/build.md (Subcommand)
Subcommand orchestre :
- @frontend-builder
- @backend-builder
- @asset-optimizer
→ Retourne build artifacts
```

**Quand utiliser** :
- ✅ Workflow **multi-phases** complexe
- ✅ Réutilisabilité (build utilisé par ci-cd ET manual-build)
- ✅ Séparation responsabilités claire

---

### 🔹 SUBAGENT / AGENT (Worker, Tâche Atomique)

> 📖 **Terme officiel** : "**Subagent**" (doc Claude Code). Ce guide utilise aussi "Agent" par simplicité, mais il s'agit toujours de subagents au sens de Claude Code.

**Définition** : Worker subagent qui exécute **UNE SEULE tâche atomique** bien définie. **JAMAIS** ne délègue.

**Caractéristiques** :
- ✅ Lancé par Command via **Task tool**
- ✅ Tâche **unique** et **atomique**
- ✅ Retourne **résultat structuré**
- ❌ **JAMAIS** lance d'autres subagents (règle officielle)
- ❌ **JAMAIS** prend décisions stratégiques
- ❌ **JAMAIS** invoque commands

**Responsabilités** :
```
AGENT
├─ 1. Recevoir input précis (fichier, URL, params)
├─ 2. Exécuter tâche unique
├─ 3. Retourner résultat structuré
└─ 4. Gérer erreurs internes (pas retry global)
```

**Exemples valides** :
```markdown
# .claude/agents/unit-tester.md
Input  : Fichier test à exécuter
Task   : Run tests, capture coverage
Output : { status: "success", coverage: 95%, failures: [] }

# .claude/agents/french-translator.md
Input  : Texte anglais
Task   : Traduire en français
Output : { translation: "...", quality: 9/10 }

# .claude/agents/legal-analyzer.md
Input  : Document légal
Task   : Analyser risques
Output : { risks: [...], severity: "medium" }
```

**Contre-exemples (INTERDIT)** :
```markdown
# ❌ .claude/agents/pipeline-manager.md
Problème : Coordonne build + test + deploy
→ C'EST UN COMMAND, pas un Agent !

# ❌ .claude/agents/multi-task-agent.md
Problème : Fait analyse + écriture + review
→ TROP LARGE, diviser en 3 agents !

# ❌ .claude/agents/delegating-agent.md
Problème : Lance d'autres agents
→ VIOLATION Règle 1 (Command orchestre toujours) !
```

**⚠️ CLARIFICATION CRITIQUE** :

```
╔═══════════════════════════════════════════════════════════╗
║    AGENT (Claude Code) ≠ AUTONOMOUS AGENT (Pattern 6)    ║
╚═══════════════════════════════════════════════════════════╝

AGENT (Claude Code) = WORKER
├─ Suit instructions Command
├─ Pas de décision autonome
├─ Tâche prédéfinie
└─ Production-ready ✅

AUTONOMOUS AGENT (Anthropic Pattern 6) = AUTONOMOUS
├─ Décide autonomously quoi faire
├─ Choix tools et next steps
├─ Tâche open-ended
└─ Research/Exploration only ⚠️
```

**Nos "Agents" sont des "Workers" dans la terminologie Anthropic.**

---

### 🔹 COORDINATOR SUBAGENT (Pattern Avancé - Sous-Orchestrateur)

> ⚠️ **ATTENTION** : Ce pattern est **avancé** et peut sembler contredire la règle officielle "subagents cannot spawn other subagents". En réalité, le **command parent reste orchestrateur** et délègue la coordination à un subagent spécialisé. Ce n'est pas un concept officiel Claude Code, mais un pattern d'implémentation proposé.

**Définition** : Subagent **spécialisé en coordination** qui aide le command parent à orchestrer d'autres subagents workers pour un domaine spécifique.

**Caractéristiques** :
- ✅ Lancé par Command via Task tool
- ✅ Coordonne l'exécution d'autres subagents workers (via le command parent)
- ✅ Agrège résultats de ses workers
- ✅ Retourne résultat structuré au Command
- ❌ **PAS un Command** (ne décide pas stratégie globale)

**Quand utiliser** :
- ✅ Workflow très complexe nécessitant **sous-orchestration par domaine**
- ✅ Diviser orchestration en **domaines spécialisés** (legal, technical, financial)
- ✅ Réutilisabilité d'un ensemble de subagents

**Exemple** :
```markdown
# .claude/commands/enterprise-rfp.md (Command)
Command orchestre :
1. @legal-coordinator → Analyse légale (lance 3 agents)
2. @technical-coordinator → Éval technique (lance 5 agents)
3. @financial-coordinator → Analyse financière (lance 2 agents)

# .claude/agents/legal-coordinator.md (Coordinator Subagent)
Coordinator lance :
- @contract-analyzer
- @compliance-checker
- @risk-assessor
→ Agrège et retourne rapport légal consolidé
```

**Hiérarchie résultante** :
```
Command (Level 1)
  ↓
Coordinator Subagent (Level 2)
  ↓
Worker Subagents (Level 3)
  ↓
Results aggregated back to Command
```

**⚠️ Limite recommandée** : Maximum **3 niveaux** (Command → Coordinator → Worker)

---

### 🔹 SKILL (Connaissances Partagées)

**Définition** : Base de connaissances **auto-invoquée** par le LLM via reasoning, accessible à **tous les niveaux** (Command, Agent).

**Caractéristiques** :
- ✅ **Auto-invocation** : LLM décide quand charger (pas user)
- ✅ **Progressive disclosure** : Fichiers chargés "only when needed" (doc officielle)
- ✅ **Économie contexte** : 10-50x moins de tokens vs memory
- ✅ **Partagée** : Accessible par Commands ET Subagents

**Progressive disclosure (modèle simplifié)** :
```
╔═══════════════════════════════════════════════════════════╗
║      SKILL PROGRESSIVE DISCLOSURE (modèle simplifié)      ║
╚═══════════════════════════════════════════════════════════╝

📖 Doc officielle : "Claude loads additional files only when needed"

Modèle pratique (non-officiel) :

NIVEAU 1 : METADATA (toujours chargé)
├─ Name, description (frontmatter SKILL.md)
├─ ~50-100 tokens
└─ LLM décide si skill pertinente

NIVEAU 2 : FULL SKILL.md (si invoqué)
├─ Instructions complètes (corps SKILL.md)
├─ ~500-2000 tokens
└─ Chargé quand skill conditions matchent

NIVEAU 3 : BUNDLED RESOURCES (si nécessaire)
├─ Fichiers additionnels (docs, examples, templates)
├─ ~5000+ tokens
└─ Chargés dynamiquement par Claude selon besoin
```

> ⚠️ **Note** : La doc officielle ne spécifie pas "3 niveaux" rigides. Claude charge les fichiers de manière flexible selon le contexte. Ce modèle est une simplification didactique.

**Exemples** :
```markdown
# .claude/skills/markdown-creator.md
WHEN:
- User asks to create README, documentation, report
- Task involves Markdown with tables or diagrams

WHEN NOT:
- Code files (.ts, .py, .js)
- Plain text files
- Already existing markdown (use Edit instead)

→ Auto-invoqué quand user dit "create README"
→ Économie : 50 tokens metadata vs 50,000 tokens si dans memory

# .claude/skills/test-generator.md
WHEN:
- User asks to write tests
- New feature implemented without tests
- Coverage below threshold

→ Auto-invoqué quand "write tests" détecté
```

**Différence Skill vs Agent** :
```
SKILL (Connaissances)
├─ Auto-invoqué par LLM reasoning
├─ Prompt injection dynamique
├─ Pas d'exécution (juste contexte)
└─ Économie contexte

AGENT (Exécution)
├─ Lancé explicitement par Command
├─ Exécute tâche atomique
├─ Utilise tools (Edit, Bash, Read)
└─ Retourne résultat
```

---

### 🔹 HOOK (Automation Bash ou LLM)

**Définition** : Script **bash** ou **prompt LLM** déclenché automatiquement par événements lifecycle (tool use, subagent stop, etc.).

**Caractéristiques** :
- ✅ **Event-driven** : Trigger automatique
- ✅ **Deux types** :
  - `type: "command"` → Script bash/python (déterministe)
  - `type: "prompt"` → LLM evaluation (intelligent, contexte-aware)
- ✅ **Exit codes** (bash hooks) :
  - `0` = Success
  - `2` = Blocking error (bloque l'action)
  - Autres = Non-blocking error
- ✅ **JSON output** : Pour contrôle avancé (decision, reason, continue, etc.)
- ✅ **Validation gates** : Quality, security, compliance

**Hook events disponibles** :
```
╔═══════════════════════════════════════════════════════════╗
║              HOOK LIFECYCLE (tous les events)             ║
╚═══════════════════════════════════════════════════════════╝

1. PreToolUse (avant tool execution)
   ├─ Validation input, security checks
   └─ Example : Bloquer "rm -rf /" dans Bash

2. PermissionRequest (quand user voit permission dialog)
   ├─ Auto-approve ou auto-deny
   └─ Example : Auto-approuver Read pour .md files

3. PostToolUse (après tool execution)
   ├─ Validation output, quality gates
   └─ Example : Vérifier format JSON valide

4. Notification (quand Claude Code envoie notification)
   ├─ Filtrer par type (permission_prompt, idle_prompt, etc.)
   └─ Example : Custom alert system

5. UserPromptSubmit (quand user soumet prompt)
   ├─ Validation, ajout contexte
   └─ Example : Ajouter date/time context

6. Stop (fin conversation main agent)
   ├─ Cleanup, final reports
   └─ Example : Générer audit trail

7. SubagentStop (quand subagent termine)
   ├─ Aggregation résultats, metrics
   └─ Example : Logger success rate

8. PreCompact (avant compact operation)
   ├─ Custom instructions pour compact
   └─ Example : Préserver certaines infos

9. SessionStart (début session)
   ├─ Setup environment, load context
   └─ Example : nvm use, set env vars

10. SessionEnd (fin session)
    ├─ Cleanup, save state
    └─ Example : Archive logs
```

**Exemples** :
```bash
# BASH HOOK : .claude/hooks/pre-tool-use.sh
# Bloquer commandes dangereuses
if [[ "$tool" == "Bash" && "$command" =~ "rm -rf /" ]]; then
  echo "❌ BLOCKED: Dangerous command detected"
  exit 2  # Blocking error
fi
exit 0  # Success

# BASH HOOK : .claude/hooks/post-tool-use.sh
# Vérifier qualité output
if [[ "$tool" == "Edit" && ! -f "$file_path" ]]; then
  echo "⚠️ WARNING: File not found after edit"
  exit 1  # Non-blocking error
fi
exit 0  # Success
```

```json
// PROMPT-BASED HOOK : settings.json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "prompt",
        "prompt": "Evaluate if Claude should stop: $ARGUMENTS. Check if all tasks complete.",
        "timeout": 30
      }]
    }]
  }
}
```

**Différence Hook vs Subagent** :
```
HOOK (Automation)
├─ Deux types :
│  ├─ Bash/Python : Logic fixe, déterministe
│  └─ Prompt : LLM evaluation, context-aware
├─ Event-driven (automatic trigger)
└─ Validation, monitoring, automation

SUBAGENT (Execution)
├─ LLM reasoning complet
├─ Décisions adaptatives complexes
├─ Command-triggered (explicit launch via Task tool)
└─ Exécution tâches complexes avec tools
```

---

### 🔹 MCP (Model Context Protocol)

**Définition** : Interface standardisée pour connecter Claude Code à **outils externes** (APIs, databases, filesystems).

**Caractéristiques** :
- ✅ **Abstraction layer** : Tools accessibles via protocol uniforme
- ✅ **Changement sans refactoring** : Swap tools sans modifier agents
- ✅ **Accessible par tous** : Commands, Agents, Skills

**Exemples** :
```
MCP Server : Supabase
├─ Tools : query_db, insert_row, update_row
└─ Accessible par : Command, Agent, Skill

MCP Server : GitHub
├─ Tools : create_pr, list_issues, add_comment
└─ Accessible par : Command, Agent

MCP Server : Filesystem
├─ Tools : read_file, write_file, list_dir
└─ Accessible par : Tous composants
```

**Configuration** :
```json
// ~/.config/claude-code/config.json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"],
      "env": {
        "SUPABASE_URL": "https://xxx.supabase.co",
        "SUPABASE_KEY": "xxx"
      }
    }
  }
}
```

---

## 🎯 Mapping Terminologie

### Claude Code ↔ Anthropic ↔ Azure

| Claude Code | Anthropic (Research) | Azure (Patterns) | Rôle |
|-------------|---------------------|------------------|------|
| **Command** | Orchestrator | Manager / Hierarchical | Décide strategy |
| **Subcommand** | Sub-Orchestrator | Team Lead | Orchestre phase |
| **Subagent** | Worker | Worker | Exécute tâche atomique |
| **Coordinator Subagent** | Coordinator | Supervisor | Sous-orchestration |
| **Skill** | Progressive Disclosure | N/A | Auto-invocation contexte |
| **Hook** | Validation Gate | N/A | Automation déterministe |
| **MCP** | Tool Integration | N/A | Interface externe |

---

### Claude Code "Agent" ≠ Autonomous Agent

```
╔═══════════════════════════════════════════════════════════╗
║       CLARIFICATION AGENT vs AUTONOMOUS AGENT             ║
╚═══════════════════════════════════════════════════════════╝

CLAUDE CODE "AGENT" (Worker)
├─ Suit instructions Command
├─ Tâche prédéfinie
├─ Pas d'autonomie décisionnelle
├─ Production-ready ✅
└─ Example : @unit-tester, @translator

ANTHROPIC "AUTONOMOUS AGENT" (Pattern 6)
├─ Décide autonomously
├─ Tâche open-ended
├─ Choix tools et next steps dynamique
├─ Research/Exploration ⚠️
└─ Example : SWE-bench solver, research assistant
```

**⚠️ Dans Claude Code** : Nos "Agents" sont des **Workers**, pas des Autonomous Agents.

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║          NOMENCLATURE CLAUDE CODE ESSENTIALS              ║
╚═══════════════════════════════════════════════════════════╝

TERMINOLOGIE OFFICIELLE :
✅ SUBAGENTS (fichiers .md dans .claude/agents/)
✅ CUSTOM SLASH COMMANDS (.claude/commands/)
✅ SKILLS (dossiers .claude/skills/)
✅ HOOKS (config settings.json, bash ou LLM)
✅ MCP (external tools protocol)

PATTERNS PROPOSÉS PAR CE GUIDE (non-officiels) :
• COMMAND = Custom slash command qui orchestre
• SUBCOMMAND = Custom command spécialisé (pattern proposé)
• COORDINATOR SUBAGENT = Subagent coordinateur (pattern avancé)
• Hiérarchie 2-3 niveaux (recommandation, pas limite officielle)

RÈGLE OFFICIELLE CLAUDE CODE :
⚠️ "Subagents cannot spawn other subagents"

HIÉRARCHIE RECOMMANDÉE (pattern proposé) :
USER → COMMAND → [COORDINATOR SUBAGENT] → WORKER SUBAGENT

INTERDICTIONS (règle officielle) :
❌ Subagent → Subagent (violation règle officielle)
❌ Subagent → Command (JAMAIS)
❌ Subagent prend décisions stratégiques (JAMAIS)

CLARIFICATIONS :
• "Agent" dans ce guide = "Subagent" (terme officiel)
• Nos "Subagents" = "Workers" (Anthropic terminology)
• ≠ "Autonomous Agent" (Anthropic Pattern 6)
```

---

## 🔗 Navigation

- 📄 [Taxonomie Générale](./taxonomie.md) - Workflow vs Agentic Workflow vs Pattern
- 📄 [Decision Framework](./decision-framework.md) - Quel composant utiliser ?
- 📄 [Orchestration Principles](../orchestration-principles.md) - Règles d'or détaillées
- 📄 [Architecture](../3-architecture/command-coordinator-workers.md) - Hiérarchie complète

---

**Quote Finale** :
> "Command orchestrates. Agents execute. Skills provide context. Hooks validate. MCP integrates."
> — Règle d'Or Claude Code
