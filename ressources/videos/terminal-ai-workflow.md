# Terminal AI: Le Workflow 10x Plus Rapide

![Miniature vidéo](https://img.youtube.com/vi/MsQACpcuTkU/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: You've Been Using AI the Hard Way (Use This Instead)
- **Auteur**: NetworkChuck
- **Durée**: 33 minutes
- **Date**: 28 octobre 2025
- **Lien**: [https://youtu.be/MsQACpcuTkU](https://youtu.be/MsQACpcuTkU)

## Tags

`#terminal` `#gemini-cli` `#claude-code` `#opencode` `#workflow` `#agents` `#context-files` `#automation` `#git` `#productivity`

---

## Résumé Exécutif

Cette vidéo démontre pourquoi utiliser AI dans le **terminal** est 10x plus rapide que dans le navigateur. L'auteur présente trois outils majeurs (**Gemini CLI**, **Claude Code**, **OpenCode**) et montre comment synchroniser plusieurs AIs sur le même projet pour un workflow ultra-efficace.

**Révélation principale**: Les fichiers de contexte (gemini.md, .claude/CLAUDE.md, agents.md) permettent de garder le contrôle sur vos projets et de ne jamais perdre votre contexte.

---

## ⚠️ Note sur la Fraîcheur de la Documentation

Cette vidéo date d'**octobre 2025**. Certaines features mentionnées peuvent avoir évolué:

- ⚠️ **Output Styles** (`/output-style`) est **DEPRECATED** depuis nov 2025
  - **Alternative**: Utiliser **PLUGINS** avec SessionStart hooks ou sub-agents
  - **Deadline**: Conversion automatique le 5 novembre 2025
- ✅ Autres features vérifiées et à jour

📄 **Voir [STATUS.md](../../STATUS.md)** pour le tracking complet des features deprecated.

---

## Problèmes du Workflow Navigateur

### Symptômes Classiques 🔴

1. **20 chats ouverts** - Context perdu entre les sessions
2. **Copy/paste chaos** - Essayer de garder des notes
3. **Chat GBT, Claude, Gemini** - Tous ouverts pour vérifier
4. **Scroll bar invisible** - Trop de contexte dans un seul chat
5. **Projet fragmenté** - Informations dispersées partout

### Citation Clé
> "Your project is a mess. Spread over 20 chats, two deep research sessions and scattered notes. There's a better way."

---

## Solution 1: Gemini CLI

### Installation

```bash
# Linux/WSL
curl -sSL https://install.gemini.cli | bash

# Mac (avec Homebrew)
brew install gemini-cli
```

### Superpouvoir: Context Files

**Le concept révolutionnaire**:

1. Créer un dossier projet
2. Lancer Gemini dedans
3. Taper `/init` → Crée **gemini.md**
4. Ce fichier = contexte permanent du projet

```bash
mkdir coffee-project
cd coffee-project
gemini
/init  # Crée gemini.md
```

### Comment ça marche?

```
Gemini analyse votre projet
    ↓
Crée gemini.md avec:
- Description du projet
- Fichiers importants
- Décisions prises
- État actuel
    ↓
Chaque nouvelle session Gemini
charge automatiquement ce contexte
```

**Résultat**: Plus besoin de ré-expliquer le contexte!

### Capacités Terminal

Gemini peut:
- ✅ Lire/écrire des fichiers sur votre disque
- ✅ Exécuter des scripts Bash et Python
- ✅ Accéder à vos notes (Obsidian, etc.)
- ✅ Demander permission avant d'agir

**Outils disponibles**: `/tools`

---

## Solution 2: Claude Code (Le Favori)

### Pourquoi Claude Code?

**7+ features killer**, dont la plus puissante: **Les Agents**

### Installation

```bash
npm install -g @anthropic/claude-code
claude  # Lancer
```

### Feature 1: Agents

**Concept**: Déléguer des tâches à des "employés" avec leur propre context window.

#### Pourquoi c'est révolutionnaire?

```
Conversation principale: 200k tokens
├── 42% utilisé (85k tokens)
└── Lance un agent
    └── Agent: FRESH 200k tokens
        └── Travaille de manière isolée
```

**Avantage**:
- Context principal protégé
- Pas de "bloat" de contexte
- Parallélisation possible

#### Créer un Agent

```bash
/agents  # Menu des agents
→ Create new agent
→ Nom: "Home Lab Guru"
→ Prompt: "You are a research expert..."
→ Outils: Choisir les permissions
→ Modèle: Sonnet, etc.
```

#### Utiliser un Agent

```
@agent home-lab-guru research the best NAS for $500
```

Claude délègue la tâche → Agent travaille → Retourne résultats

#### Agents Multiples

**Exemple puissant**:
```
User: "Create a comprehensive report"

Claude:
├── Lance @home-lab-guru → Recherche NAS
├── Lance @general-agent → Trouve pizza Dallas
└── Lance @home-lab-guru → Meilleure GPU gaming

→ 3 agents en parallèle
→ Résultats compilés
```

**Citation**:
> "I feel so powerful right now. This is so fun."

#### Agents Personnels

Exemples d'agents utiles:
- **Brutal Critic** - Roast impitoyable pour améliorer le travail
- **Session Closer** - Synchronise tout et commit Git
- **Research Expert** - Utilise Gemini en headless mode
- **Script Writer** - Optimisé pour écriture vidéo

### Feature 2: ~~Output Styles~~ ⚠️ DEPRECATED

> **⚠️ DEPRECATED**: Output styles seront automatiquement convertis en plugins le **5 novembre 2025**
>
> **Source**: [Claude Code Docs - Output Styles](https://code.claude.com/docs/fr/docs/claude-code/output-styles)
>
> **Alternative Recommandée**: Utiliser des **PLUGINS** (pas agents!)
>
> _"Les plugins offrent des moyens plus puissants et flexibles de personnaliser le comportement de Claude Code."_

**Ancienne méthode** (ne plus utiliser):
```bash
/output-style  # ❌ Sera retiré le 5 nov 2025
```

**Nouvelles méthodes** (via Plugins):

#### Option 1: SessionStart Hooks
Injecter du contexte au démarrage sans modifier le system prompt:

```typescript
// .claude/plugins/custom-behavior/index.ts
export default {
  sessionStart: async () => {
    return {
      context: "You are a home lab expert. Always provide detailed explanations..."
    };
  }
};
```

#### Option 2: Sub-agents (pour prompts différents)
Utiliser des sub-agents dans vos plugins pour comportements spécialisés:

```bash
# Dans votre plugin
/agents → Create new agent
→ System prompt personnalisé
→ Context window séparé
```

**Avantages des Plugins vs Output Styles**:
- ✅ Plus puissants et flexibles
- ✅ SessionStart hooks (injection dynamique de contexte)
- ✅ Sub-agents pour comportements spécialisés
- ✅ Système activement maintenu

**Migration**: Convertir avant le 5 novembre 2025 pour transition fluide.

**Exemple**: Au lieu d'un output style "script writing", créer un plugin avec SessionStart hook.

### Feature 3: Planning Mode

```bash
Shift + Tab → Planning Mode
```

Claude:
1. Crée un plan détaillé
2. Vous le présente
3. Vous l'approuvez ou ajustez
4. Exécute le plan étape par étape

### Feature 4: Context Management

```bash
/context
```

Voir exactement:
- Tokens utilisés
- Tokens restants
- Quels fichiers/ressources consomment du contexte

### Autres Features

- **Prompts**: Templates réutilisables
- **Hooks**: Scripts qui s'exécutent sur événements
- **Custom Status Lines**: Personnaliser l'interface
- **Images**: Coller des images directement dans le terminal
- **Permissions**: `--dangerously-skip-permissions` pour mode rapide

### Mode Dangereux

```bash
claude -R --dangerously-skip-permissions
```

⚠️ Bypass toutes les confirmations - Utilisez avec précaution!

---

## Solution 3: OpenCode (Open Source)

### Pourquoi OpenCode?

- ✅ **Open source**
- ✅ Modèles locaux supportés
- ✅ Login avec Claude Pro
- ✅ Grok gratuit
- ✅ Features avancées

### Installation

```bash
curl -sSL https://opencode.ai/install | bash
source ~/.bashrc
opencode
```

### Utiliser Modèles Locaux

Éditer `~/.config/opencode/opencode.json`:

```json
{
  "model": "llama3.2"
}
```

```bash
opencode
/model → Switch to llama3.2
```

### Login Claude Pro

```bash
opencode auth login
→ Anthropic (Claude Pro)
→ Paste code
```

### Features Uniques

#### Timeline

```bash
/timeline
```

**Voyager dans le temps** de votre conversation:
- Voir l'historique complet
- Restaurer à un point précis
- "I want that in real life!"

#### Sessions Partagées

```bash
/share
```

Génère une URL → Partager votre session live avec d'autres

#### Export

```bash
opencode export --format json
```

Exporter toute la session en JSON

#### Headless Server

```bash
opencode start-server
opencode attach
```

Mode serveur pour automation avancée

---

## Le Workflow Ultimate: Sync Multiple AIs

### Concept

Utiliser **Gemini + Claude + Codex** simultanément sur le même projet.

### Comment?

#### Étape 1: Même Dossier

```bash
cd mon-projet

# Terminal 1
gemini

# Terminal 2
claude

# Terminal 3
codex
```

Tous les trois accèdent aux **mêmes fichiers**.

#### Étape 2: Sync des Context Files

Garder ces fichiers synchronisés:
- `gemini.md`
- `.claude/CLAUDE.md`
- `agents.md` (Codex)

**Astuce**: Utiliser un agent Claude pour les sync automatiquement.

### Workflow de l'Auteur

**Exemple concret** (création vidéo YouTube):

```
Terminal 1 - Claude:
├── Écrit hook "authority angle"
└── Sauvegarde dans authority-hook.md

Terminal 2 - Gemini:
├── Écrit hook "discovery angle"
└── Sauvegarde dans discovery-hook.md

Terminal 3 - Codex (ChatGPT):
├── Lit les deux hooks
├── Analyse et compare
└── Donne feedback de haut niveau
```

**Résultat**:
- 3 AIs différentes
- Travaillant sur le même projet
- Pas de copy/paste
- Tout est sur le disque local

#### 💡 Insight Clé: C'est Comme des Agents Parallèles!

**Ce workflow = Agents de Claude Code, mais en plus puissant**:

```
Claude Code Agents:
├── Agent 1: Context window isolé
├── Agent 2: Context window isolé
└── Agent 3: Context window isolé
    └── Tous dans Claude

Multi-AI Terminal:
├── Gemini: Context window isolé (GRATUIT)
├── Claude: Context window isolé
└── Codex: Context window isolé
    └── 3 modèles différents = 3 expertises!
```

**Avantages du Multi-AI**:
- ✅ **Diversité**: Chaque AI a ses forces
  - Gemini: Excellent pour recherche, gratuit
  - Claude: Meilleur pour deep work, coding
  - ChatGPT: Analyse haut niveau, critique

- ✅ **Indépendance**: Si un service est down, les autres continuent

- ✅ **Cost-effective**: Gemini gratuit + Claude Pro = Moins cher que plusieurs subscriptions

- ✅ **Validation croisée**: Vérifier les résultats entre AIs

**Citation**:
> "I can use all AI, I'll use the best AI. No one could stop me."

**En bref**: Au lieu de 3 agents dans Claude, vous avez 3 AIs différentes qui travaillent ensemble. C'est le même concept de parallélisation, mais avec plus de flexibilité!

---

## Système de Session Management

### Agent: Session Closer

**Rôle**: Automatiser la fermeture de sessions de travail.

#### Ce qu'il fait:

1. **Résume** tout ce qui a été fait dans la session
2. **Met à jour** `session-summary.md`
3. **Sync** tous les context files:
   - gemini.md
   - .claude/CLAUDE.md
   - agents.md
4. **Commit Git** avec message auto-généré
5. **Prépare** la prochaine session

### Exemple

```bash
# Fin de journée
Hey Claude, close this out. Run @session-closer
```

Claude:
- Analyse le travail fait
- Update tous les fichiers
- Commit: "Updated script outline, created 3 hooks, reviewed framework"
- Terminé ✅

**Lendemain**:
```bash
claude
"Hey, where are we at?"

→ "Chuck, you finished the script.
   Time to record. We made these
   three decisions, go for it."
```

---

## Git: Traiter Tout Comme du Code

### Philosophie

> "I treat my scripts and pretty much every project I work on in my life like code."

### Pourquoi Git?

1. **Historique complet** de toutes les décisions
2. **Tracking des changements** avec raisons
3. **Rollback** si quelque chose casse
4. **Documentation automatique** via commits

### Workflow

```bash
# Agent Session Closer fait:
git add .
git commit -m "Session: Updated outline, created hooks, reviewed framework"
```

**Résultat**: Chaque session de travail = commit Git avec contexte.

---

## Agent: Brutal Critic

### Concept

Agent **ultra critique** pour éviter le biais de complaisance.

### Problème Résolu

```
AI normale: "Oh Chuck, best thing you ever wrote!"
Chuck: "You're gaslighting me. Stop it."
```

### Solution

Créer un agent **designed to roast**:

```yaml
Brutal Critic:
  Rôle: Critique impitoyable
  Personnalités: 3 reviewers différents
  But: Être difficile à plaire
  Framework: Lit les docs de framework
  Output: Note /10 + critique détaillée
```

### Utilisation

```bash
Use @brutal-critic to roast my script
```

**Résultat**:
```
Score: 8.2/10

Three Reviewers:
├── Reviewer 1: "Segment 5 is a feature dump..."
├── Reviewer 2: "9 features, zero depth"
└── Reviewer 3: "5-8% retention drop expected"
```

**Avantage**: Feedback honnête et utile, pas de flatterie.

---

## Cas d'Usage Avancés

### 1. AI Utilisant AI

**Créer un agent** qui utilise Gemini en headless:

```bash
# Agent prompt
"You are a research expert.
Use Gemini in headless mode:
gemini -p 'your prompt here'"
```

**Utilisation**:
```
Find best AI terminal videos on YouTube
Use @gemini-research-agent
```

→ Claude lance un agent
→ Agent exécute Gemini
→ Retourne résultats

### 2. Multi-Agent Video Production

**Exemple de l'auteur**:

```
Project: YouTube Video
├── Agent 1: Transcribe files
├── Agent 2: Analyze content
├── Agent 3: Generate editor notes
├── Agent 4: Detect repetitions
├── Agent 5: Timeline analysis
└── Agents 6-7: Parallel tasks
```

**7 agents** travaillant simultanément!

### 3. Notes App Replacement

```
Obsidian Vault = Dossier de fichiers
    ↓
AI accède directement aux fichiers
    ↓
Plus besoin de copy/paste
```

### 4. Gemini + Claude: Le Combo Parfait

**Scénario**: Projet de recherche avec analyse

```bash
# Setup
cd mon-projet-recherche

# Terminal 1 - Gemini (Gratuit pour recherche)
gemini
→ "Research the top 10 AI terminal tools"
→ "Compile results in research.md"

# Terminal 2 - Gemini (Autre tâche)
gemini
→ "Find best practices for context files"
→ "Create best-practices.md"

# Terminal 3 - Claude (Analysis profonde)
claude
→ "Read research.md and best-practices.md"
→ "Create comprehensive guide combining both"
→ "Use @brutal-critic to review"
```

**Résultat**:
- 2 Gemini gratuits font la recherche (parallèle)
- Claude fait l'analyse et critique (payant mais meilleur)
- Tous lisent/écrivent dans le même dossier
- Context files synchronisés

**Économie**:
- Recherche gratuite (Gemini)
- Deep work payant seulement (Claude)
- Best of both worlds!

**C'est exactement ce que NetworkChuck fait dans la vidéo!**

---

## Principes Clés

### 1. Ownership de Votre Contexte

```
Browser AI:
└── Contexte piégé dans l'app
    └── Vendor lock-in
    └── Perdu si service change

Terminal AI:
└── Contexte sur votre disque dur
    └── Portable
    └── Vous le possédez
    └── Indépendant des services
```

**Citation**:
> "I own my context. If a new greater, better AI comes out, I'm ready for it."

### 2. Multi-AI Strategy

Ne pas dépendre d'un seul AI:
- **Claude**: Meilleur pour deep work et agents
- **Gemini**: Bon pour recherche et gratuit
- **ChatGPT/Codex**: Excellent pour analyse haut niveau

### 3. Files Are King

Tout stocker en fichiers:
- Scripts
- Notes
- Contexte
- Décisions
- Recherches

**Avantage**: Accessible par tous les AIs, backupable, versionnable.

---

## Installation Complete Guide

### Mac

```bash
# Gemini
brew install gemini-cli

# Claude Code
npm install -g @anthropic/claude-code

# OpenCode
curl -sSL https://opencode.ai/install | bash
```

### Linux/WSL

```bash
# Gemini
curl -sSL https://install.gemini.cli | bash

# Claude Code
sudo npm install -g @anthropic/claude-code

# OpenCode
curl -sSL https://opencode.ai/install | bash
source ~/.bashrc
```

### Windows

Utiliser WSL (Windows Subsystem for Linux) - Voir vidéo de NetworkChuck sur WSL.

---

## Comparaison des Outils

| Feature | Gemini CLI | Claude Code | OpenCode |
|---------|------------|-------------|----------|
| **Prix** | ✅✅✅ Gratuit | Claude Pro ($20/mois) | Gratuit (+ Claude Pro login) |
| **Agents formels** | ❌ | ✅✅✅ (Killer feature) | ✅ |
| **Context Files** | ✅ gemini.md | ✅ .claude/CLAUDE.md | ✅ agents.md |
| **Modèles locaux** | ❌ | ❌ | ✅ |
| **~~Output Styles~~** | ❌ | ⚠️ Deprecated | ❌ |
| **Planning Mode** | ❌ | ✅ | ❌ |
| **Timeline** | ❌ | ❌ | ✅ |
| **Session Sharing** | ❌ | ❌ | ✅ |
| **Web Search** | ✅ | ✅ | Selon modèle |
| **Headless Mode** | ✅ `gemini -p` | ✅ Via agents | ✅ |
| **Multi-AI Workflow** | ✅✅✅ Parfait | ✅✅✅ Parfait | ✅✅✅ Parfait |

---

## Quick Commands Reference

### Gemini CLI

```bash
gemini              # Lancer
/init              # Créer gemini.md
/tools             # Voir outils disponibles
gemini -p "prompt" # Headless mode
```

### Claude Code

```bash
claude                              # Lancer
claude -R                           # Resume session
claude --dangerously-skip-permissions # Mode rapide
/init                               # Créer .claude/CLAUDE.md
/context                            # Voir tokens
/agents                             # Menu agents
Shift+Tab                           # Planning mode
@agent-name                         # Appeler agent
# /output-style                     # ⚠️ DEPRECATED - Utiliser agents à la place
```

### OpenCode

```bash
opencode                   # Lancer
opencode auth login        # Login
/model                     # Switch model
/timeline                  # Timeline
/share                     # Share session
/sessions                  # Voir sessions
opencode export           # Export
```

---

## Limitations et Considérations

### Courbe d'Apprentissage

- Terminal peut être intimidant au début
- Nécessite familiarité avec ligne de commande
- Mais: NetworkChuck insiste que "everyone should use this"

### Coûts

- **Gemini**: Gratuit (généreux free tier)
- **Claude Code**: Requiert Claude Pro ($20/mois)
- **OpenCode**: Gratuit, ou Claude Pro pour meilleurs modèles

### Sécurité

**Important**: AI a accès à votre filesystem!

**Recommendations**:
- Utiliser TwinGate pour accès réseau (sponsor)
- Vérifier les permissions
- Mode dangereux seulement si vous savez ce que vous faites
- Zero-trust pour remote access

---

## Citations Inspirantes

> "If you're still using AI in the browser, you're doing it the slow way."

> "The terminal is a superpower."

> "Everything I'm doing, talking with these three different AIs on a project, it's not tied in a browser. It's just this folder right here on my hard drive."

> "I own my context... I will use all AI, I'll use the best AI. No one could stop me."

> "Don't let the terminal scare you... This tool is for everyone."

> "I wake up every day feeling like I have superpowers."

---

## Use Cases par Domaine

### Développeurs

- Code reviews automatisés
- Refactoring parallèle
- Documentation auto-générée
- Tests batch processing

### Créateurs de Contenu

- Scripts vidéo avec critiques
- Recherche multi-sources
- Organisation de projets
- Timeline management

### Chercheurs

- Compilation de recherches
- Multi-source analysis
- Note organization
- Citation tracking

### Tous

- Gestion de projets
- Prise de notes organisée
- Automation de tâches répétitives
- Contrôle total sur le contexte

---

## Prochaines Étapes Suggérées

### Niveau Débutant

1. ✅ Installer Gemini CLI (gratuit)
2. ✅ Créer un projet test
3. ✅ Essayer `/init` et gemini.md
4. ✅ Demander à Gemini de créer des fichiers

### Niveau Intermédiaire

1. 🔄 S'abonner à Claude Pro
2. 🔄 Installer Claude Code
3. 🔄 Créer votre premier agent
4. 🔄 Tester Planning Mode (Shift+Tab)

### Niveau Avancé

1. 🚀 Setup multi-AI workflow
2. 🚀 Créer agents spécialisés (Critic, Session Closer)
3. 🚀 Intégrer Git dans workflow
4. 🚀 Automatiser avec headless modes
5. 🚀 Ajouter MCP servers (voir autre vidéo NetworkChuck)

---

## Ressources Additionnelles

- **GitHub Repo de l'auteur**: [github.com/theNetworkChuck/ai-in-the-terminal](https://github.com/theNetworkChuck/ai-in-the-terminal)
- **Gemini CLI Docs**: [ai.google.dev/gemini-api](https://ai.google.dev/gemini-api)
- **Claude Code**: [claude.com/product/claude-code](https://www.claude.com/product/claude-code)
- **OpenCode**: [opencode.ai](https://opencode.ai)
- **TwinGate**: [twingate.com](https://ntck.co/ai_terminal)

---

## Notes Personnelles

<!-- Ajoutez vos réflexions et expériences ici -->

**Questions à explorer**:
- Comment créer mon premier agent personnalisé?
- Quelle est la meilleure structure de gemini.md/.claude/CLAUDE.md?
- Comment automatiser la sync entre les context files?
- Git workflow: quelle fréquence de commits?

**À expérimenter**:
- [ ] Setup Gemini CLI sur mon projet actuel
- [ ] Créer un agent "Session Closer"
- [ ] Tester multi-AI sur un petit projet
- [ ] Organiser mes notes Obsidian pour AI access

**Insights**:
- Le concept de "ownership de contexte" est puissant
- Agents = game changer pour context management
- Terminal > Browser pour productivité
