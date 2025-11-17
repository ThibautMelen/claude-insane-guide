# Skills vs Slash Commands vs Sub-Agents vs MCP - Le Guide Complet

![Miniature vidéo](https://img.youtube.com/vi/kFpLzCVLA20/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: Skills vs Slash Commands vs Sub-Agents vs MCP - Le Guide Complet
- **Auteur**: Dan
- **Durée**: 27 minutes
- **Date**: 2025
- **Lien**: [https://www.youtube.com/watch?v=kFpLzCVLA20](https://www.youtube.com/watch?v=kFpLzCVLA20)

## Tags

`#skills` `#slash-commands` `#subagents` `#mcp` `#comparison` `#compositional-hierarchy` `#prompts-as-primitives` `#core-4` `#progressive-disclosure` `#agent-first`

---

## Résumé Exécutif

Cette vidéo est **LA référence ultime** pour comprendre quand utiliser Skills, Slash Commands, Sub-Agents ou MCP dans Claude Code. Dan démontre que ces 4 features ne sont PAS interchangeables et ont chacune un rôle distinct. Il révèle la **hiérarchie compositionnelle** où les **prompts (slash commands) sont les primitives** de tout le système. La vidéo montre que Skills ne remplacent PAS les slash commands, mais les **composent** pour créer des solutions réutilisables à des problèmes récurrents.

**Conclusion principale**: **Les prompts sont la primitive fondamentale de tout agent coding**. Skills, MCP et Sub-Agents sont des couches compositionnelles au-dessus des prompts. Si vous ne maîtrisez pas les prompts (slash commands), vous ne maîtriserez jamais l'agent coding.

---

## Timecodes

- **01:20** - Introduction aux 4 features (Skills, Sub-Agents, Slash Commands, MCP)
- **01:42** - Démo: Créer git worktrees avec 3 approches différentes
- **02:19** - Tableau comparatif des capabilities (agent-invoked, context efficiency, etc.)
- **04:50** - Use cases: Quand utiliser chaque feature
- **05:50** - Exemple 1: Extract PDF → Skill (automatic)
- **06:10** - Exemple 2: Connect to Jira → MCP (external)
- **06:18** - Exemple 3: Security audit → Sub-Agent (isolated + parallel)
- **06:40** - Exemple 4: Git commit messages → Slash Command (simple, manual)
- **08:20** - Skills vs Slash Commands: La confusion principale
- **09:40** - Compositional hierarchy: Skills au sommet, prompts à la base
- **12:01** - **The Core 4**: Context, Model, Prompt, Tools
- **13:30** - Quand passer d'un prompt à un Skill (ex: git worktree manager)
- **15:00** - Démo live: Skill "worktree manager" (remove, create, list)
- **16:39** - Definitions: Skills = reoccurring workflows, MCP = external tools
- **18:00** - Compositional levels: Skills > MCP > Sub-Agents > Slash Commands (primitives)
- **19:00** - Custom Slash Commands = closest to bare metal LLM (prompts)
- **21:20** - Prompts as primitives: "Everything is a prompt in the end"
- **23:00** - Pros & Cons of Skills (8/10 rating)
- **24:00** - Con #1: Skills don't go all the way (no nested /commands directory)
- **24:40** - Con #2: Reliability when chaining multiple skills
- **25:20** - Con #3: Skills = "canonized prompt engineering + modularity" (pas vraiment nouveau)
- **26:00** - Repo disponible avec 4 skills (meta, video-processor, etc.)

---

## Concepts Clés

### 1. Skills vs Slash Commands vs Sub-Agents vs MCP - Tableau Comparatif

**Définition**: Chaque feature a des capabilities distinctes et des use cases spécifiques.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    FEATURE COMPARISON TABLE                                 │
├────────────────┬──────────┬──────────┬─────────────┬─────────────────────┤
│   CAPABILITY   │  SKILLS  │   MCP    │ SUB-AGENTS  │ SLASH COMMANDS      │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Agent-Invoked  │    ✅    │    ✅    │     ✅      │        ❌           │
│ (auto trigger) │  (YES)   │  (YES)   │   (YES)     │   (manual only)     │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Context        │    ✅    │    ❌    │     ✅      │        ✅           │
│ Efficiency     │ (progr.) │ (BLOAT!) │ (isolated)  │   (efficient)       │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Context        │    ✅    │    ✅    │     ❌      │        ✅           │
│ Persistence    │  (YES)   │  (YES)   │  (LOST!)    │     (YES)           │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Modularity     │  ✅ HIGH │    🟡    │   🟡 DIY    │      🟡 DIY         │
│                │ (dedic.) │ (dedic.) │  (manual)   │    (manual)         │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Composability  │    ✅    │    🟡    │     ❌      │        ✅           │
│                │  (HIGH)  │  (MED)   │  (NO SUB)   │     (HIGH)          │
├────────────────┼──────────┼──────────┼─────────────┼─────────────────────┤
│ Parallelization│    ❌    │    ❌    │     ✅      │        ❌           │
│                │          │          │  (ONLY!)    │                     │
└────────────────┴──────────┴──────────┴─────────────┴─────────────────────┘

Legend:
✅ = Full support
🟡 = Partial / Manual
❌ = Not supported
```

**Avantages**:
- ✅ Clarté sur quand utiliser chaque feature
- ✅ Évite la confusion entre Skills et Slash Commands
- ✅ Aide à choisir le bon outil pour le bon problème
- ✅ Met en évidence les capabilities uniques (ex: Sub-Agents = seul à paralléliser)

**Limitations**:
- ❌ Beaucoup d'overlap entre Skills et Slash Commands
- ❌ Risque de sur-complexifier avec trop de features
- ❌ Pas toujours clair quand passer d'un prompt à un Skill

**Cas d'usage**:
- **Skills**: Automatic PDF extraction, style guide violations detection
- **MCP**: Jira integration, database queries, weather API
- **Sub-Agents**: Security audits, parallel test fixing, isolated workflows
- **Slash Commands**: Git commit messages, create component, one-off tasks

---

### 2. Compositional Hierarchy - Skills au Sommet, Prompts à la Base

**Définition**: Les features s'empilent en couches compositionnelles, avec les **prompts (slash commands) comme primitive fondamentale**.

```
                    ╔═══════════════════════════╗
                    ║        SKILLS             ║  ← Top level
                    ║  (Agent-first solutions)  ║
                    ╚═══════════════════════════╝
                              ▲
                              │ composes ↓
                    ┌─────────┴─────────┐
                    │                   │
            ┌───────────────┐   ┌───────────────┐
            │  MCP SERVERS  │   │  SUB-AGENTS   │  ← Mid level
            │  (External)   │   │  (Isolated)   │
            └───────────────┘   └───────────────┘
                    │                   │
                    └─────────┬─────────┘
                              ▼ composes ↓
                    ┌───────────────────────────┐
                    │   SLASH COMMANDS          │  ← Primitive
                    │   (Prompts = Base Level)  │
                    └───────────────────────────┘
                              ▲
                              │
                    ╔═══════════════════════════╗
                    ║      THE CORE 4           ║  ← Foundation
                    ║  Context • Model          ║
                    ║  Prompt  • Tools          ║
                    ╚═══════════════════════════╝
```

**Règles de Composition**:
- ✅ Skills peuvent utiliser: MCP + Sub-Agents + Slash Commands
- ✅ Slash Commands peuvent utiliser: Skills + MCP + Sub-Agents
- ❌ Sub-Agents **NE PEUVENT PAS** utiliser d'autres Sub-Agents
- ❌ MCP (lower level) ne devrait PAS utiliser Skills (higher level)

**Pourquoi c'est important**:
> "If you avoid understanding how to write great prompts, how to really build these out in a repeatable way, you will not progress as an agentic engineer. The prompt is the fundamental unit of knowledge work."
> — Dan

**Cas d'usage**:
- **Git Worktree Skill**: Utilise un slash command `/create-worktree` comme primitive
- **Video Processor Skill**: Compose plusieurs prompts pour transcription + processing
- **Meta Skill**: Skill qui génère d'autres skills (build the thing that builds the thing)

---

### 3. Progressive Disclosure - Efficacité du Contexte avec Skills

**Définition**: Les Skills protègent le contexte en chargeant l'information en 3 niveaux progressifs, contrairement aux MCP qui "torchent" le context window dès le démarrage.

```
┌──────────────────────────────────────────────────────────────┐
│         SKILLS: Progressive Disclosure (3 Levels)            │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Level 1: METADATA                                           │
│  ┌────────────────────────────────────┐                     │
│  │ • Skill name                       │  ← Always loaded    │
│  │ • Description                      │                     │
│  │ • Available capabilities           │                     │
│  └────────────────────────────────────┘                     │
│           ▼ (agent decides to invoke)                        │
│                                                              │
│  Level 2: INSTRUCTIONS (SKILL.md)                            │
│  ┌────────────────────────────────────┐                     │
│  │ • Full prompt/instructions         │  ← Loaded on use    │
│  │ • Guidelines                       │                     │
│  │ • Examples                         │                     │
│  └────────────────────────────────────┘                     │
│           ▼ (skill pulls resources)                          │
│                                                              │
│  Level 3: RESOURCES                                          │
│  ┌────────────────────────────────────┐                     │
│  │ • Files in /resources              │  ← Loaded as needed │
│  │ • Documentation                    │                     │
│  │ • Code snippets                    │                     │
│  └────────────────────────────────────┘                     │
│                                                              │
└──────────────────────────────────────────────────────────────┘

VS

┌──────────────────────────────────────────────────────────────┐
│         MCP: Context Window Explosion                        │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────────────────────────────────────────────┐     │
│  │  ALL TOOLS + SCHEMAS LOADED AT BOOTUP             │     │
│  │  ════════════════════════════════════════════════  │     │
│  │  • Tool 1 definition + schema                      │     │
│  │  • Tool 2 definition + schema                      │     │
│  │  • Tool 3 definition + schema                      │     │
│  │  • ...                                             │     │
│  │  • Tool N definition + schema                      │     │
│  │                                                     │     │
│  │  ⚠️ BLOATS CONTEXT WINDOW IMMEDIATELY!             │     │
│  └────────────────────────────────────────────────────┘     │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Avantages**:
- ✅ Économie massive de tokens (context efficiency)
- ✅ Agent charge uniquement ce dont il a besoin
- ✅ Scalable: ajouter des skills ne bloat pas le context
- ✅ Meilleure performance du modèle (moins de distraction)

**Limitations**:
- ❌ Latence additionnelle (3 round-trips vs 1 pour prompts)
- ❌ Dépend de la capacité de l'agent à choisir le bon skill

**Cas d'usage**:
- Library de 50+ skills disponibles mais seuls 2-3 sont chargés par session
- Worktree manager skill: charge seulement les instructions quand worktrees mentionnés
- PDF skill: charge uniquement quand un PDF est détecté dans le contexte

---

### 4. The Core 4 - Fondamentaux de l'Agent Coding

**Définition**: **Tous les agents** et **toutes les features** reposent sur 4 éléments fondamentaux. Si vous maîtrisez ces 4, vous maîtrisez tout.

```
╔═══════════════════════════════════════════════════════════════╗
║                        THE CORE 4                             ║
║                 Foundation of All Agents                      ║
╚═══════════════════════════════════════════════════════════════╝
                              ▼
        ┌─────────────────────────────────────────────┐
        │                                             │
        │         Every Agent = Core 4                │
        │                                             │
        │   ┌─────────────────────────────────┐      │
        │   │  1. CONTEXT                     │      │
        │   │     • Codebase files            │      │
        │   │     • Memory (CLAUDE.md)        │      │
        │   │     • Conversation history      │      │
        │   └─────────────────────────────────┘      │
        │                  ▼                          │
        │   ┌─────────────────────────────────┐      │
        │   │  2. MODEL                       │      │
        │   │     • LLM (Claude Sonnet 4.5)   │      │
        │   │     • Reasoning capabilities    │      │
        │   └─────────────────────────────────┘      │
        │                  ▼                          │
        │   ┌─────────────────────────────────┐      │
        │   │  3. PROMPT                      │      │
        │   │     • Instructions               │      │
        │   │     • User intent                │      │
        │   │     • **THE PRIMITIVE**          │      │
        │   └─────────────────────────────────┘      │
        │                  ▼                          │
        │   ┌─────────────────────────────────┐      │
        │   │  4. TOOLS                       │      │
        │   │     • Read, Write, Edit, Bash   │      │
        │   │     • MCP tools                 │      │
        │   └─────────────────────────────────┘      │
        │                                             │
        └─────────────────────────────────────────────┘
                              ▼
        ┌─────────────────────────────────────────────┐
        │  Every Claude Code Feature Builds on This   │
        │                                              │
        │  Skills      = Core 4 + Modularity           │
        │  MCP         = Core 4 + External Tools       │
        │  Sub-Agents  = Core 4 + Isolated Context     │
        │  Slash Cmds  = Core 4 (closest to bare metal)│
        └─────────────────────────────────────────────┘
```

**Citation clé**:
> "It's because everything comes down to just four pieces. You have context, model, prompt, and tools. If you understand these, if you can build and manage these, you will win."
> — Dan

**Avantages**:
- ✅ Framework mental simplifié pour comprendre toutes les features
- ✅ Toujours revenir aux fondamentaux quand confus
- ✅ Évite la surcharge de features (feature bloat)

**Limitations**:
- ❌ Peut paraître trop simpliste pour des workflows complexes

**Cas d'usage**:
- Debugger un skill qui ne fonctionne pas → revenir au Core 4
- Apprendre une nouvelle feature → la décomposer en Core 4
- Choisir entre 2 approches → celle qui expose le mieux le Core 4

---

### 5. Quand Utiliser Chaque Feature - Decision Tree

**Définition**: Un arbre de décision clair pour choisir la bonne feature selon votre use case.

```
                      ┌────────────────────┐
                      │  Nouveau Problème  │
                      └──────────┬─────────┘
                                 │
                      ┌──────────▼──────────┐
                      │ Besoin paralléliser?│
                      └──────────┬──────────┘
                                 │
                    ┌────────────┴────────────┐
                    │ YES                     │ NO
                    ▼                         ▼
            ┌───────────────┐      ┌──────────────────┐
            │  SUB-AGENTS   │      │ Intégration ext? │
            │  (isolated +  │      └──────────┬───────┘
            │   parallel)   │                 │
            └───────────────┘      ┌──────────┴──────────┐
                                   │ YES                 │ NO
                                   ▼                     ▼
                           ┌───────────────┐   ┌─────────────────┐
                           │  MCP SERVERS  │   │ Tâche répétée ? │
                           │  (external    │   └────────┬────────┘
                           │   tools)      │            │
                           └───────────────┘   ┌────────┴────────┐
                                               │ YES             │ NO
                                               ▼                 ▼
                                     ┌──────────────────┐ ┌─────────────────┐
                                     │ Agent doit auto? │ │ SLASH COMMAND   │
                                     └────────┬─────────┘ │ (manual, simple)│
                                              │           └─────────────────┘
                                   ┌──────────┴──────────┐
                                   │ YES                 │ NO
                                   ▼                     ▼
                          ┌─────────────────┐  ┌─────────────────┐
                          │     SKILL       │  │ SLASH COMMAND   │
                          │ (agent-invoked) │  │ (manual invoke) │
                          └─────────────────┘  └─────────────────┘

MOTS-CLÉS TRIGGERS:
━━━━━━━━━━━━━━━━━━
• "parallel"           → SUB-AGENTS
• "external API/DB"    → MCP
• "automatically"      → SKILL
• "one-off task"       → SLASH COMMAND
• "repeat workflow"    → SKILL ou SLASH COMMAND (selon auto/manual)
```

**Exemples annotés**:
- ✅ "Fix 50 failing tests in parallel" → **Sub-Agents** (parallel keyword)
- ✅ "Automatically extract PDF data" → **Skill** (automatic keyword)
- ✅ "Connect to Jira" → **MCP** (external integration)
- ✅ "Generate commit message" → **Slash Command** (simple, one-off)
- ✅ "Manage git worktrees (create/list/remove)" → **Skill** (repeat workflow, multiple ops)

**Avantages**:
- ✅ Decision tree clair et actionnable
- ✅ Évite la paralysie du choix
- ✅ Mots-clés triggers faciles à repérer

**Limitations**:
- ❌ Cas edge où plusieurs solutions sont valides

**Cas d'usage**:
- Nouveau projet: partir avec Slash Commands, évoluer vers Skills si répété
- Debugging: toujours commencer avec un Slash Command simple
- Production: Skills pour workflows automatiques, MCP pour intégrations

---

## Citations Marquantes

> "The prompt is the fundamental unit of knowledge work and of programming. If you don't know how to build and manage prompts, you will lose."
> — Dan (12:09)

> "If you understand these [Core 4], if you can build and manage these, you will win. Why is that? It's because every agent is the core 4."
> — Dan (12:44)

> "Do not give away the prompt. The prompt is the fundamental unit of knowledge work. If you avoid understanding how to write great prompts, you will not progress as an agentic engineer."
> — Dan (19:10)

> "Skills are effectively canonized prompt engineering plus modularity. The real question is what's the actual innovation? I think the answer is not that much."
> — Dan (24:48)

> "Use whatever works for you. But I would say have a strong bias towards slash commands. And then when you're thinking about composing many slash commands, sub agents or MCPs, think about putting them in a skill."
> — Dan (20:44)

> "This [Skills] is the agentic approach. This is what you want to see. Agent just does the right thing."
> — Dan (22:14)

---

## Points d'Action

### ✅ Immédiat

1. **Maîtriser les Slash Commands AVANT tout**
   - Créer 5-10 slash commands pour vos workflows quotidiens
   - Refactorer vos prompts ad-hoc en slash commands réutilisables
   - Ne PAS sauter directement aux Skills

2. **Clarifier votre mental model avec le Core 4**
   - Pour chaque feature que vous utilisez, la décomposer en Context + Model + Prompt + Tools
   - Revenir au Core 4 quand vous êtes confus sur quelle feature utiliser

### 🔄 Court Terme

3. **Identifier les candidats pour Skills**
   - Repérer vos slash commands utilisés 5+ fois par semaine
   - Workflows avec plusieurs étapes répétitives (ex: worktree management)
   - Passer de slash command → skill uniquement si bénéfice clair (auto-invoke + modularity)

4. **Tester la compositional hierarchy**
   - Créer un skill qui compose 3 slash commands
   - Vérifier si l'agent trigger le bon skill automatiquement
   - Mesurer la fiabilité (est-ce que ça marche 90% du temps ?)

### 💪 Long Terme

5. **Build the thing that builds the thing**
   - Créer un "meta skill" pour générer d'autres skills
   - Automatiser la création de skills à partir de slash commands existants

6. **Maîtriser le prompt engineering**
   - Étudier les patterns de prompts efficaces
   - S'entraîner à décomposer des problèmes complexes en prompts simples
   - Se former sur Tactical Agentic Coding (mentionné par Dan)

---

## Ressources Mentionnées

### 🔗 Outils

- **Claude Code Skills Feature** : [https://docs.anthropic.com/en/docs/build-with-claude/agent-skills](https://docs.anthropic.com/en/docs/build-with-claude/agent-skills)
  - Feature officielle pour créer des skills agent-first

- **Git Worktrees** : Outil git natif pour travailler sur plusieurs branches en parallèle
  - `git worktree add <path> <branch>` pour créer
  - Use case: développement parallèle sur plusieurs features

### 📚 Documentation

- **Tactical Agentic Coding** : [Mentionné par Dan, lien non fourni]
  - Formation avancée sur les patterns d'agent coding
  - Couvre les ADWs (AI Developer Workflows)

- **Agentic Horizon** : [Mentionné par Dan, lien non fourni]
  - Cours sur multi-agent workflows

### 🎥 Repo GitHub

- **Codebase de la vidéo** : [Lien mentionné "in description"]
  - 4 skills inclus: Meta skill, Video processor, Worktree manager, etc.
  - Démo complète de compositional patterns

---

## Schéma Récapitulatif

```
╔═══════════════════════════════════════════════════════════════════════════╗
║              CLAUDE CODE FEATURES - THE COMPLETE PICTURE                  ║
╚═══════════════════════════════════════════════════════════════════════════╝

                              ┌────────────────┐
                              │   YOUR TASK    │
                              └───────┬────────┘
                                      │
                        ┌─────────────▼─────────────┐
                        │  Decision Framework       │
                        ├───────────────────────────┤
                        │ • Parallelize? → Sub      │
                        │ • External?    → MCP      │
                        │ • Automatic?   → Skill    │
                        │ • One-off?     → Slash    │
                        └─────────────┬─────────────┘
                                      │
                        ┌─────────────▼─────────────┐
                        │  Compositional Hierarchy  │
                        └───────────────────────────┘
                                      │
        ┌─────────────────────────────┼─────────────────────────────┐
        │                             │                             │
        ▼                             ▼                             ▼
┌───────────────┐          ┌────────────────────┐        ┌──────────────────┐
│    SKILLS     │          │    MCP SERVERS     │        │   SUB-AGENTS     │
│               │          │                    │        │                  │
│ • Agent-first │          │ • External tools   │        │ • Isolated       │
│ • Reusable    │◄────────►│ • Database/APIs    │        │ • Parallel       │
│ • Modular     │ composes │ • Context bloat    │        │ • Context LOST   │
└───────┬───────┘          └──────────┬─────────┘        └────────┬─────────┘
        │                             │                           │
        └─────────────────────────────┼───────────────────────────┘
                                      │ ALL compose ↓
                                      ▼
                        ┌──────────────────────────┐
                        │   SLASH COMMANDS         │
                        │   (Prompts = Primitive)  │
                        │                          │
                        │ • Closest to bare metal  │
                        │ • MUST MASTER FIRST      │
                        │ • Foundation of all      │
                        └─────────────┬────────────┘
                                      │ built on ↓
                                      ▼
                        ┌──────────────────────────┐
                        │      THE CORE 4          │
                        ├──────────────────────────┤
                        │ Context • Model          │
                        │ Prompt  • Tools          │
                        └──────────────────────────┘

KEY INSIGHTS:
━━━━━━━━━━━━━
1. START with Slash Commands (prompts)
2. SCALE to Skills when repeated (3+ times/week)
3. USE MCP for external integrations only
4. USE Sub-Agents for parallelization only
5. ALWAYS understand the Core 4 foundation
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Les Skills sont-ils vraiment fiables quand on en chaîne 3-4 ensemble ? (Dan doute à 24:40)
- Pourquoi Skills n'ont-ils pas de répertoire `/commands` dédié pour nested prompts ?
- Quel est le seuil exact pour passer d'un slash command à un skill ? (3 fois ? 5 fois ?)
- Est-ce que Skills vont évoluer pour supporter des nested sub-agents ?

### 💡 Idées d'Amélioration

- Créer un "skill health check" slash command pour tester la fiabilité des skills
- Développer une convention de nommage claire: `skill-[domain]-manager` (ex: `skill-worktree-manager`)
- Ajouter un compteur d'usage aux slash commands pour détecter automatiquement les candidats à skill
- Créer un template de migration slash-command → skill

### 🔗 À Combiner Avec

- **Skills Deep Dive** (Solo Swift Crafter) pour comprendre l'architecture interne
- **MCP Servers Guide** pour intégrations externes (Jira, DBs, APIs)
- **Sub-Agents Workflows** (Melvynx) pour parallelization patterns
- **Prompt Engineering Mastery** (fondamental selon Dan)

---

## Conclusion

**Message clé** : **Ne pas se laisser distraire par les nouvelles features**. Les prompts (slash commands) sont et restent la primitive fondamentale de tout agent coding. Skills ne remplacent PAS les slash commands, ils les **composent**. Commencez toujours avec un slash command simple, puis évoluez vers un skill uniquement si vous avez un workflow répétitif qui bénéficie de l'auto-invocation par l'agent.

Dan donne une note de **8/10 aux Skills** : feature solide, mais pas révolutionnaire (= "canonized prompt engineering"). Les vraies limitations : pas de nested `/commands`, fiabilité inconnue pour le chaining, et pas vraiment d'innovation technique (juste une structure opinionated).

**Action immédiate** :
1. Lister vos 10 prompts les plus utilisés
2. Les convertir en slash commands (pas en skills !)
3. Identifier ceux utilisés 5+ fois/semaine → candidats pour skills
4. Créer 1 skill "manager" pour un workflow répétitif (ex: git worktrees, deployments, testing)

---

**🎓 Niveau de difficulté** : 🟠 Avancé (nécessite expérience avec prompts, slash commands ET MCP)
**⏱️ Temps de mise en pratique** : 2-4 heures (créer 1 skill complet avec 3 slash commands composés)
**💪 Impact** : 🔥 TRÈS ÉLEVÉ - Change complètement la compréhension des features Claude Code
