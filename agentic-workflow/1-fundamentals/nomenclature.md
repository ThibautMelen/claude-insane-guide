# Nomenclature Claude Code - Termes et Hiérarchie

> Clarification des termes spécifiques à **Claude Code** : Command, Subcommand, Agent, Skill, Hook, MCP

---

## 🎯 Pourquoi Cette Nomenclature ?

L'écosystème Claude Code utilise une **terminologie spécifique** qui diffère parfois de l'industrie. Ce guide clarifie :

- ✅ **Command** vs **Agent** vs **Skill**
- ✅ **Agent** (Claude Code) vs **Autonomous Agent** (Anthropic Pattern 6)
- ✅ **Orchestrator** (industrie) vs **Command** (Claude Code)
- ✅ Hiérarchie stricte et règles d'or

---

## 📊 Hiérarchie Claude Code

```
╔═══════════════════════════════════════════════════════════╗
║         HIÉRARCHIE CLAUDE CODE (3 NIVEAUX MAX)            ║
╚═══════════════════════════════════════════════════════════╝

NIVEAU 0 : USER
   ↓ (invoque via /command)
NIVEAU 1 : COMMAND (orchestrateur)
   ↓ (délègue via Task tool)
NIVEAU 2 : COORDINATOR AGENT (optionnel, sous-orchestration)
   ↓ (délègue via Task tool)
NIVEAU 3 : AGENT (worker, tâche atomique)
   ↓ (retourne résultat)
NIVEAU 2 ou 1 : Agrégation résultats


COMPOSANTS TRANSVERSAUX :
├── SKILL (auto-invoqué par LLM reasoning, any level)
├── HOOK (automation déterministe, triggered by events)
└── MCP (external tools, accessible by all)
```

**⚠️ RÈGLE CRITIQUE** : Agents ne peuvent **JAMAIS** lancer d'autres agents ou commands.

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

### 🔹 SUBCOMMAND (Sous-Orchestrateur)

**Définition** : Command **spécialisé** pour une phase d'un workflow parent. Orchestre agents pour **sa phase** uniquement.

**Caractéristiques** :
- ✅ Invoqué par **Command parent**
- ✅ Orchestre agents pour une **phase spécifique**
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

### 🔹 AGENT (Worker, Tâche Atomique)

**Définition** : Worker qui exécute **UNE SEULE tâche atomique** bien définie. **JAMAIS** ne délègue.

**Caractéristiques** :
- ✅ Lancé par Command via **Task tool**
- ✅ Tâche **unique** et **atomique**
- ✅ Retourne **résultat structuré**
- ❌ **JAMAIS** lance d'autres agents
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

### 🔹 COORDINATOR AGENT (Sous-Orchestrateur Optionnel)

**Définition** : Agent **spécial** qui peut lancer d'autres agents, utilisé pour **sous-orchestration** dans hiérarchie à 3 niveaux.

**Caractéristiques** :
- ✅ Lancé par Command via Task tool
- ✅ Peut lancer **agents workers** via Task tool
- ✅ Agrège résultats de ses workers
- ✅ Retourne résultat structuré au Command
- ❌ **PAS un Command** (ne décide pas stratégie globale)

**Quand utiliser** :
- ✅ Workflow très complexe nécessitant **sous-orchestration**
- ✅ Diviser orchestration en **domaines spécialisés**
- ✅ Réutilisabilité d'un ensemble d'agents

**Exemple** :
```markdown
# .claude/commands/enterprise-rfp.md (Command)
Command orchestre :
1. @legal-coordinator → Analyse légale (lance 3 agents)
2. @technical-coordinator → Éval technique (lance 5 agents)
3. @financial-coordinator → Analyse financière (lance 2 agents)

# .claude/agents/legal-coordinator.md (Coordinator Agent)
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
Coordinator Agent (Level 2)
  ↓
Worker Agents (Level 3)
  ↓
Results aggregated back to Command
```

**⚠️ Limite recommandée** : Maximum **3 niveaux** (Command → Coordinator → Worker)

---

### 🔹 SKILL (Connaissances Partagées)

**Définition** : Base de connaissances **auto-invoquée** par le LLM via reasoning, accessible à **tous les niveaux** (Command, Agent).

**Caractéristiques** :
- ✅ **Auto-invocation** : LLM décide quand charger (pas user)
- ✅ **Progressive disclosure** : 3 niveaux (metadata → full → bundled)
- ✅ **Économie contexte** : 10-50x moins de tokens vs memory
- ✅ **Partagée** : Accessible par Commands ET Agents

**Niveaux de disclosure** :
```
╔═══════════════════════════════════════════════════════════╗
║         SKILL PROGRESSIVE DISCLOSURE (3 NIVEAUX)          ║
╚═══════════════════════════════════════════════════════════╝

NIVEAU 1 : METADATA (toujours chargé)
├─ Name, description, WHEN/WHEN NOT
├─ ~50-100 tokens
└─ LLM décide si skill pertinente

NIVEAU 2 : FULL PROMPT (si invoqué)
├─ Instructions complètes
├─ ~500-2000 tokens
└─ Chargé seulement si WHEN conditions match

NIVEAU 3 : BUNDLED RESOURCES (optionnel)
├─ Files, examples, templates
├─ ~5000+ tokens
└─ Chargé si skill explicitement invoquée par user
```

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

### 🔹 HOOK (Automation Déterministe)

**Définition** : Script **déterministe** déclenché automatiquement par événements lifecycle (tool use, agent stop, etc.).

**Caractéristiques** :
- ✅ **Event-driven** : Trigger automatique
- ✅ **Déterministe** : Logic fixe (if/else, no LLM)
- ✅ **Exit codes** : 0=OK, 1=Warning, 2=Block
- ✅ **Validation gates** : Quality, security, compliance

**Types de hooks** :
```
╔═══════════════════════════════════════════════════════════╗
║                  HOOK LIFECYCLE                           ║
╚═══════════════════════════════════════════════════════════╝

1. PreToolUse (avant tool execution)
   ├─ Validation input
   ├─ Security checks
   └─ Example : Bloquer "rm -rf /" dans Bash

2. PostToolUse (après tool execution)
   ├─ Validation output
   ├─ Quality gates
   └─ Example : Vérifier format JSON valide

3. SubagentStop (quand agent termine)
   ├─ Aggregation résultats
   ├─ Metrics logging
   └─ Example : Logger success rate

4. Stop (fin conversation)
   ├─ Cleanup
   ├─ Final reports
   └─ Example : Générer audit trail
```

**Exemples** :
```bash
# .claude/hooks/pre-tool-use.sh
# Bloquer commandes dangereuses
if [[ "$tool" == "Bash" && "$command" =~ "rm -rf /" ]]; then
  echo "❌ BLOCKED: Dangerous command detected"
  exit 2  # Block
fi
exit 0  # OK

# .claude/hooks/post-tool-use.sh
# Vérifier qualité output
if [[ "$tool" == "Edit" && ! -f "$file_path" ]]; then
  echo "⚠️ WARNING: File not found after edit"
  exit 1  # Warning
fi
exit 0  # OK
```

**Différence Hook vs Agent** :
```
HOOK (Déterministe)
├─ Logic fixe (bash, python script)
├─ Pas de LLM reasoning
├─ Event-driven (automatic trigger)
└─ Validation, monitoring, automation

AGENT (Intelligent)
├─ LLM reasoning
├─ Décisions adaptatives
├─ Command-triggered (explicit launch)
└─ Exécution tâches complexes
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
| **Agent** | Worker | Worker | Exécute tâche atomique |
| **Coordinator Agent** | Coordinator | Supervisor | Sous-orchestration |
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

✅ COMMAND orchestre toujours (Règle 1)
✅ AGENTS = Workers (tâches atomiques)
✅ Hiérarchie plate : 3 niveaux max
✅ SKILL = auto-invocation (économie contexte)
✅ HOOK = automation déterministe (validation gates)
✅ MCP = abstraction outils externes

HIÉRARCHIE :
USER → COMMAND → [COORDINATOR AGENT] → AGENT

INTERDICTIONS :
❌ Agent → Agent (JAMAIS)
❌ Agent → Command (JAMAIS)
❌ Agent prend décisions stratégiques (JAMAIS)

CLARIFICATION :
Notre "Agent" = "Worker" (Anthropic)
≠ "Autonomous Agent" (Pattern 6)
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
