# When to Use Claude Code Agent Skills vs MCP vs Sub-Agents vs Slash Commands

![Miniature vidéo](https://img.youtube.com/vi/kFpLzCVLA20/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: When to Use Claude Code Agent Skills vs MCP vs Sub-Agents vs Slash Commands
- **Auteur**: Dan (Agentic Coding)
- **Durée**: 27 minutes
- **Date**: Janvier 2025
- **Lien**: [https://youtu.be/kFpLzCVLA20](https://youtu.be/kFpLzCVLA20)

## Tags

`#skills` `#mcp` `#subagents` `#slash-commands` `#composition` `#prompts` `#primitives` `#core-4` `#progressive-disclosure` `#agent-first`

---

## Résumé Exécutif

Dan analyse en profondeur les **4 capabilities clés de Claude Code** : Skills, MCP, Sub-Agents et Slash Commands. Il démontre que chaque feature a un rôle distinct et qu'**elles ne se remplacent pas mutuellement**. La vidéo révèle que **les prompts (slash commands) sont les primitives fondamentales** de tout agent coding, et que Skills agit comme une **couche de composition** pour regrouper ces primitives en solutions réutilisables.

Le message révolutionnaire : **"The prompt is the fundamental unit of knowledge work"**. Dan insiste sur le fait que maîtriser les prompts est NON-NÉGOCIABLE pour réussir en tant qu'ingénieur agentic en 2025+.

**Conclusion principale**: Skills ne remplacent pas les slash commands ou MCP - ils composent ces features ensemble pour créer des solutions agent-first automatisées et modulaires. Toujours commencer par un prompt simple, puis composer progressivement.

---

## Timecodes

- 00:00 - Introduction : Skills vs MCP vs Sub-Agents vs Slash Commands
- 01:08 - Le MAUVAIS moyen d'utiliser Skills (démo git worktrees)
- 01:42 - Comparaison des 4 capabilities (table comparative)
- 03:00 - Progressive Disclosure : Skills économisent le context window
- 04:42 - Démonstration : Créer 3 git worktrees en parallèle
- 06:25 - Modularity : Structure dédiée des Skills
- 07:47 - Composition : Skills peuvent utiliser tout (MCP, Sub-Agents, Prompts)
- 08:52 - Cas d'usage par feature (quand utiliser quoi ?)
- 11:20 - Table décisionnelle : Extract PDF → Skill, Jira → MCP, etc.
- 13:58 - Skills vs Slash Commands : La confusion principale
- 15:47 - Le BON moyen d'utiliser Skills (composition)
- 17:20 - The Core 4 : Context, Model, Prompt, Tools
- 18:30 - Prompts = Primitive fondamentale de tout agent coding
- 19:10 - Quand passer d'un Prompt à un Skill ? (gestion vs création)
- 21:00 - Démonstration : Work Tree Manager Skill
- 22:40 - Définitions officielles des 4 capabilities
- 24:30 - Composition Hierarchy : Skills > MCP > Sub-Agents > Prompts
- 25:40 - Pros & Cons des Skills (8/10 rating)
- 26:30 - Conclusion : Maîtriser les prompts d'abord, composer ensuite

---

## Concepts Clés

### 1. The Core 4 : Fondation de Tout Agent

**Définition**: Les 4 éléments fondamentaux de tout agent coding : **Context, Model, Prompt, Tools**. Maîtriser ces 4 éléments = maîtriser tous les agents et toutes les features.

```
╔═══════════════════════════════════════╗
║          THE CORE 4                   ║
║   Foundation of All Agents            ║
╚═══════════════════════════════════════╝
              ▼
      ┌─────────────────┐
      │   1. CONTEXT    │ ← What the agent knows
      └─────────────────┘
              ▼
      ┌─────────────────┐
      │   2. MODEL      │ ← Which LLM (Claude 3.5, etc.)
      └─────────────────┘
              ▼
      ┌─────────────────┐
      │   3. PROMPT     │ ← Instructions (THE PRIMITIVE)
      └─────────────────┘
              ▼
      ┌─────────────────┐
      │   4. TOOLS      │ ← What the agent can do
      └─────────────────┘
              ▼
        ╔═══════════╗
        ║   AGENT   ║
        ╚═══════════╝

🎯 Master The Core 4 → Master All Features
```

**Avantages**:
- ✅ Simplifie toute la complexité de Claude Code
- ✅ Permet de comprendre n'importe quelle feature (Skills, MCP, etc.)
- ✅ Applicable à tous les outils d'agent coding (pas juste Claude Code)
- ✅ Framework mental pour décider quelle feature utiliser

**Limitations**:
- ❌ Abstraction de haut niveau (pas de détails techniques)
- ❌ Nécessite de maîtriser chaque élément individuellement

**Cas d'usage**:
- Débugger un agent qui ne fonctionne pas → vérifier chaque élément du Core 4
- Choisir entre Skills/MCP/Sub-Agents → analyser quel élément du Core 4 est impacté
- Apprendre une nouvelle feature → la relier au Core 4

---

### 2. Composition Hierarchy : L'Ordre des Primitives

**Définition**: Les features Claude Code ont une **hiérarchie de composition claire**. Skills est au sommet (peut utiliser tout), Prompts est à la base (primitive fondamentale).

```
Composition Hierarchy (Top to Bottom)
══════════════════════════════════════

┌──────────────────────────────────────┐
│        🏆 SKILLS (TOP)               │ ← Compose TOUT
│  ┌────────────────────────────────┐  │
│  │ Can use: MCP, Sub-Agents,      │  │
│  │ Slash Commands, other Skills   │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘
              ▼ Uses
┌──────────────────────────────────────┐
│        🔌 MCP SERVERS                │ ← External integrations
│  (Connect to Jira, DB, APIs, etc.)   │
└──────────────────────────────────────┘
              ▼ Can use
┌──────────────────────────────────────┐
│      🤖 SUB-AGENTS                   │ ← Isolate context
│  (Parallel workflows, task delegate) │
└──────────────────────────────────────┘
              ▼ Can use
┌──────────────────────────────────────┐
│    ⚡ SLASH COMMANDS (PRIMITIVE)      │ ← Base unit
│  ┌────────────────────────────────┐  │
│  │ THE FUNDAMENTAL UNIT           │  │
│  │ Everything = Prompt at the end │  │
│  └────────────────────────────────┘  │
└──────────────────────────────────────┘

⚠️ CIRCULAR COMPOSITION POSSIBLE:
   - Slash Command can invoke Skills
   - Skills can invoke Slash Commands
   - Sub-Agents can invoke Slash Commands

🎯 KEY INSIGHT: Always start with Slash Commands,
   then compose upward when needed
```

**Avantages**:
- ✅ Clarifie quand utiliser chaque feature
- ✅ Montre que Skills n'est PAS un remplacement
- ✅ Révèle que Slash Commands est la primitive la plus importante
- ✅ Guide pour construire des solutions modulaires

**Limitations**:
- ❌ Composition circulaire peut créer de la confusion
- ❌ Hiérarchie non stricte (plusieurs chemins possibles)

**Cas d'usage**:
- Créer une nouvelle feature → commencer par Slash Command
- Besoin d'automatisation → envelopper dans un Skill
- Besoin d'isolation → déléguer à Sub-Agent
- Besoin de connexion externe → utiliser MCP

---

### 3. Progressive Disclosure : Skills vs MCP Context Window

**Définition**: Skills utilisent **3 niveaux d'adoption progressive** pour économiser le context window, contrairement aux MCP qui "explodent" le contexte au démarrage.

```
Context Window Management
═════════════════════════

MCP Servers (❌ Context Explosion):
┌─────────────────────────────────────┐
│ MCP SERVER STARTS                   │
│ ┌─────────────────────────────────┐ │
│ │ ❌ ALL TOOLS LOADED AT BOOT     │ │
│ │ ❌ ALL SCHEMAS IN CONTEXT       │ │
│ │ ❌ FULL API DOCS LOADED         │ │
│ └─────────────────────────────────┘ │
│                                     │
│ 🔥 CONTEXT WINDOW: 50K+ tokens     │
└─────────────────────────────────────┘


Skills (✅ Progressive Disclosure):
┌─────────────────────────────────────┐
│ LEVEL 1: METADATA ONLY              │
│ ┌─────────────────────────────────┐ │
│ │ ✅ Skill name + description     │ │
│ │ ✅ ~100 tokens                  │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
              ▼ If triggered
┌─────────────────────────────────────┐
│ LEVEL 2: INSTRUCTIONS               │
│ ┌─────────────────────────────────┐ │
│ │ ✅ SKILL.md loaded              │ │
│ │ ✅ ~2K tokens                   │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘
              ▼ If resources needed
┌─────────────────────────────────────┐
│ LEVEL 3: RESOURCES                  │
│ ┌─────────────────────────────────┐ │
│ │ ✅ Examples, docs, templates    │ │
│ │ ✅ ~5K tokens                   │ │
│ └─────────────────────────────────┘ │
└─────────────────────────────────────┘

💡 Skills load context ONLY when needed
🔥 MCP loads EVERYTHING upfront
```

**Avantages**:
- ✅ Économie massive du context window (100x moins que MCP)
- ✅ Permet d'avoir 10+ Skills vs 2-3 MCP servers max
- ✅ Chargement incrémental = plus rapide
- ✅ Agent décide quoi charger et quand

**Limitations**:
- ❌ Nécessite que l'agent détecte le bon moment (reliability concerns)
- ❌ Si mal configuré, peut charger trop de levels inutilement

**Cas d'usage**:
- Remplacer un MCP server qui torture votre context window
- Avoir des dizaines de skills disponibles sans coût
- Automatiser des workflows sans sacrifier du contexte

---

### 4. Agent-First vs Manual Trigger : Skills vs Slash Commands

**Définition**: **Skills sont invoqués automatiquement par l'agent**, tandis que **Slash Commands sont des triggers manuels**. C'est LA différence principale.

```
Decision Flow: Skill or Slash Command?
═══════════════════════════════════════

User Request:
"Implement authentication"
              │
              ▼
┌─────────────────────────────────────┐
│ Question: Do you want this AUTOMATIC│
│ or do you want MANUAL CONTROL?      │
└─────────────────────────────────────┘
         │                    │
         ▼                    ▼
    AUTOMATIC            MANUAL
         │                    │
         ▼                    ▼
┌──────────────┐      ┌──────────────┐
│   SKILL      │      │ /COMMAND     │
│              │      │              │
│ ✅ Agent     │      │ ✅ You       │
│  decides     │      │  decide      │
│  when        │      │  when        │
│              │      │              │
│ ✅ Triggered │      │ ✅ Explicit  │
│  by context  │      │  invocation  │
│              │      │              │
│ Example:     │      │ Example:     │
│ - PDF text   │      │ - /commit    │
│   extraction │      │ - /test      │
│ - Style      │      │ - /deploy    │
│   violations │      │              │
└──────────────┘      └──────────────┘

🎯 Use Skill: When you want "set it and forget it"
⚡ Use /Command: When you want explicit control
```

**Avantages (Skills)**:
- ✅ Agent invoqué automatiquement = moins de micro-management
- ✅ Dial up autonomy knob to 11
- ✅ Agent détecte le bon contexte (si bien configuré)

**Avantages (Slash Commands)**:
- ✅ Contrôle total sur quand exécuter
- ✅ Prévisibilité : tu sais exactement ce qui va se passer
- ✅ Plus simple à débugger
- ✅ Primitive fondamentale = toujours fiable

**Limitations**:
- ❌ Skills : Reliability concerns (l'agent choisira-t-il le bon skill ?)
- ❌ Slash Commands : Nécessite ton intervention manuelle

**Cas d'usage**:
- **Skill** : Extraire automatiquement du texte de PDFs dans ton workflow
- **Slash Command** : Créer un commit message (`/commit`) quand TU décides
- **Skill** : Détecter automatiquement les violations de style guide
- **Slash Command** : Lancer les tests (`/test`) à un moment précis

---

### 5. The Prompt is the Fundamental Unit

**Définition**: **"The prompt is the fundamental unit of knowledge work and programming"** (Dan). TOUT se résume à des prompts (tokens in, tokens out). Maîtriser les prompts est NON-NÉGOCIABLE.

```
Why Prompts are the Primitive
══════════════════════════════

Everything Reduces to Prompts:
┌─────────────────────────────────────┐
│           SKILL                     │
│  ┌───────────────────────────────┐  │
│  │ Uses /slash-command-1         │  │
│  │ Uses /slash-command-2         │  │
│  │ Uses MCP server (prompt)      │  │
│  └───────────────────────────────┘  │
│         ▼ All reduce to             │
│  ┌───────────────────────────────┐  │
│  │      PROMPTS (tokens)         │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘

LLM Execution:
┌─────────┐    ┌─────────┐    ┌─────────┐
│ Tokens  │───>│  Model  │───>│ Tokens  │
│  IN     │    │ Process │    │  OUT    │
└─────────┘    └─────────┘    └─────────┘
    ▲                              │
    │                              │
    └──────────────────────────────┘
         Everything is a PROMPT

🎯 Master Prompts → Master Everything
❌ Skip Prompts → You Will Lose

Dan's Warning:
"If you avoid understanding how to write
great prompts, you will not progress as
an agentic engineer in 2025, 2026 and beyond."
```

**Avantages**:
- ✅ Fondation universelle (applicable à tous les LLMs/agents)
- ✅ Toutes les features se composent de prompts
- ✅ Maîtriser les prompts = débloquer toutes les capabilities
- ✅ Compétence transférable (GPT, Gemini, Claude, etc.)

**Limitations**:
- ❌ Les features "fancy" (Skills, MCP) peuvent masquer cette vérité
- ❌ Tentation de skip les fondamentaux pour aller vite

**Cas d'usage**:
- Toujours commencer par un **simple prompt** (slash command)
- Si le prompt marche → ne le remplace PAS par un Skill (sauf si automatisation nécessaire)
- Débugger un Skill qui échoue → revenir au prompt de base
- Apprendre une nouvelle feature → la décomposer en prompts

---

## Citations Marquantes

> "The prompt is the fundamental unit of knowledge work and programming. If you don't know how to build and manage prompts, you will lose."

> "Skills are effectively opinionated prompt engineering plus modularity. The real question is: what's actually new here?"

> "Don't give away the prompt. Everything comes down to just four pieces: Context, Model, Prompt, Tools. If you master these, you will win."

> "Skills don't replace slash commands or MCP or sub-agents. This is a higher compositional level to group features together."

> "If you can do the job with a sub-agent or custom slash command and it's a one-off job, do not use a skill. This is not what skills are for."

> "Use whatever works for you, but have a strong bias towards slash commands. When composing many slash commands, think about putting them in a skill."

---

## Points d'Action

### ✅ Immédiat (< 1h)

1. **Auditer tes Slash Commands actuels**
   - Lister tous tes `/commands` existants
   - Identifier lesquels pourraient être automatisés (→ Skills)
   - Garder les one-off tasks en `/commands`

2. **Créer un Simple Prompt avant tout**
   - Prochain workflow : commencer par `/command`
   - Tester et valider la solution
   - Seulement APRÈS → envisager un Skill

3. **Vérifier ton Context Window**
   - Si tu as beaucoup de MCP servers → context explosion ?
   - Envisager de convertir certains MCP en Skills
   - Mesurer la différence de tokens

### 🔄 Court Terme (1 jour - 1 semaine)

4. **Créer ton Premier Skill de "Manager"**
   - Identifier un workflow répétitif avec plusieurs étapes
   - Créer un Skill qui compose plusieurs `/commands`
   - Exemple : Git Work Tree Manager (create, list, remove, merge)

5. **Documenter ta Composition Hierarchy**
   - Mapper tes Skills → quels /commands ils utilisent ?
   - Mapper tes /commands → lesquels utilisent des MCP ?
   - Visualiser ta chaîne de composition

6. **Tester la Reliability des Skills**
   - Créer un Skill et observer si l'agent le trigger au bon moment
   - Comparer avec `/command` équivalent
   - Noter les cas où Skills échoue à se déclencher

### 💪 Long Terme (> 1 semaine)

7. **Maîtriser The Core 4**
   - Approfondir Context management (memory, CLAUDE.md)
   - Approfondir Prompt engineering (frameworks, patterns)
   - Approfondir Tools (créer tes propres MCP servers)

8. **Construire des Skills Composables**
   - Créer des Skills qui utilisent d'autres Skills
   - Tester la chaîne de composition (Skill A → Skill B → /command)
   - Documenter les limites de composition

9. **Contribuer à l'Écosystème**
   - Partager tes meilleurs Skills (GitHub, Plugins)
   - Documenter tes patterns de composition
   - Aider la communauté à clarifier Skills vs /commands

---

## Ressources Mentionnées

### 🔗 Outils

- **Git Work Trees** : [Git Documentation](https://git-scm.com/docs/git-worktree)
  - Permet de créer plusieurs branches en parallèle sans switching

- **Tactical Agentic Coding** : [Dan's Course](https://tacticalagenticcoding.com)
  - Cours avancé sur les patterns d'agent coding et AI Developer Workflows (ADWs)

- **Agentic Horizon** : [Dan's Community](https://agentichorizon.com)
  - Communauté pour maîtriser les prompts à l'échelle avec multi-agents

### 📚 Documentation

- **Claude Code Skills Docs** : [https://code.claude.com/docs/skills](https://code.claude.com/docs/skills)
  - Documentation officielle sur les Skills

- **Claude Code MCP Docs** : [https://modelcontextprotocol.io/](https://modelcontextprotocol.io/)
  - Spécification du Model Context Protocol

### 🎥 Vidéos Connexes

- **Dan's Channel** : Autres vidéos sur Skills, Sub-Agents, Prompts
  - Output Styles, Hooks, Plugins, etc.

---

## Schéma Récapitulatif

```
🎯 DAN'S ULTIMATE DECISION TREE
═══════════════════════════════

Start Here:
┌─────────────────────────────────────┐
│ "I need to solve a problem"         │
└─────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────┐
│ Q1: Is this a REPEAT WORKFLOW?      │
└─────────────────────────────────────┘
     YES │           │ NO
         ▼           ▼
    ┌────────┐  ┌─────────────┐
    │ Maybe  │  │ Use /command│
    │ Skill  │  │ (one-off)   │
    └────────┘  └─────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│ Q2: Do I want AUTOMATIC trigger?    │
└─────────────────────────────────────┘
     YES │           │ NO
         ▼           ▼
    ┌────────┐  ┌─────────────┐
    │ SKILL  │  │ /command    │
    │        │  │ (manual)    │
    └────────┘  └─────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│ Q3: Does it need EXTERNAL data?     │
└─────────────────────────────────────┘
         │ YES
         ▼
    ┌────────┐
    │ Skill  │
    │  +     │
    │  MCP   │
    └────────┘


Special Cases:
══════════════

Need PARALLEL workflows?
  → SUB-AGENTS (always)

Need EXTERNAL integration?
  → MCP SERVER (always)

One-off task?
  → /COMMAND (always start here)

Managing multiple /commands?
  → SKILL (compose them)


The Golden Rule:
════════════════
Start with /command → Validate → Compose into Skill if needed
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- **Reliability des Skills** : Dans combien de cas l'agent trigger le bon skill vs échoue ?
- **Composition Limits** : Peut-on vraiment chaîner 5+ Skills de manière fiable ?
- **Performance** : Skills vs /commands → quelle différence de latency/tokens ?
- **Best Practices** : Quand arrêter de composer et garder un simple /command ?

### 💡 Idées d'Amélioration

- Créer une **Skill Library personnelle** avec patterns réutilisables
- Développer un **Skill Tester** pour mesurer reliability automatiquement
- Construire un **Meta Skill** (comme Dan) pour générer d'autres Skills
- Documenter ma propre **Composition Hierarchy** pour mes projets

### 🔗 À Combiner Avec

- [Formation Claude Code 2.0 - Melvynx](./formation-claude-code-2-0-melvynx.md) : Setup de Skills
- [Sub-Agents Usage - Melvynx](./subagents-usage-melvynx.md) : Quand utiliser Sub-Agents vs Skills
- [800h Claude Code - Edmund Yong](./800h-claude-code-edmund-yong.md) : D.R.Y. avec Skills
- Documentation MCP : Comparaison Skills vs MCP (context window)

---

## Conclusion

**Message clé** : Skills, MCP, Sub-Agents et Slash Commands sont **4 outils DISTINCTS** qui ne se remplacent pas. Skills est une **couche de composition** pour automatiser des workflows répétitifs en regroupant des /commands, MCP, et sub-agents. MAIS : **le prompt (/command) reste la primitive fondamentale** que tu DOIS maîtriser avant tout.

**Dan's Rating** : 8/10 pour Skills
- ✅ Agent-invoked, context-efficient, modular
- ❌ Doesn't go all the way (no `/commands` directory inside Skills)
- ❌ Reliability concerns (will agent trigger right skill in chains?)

**Action immédiate** : Audite tes Slash Commands actuels. Identifie UN workflow répétitif. Crée ton premier Skill qui compose plusieurs /commands. Teste la reliability. Compare avec /command équivalent.

---

**🎓 Niveau de difficulté** : 🟠 Avancé (nécessite maîtrise de /commands, MCP, Sub-Agents d'abord)
**⏱️ Temps de mise en pratique** : 2-4 heures (créer 2-3 Skills expérimentaux)
**💪 Impact** : 🔥🔥🔥 MAJEUR (change complètement la façon de penser Skills)
