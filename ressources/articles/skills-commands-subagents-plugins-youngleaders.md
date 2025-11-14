# Understanding Claude Code: Skills vs Commands vs Subagents vs Plugins

**Source** : Young Leaders in Tech
**Auteur** : John Conneely
**Date** : 21 octobre 2025
**URL** : https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins
**Durée de lecture** : 20-25 minutes

---

## 🎯 Résumé Exécutif

John Conneely partage son retour d'expérience après avoir reconstruit son setup Claude Code suite aux releases successives de plugins, marketplaces et skills. L'article propose un **modèle mental clair** pour distinguer Skills, Commands, Subagents et Plugins - quatre types d'extensibilité qui fonctionnent ensemble comme un système cohérent. À travers des exemples concrets (création de 803 lignes d'agent réduit à 281 lignes sans perte de fonctionnalité), l'auteur démontre comment Skills résout le problème de duplication d'instructions et améliore la maintenabilité des agents.

**Problème résolu** : Confusion entre les différents types d'extensibilité Claude Code et comment les utiliser efficacement.

**Solution proposée** : Un arbre de décision simple + patterns validés (WHEN/WHEN NOT pour Skills, Subagent Analyse + Main Claude Execute, etc.)

**Pertinence pour Claude Code** : ⭐⭐⭐⭐⭐ - Article de référence pour comprendre l'écosystème d'extensibilité de Claude Code.

---

## 📋 Table des Matières

- [Concepts Clés](#🎯-concepts-clés)
  - [1. L'Arbre de Décision : 4 Types d'Extensibilité](#1-larbre-de-décision--4-types-dextensibilité)
  - [2. Skills : Auto-Invocation Contextuelle](#2-skills--auto-invocation-contextuelle)
  - [3. Subagents : Orchestration de Workflows](#3-subagents--orchestration-de-workflows)
  - [4. Commands : Shortcuts vers Workflows](#4-commands--shortcuts-vers-workflows)
  - [5. Plugins : Distribution Scalable](#5-plugins--distribution-scalable)
- [Citations Marquantes](#💬-citations-marquantes)
- [Exemples Pratiques](#💻-exemples-pratiques)
- [Points d'Action](#✅-points-daction)
- [Ressources](#📚-ressources)

---

## 🎯 Concepts Clés

### 1. L'Arbre de Décision : 4 Types d'Extensibilité

**Définition** : Claude Code offre 4 mécanismes d'extensibilité qui se complètent.

**Arbre de Décision** :
```
                   ┌─────────────────────────────────┐
                   │ Quel est mon besoin ?           │
                   └──────────┬──────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│Claude se      │     │Automatiser    │     │Raccourci      │
│souvient de X  │     │workflow Y     │     │pour agent Z   │
│automatiquement│     │step-by-step   │     │fréquent       │
└───────┬───────┘     └───────┬───────┘     └───────┬───────┘
        │                     │                     │
        ▼                     ▼                     ▼
    📄 SKILL            🤖 SUBAGENT           ⚡ COMMAND
        │                     │                     │
        └─────────────────────┴─────────────────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │Partager le setup ?│
                    └─────────┬─────────┘
                              │
                              ▼
                         📦 PLUGIN
                    (bundle tout ensemble)
```

**Avantages** :
- Modèle mental simple et mémorisable
- Chaque type a un rôle distinct
- Complémentarité entre les 4 types
- Guide les décisions d'architecture

**Limitations** :
- Nécessite de comprendre les 4 concepts
- Peut sembler complexe au début

**Cas d'usage** :
- Décider quel type d'extensibilité utiliser
- Architecturer son setup Claude Code
- Communiquer avec son équipe

**Schéma - Hiérarchie des Locations** :
```
📦 Claude Code Setup
┣━━ 📁 Personal (~/.claude/)
┃   ┣━━ 📄 skills/user-manual.md         → Auto-invoked
┃   ┣━━ 🤖 agents/skill-creator.md       → Explicit
┃   ┗━━ ⚡ commands/create-skill.md      → /create-skill
┃
┣━━ 📁 Project (.claude/)
┃   ┣━━ 📄 skills/stakeholder.md         → Auto-invoked
┃   ┣━━ 🤖 agents/validator.md           → Explicit
┃   ┗━━ ⚡ commands/validate-skill.md    → /validate-skill
┃
┗━━ 📁 Shared (~/.claude/skills/shared/)
    ┗━━ 📄 templates/stakeholder.md      → Template
```

---

### 2. Skills : Auto-Invocation Contextuelle

**Définition** : Skills sont des **fournisseurs de contexte auto-invoqués**. Claude les charge automatiquement selon la description et le contexte de conversation.

**Avantages** :
- Auto-invocation basée sur le contexte
- Pas besoin de mentionner explicitement
- Évite répétition de préférences
- Coordonne plusieurs skills simultanément

**Limitations** :
- Qualité de description = précision d'invocation
- Descriptions génériques échouent
- Nécessite pattern WHEN + WHEN NOT

**Cas d'usage** :
- Personal User Manual (préférences travail)
- Contexte stakeholder projet
- Templates réutilisables

**Schéma - Pattern WHEN/WHEN NOT** :
```
╔═══════════════════════════════════════════════════╗
║  SKILL DESCRIPTION - PATTERN OBLIGATOIRE          ║
╚═══════════════════════════════════════════════════╝
                        │
        ┌───────────────┼───────────────┐
        │               │               │
        ▼               ▼               ▼
┌───────────────┐ ┌──────────┐ ┌──────────────┐
│WHAT           │ │WHEN      │ │WHEN NOT      │
│Contenu skill  │ │Trigger   │ │Boundaries    │
└───────────────┘ └──────────┘ └──────────────┘

Exemple Efficace ✅ :
╔═══════════════════════════════════════════════════╗
║ Personal work preferences for John Conneely.     ║
║                                                   ║
║ WHEN: drafting HIS emails, Slack messages,       ║
║       planning HIS work, optimising HIS workflows║
║                                                   ║
║ WHEN NOT: external blog posts, customer-facing   ║
║           communications, public docs            ║
╚═══════════════════════════════════════════════════╝

Exemple Inefficace ❌ :
┌───────────────────────────────────────────────────┐
│ Provides information about stakeholders          │
└───────────────────────────────────────────────────┘
     ▲
     │
  Trop vague, pas de boundaries
```

**Exemple d'usage - Personal User Manual** :
```markdown
---
description: Personal work preferences and communication style for John Conneely.
  Auto-invoke when drafting HIS emails, Slack messages, or internal updates;
  planning HIS work or tasks; optimising HIS productivity workflows; or discussing
  HIS collaboration approach. Do NOT load for external blog posts, customer-facing
  communications, or public documentation unless John explicitly requests.
---

# Personal User Manual

## Communication Style
- Direct and concise
- Skip the AI formalities
- Get to the point quickly
...
```

**Résultat Mesuré** :
- Sans skill : Message Slack verbose, style IA évident
- Avec skill : Message concis, ton personnel, style John

---

### 3. Subagents : Orchestration de Workflows

**Définition** : Subagents sont des **orchestrateurs de workflows explicites**. Invoqués par `@agent-name`, keywords ou Task tool pour guider processus multi-étapes.

**Avantages** :
- Workflows structurés step-by-step
- Réutilisables à travers projets
- Maintenables avec Skills
- Pattern Analyse/Exécution validé

**Limitations** :
- Nécessite invocation explicite
- Verbosité = baisse performance
- Accès limité aux outils (Read/Grep/Glob/TodoWrite)

**Cas d'usage** :
- Création interactive de skills
- Validation de checklist
- Workflows multi-étapes complexes

**Schéma - Pattern Analyse/Exécution** :
```
ARCHITECTURE HYBRIDE
════════════════════════════════════════════════════

┌─────────────────────────────────────────────────┐
│          SUBAGENT (Analyse Only)                │
│                                                 │
│  Tools: Read, Grep, Glob, TodoWrite            │
│                                                 │
│  1. Analyse context                            │
│  2. Create comprehensive plan                  │
│  3. Return plan to Main Claude                 │
└────────────┬────────────────────────────────────┘
             │
             │ Plan + Todos
             │
             ▼
┌─────────────────────────────────────────────────┐
│        MAIN CLAUDE (Execution)                  │
│                                                 │
│  Tools: Write, Edit, Bash                      │
│                                                 │
│  1. Receive plan from Subagent                 │
│  2. Execute modifications                      │
│  3. Full tool access preserved                 │
└─────────────────────────────────────────────────┘

POURQUOI ?
──────────
✅ Subagent = Structured workflows
✅ Main Claude = Full tool access
✅ Best of both worlds
```

**Exemple - Refactoring 803 → 281 lignes** :

**AVANT (803 lignes)** :
- 5 structures TODO dupliquées
- Section template 130 lignes mal alignée
- Checklists répétitives
- Instructions sur-expliquées
- **Eval Score** : 62/100

**APRÈS (281 lignes - 65% réduction)** :
- 1 pattern TODO réutilisable
- Template extrait dans Skills
- Checklists consolidées
- Instructions streamlined
- **Eval Score** : 82-85/100
- **Fonctionnalité** : 0% perdue

**Learning** :
> "More lines ≠ better instructions. Subagents need to be maintainable, not comprehensive."

---

### 4. Commands : Shortcuts vers Workflows

**Définition** : Commands sont des **raccourcis user-initiated**. Taper `/command` déclenche prompts sauvegardés ou invoque subagents.

**Avantages** :
- Invocation ultra-rapide (`/create-skill`)
- Prompts consistants entre sessions
- Peuvent invoquer subagents ou bash scripts
- Partageables (global ou projet)

**Limitations** :
- Nécessite création manuelle
- Un command = un workflow
- Pas d'auto-invocation

**Cas d'usage** :
- Shortcut vers subagents fréquents
- Scripts bash utilitaires
- Workflows répétitifs

**Schéma - Commands vs Subagents** :
```
COMPARAISON
════════════════════════════════════════════════════

Sans Command ❌ :
┌─────────────────────────────────────────────────┐
│ User : "Can you help me create a skill?"       │
│          ou                                     │
│        "@skill-creator-agent"                   │
└─────────────────────────────────────────────────┘
         │ Long, répétitif, variations
         ▼
┌─────────────────────────────────────────────────┐
│ Claude : Invoque skill-creator-agent           │
└─────────────────────────────────────────────────┘

Avec Command ✅ :
┌─────────────────────────────────────────────────┐
│ User : "/create-skill"                          │
└─────────────────────────────────────────────────┘
         │ Rapide, consistant
         ▼
┌─────────────────────────────────────────────────┐
│ Claude : Invoque skill-creator-agent           │
│          automatiquement                        │
└─────────────────────────────────────────────────┘

Location :
──────────
📁 .claude/commands/
  ┣━━ create-skill.md    → Invoque subagent
  ┣━━ validate-skill.md  → Invoque subagent
  ┗━━ list-skills.md     → Bash script
```

**Exemples Commands du Skills Toolkit** :
```bash
/create-skill     # Invoque skill-creator-agent
/validate-skill   # Invoque skill-validator-agent
/list-skills      # Bash: ls ~/.claude/skills/
```

---

### 5. Plugins : Distribution Scalable

**Définition** : Plugins sont des **packages bundlés** de Skills + Subagents + Commands distribués comme unités cohésives via marketplaces.

**Avantages** :
- Distribution one-click avec install script
- Versioning automatique
- Dépendances gérées
- Documentation bundlée
- Partage communautaire facilité

**Limitations** :
- Nécessite marketplace structure
- Install script requis
- Gestion versions à prévoir

**Cas d'usage** :
- Partager setup avec équipe
- Open-source de workflows
- Distribution scalable d'agents

**Schéma - Architecture Plugin** :
```
STRUCTURE PLUGIN
════════════════════════════════════════════════════

📦 skills-toolkit/                    (Plugin Root)
┣━━ 📄 README.md                      Documentation
┣━━ ⚙️ install.sh                     Auto-installer
┣━━ 📁 agents/
┃   ┣━━ 🤖 skill-creator.md           (281 lignes)
┃   ┗━━ 🤖 skill-validator.md         (306 lignes)
┣━━ 📁 commands/
┃   ┣━━ ⚡ create-skill.md
┃   ┣━━ ⚡ validate-skill.md
┃   ┗━━ ⚡ list-skills.md
┣━━ 📁 skills/shared/templates/
┃   ┣━━ 📄 stakeholder.md
┃   ┣━━ 📄 ground-truth.md
┃   ┣━━ 📄 product-context.md
┃   ┗━━ 📄 initiative-overview.md
┗━━ 📁 docs/
    ┣━━ usage.md
    ┗━━ troubleshooting.md

INSTALL SCRIPT (install.sh)
════════════════════════════════════════════════════
#!/bin/bash
# Auto-détecte ~/.claude/
# Copie agents → .claude/agents/
# Copie commands → .claude/commands/
# Copie templates → .claude/skills/shared/
# Vérifie installation
```

**Installation - Young Leaders Marketplace** :
```bash
# Clone marketplace
git clone https://github.com/YoungLeadersDotTech/young-leaders-tech-marketplace.git

# Navigate to plugin
cd young-leaders-tech-marketplace/plugins/skills-toolkit

# Run installer
./install.sh
```

**Résultat** :
- ✅ 2 subagents installés
- ✅ 3 commands installés
- ✅ 4 templates skills installés
- ✅ Documentation incluse
- ✅ Zéro configuration manuelle

**Pattern Team Rollout** :
```
DÉPLOIEMENT ÉQUIPE
════════════════════════════════════════════════════

1. Partager URL marketplace
   👥 Équipe → Clone repo

2. Documenter quels plugins = quels problèmes
   📋 Wiki interne

3. Fork marketplace pour customisation interne
   🔧 Company-specific plugins

4. Git pull pour sync updates
   🔄 Tout le monde à jour
```

---

## 💬 Citations Marquantes

> "I want Claude to remember X automatically → Skill
> I want to automate Y workflow step-by-step → Subagent
> I use subagent Z frequently and want a shortcut → Command
> I want to share my setup with others → Plugin (bundle all three)"
> — John Conneely (Arbre de décision)

> "The critical success factor was also my first discovery - **description quality directly determines auto-invocation accuracy**."
> — John Conneely (Sur Skills)

> "More lines ≠ better instructions. Subagents need to be maintainable, not comprehensive. Claude is smart enough to work with concise, well-structured guidance."
> — John Conneely (Learning refactoring 803 → 281 lignes)

> "This is what I know as of today (21st of October). I've validated these patterns through some small testing, but I'm still learning."
> — John Conneely (Transparence learning in public)

> "Plugins may solve the distribution problem. Instead of sharing scattered markdown files with complex install scripts on scattered repos, you now get a complete package with versioning, documentation, and automated installation."
> — John Conneely (Sur Plugins)

---

## 💻 Exemples Pratiques

### Exemple 1 : Personal User Manual Skill

**Problème** :
Messages Slack générés par Claude sont verbeux, style IA évident, manquent de ton personnel.

**Solution** :
Créer un skill `user-manual.md` avec préférences communication.

**Code** :
```markdown
---
description: Personal work preferences and communication style for John Conneely.
  Auto-invoke when drafting HIS emails, Slack messages, or internal updates;
  planning HIS work or tasks; optimising HIS productivity workflows; or discussing
  HIS collaboration approach. Auto-invoke when user requests "help me write",
  "draft an email", "create a message", "plan my work", or "write internally".
  Do NOT load for external blog posts, customer-facing communications, or public
  documentation unless John explicitly requests.
---

# Personal User Manual

## Communication Style
- Direct and concise
- Skip the AI formalities ("I hope this message finds you well...")
- Get to the point in first sentence
- Use bullet points over paragraphs
- Internal tone: casual but professional

## Work Preferences
- Deep work blocks: 9am-12pm
- Async communication preferred
- Slack > Email for quick questions
- Notion for documentation
...
```

**Explication** :
- **WHEN** : Possessive "HIS" scope la skill à l'auteur
- **WHEN NOT** : Exclut communications externes
- **Triggers** : "help me write", "draft", "create message"
- **Résultat** : Messages Slack concis, ton personnel, zéro AI fluff

**Avant/Après** :
```
AVANT (sans skill) :
─────────────────────────────────────────
Hi team! 👋

I hope this message finds you well. I wanted to
take a moment to share some exciting developments
we've been working on...

[8 lignes de fluff IA]

APRÈS (avec skill) :
─────────────────────────────────────────
Team - new blog on Claude Code extensibility:

• Skills vs Commands vs Subagents vs Plugins
• Real examples from my marketplace
• Check it out: [link]

Feedback welcome.
```

---

### Exemple 2 : Refactoring Subagent avec Skills

**Problème** :
`skill-creator-agent` = 803 lignes, eval score 62/100, feedback "Too verbose, redundant structure, difficult to maintain".

**Solution** :
Extraire sections répétitives dans Skills, consolider checklists, streamline instructions.

**Étapes** :
1. Identifier duplication :
   - 5 structures TODO identiques
   - Section template 130 lignes mal alignée
   - Checklists validation répétées

2. Extraire dans Skills :
   ```markdown
   # skills/shared/templates/skill-template.md
   [130 lignes de template structure]
   ```

3. Consolider checklists :
   ```markdown
   # Avant : 5 checklists de 20 lignes
   # Après : 1 checklist réutilisable
   ```

4. Streamline language :
   ```markdown
   # Avant :
   "You should carefully consider the description and ensure
   that it follows the WHEN + WHEN NOT pattern as described
   in the previous section, making sure to..."

   # Après :
   "Use WHEN + WHEN NOT pattern for description."
   ```

**Résultat** :
- **Lignes** : 803 → 281 (65% réduction)
- **Eval score** : 62 → 82-85/100
- **Fonctionnalité** : 100% préservée
- **Maintenabilité** : Dramatically improved

**Explication** :
Skills permettent de factoriser contexte réutilisable (templates, patterns) hors des subagents. Subagents restent concis et focalisés sur workflow orchestration.

---

### Exemple 3 : Installation Plugin depuis Marketplace

**Problème** :
Partager agents = repos multiples, install scripts complexes, dépendances manquantes, validation manuelle.

**Solution** :
Plugin bundlé dans marketplace avec install script automatique.

**Code** :
```bash
# Clone marketplace
git clone https://github.com/YoungLeadersDotTech/young-leaders-tech-marketplace.git

# Navigate to plugin
cd young-leaders-tech-marketplace/plugins/skills-toolkit

# Run installer
./install.sh
```

**install.sh** (simplifié) :
```bash
#!/bin/bash

# Detect Claude Code directory
CLAUDE_DIR="${HOME}/.claude"

# Copy agents
cp -r agents/* "${CLAUDE_DIR}/agents/"

# Copy commands
cp -r commands/* "${CLAUDE_DIR}/commands/"

# Copy skill templates
cp -r skills/shared/* "${CLAUDE_DIR}/skills/shared/"

# Verify installation
echo "✅ Skills Toolkit installed successfully"
echo "📊 2 subagents, 3 commands, 4 templates"
```

**Résultat** :
- ✅ Installation one-click
- ✅ Zéro configuration manuelle
- ✅ Dépendances gérées
- ✅ Documentation bundlée
- ✅ Updates via `git pull + ./install.sh`

**Explication** :
Plugins résolvent distribution problem. User clone marketplace → run install script → tout fonctionne. Pas besoin de comprendre structure interne.

---

## ✅ Points d'Action

### Immédiat (< 1h)

- [ ] **Créer Personal User Manual Skill**
  Template : `~/.claude/skills/user-manual.md`
  Contenu : Préférences communication, work style, feedback preferences

- [ ] **Tester pattern WHEN + WHEN NOT**
  Créer 1 skill simple avec boundaries explicites
  Vérifier auto-invocation dans conversations

- [ ] **Explorer Young Leaders Marketplace**
  URL : https://github.com/YoungLeadersDotTech/young-leaders-tech-marketplace
  Lire README, parcourir plugins disponibles

### Court terme (1-7 jours)

- [ ] **Installer Skills Toolkit Plugin**
  Clone marketplace → Run install script
  Tester `/create-skill` command

- [ ] **Refactor 1 Subagent avec Skills**
  Identifier duplication dans agent existant
  Extraire sections répétitives dans Skills
  Mesurer réduction lignes + amélioration clarté

- [ ] **Créer 2-3 Project Skills**
  Exemples : stakeholder context, product ground truth, initiative overview
  Utiliser templates du Skills Toolkit

- [ ] **Valider pattern Analyse/Exécution**
  Créer 1 subagent qui analyse (Read/Grep/TodoWrite)
  Main Claude exécute modifications (Write/Edit/Bash)

### Long terme (> 1 semaine)

- [ ] **Architecturer Setup Complet**
  Personal Skills (user manual, preferences)
  Project Skills (stakeholders, context)
  Subagents (workflows clés)
  Commands (shortcuts fréquents)

- [ ] **Créer Plugin Interne pour Équipe**
  Bundler Skills + Subagents + Commands projet
  Écrire install script + documentation
  Fork marketplace pour customisation interne

- [ ] **Contribuer au Marketplace Communautaire**
  Identifier patterns réutilisables
  Créer plugin open-source
  Partager learnings avec communauté

- [ ] **Mesurer Impact Skills sur Productivité**
  Tracker temps gagné sur tâches répétitives
  Mesurer qualité outputs (avant/après skills)
  Itérer descriptions skills selon feedback

---

## 📚 Ressources

### Documentation Officielle

- 📄 [Claude Code Skills](https://docs.claude.com/en/docs/claude-code/skills) - Documentation officielle Skills
- 📄 [Claude Code Subagents](https://docs.anthropic.com/en/docs/claude-code/sub-agents) - Documentation officielle Subagents
- 📄 [Claude Code Slash Commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands) - Documentation officielle Commands
- 📄 [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins) - Documentation officielle Plugins
- 📄 [Claude Code Plugin Marketplaces](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces) - Documentation officielle Marketplaces

### Repos & Marketplaces

- 🔗 [Young Leaders Tech Marketplace](https://github.com/YoungLeadersDotTech/young-leaders-tech-marketplace) - Marketplace John Conneely avec Skills Toolkit
- 🔗 [Skills Toolkit Plugin](https://github.com/YoungLeadersDotTech/young-leaders-tech-marketplace/tree/main/plugins/skills-toolkit) - Plugin complet (agents + commands + templates)

### Articles Connexes

- 📄 [Why You Should Have a Personal User Manual | #88](https://www.youngleaders.tech/p/why-you-should-have-a-personal-user-manual) - John Conneely (25 mars 2025)
- 📄 [How to Make ChatGPT Speak in Your Tone of Voice | #54](https://www.youngleaders.tech/p/how-to-create-your-own-brand-voice) - John Conneely (25 juin 2024)
- 📄 [How To Create Your Own Personal AI Mentor | #90](https://www.youngleaders.tech/p/how-to-create-your-own-personal-ai-mentor) - John Conneely (14 avril 2025)

### Concepts Avancés

- 🔗 Hooks - Automatisation event-driven
- 🔗 MCP Servers - Model Context Protocol integration
- 🔗 Eval Committee - Pattern validation d'agents

---

**Tags** : `#skills` `#commands` `#subagents` `#plugins` `#marketplace` `#extensibilité` `#architecture` `#best-practices` `#refactoring` `#workflows` `#distribution` `#learning-in-public`

**Niveau** : 🟠 Avancé

**Temps de pratique estimé** : 60-90 minutes (installation + tests + création 2-3 skills)

---

## 🎓 Notes Complémentaires

### Key Success Factors (validés par John)

**1. Description Engineering** :
- Pattern WHEN + WHEN NOT = 🔑 auto-invocation précise
- Possessive pronouns ("HIS/HER/THEIR work") = scoping personnel
- Descriptions génériques = échec garanti

**2. Multi-Skill Coordination** :
- Claude charge plusieurs skills complémentaires simultanément
- Personal + Project skills coexistent sans conflits
- Template meta-skills guident création autres skills

**3. Subagent Concision** :
- Plus de lignes ≠ meilleures instructions
- Target : 300-400 lignes max
- Extract repetition → Skills
- Maintainability > Comprehensiveness

**4. Hybrid Pattern** :
- Subagent Analyse (Read/Grep/Glob/TodoWrite) → Plan
- Main Claude Execute (Write/Edit/Bash) → Modifications
- Preserves security boundaries + enables automation

**5. Distribution via Plugins** :
- Marketplace = solution scalable
- Install script = one-click setup
- Versioning + documentation bundlée
- Community-driven extensibility

### Questions Ouvertes (John still figuring out)

- Best practices team/company-wide skill management
- Performance implications of many auto-invoked skills
- How skills interact with other Claude Code features (hooks, MCP servers)
- What makes a plugin worth publishing vs keeping internal

### Métriques de Succès

**Refactoring Agent** :
- Lignes : 803 → 281 (65% ↓)
- Eval score : 62 → 82-85/100 (32% ↑)
- Fonctionnalité : 100% preserved
- Maintenability : Dramatically improved

**Skills Toolkit Plugin** :
- 2 subagents (creation + validation)
- 3 commands (shortcuts workflows)
- 4 skill templates (stakeholder, ground truth, product, initiative)
- Installation : < 2 minutes
- Adoption : Community testing ongoing

### Contexte Temporel

**Timeline Anthropic Releases** :
- Plugins → Marketplaces → Skills (3 semaines)
- Article publié : 21 octobre 2025
- Context : "Coming out the other end with a much clearer picture"

**Learnings Timeline** :
- Week 1 : Confusion, multiple rebuilds
- Week 2 : Skills = Aha moment
- Week 3 : Refactoring agents, testing patterns
- Week 4 : Skills Toolkit plugin shipped to marketplace

**État Actuel** :
- Patterns validés through testing
- Still learning (transparent learning in public)
- Marketplace experiment ongoing
- Inviting community feedback
