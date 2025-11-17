# The Only Claude Skills Guide You Need (Beginner to Expert)

![Miniature vidéo](https://img.youtube.com/vi/421T2iWTQio/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: The Only Claude Skills Guide You Need (Beginner to Expert)
- **Auteur**: Kenny Liao
- **Durée**: 36 minutes
- **Date**: 24 octobre 2025
- **Lien**: [https://www.youtube.com/watch?v=421T2iWTQio](https://www.youtube.com/watch?v=421T2iWTQio)

## Tags

`#claude-skills` `#progressive-disclosure` `#context-engineering` `#mcp` `#slash-commands` `#claude-code` `#custom-skills` `#youtube-automation` `#excel-modeling` `#skill-creator`

---

## Résumé Exécutif

Cette vidéo propose un guide complet sur les Claude Agent Skills, de la compréhension des concepts fondamentaux à la création de skills personnalisés avancés. Kenny Liao explique le problème d'efficacité contextuelle que résolvent les Skills grâce au principe de **progressive disclosure**. Il compare les Skills aux MCPs et slash commands, démontrant comment les Skills permettent de charger uniquement le nom et la description dans le prompt système (50 tokens vs 3000 tokens pour un MCP équivalent). La vidéo inclut des démos pratiques dans Claude.ai et Claude Code, culminant avec deux skills personnalisés impressionnants : un générateur de modèles Excel de cohort analysis et un créateur de thumbnails YouTube intégré à son assistant personnel.

**Conclusion principale**: Les Skills résolvent le problème d'efficacité contextuelle grâce au principe de progressive disclosure - seul le nom et la description sont chargés initialement, le reste du contexte n'étant chargé qu'à la demande.

---

## Timecodes

- 00:00 - Introduction
- 01:18 - Deep Dive : Qu'est-ce que les Skills ?
- 11:58 - Utilisation des Skills avec Claude.ai
- 18:26 - Utilisation des Skills avec Claude Code
- 25:52 - Démo Skill Personnalisé avec Claude Code
- 34:13 - Optimisation des Skills Personnalisés

---

## Concepts Clés

### 1. Progressive Disclosure - Le Cœur des Skills

**Définition**: Technique d'ingénierie contextuelle où seules les métadonnées minimales (nom + description) sont chargées dans le prompt système. Le corps complet du skill (instructions détaillées) n'est lu que lorsque l'agent décide d'utiliser le skill.

```
╔═══════════════════════════════════════════════════════╗
║        PROGRESSIVE DISCLOSURE - EFFICACITÉ            ║
╚═══════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────┐
│  SYSTÈME TRADITIONNEL (MCP)                         │
├─────────────────────────────────────────────────────┤
│  System Prompt                                       │
│  ├─ MCP Tool 1 schema (500 tokens)                  │
│  ├─ MCP Tool 2 schema (600 tokens)                  │
│  ├─ MCP Tool 3 schema (700 tokens)                  │
│  └─ ... (20 tools total)                            │
│  TOTAL: ~3000 tokens (TOUT LE TEMPS)               │
└─────────────────────────────────────────────────────┘
                         VS
┌─────────────────────────────────────────────────────┐
│  SYSTÈME SKILLS (PROGRESSIVE DISCLOSURE)            │
├─────────────────────────────────────────────────────┤
│  System Prompt                                       │
│  ├─ Skill 1: "PDF handler" (25 tokens)             │
│  ├─ Skill 2: "Excel builder" (25 tokens)           │
│  └─ Skill 3: "Thumbnail creator" (25 tokens)       │
│  TOTAL INITIAL: ~75 tokens                          │
│                                                      │
│  Quand l'agent décide d'utiliser Skill 1:          │
│  └─> Lecture du corps complet (2500 tokens)        │
│       UNIQUEMENT SI NÉCESSAIRE                      │
└─────────────────────────────────────────────────────┘

Ratio d'efficacité: 3000 tokens → 75 tokens (40x plus efficace)
```

**Avantages**:
- ✅ **Économie de tokens massive** : 50 tokens initiaux vs 3000 tokens pour un MCP équivalent (60x plus efficace)
- ✅ **Scalabilité** : Permet d'avoir des dizaines de skills disponibles sans surcharger le contexte
- ✅ **Flexibilité contextuelle** : L'agent charge uniquement ce dont il a besoin, quand il en a besoin
- ✅ **Portabilité** : Même skill utilisable dans Claude.ai, Claude Code et Claude Agent SDK

**Limitations**:
- ❌ **Latence potentielle** : Lecture du skill à chaque utilisation (overhead minimal mais présent)
- ❌ **Dépendance à la description** : Si la description du skill est imprécise, l'agent peut ne pas l'utiliser correctement
- ❌ **Debugging moins évident** : Complexité accrue pour comprendre pourquoi un skill n'est pas utilisé

**Cas d'usage**:
- 🎯 **Workflows répétitifs** : Génération de rapports Excel, création de thumbnails YouTube, analyse de PDFs
- 🎯 **Tâches complexes multi-étapes** : Modélisation financière, validation de données avec scripts Python
- 🎯 **Agents avec multiples capacités** : Assistant personnel ayant accès à 20+ skills différents

---

### 2. Anatomie d'un Skill - Structure et Organisation

**Définition**: Un skill est structurellement un dossier contenant au minimum un fichier `skill.md` avec YAML front matter (name + description) et un corps Markdown avec instructions détaillées.

```
📦 mon-skill/
┣━━ 📄 skill.md          ← OBLIGATOIRE (YAML + instructions)
┣━━ 📁 scripts/          ← OPTIONNEL
┃   ┣━━ 🐍 validate.py
┃   ┗━━ 📜 process.sh
┣━━ 📁 data/             ← OPTIONNEL
┃   ┣━━ 📊 template.csv
┃   ┗━━ 📋 examples.json
┗━━ 📁 docs/             ← OPTIONNEL
    ┣━━ 📄 guidelines.md
    ┗━━ 📄 best-practices.md

╔═══════════════════════════════════════════════════════╗
║              STRUCTURE skill.md                        ║
╠═══════════════════════════════════════════════════════╣
║  ---                                                   ║
║  name: "PDF Handler Skill"                           ║
║  description: "Use when user asks to work with PDF   ║
║                files - extract, analyze, convert"     ║
║  ---                                                   ║
║                                                        ║
║  # Instructions détaillées                            ║
║                                                        ║
║  ## Required Reading (OBLIGATOIRE)                    ║
║  - docs/pdf-requirements.md                           ║
║  - docs/prompting-guidelines.md                       ║
║                                                        ║
║  ## Optional Assets                                   ║
║  - scripts/validate_pdf.py (validation)               ║
║  - data/templates/ (modèles pré-définis)             ║
║                                                        ║
║  ## Workflow                                          ║
║  1. Read PDF structure                                ║
║  2. Apply transformations                             ║
║  3. Validate output with scripts/validate_pdf.py     ║
║  4. Return formatted result                           ║
╚═══════════════════════════════════════════════════════╝
```

**Avantages**:
- ✅ **Simplicité** : Juste des fichiers Markdown et scripts, pas de serveur MCP à configurer
- ✅ **Modularité** : Contexte organisé en sections (required reading, optional assets)
- ✅ **Extensibilité** : Ajout facile de scripts Python/Bash, données CSV, docs supplémentaires
- ✅ **Portabilité** : Zipper le dossier et uploader dans Claude.ai ou copier dans `.claude/skills/`

**Limitations**:
- ❌ **Pas de logique serveur** : Contrairement aux MCPs, pas d'exécution côté serveur
- ❌ **Convention de nommage stricte** : Le fichier DOIT s'appeler `skill.md`, pas de flexibilité
- ❌ **YAML front matter obligatoire** : Si malformé, le skill n'est pas reconnu

**Cas d'usage**:
- 📊 **Modélisation Excel** : Skill avec templates, scripts de validation Python, guidelines de formules
- 🎨 **Génération créative** : Skill thumbnail avec assets (icônes, headshots), templates Figma, guidelines design
- 📝 **Documentation** : Skill avec standards de rédaction, exemples, scripts de formatage

---

### 3. Skills vs MCPs vs Slash Commands - Quand Utiliser Quoi ?

**Définition**: Comparaison des trois principaux mécanismes d'extension de Claude pour comprendre leurs forces et cas d'usage optimaux.

```
╔══════════════════════════════════════════════════════════════════════╗
║                    COMPARAISON DÉTAILLÉE                             ║
╠══════════════════════════════════════════════════════════════════════╣
║                                                                       ║
║  SLASH COMMANDS                                                      ║
║  ┌───────────────────────────────────────────────────────┐          ║
║  │  Déclenchement   : 👤 MANUEL (utilisateur)            │          ║
║  │  Token Usage     : ⚡ 0 (avant déclenchement)         │          ║
║  │  Complexité      : 🟢 SIMPLE (juste un .md)           │          ║
║  │  Use Case        : Workflows prédéfinis répétitifs    │          ║
║  │  Exemple         : /commit, /review-pr, /debug        │          ║
║  └───────────────────────────────────────────────────────┘          ║
║                           ⬇️                                          ║
║  SKILLS                                                              ║
║  ┌───────────────────────────────────────────────────────┐          ║
║  │  Déclenchement   : 🤖 AUTONOME (agent décide)         │          ║
║  │  Token Usage     : ⚡⚡ 50 initial + X à la demande    │          ║
║  │  Complexité      : 🟢 SIMPLE (folder + skill.md)      │          ║
║  │  Use Case        : Capacités dynamiques multiples     │          ║
║  │  Exemple         : Excel builder, PDF handler         │          ║
║  └───────────────────────────────────────────────────────┘          ║
║                           ⬇️                                          ║
║  MCPs (Model Context Protocol)                                      ║
║  ┌───────────────────────────────────────────────────────┐          ║
║  │  Déclenchement   : 🤖 AUTONOME (agent décide)         │          ║
║  │  Token Usage     : 🔴 3000+ (toujours chargé)         │          ║
║  │  Complexité      : 🔴 COMPLEXE (serveur + client)     │          ║
║  │  Use Case        : Intégrations externes (APIs)       │          ║
║  │  Exemple         : Google Drive, Notion, Slack        │          ║
║  └───────────────────────────────────────────────────────┘          ║
╚══════════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────────┐
│                    QUAND UTILISER QUOI ?                             │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  Slash Command si :                                                  │
│  ✓ Workflow toujours identique (commit, PR review)                 │
│  ✓ Vous voulez contrôler QUAND déclencher                          │
│  ✓ Pas besoin de prise de décision de l'agent                      │
│                                                                      │
│  Skill si :                                                          │
│  ✓ L'agent doit décider QUAND utiliser la capacité                 │
│  ✓ Workflow complexe multi-étapes                                  │
│  ✓ Besoin d'optimiser les tokens (beaucoup de capacités)           │
│  ✓ Pas besoin d'API externes                                       │
│                                                                      │
│  MCP si :                                                            │
│  ✓ Intégration API externe (Google, Notion, Slack)                 │
│  ✓ Besoin de logique serveur (state management)                    │
│  ✓ Partage entre plusieurs applications                            │
│  ✓ Token efficiency pas critique                                   │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

**Exemple concret** : Workflow de création de contenu YouTube

```
🎬 PIPELINE YOUTUBE
┌────────────────┐
│ 1. Recherche   │──> SKILL "YouTube Research"
│                │     (analyse concurrents, trends)
└────────────────┘
        │
        ⬇️
┌────────────────┐
│ 2. Génération  │──> SKILL "Thumbnail Creator"
│    Thumbnail   │     (design + Nano Banana MCP)
└────────────────┘
        │
        ⬇️
┌────────────────┐
│ 3. Upload      │──> MCP "YouTube Studio"
│                │     (API YouTube)
└────────────────┘
        │
        ⬇️
┌────────────────┐
│ 4. Commit      │──> SLASH COMMAND /commit
│    Changes     │     (Git workflow fixe)
└────────────────┘
```

**Avantages**:
- ✅ **Complémentarité** : Skills et MCPs peuvent travailler ensemble (Skill qui utilise un MCP)
- ✅ **Flexibilité** : Convertir un slash command en skill pour autonomisation
- ✅ **Optimisation tokens** : Skills permettent d'avoir 10x plus de capacités qu'avec MCPs seuls

**Limitations**:
- ❌ **Confusion initiale** : Pas toujours évident de choisir le bon mécanisme
- ❌ **MCPs non optimisés** : Anthropic pourrait implémenter progressive disclosure pour MCPs (pourquoi ce n'est pas fait reste mystérieux)
- ❌ **Duplication potentielle** : Risque de créer skill + slash command + MCP pour la même tâche

**Cas d'usage**:
- 🎯 **Migration progressive** : Commencer avec slash command → convertir en skill quand besoin d'autonomie
- 🎯 **Compounding skills** : Skill Excel Builder qui utilise skill Excel (Anthropic) existant
- 🎯 **Hybrid approach** : MCPs pour APIs externes + Skills pour logique métier + Slash commands pour workflows

---

### 4. Skills Personnalisés Avancés - Cohort Analysis & Thumbnail Creator

**Définition**: Démonstration de deux skills personnalisés production-ready : un générateur de modèles Excel de cohort analysis financière et un créateur de thumbnails YouTube intégré à un assistant personnel.

```
╔═══════════════════════════════════════════════════════════════════╗
║              SKILL 1: COHORT ANALYSIS EXCEL BUILDER               ║
╠═══════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📦 cohort-analysis-skill/                                        ║
║  ┣━━ 📄 skill.md                                                  ║
║  ┗━━ 📁 scripts/                                                  ║
║      ┣━━ 🐍 validate_formulas.py  ← Vérifie 0 erreur formule     ║
║      ┗━━ 🐍 check_structure.py    ← Valide structure Excel       ║
║                                                                    ║
║  WORKFLOW:                                                         ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ Input: transactions.csv (20K lignes, 5K clients)            │ ║
║  │   ⬇️                                                         │ ║
║  │ 1. Analyse structure données                                │ ║
║  │   ⬇️                                                         │ ║
║  │ 2. Calcul colonnes: cohort_month, months_since_first        │ ║
║  │   ⬇️                                                         │ ║
║  │ 3. Création onglet modèle avec:                             │ ║
║  │    - Input assumptions (CAC, discount rate)                 │ ║
║  │    - Retention matrix par cohort                            │ ║
║  │    - Customer counts                                        │ ║
║  │    - Transaction counts                                     │ ║
║  │    - Revenue per cohort                                     │ ║
║  │    - LTV (Lifetime Value)                                   │ ║
║  │    - CAC-adjusted LTV                                       │ ║
║  │   ⬇️                                                         │ ║
║  │ 4. Run validate_formulas.py → 0 erreur                      │ ║
║  │   ⬇️                                                         │ ║
║  │ 5. Output: cohort_model.xlsx (100% formules, live updates) │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║                                                                    ║
║  IMPACT: Économise 40h de travail analyst financier              ║
╚═══════════════════════════════════════════════════════════════════╝

╔═══════════════════════════════════════════════════════════════════╗
║           SKILL 2: YOUTUBE THUMBNAIL CREATOR                      ║
╠═══════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  📦 youtube-thumbnail-skill/                                      ║
║  ┣━━ 📄 skill.md                                                  ║
║  ┣━━ 📁 design-requirements/                                      ║
║  ┃   ┣━━ 📄 design-requirements.md  ← VidIQ best practices       ║
║  ┃   ┗━━ 📄 prompting-guidelines.md ← Nano Banana prompts        ║
║  ┣━━ 📁 assets/ (OPTIONNEL)                                      ║
║  ┃   ┣━━ 🎨 icons/                                               ║
║  ┃   ┣━━ 📸 headshots/                                           ║
║  ┃   ┗━━ 🎨 templates/                                           ║
║  ┗━━ 📁 scripts/                                                  ║
║      ┗━━ 📜 generate_thumbnail.sh                                ║
║                                                                    ║
║  CONTEXT ENGINEERING:                                             ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ skill.md structure:                                          │ ║
║  │                                                              │ ║
║  │ ## REQUIRED READING (toujours chargé)                       │ ║
║  │ - design-requirements.md                                    │ ║
║  │ - prompting-guidelines.md                                   │ ║
║  │                                                              │ ║
║  │ ## OPTIONAL ASSETS (chargé si besoin)                       │ ║
║  │ - assets/icons/ (si demande icônes spécifiques)            │ ║
║  │ - assets/templates/ (si création from template)            │ ║
║  │ - assets/headshots/ (si besoin photo Kenny)                │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║                                                                    ║
║  PROGRESSIVE DISCLOSURE EN ACTION:                                ║
║  1. Agent voit "YouTube Thumbnail Creator" (30 tokens)           ║
║  2. User: "create thumbnail for Skills video"                    ║
║  3. Agent lit skill.md → required reading (800 tokens)           ║
║  4. Agent décide: création from scratch → skip templates         ║
║  5. Total: 830 tokens vs 2500 si tout chargé                     ║
║                                                                    ║
║  INTÉGRATION:                                                     ║
║  - Gemini CLI → Nano Banana MCP → Image generation              ║
║  - Personal Assistant (Claude Agent SDK) utilise ce skill        ║
╚═══════════════════════════════════════════════════════════════════╝
```

**Avantages**:
- ✅ **Production-ready** : Skills testés et utilisés quotidiennement par Kenny
- ✅ **Validation automatique** : Scripts Python garantissent 0 erreur (formules Excel, structure)
- ✅ **Réutilisabilité** : Skill Excel peut être réutilisé pour P&L, cash flow, forecasting
- ✅ **Compounding** : Cohort skill peut utiliser Excel skill d'Anthropic comme base

**Limitations**:
- ❌ **Qualité variable thumbnails** : Nano Banana parfois génère des résultats moyens (itération nécessaire)
- ❌ **Dépendance outils externes** : Nano Banana MCP requis, pas standalone
- ❌ **Maintenance** : Prompts Nano Banana nécessitent optimisation continue

**Cas d'usage**:
- 💼 **Finance Teams** : Automatiser modélisation Excel (cohorts, P&L, forecasts)
- 🎥 **Content Creators** : Pipeline YouTube (research → thumbnail → upload → commit)
- 🤖 **Personal Assistants** : Intégrer skills dans agents SDK pour workflows end-to-end

---

### 5. Optimisation et Debugging de Skills

**Définition**: Méthodologie itérative pour améliorer skills personnalisés via vibe-coding avec Claude, analyse des échecs et refinement progressif.

```
╔═══════════════════════════════════════════════════════════════════╗
║              WORKFLOW D'OPTIMISATION DE SKILL                     ║
╠═══════════════════════════════════════════════════════════════════╣
║                                                                    ║
║  Itération 1: ÉCHEC                                               ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ User: "Create thumbnail for AI video"                       │ ║
║  │ Skill génère: 🖼️ Thumbnail avec personne asiatique random   │ ║
║  │ ❌ Échec: Pas utilisé le headshot de Kenny                   │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║       │                                                            ║
║       ⬇️  DEBUGGING                                                ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ Prompt à Claude Code:                                        │ ║
║  │ "The skill failed because it didn't use my headshot.        │ ║
║  │  Expected: thumbnail with my face                           │ ║
║  │  Got: random Asian guy                                      │ ║
║  │  Review the full skill and identify failure point."         │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║       │                                                            ║
║       ⬇️  ANALYSE                                                  ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ Claude identifie:                                            │ ║
║  │ - skill.md: headshots path mentionné mais pas emphasized    │ ║
║  │ - prompting-guidelines.md: pas d'instruction explicite      │ ║
║  │   pour toujours utiliser headshot fourni                    │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║       │                                                            ║
║       ⬇️  FIX SUGGÉRÉ                                              ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ Claude propose:                                              │ ║
║  │ 1. Ajouter dans REQUIRED READING:                           │ ║
║  │    "ALWAYS use assets/headshots/kenny.png"                  │ ║
║  │ 2. Modifier prompting-guidelines.md:                        │ ║
║  │    "Include [USER_HEADSHOT] token in Nano Banana prompt"   │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║       │                                                            ║
║       ⬇️  IMPLÉMENTATION                                           ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ User: "Go ahead and implement this fix"                     │ ║
║  │ Claude modifie skill.md + prompting-guidelines.md           │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
║       │                                                            ║
║       ⬇️  TEST                                                     ║
║  Itération 2: SUCCÈS                                              ║
║  ┌─────────────────────────────────────────────────────────────┐ ║
║  │ User: "Create thumbnail for AI video"                       │ ║
║  │ Skill génère: 🖼️ Thumbnail avec Kenny's headshot            │ ║
║  │ ✅ Succès!                                                   │ ║
║  └─────────────────────────────────────────────────────────────┘ ║
╚═══════════════════════════════════════════════════════════════════╝

BEST PRACTICES D'OPTIMISATION:

1. 🔍 FEEDBACK LOOP RAPIDE
   ┌────────────────────────────────────┐
   │ Test → Fail → Analyze → Fix → Test│
   └────────────────────────────────────┘
   Cycle de 5-10 minutes par itération

2. 📊 COMPARAISONS EXPLICITES
   ❌ "The skill didn't work"
   ✅ "Expected: X, Got: Y, Difference: Z"

3. 🎯 ISOLER LES PROBLÈMES
   - Skill description trop vague ?
   - Required reading pas assez directif ?
   - Optional assets mal référencés ?
   - Scripts de validation manquants ?

4. 📚 EXEMPLES CONCRETS
   Ajouter dans skill.md:
   ```markdown
   ## Examples
   Good prompt: "Create before/after split thumbnail"
   Bad prompt: "Make a thumbnail"
   ```

5. 🧪 VALIDATION AUTOMATISÉE
   Ajouter scripts Python:
   - validate_output.py
   - check_requirements.py
   - test_edge_cases.py
```

**Avantages**:
- ✅ **Amélioration continue** : Chaque échec = opportunité de raffiner le skill
- ✅ **Documentation vivante** : Examples dans skill.md s'enrichissent au fil du temps
- ✅ **Collaboration Claude** : Vibe-coding permet d'optimiser sans expertise technique profonde
- ✅ **Validation automatique** : Scripts Python garantissent qualité constante

**Limitations**:
- ❌ **Temps d'optimisation** : Peut prendre plusieurs itérations avant skill production-ready
- ❌ **Over-specification** : Risque de rendre skill trop rigide avec trop de contraintes
- ❌ **Maintenance continue** : Best practices évoluent (Nano Banana, Excel formulas, etc.)

**Cas d'usage**:
- 🎨 **Creative workflows** : Thumbnails, logos, design assets (qualité variable nécessite itération)
- 📊 **Data workflows** : Excel models, CSV transformations (validation critique)
- 🧪 **Experimental skills** : Nouveaux use cases où best practices pas encore établies

---

## Citations Marquantes

> "Skills are just a folder with a skill.md file. That's it. At a minimum, that's all you need."

> "The main design pattern for skills is progressive disclosure. Only the name and description are loaded in the system prompt - maybe 50 tokens vs 3000 tokens for an MCP with the same functionality."

> "I don't understand why progressive disclosure isn't already implemented in Claude with MCPs. Technically we don't have to load all tool schemas upfront. If you have clarity on that, let me know in the comments."

> "The fact that you can program a cohort analysis skill and have it be so reliable - as a finance manager at a fintech company, I can tell you this is an insane amount of work that would go into creating this by hand."

> "Just like anything else you vibe code, you can improve skills over time by showing Claude what the expected output was versus what happened, and having it suggest how to fix it."

---

## Points d'Action

### ✅ Immédiat

1. **Activer les Skills de base dans Claude.ai**
   - Aller dans Settings → Capabilities → Skills
   - Activer: Skill Creator, Excel, PDF Handler
   - Tester avec un workflow simple (ex: analyser un PDF)

2. **Créer votre premier Skill simple**
   - Créer dossier `.claude/skills/hello-skill/`
   - Créer `skill.md` avec YAML front matter minimal
   - Tester dans Claude Code avec prompt: "use hello skill"

### 🔄 Court Terme

3. **Explorer le repo Anthropic Skills**
   - Cloner: https://github.com/anthropics/skills
   - Analyser structure du PDF skill, Excel skill
   - Identifier patterns réutilisables pour vos workflows

4. **Migrer un Slash Command en Skill**
   - Identifier slash command répétitif que vous utilisez
   - Convertir en skill pour autonomisation
   - Comparer efficacité avant/après

5. **Créer Skill personnalisé pour workflow quotidien**
   - Identifier tâche répétitive (ex: génération rapport, formatage données)
   - Structurer skill.md avec required reading + optional assets
   - Itérer avec feedback loop (test → fail → fix)

### 💪 Long Terme

6. **Construire Personal Assistant avec Skills**
   - Suivre vidéo précédente Kenny (Claude Agent SDK)
   - Intégrer 5-10 skills personnalisés
   - Implémenter context engineering avec progressive disclosure

7. **Contribuer à l'écosystème Skills**
   - Partager vos skills sur GitHub
   - Documenter best practices découverts
   - Collaborer sur Anthropic Skills repo

---

## Ressources Mentionnées

### 🔗 Outils

- **Claude Skills Cheatsheet (Kenny Liao)** : [https://share.note.sx/8k50udm8](https://share.note.sx/8k50udm8#ME3MD6walWogaQZxAVIdsAMaYPFQvw694zbFb622c0Y)
  - Comparaison détaillée Skills vs MCPs vs Slash Commands vs Subagents
  - Comment créer et optimiser custom skills
  - Toutes les sources documentaires

- **Nano Banana MCP** : Générateur d'images utilisé dans Thumbnail Creator skill

### 📚 Documentation

- **Anthropic Skills News** : [https://www.anthropic.com/news/skills](https://www.anthropic.com/news/skills)
- **Anthropic Skills Repository** : [https://github.com/anthropics/skills](https://github.com/anthropics/skills)
  - Skills officiels: PDF, Excel, PowerPoint, Word, Skill Creator
  - Examples de structure et best practices
- **Agent Skills Documentation** : [https://code.claude.com/docs/en/docs/agents-and-tools/agent-skills/overview](https://code.claude.com/docs/en/docs/agents-and-tools/agent-skills/overview)

### 🎥 Vidéos

- **Build Your Own Personal Assistant with Claude Agent SDK** : [https://youtu.be/gP5iZ6DCrUI](https://youtu.be/gP5iZ6DCrUI)
  - Prérequis pour comprendre l'intégration Skills + Agent SDK
  - Context engineering patterns

---

## Schéma Récapitulatif

```
╔══════════════════════════════════════════════════════════════════════════╗
║                   ÉCOSYSTÈME CLAUDE SKILLS - VUE D'ENSEMBLE             ║
╠══════════════════════════════════════════════════════════════════════════╣
║                                                                           ║
║                            👤 UTILISATEUR                                ║
║                                  │                                        ║
║                    ┌─────────────┼─────────────┐                         ║
║                    │             │             │                          ║
║                    ⬇️             ⬇️             ⬇️                          ║
║          ┌──────────────┐ ┌──────────────┐ ┌──────────────┐             ║
║          │  Claude.ai   │ │ Claude Code  │ │ Agent SDK    │             ║
║          │   (Web)      │ │   (CLI)      │ │  (Custom)    │             ║
║          └──────────────┘ └──────────────┘ └──────────────┘             ║
║                    │             │             │                          ║
║                    └─────────────┼─────────────┘                         ║
║                                  │                                        ║
║                                  ⬇️                                        ║
║                    ╔════════════════════════════╗                        ║
║                    ║    CLAUDE HARNESS          ║                        ║
║                    ║  (Skills Management)       ║                        ║
║                    ╚════════════════════════════╝                        ║
║                                  │                                        ║
║              ┌───────────────────┼───────────────────┐                   ║
║              │                   │                   │                    ║
║              ⬇️                   ⬇️                   ⬇️                    ║
║    ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐         ║
║    │ SLASH COMMANDS  │ │     SKILLS      │ │      MCPs       │         ║
║    ├─────────────────┤ ├─────────────────┤ ├─────────────────┤         ║
║    │ 👤 MANUEL       │ │ 🤖 AUTONOME     │ │ 🤖 AUTONOME     │         ║
║    │ ⚡ 0 tokens     │ │ ⚡⚡ 50 tokens   │ │ 🔴 3000 tokens  │         ║
║    │ 🟢 SIMPLE       │ │ 🟢 SIMPLE       │ │ 🔴 COMPLEXE     │         ║
║    │                 │ │                 │ │                 │         ║
║    │ Use case:       │ │ Use case:       │ │ Use case:       │         ║
║    │ - /commit       │ │ - Excel builder │ │ - Google Drive  │         ║
║    │ - /review-pr    │ │ - PDF handler   │ │ - Notion        │         ║
║    │ - /debug        │ │ - Thumbnail gen │ │ - Slack         │         ║
║    └─────────────────┘ └─────────────────┘ └─────────────────┘         ║
║                                  │                                        ║
║         Progressive Disclosure   │                                        ║
║         ═══════════════════════  │                                        ║
║                                  ⬇️                                        ║
║              ┌───────────────────────────────────────┐                   ║
║              │  SYSTEM PROMPT                        │                   ║
║              ├───────────────────────────────────────┤                   ║
║              │  Skills metadata:                     │                   ║
║              │  • "PDF Handler" (25 tokens)          │                   ║
║              │  • "Excel Builder" (25 tokens)        │                   ║
║              │  • "Thumbnail Creator" (25 tokens)    │                   ║
║              │  Total: 75 tokens                     │                   ║
║              └───────────────────────────────────────┘                   ║
║                                  │                                        ║
║         Agent décide d'utiliser  │                                        ║
║         "Excel Builder"          │                                        ║
║                                  ⬇️                                        ║
║              ┌───────────────────────────────────────┐                   ║
║              │  PROGRESSIVE DISCLOSURE               │                   ║
║              ├───────────────────────────────────────┤                   ║
║              │  1. Read skill.md body (1500 tokens)  │                   ║
║              │  2. Read required reading (800 tok)   │                   ║
║              │  3. Skip optional assets (not needed) │                   ║
║              │  Total: 2300 tokens (à la demande)    │                   ║
║              └───────────────────────────────────────┘                   ║
║                                  │                                        ║
║                                  ⬇️                                        ║
║              ┌───────────────────────────────────────┐                   ║
║              │  SKILL EXECUTION                      │                   ║
║              ├───────────────────────────────────────┤                   ║
║              │  • Run Python scripts                 │                   ║
║              │  • Use MCP tools (if needed)          │                   ║
║              │  • Generate output                    │                   ║
║              │  • Validate with scripts              │                   ║
║              └───────────────────────────────────────┘                   ║
║                                  │                                        ║
║                                  ⬇️                                        ║
║                         ✅ OUTPUT FINAL                                   ║
║                                                                           ║
╚══════════════════════════════════════════════════════════════════════════╝

COMPOUNDING SKILLS - EXEMPLE:
┌────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│  📦 cohort-analysis-skill/                                             │
│  └─> Utilise: excel-skill (Anthropic default)                         │
│      └─> Ajoute: validation scripts + formulas specifics              │
│                                                                         │
│  📦 thumbnail-creator-skill/                                           │
│  └─> Utilise: nano-banana-mcp (image generation)                      │
│      └─> Ajoute: design guidelines + templates + headshots            │
│                                                                         │
│  AVANTAGE: Ne pas réinventer la roue, composer avec l'existant        │
│                                                                         │
└────────────────────────────────────────────────────────────────────────┘
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Pourquoi Anthropic n'a pas implémenté progressive disclosure pour MCPs ? Limitation technique ou choix de design ?
- Peut-on créer un "meta-skill" qui gère dynamiquement d'autres skills (skill orchestrator) ?
- Comment mesurer l'efficacité d'un skill (token savings, time saved, error rate) ?
- Skills peuvent-ils communiquer entre eux ou doivent passer par l'agent central ?

### 💡 Idées d'Amélioration

- **Skill Testing Framework** : Créer suite de tests automatisés pour valider skills avant déploiement
- **Skill Analytics** : Logger combien de fois chaque skill est utilisé, taux de succès, tokens économisés
- **Skill Templates** : Créer générateur de skills avec structure pré-définie (comme create-react-app)
- **Community Skill Registry** : Marketplace de skills partagés (comme npm pour Node.js)

### 🔗 À Combiner Avec

- [Build Your Own Personal Assistant with Claude Agent SDK](https://youtu.be/gP5iZ6DCrUI) - Pour intégrer skills dans agents personnalisés
- [Skills vs MCP vs Subagents Comparison](ressources/videos/skills-vs-mcp-vs-subagents.md) - Pour approfondir différences architecturales
- Documentation officielle Anthropic Skills - Pour patterns avancés

---

## Conclusion

**Message clé** : Les Skills représentent une avancée majeure dans l'efficacité contextuelle des agents Claude grâce au principe de progressive disclosure. En chargeant uniquement 50 tokens initiaux (vs 3000 pour un MCP équivalent), ils permettent de donner à Claude des dizaines de capacités sans saturer le contexte. La simplicité de création (un dossier + skill.md) combinée à la puissance (scripts Python, validation, compounding) en fait l'outil idéal pour automatiser workflows complexes.

**Action immédiate** : Créez votre premier skill aujourd'hui - identifiez une tâche répétitive dans votre workflow quotidien, créez un dossier `.claude/skills/mon-skill/` avec un `skill.md` minimal, et testez. Itérez ensuite avec le feedback loop de Kenny (test → fail → analyze → fix).

---

**🎓 Niveau de difficulté** : 🟡 Niveau 2 - Utilisation (concepts simples, mais optimisation avancée)
**⏱️ Temps de mise en pratique** : 2-4 heures (créer premier skill simple: 1h, skill avancé avec scripts: 3h+)
**💪 Impact** : 🔥🔥🔥 TRÈS ÉLEVÉ - Token efficiency 40x, autonomisation workflows, scalabilité agent
