# Formation Claude Code 2.0 : La seule formation dont tu as besoin (tuto complet)

![Miniature vidéo](https://img.youtube.com/vi/bDr1tGskTdw/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: Formation Claude Code 2.0 : La seule formation dont tu as besoin (tuto complet)
- **Auteur**: Melvynx • Apprendre à coder
- **Durée**: 51 minutes
- **Date**: 6 octobre 2025
- **Lien**: [https://www.youtube.com/watch?v=bDr1tGskTdw](https://www.youtube.com/watch?v=bDr1tGskTdw)

## Tags

`#claudecode` `#cli` `#terminal` `#workflow` `#epct` `#commands` `#memory` `#agents` `#mcp` `#vscode` `#thinking-mode` `#voice-input` `#rewind` `#todo-dynamique`

---

## Résumé Exécutif

Cette masterclass complète de 51 minutes couvre l'intégralité de Claude Code 2.0, de l'installation aux fonctionnalités avancées. Melvynx guide à travers tous les aspects essentiels : setup initial avec Node.js, connexion via API ou abonnement, utilisation du terminal et de l'extension VS Code, modes d'édition (auto/plan/ask), thinking mode, fichier mémoire CLAUDE.md, création de commandes slash personnalisées, workflow EPCT (Explore-Plan-Code-Test), historique avec rewind, todo dynamique, MCP servers, et agents parallèles. Le tutoriel privilégie une approche pragmatique avec des exemples concrets de création de landing pages, gestion de projets Vite, et automatisation de workflows Git.

**Conclusion principale**: Claude Code 2.0 transforme le terminal en assistant IA complet pour développeurs, permettant de coder, gérer des projets et automatiser des tâches directement depuis le CLI avec une mémoire persistante et des workflows personnalisables.

---

## Timecodes

- **00:00** - Introduction & installation de ClaudeCode
- **03:00** - Connexion, thèmes et abonnements Claude
- **06:00** - Autorisation & interface ClaudeCode prête
- **09:00** - Créer fichiers et ouvrir dans VS Code
- **12:00** - Extension VS Code et modes d'édition
- **15:00** - Modes d'édition : auto, plan et ask
- **18:00** - Mode thinking et saisie vocale (Voice Ink)
- **21:00** - Tester responsive & mémoire Claude.md
- **24:00** - Personnaliser Claude.md et commandes Vite
- **27:00** - Tâches background & exécution du serveur
- **30:00** - Workflow EPCT : Explore - Plan - Code - Test
- **33:00** - Commandes partagées, personnelles et CLI
- **36:00** - Historique, rewind et restauration de code
- **39:00** - To-do dynamique et mémoires projet
- **42:00** - MCP : risques et alternative GitHub CLI
- **45:00** - Context7 & création d'agents (explore code)
- **48:00** - Agents parallèles, résumé et conclusion

---

## Concepts Clés

### 1. Installation et Configuration Initiale

**Définition**: Claude Code est un CLI (Command Line Interface) créé par Anthropic permettant d'interagir avec Claude directement depuis le terminal pour coder, gérer des fichiers et automatiser des tâches sur son ordinateur.

```
╔══════════════════════════════════════╗
║     INSTALLATION CLAUDE CODE         ║
╚══════════════════════════════════════╝
              ▼
┌────────────────────────────────────┐
│  1. Installer Node.js (npm)        │
│     via https://nodejs.org         │
└────────────────────────────────────┘
              ▼
┌────────────────────────────────────┐
│  2. Exécuter commande d'install    │
│     npx claude-code                │
└────────────────────────────────────┘
              ▼
┌────────────────────────────────────┐
│  3. Vérifier installation          │
│     claude -v                      │
└────────────────────────────────────┘
              ▼
┌────────────────────────────────────┐
│  4. Connexion (API ou Abonnement)  │
│     - API Key : paiement à l'usage │
│     - Pro : 20$/mois (40-45 msg)   │
│     - Max : 100$/mois (200-250 msg)│
└────────────────────────────────────┘
```

**Avantages**:
- ✅ Contrôle direct de l'ordinateur via terminal
- ✅ Création et modification de fichiers locaux sans téléchargement
- ✅ Intégration native avec Visual Studio Code
- ✅ Workflows automatisables et personnalisables

**Limitations**:
- ❌ Nécessite Node.js installé (prérequis technique)
- ❌ Limite de messages par session (5h) selon abonnement
- ❌ Courbe d'apprentissage pour utilisateurs non-familiers du terminal

**Cas d'usage**:
- Créer des landing pages HTML/CSS/JS en une commande
- Setup de projets (Vite, React, Next.js) avec configuration automatique
- Automatisation Git (commits, création de repos)
- Refactoring de code avec contexte projet complet

---

### 2. Modes d'Édition et Thinking Mode

**Définition**: Claude Code propose trois modes d'édition contrôlant comment l'IA modifie les fichiers, plus un mode "thinking" qui augmente la réflexion de l'IA avant d'agir.

```
╔═════════════════════════════════════════╗
║         MODES D'ÉDITION                 ║
╚═════════════════════════════════════════╝

┌─────────────────────────────────────────┐
│  🟠 ASK BEFORE EDIT (Défaut)            │
│  → Demande confirmation avant           │
│     chaque modification                 │
│  → Idéal pour débutants                 │
└─────────────────────────────────────────┘
              ▼ Shift+Tab
┌─────────────────────────────────────────┐
│  ⚪ EDIT AUTOMATICALLY                   │
│  → Modifications automatiques           │
│  → Pas de confirmation                  │
│  → Idéal pour workflow rapide           │
└─────────────────────────────────────────┘
              ▼ Shift+Tab
┌─────────────────────────────────────────┐
│  🔵 PLAN MODE                            │
│  → Interdit les modifications           │
│  → Propose un plan avant de coder       │
│  → Idéal pour features complexes        │
└─────────────────────────────────────────┘

            THINKING MODE (Tab)
┌─────────────────────────────────────────┐
│  🧠 THINKING ON (bordure bleue)         │
│  → Plus de tokens de réflexion          │
│  → Meilleure qualité de code            │
│  → Contrôle+O : voir les pensées        │
│                                         │
│  🔲 THINKING OFF (bordure grise)        │
│  → Réponses plus rapides                │
│  → Moins de contexte utilisé            │
└─────────────────────────────────────────┘
```

**Avantages**:
- ✅ Contrôle granulaire sur les actions de l'IA
- ✅ Thinking mode améliore significativement la qualité
- ✅ Changement de mode instantané (Shift+Tab / Tab)
- ✅ Visibilité sur le raisonnement de l'IA (Ctrl+O)

**Limitations**:
- ❌ Thinking mode consomme plus de tokens
- ❌ Plan mode peut ralentir le workflow pour tâches simples
- ❌ Nécessite d'apprendre les raccourcis clavier

**Cas d'usage**:
- **Ask Before Edit**: Modification de code sensible, apprentissage de Claude Code
- **Edit Automatically**: Création rapide de prototypes, modifications mineures
- **Plan Mode**: Architecture de features complexes, refactoring majeur
- **Thinking Mode**: Résolution de bugs complexes, création de workflows

---

### 3. Fichier CLAUDE.md - La Mémoire du Projet

**Définition**: Le fichier `.claude/CLAUDE.md` agit comme une mémoire persistante injectée automatiquement dans chaque conversation, permettant de définir des règles, conventions, commandes et contexte projet.

```
📦 Projet/
┣━━ 📁 .claude/
┃   ┣━━ 📄 CLAUDE.md ⭐ (Mémoire projet)
┃   ┣━━ 📁 commands/
┃   ┃   ┣━━ 📄 epct.md
┃   ┃   ┣━━ 📄 commit.md
┃   ┃   └━━ 📄 debug.md
┃   └━━ 📁 agents/
┃       └━━ 📄 explore-code.md
┗━━ 📁 src/

╔══════════════════════════════════════════╗
║      CONTENU CLAUDE.md TYPIQUE           ║
╚══════════════════════════════════════════╝

1️⃣ RÈGLES DE STYLE
   • Primary color: indigo-500
   • Always write code in English
   • Never write comments

2️⃣ COMMANDES DISPONIBLES
   • npm run dev : Lancer serveur
   • npm run build : Build production
   • npm test : Lancer tests

3️⃣ CONTEXTE PROJET
   • Stack: Vite + React + TypeScript
   • Structure: Single page application
   • Features: Responsive navigation

4️⃣ CONVENTIONS
   • Components dans /src/components
   • Styles avec TailwindCSS
   • Tests avec Vitest
```

**Avantages**:
- ✅ Mémoire persistante entre sessions (5h+)
- ✅ Claude se souvient des commandes projet sans les redemander
- ✅ Cohérence de style et conventions automatiques
- ✅ Génération automatique avec `/init`

**Limitations**:
- ❌ Consomme du contexte à chaque message
- ❌ Nécessite mise à jour manuelle ou via Claude
- ❌ Pas de synchronisation automatique entre projets

**Cas d'usage**:
- Définir les couleurs primaires/secondaires du design system
- Lister les commandes npm/pnpm/yarn disponibles
- Spécifier la stack technique et architecture
- Imposer des conventions de code (langue, commentaires, formatage)
- Stocker les URLs d'APIs et variables d'environnement importantes

---

### 4. Commandes Slash Personnalisées

**Définition**: Les commandes slash permettent d'injecter des prompts complexes et réutilisables via la syntaxe `/nom-commande`. Elles peuvent être partagées (projet) ou personnelles (globales).

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

🏠 Commandes Personnelles (Globales)
   ~/.claude/commands/
   ┣━━ 📄 debug.md
   ┣━━ 📄 prompt.md
   ┗━━ 📄 refactor.md
   → Locales à l'utilisateur
   → Non versionnées

┌────────────────────────────────────────┐
│   WORKFLOW CRÉATION COMMANDE           │
└────────────────────────────────────────┘
        ┌─────────────────┐
        │ Créer fichier   │
        │ .claude/        │
        │ commands/       │
        │ nom.md          │
        └────────┬────────┘
                 ▼
        ┌─────────────────┐
        │ Demander à      │
        │ Claude de       │
        │ rédiger le      │
        │ prompt          │
        └────────┬────────┘
                 ▼
        ┌─────────────────┐
        │ Relancer        │
        │ Claude Code     │
        │ (Ctrl+C puis    │
        │ claude)         │
        └────────┬────────┘
                 ▼
        ┌─────────────────┐
        │ Utiliser avec   │
        │ /nom-commande   │
        │ [arguments]     │
        └─────────────────┘
```

**Avantages**:
- ✅ Prompts complexes réutilisables en une commande
- ✅ Partage de workflows entre membres d'équipe
- ✅ Autocomplétion automatique dans terminal et VS Code
- ✅ Peut récupérer documentation externe (WebFetch)

**Limitations**:
- ❌ Nécessite redémarrage de Claude Code pour charger nouvelles commandes
- ❌ Pas d'éditeur visuel (fichiers markdown)
- ❌ Debugging complexe si prompt mal formulé

**Cas d'usage**:
- **/epct** : Workflow Explore-Plan-Code-Test pour nouvelles features
- **/commit** : Génération de commits conventionnels avec analyse Git
- **/debug** : Analyse systématique de bugs avec exploration code
- **/prompt** : Création de commandes via Claude
- **/refactor** : Amélioration de code existant avec suggestions

---

### 5. Workflow EPCT (Explore-Plan-Code-Test)

**Définition**: EPCT est une méthodologie structurée en 4 phases pour créer des features complexes : Exploration du contexte, Planification avec validation, Développement, et Tests automatisés.

```
╔════════════════════════════════════════════════════════╗
║              WORKFLOW EPCT DÉTAILLÉ                    ║
╚════════════════════════════════════════════════════════╝

┌──────────────────────────────────────────────────────┐
│  PHASE 1 : 🔍 EXPLORE                                 │
├──────────────────────────────────────────────────────┤
│  • Recherche internet (documentation)                │
│  • Lecture fichiers projet pertinents                │
│  • Analyse architecture existante                    │
│  • Identification des dépendances                    │
│                                                       │
│  Outils : WebSearch, Grep, Read, Context7            │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 2 : 📋 PLAN                                    │
├──────────────────────────────────────────────────────┤
│  • Proposition de plan structuré                     │
│  • ⚠️ STOP : Demande validation utilisateur          │
│  • Questions sur points ambigus                      │
│  • Validation approche avant code                    │
│                                                       │
│  Résultat : Plan approuvé ou ajusté                  │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 3 : 💻 CODE                                    │
├──────────────────────────────────────────────────────┤
│  • Implémentation selon plan validé                  │
│  • Respect conventions CLAUDE.md                     │
│  • Modifications fichiers multiples                  │
│  • Gestion dépendances (npm install)                 │
│                                                       │
│  Outils : Write, Edit, Bash                          │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 4 : ✅ TEST                                    │
├──────────────────────────────────────────────────────┤
│  • Lecture fichiers config (package.json)            │
│  • Exécution tests existants uniquement              │
│  • Linting (ESLint) si configuré                     │
│  • Build de vérification                             │
│                                                       │
│  ❌ Ne pas créer tests inexistants                   │
└──────────────────────────────────────────────────────┘

        ✅ Feature complète et testée
```

**Avantages**:
- ✅ Réduit hallucinations grâce à phase d'exploration
- ✅ Validation humaine avant développement (phase Plan)
- ✅ Contexte optimal pour décisions architecturales
- ✅ Tests automatiques si configurés dans projet

**Limitations**:
- ❌ Plus lent qu'une approche directe pour tâches simples
- ❌ Consomme plus de tokens (exploration + thinking)
- ❌ Nécessite bonne rédaction de la commande EPCT

**Cas d'usage**:
- Ajout de nouvelle page dans application existante
- Intégration d'API tierce (Stripe, Supabase)
- Refactoring architecture (monolith → composants)
- Migration technologique (JS → TypeScript)

---

### 6. Historique et Rewind

**Définition**: Système de navigation temporelle permettant de revenir à un état antérieur de la conversation et/ou du code, similaire à un Git checkout pour les échanges Claude Code.

```
╔═══════════════════════════════════════════╗
║       SYSTÈME DE REWIND                   ║
╚═══════════════════════════════════════════╝

Raccourci : Échap Échap

┌───────────────────────────────────────────┐
│  HISTORIQUE DES MESSAGES                  │
├───────────────────────────────────────────┤
│  ↑ Message 5 : "Modifie homepage" [6 📄]  │
│  ↑ Message 4 : "Crée page about" [2 📄]   │
│  ↑ Message 3 : "Setup Vite" [0 📄]        │
│  ↑ Message 2 : "Crée sidebar" [4 📄]      │
│  ↑ Message 1 : "Crée index.html" [1 📄]   │
└───────────────────────────────────────────┘
          [Sélectionner avec ↑↓]
                    ▼
┌───────────────────────────────────────────┐
│  OPTIONS DE RESTAURATION                  │
├───────────────────────────────────────────┤
│  1️⃣ Restore Conversation                  │
│     → Revient au message sélectionné      │
│     → Code inchangé                       │
│                                           │
│  2️⃣ Restore Code                          │
│     → Annule modifications fichiers       │
│     → Conversation intacte                │
│                                           │
│  3️⃣ Restore Code & Conversation           │
│     → Annule tout (message + fichiers)    │
│     → Repart de zéro depuis ce point      │
└───────────────────────────────────────────┘

Indicateur : [X 📄] = X fichiers modifiés
```

**Avantages**:
- ✅ Annulation granulaire (conversation OU code OU les deux)
- ✅ Navigation rapide dans historique (flèches)
- ✅ Visualisation du nombre de fichiers modifiés par message
- ✅ Pas de perte de travail lors d'exploration de solutions

**Limitations**:
- ❌ Ne fonctionne que dans session active (pas entre redémarrages)
- ❌ Pas de preview des changements avant restauration
- ❌ Historique limité à la session courante

**Cas d'usage**:
- Tester plusieurs approches pour une feature (A/B testing)
- Annuler modification malheureuse après validation
- Revenir à un point stable avant erreur
- Explorer différentes implémentations sans branches Git

---

### 7. Tâches Background et Todo Dynamique

**Définition**: Claude Code peut exécuter des commandes longues en arrière-plan (serveurs, builds) et génère automatiquement des todo-lists suivies en temps réel durant l'exécution.

```
╔═══════════════════════════════════════════╗
║     TÂCHES BACKGROUND                     ║
╚═══════════════════════════════════════════╝

Commande : npm run dev (exemple)
           ↓
┌───────────────────────────────────────────┐
│  🔄 Background Task Started               │
│  → Process ID : #1234                     │
│  → Commande : npm run dev                 │
│  → Status : Running                       │
└───────────────────────────────────────────┘
           ↓ Flèche ↓
┌───────────────────────────────────────────┐
│  📊 Logs en Temps Réel                    │
│  > vite v5.0.0 dev server running at:     │
│  > http://localhost:5173                  │
│  > Cmd+Click pour ouvrir                  │
└───────────────────────────────────────────┘
           ↓ K pour kill
┌───────────────────────────────────────────┐
│  ❌ Process Killed                        │
└───────────────────────────────────────────┘

╔═══════════════════════════════════════════╗
║       TODO DYNAMIQUE                      ║
╚═══════════════════════════════════════════╝

Affichage : Ctrl+T

📋 Todo List Active
┣━━ ✅ Lire fichier about.html
┣━━ ✅ Ajouter lien melvinx.com
┣━━ 🔄 Modifier style header
┣━━ ⏳ Tester responsive mobile
┗━━ ⏳ Build de vérification

Statuts :
• ✅ Terminé
• 🔄 En cours
• ⏳ En attente
```

**Avantages**:
- ✅ Serveurs continuent en background pendant qu'on code
- ✅ Visualisation progression sur tâches complexes
- ✅ Kill processus depuis Claude Code (touche K)
- ✅ Todo auto-générée pour features multi-étapes

**Limitations**:
- ❌ Todo disparaît après session (pas de persistance)
- ❌ Gestion limitée de processus multiples simultanés
- ❌ Pas d'export de todo vers outils externes

**Cas d'usage**:
- Lancer serveur dev pendant développement
- Builds longs (Next.js, Vite) en background
- Suivi d'installation de dépendances multiples
- Visualisation étapes de workflows complexes (EPCT)

---

### 8. MCP Servers et Alternative CLI

**Définition**: MCP (Model Context Protocol) permet d'étendre Claude Code avec des outils externes, mais Melvynx recommande d'utiliser des CLI classiques pour éviter pollution du contexte.

```
╔══════════════════════════════════════════════╗
║     MCP vs CLI : COMPARAISON                 ║
╚══════════════════════════════════════════════╝

❌ APPROCHE MCP (Non Recommandée)
┌────────────────────────────────────────────┐
│  Installer MCP GitHub                      │
│  → Ajoute outils dans contexte permanent   │
│  → Consomme tokens à chaque message        │
│  → Limite espace pour code important       │
└────────────────────────────────────────────┘
           Exemple : 5-10% contexte perdu

✅ APPROCHE CLI (Recommandée)
┌────────────────────────────────────────────┐
│  Installer GitHub CLI                      │
│  brew install gh                           │
│  → Claude utilise commandes bash           │
│  → Aucun contexte consommé                 │
│  → Outils disponibles à la demande         │
└────────────────────────────────────────────┘

🌟 EXCEPTION : Context7 (Seul MCP Utile)
┌────────────────────────────────────────────┐
│  • Accès documentation frameworks          │
│  • Pas de recherche internet nécessaire    │
│  • Contexte optimisé (pas de HTML brut)    │
│  • Installation :                          │
│    claude mcp transport https://...        │
└────────────────────────────────────────────┘

COMMANDES CLI RECOMMANDÉES :
• gh (GitHub CLI) : Gestion repos/issues/PR
• git : Versioning
• npm/pnpm/yarn : Packages
• curl : Requêtes HTTP
• jq : Manipulation JSON
```

**Avantages**:
- ✅ CLI ne consomme pas de contexte permanent
- ✅ Outils disponibles à la demande uniquement
- ✅ Plus de flexibilité (toutes commandes bash)
- ✅ Context7 : documentation optimisée (Vite, React, etc.)

**Limitations**:
- ❌ Nécessite installation CLI séparées (brew, apt)
- ❌ Context7 nécessite compte et API key
- ❌ Certains MCP offrent intégrations spécifiques utiles

**Cas d'usage**:
- **CLI GitHub** : Créer repos, gérer issues, ouvrir PR
- **Context7** : Documentation Next.js, Vite, Supabase lors de développement
- **CLI Docker** : Gérer conteneurs sans MCP
- **CLI AWS/GCP** : Déploiements cloud sans surcharge contexte

---

### 9. Agents Personnalisés et Parallélisation

**Définition**: Les agents sont des sous-tâches Claude isolées qui explorent, analysent ou traitent des informations sans polluer le contexte principal, pouvant s'exécuter en parallèle pour gains de performance.

```
╔═══════════════════════════════════════════════════╗
║         ARCHITECTURE AGENTS                       ║
╚═══════════════════════════════════════════════════╝

📦 Projet/
┗━━ 📁 .claude/
    ┗━━ 📁 agents/
        ┣━━ 📄 explore-code.md
        ┣━━ 📄 analyze-deps.md
        └━━ 📄 security-audit.md

┌─────────────────────────────────────────────────┐
│         WORKFLOW AGENT                          │
└─────────────────────────────────────────────────┘

Main Agent (Claude Code Principal)
        │
        ├─> Invoque : /epct "Créer page CGV"
        │
        ├──────> 🤖 Agent 1: explore-code
        │        └─> Tâche : Analyser structure projet
        │        └─> Output : Fichiers pertinents
        │
        ├──────> 🤖 Agent 2: explore-code
        │        └─> Tâche : Comprendre routing
        │        └─> Output : Config Vite
        │
        └──────> 🤖 Agent 3: explore-code
                 └─> Tâche : Trouver styles communs
                 └─> Output : Classes CSS
                            │
                            ▼
        ╔════════════════════════════╗
        ║  Agrégation Résultats      ║
        ║  → Agent 1 : 5 fichiers    ║
        ║  → Agent 2 : Config found  ║
        ║  → Agent 3 : TailwindCSS   ║
        ╚════════════════════════════╝
                            ▼
        Main Agent : Génère Plan basé sur outputs

AVANTAGES PARALLÉLISATION :
┌─────────────────────────────────────────┐
│  Sans Agents : 3 × 30s = 90 secondes    │
│  Avec Agents : max(30s, 30s, 30s) = 30s │
│  → Gain : 66% de temps                  │
└─────────────────────────────────────────┘
```

**Avantages**:
- ✅ Contexte principal préservé (agents isolés)
- ✅ Parallélisation = gains performance massifs
- ✅ Spécialisation (agent explore-code, analyze-deps, etc.)
- ✅ Outputs structurés réutilisables

**Limitations**:
- ❌ Création agent nécessite prompt engineering avancé
- ❌ Debugging complexe (outputs intermédiaires invisibles)
- ❌ Coût tokens supérieur (multiples invocations)

**Cas d'usage**:
- **explore-code** : Recherche multi-fichiers pour contexte feature
- **analyze-deps** : Audit dépendances npm (vulnérabilités, versions)
- **security-audit** : Scan code pour XSS, injections SQL
- **generate-tests** : Création tests unitaires sur plusieurs fichiers

---

### 10. Extension VS Code et Voice Input

**Définition**: L'extension Claude Code pour VS Code offre une interface graphique au CLI, tandis que Voice Ink (macOS) permet la saisie vocale dans le terminal.

```
╔════════════════════════════════════════════╗
║      EXTENSION VS CODE                     ║
╚════════════════════════════════════════════╝

Installation : Marketplace VS Code
               "Claude Code for VS Code"
               Version : 2.0+

┌──────────────────────────────────────────┐
│  Interface Graphique                     │
├──────────────────────────────────────────┤
│  • Panneau latéral chat                  │
│  • Tags de fichiers (Cmd+@)              │
│  • Changement modes visuel               │
│  • Historique conversations              │
│  • Nouveau terminal intégré              │
└──────────────────────────────────────────┘

╔════════════════════════════════════════════╗
║      VOICE INPUT (Voice Ink)               ║
╚════════════════════════════════════════════╝

Prix : 25$ (1 device) / 39$ (2 devices)
Alternative : Super Whisper (9$/mois)

Workflow :
1. Cmd (maintenir) → Parler
2. Cmd (relâcher) → Transcription
3. Texte inséré dans terminal

Exemple Prompt Vocal :
"S'il te plaît créer une sidebar responsive
qui est dans la header avec différents liens
et qui se transforme en burger menu sur mobile
en utilisant JavaScript et Font Awesome"

→ Transcription instantanée
→ Claude traite le prompt vocal
```

**Avantages**:
- ✅ Interface graphique plus accessible débutants
- ✅ Voice Input : prompts complexes sans typing
- ✅ Extension : tag fichiers visuellement (Cmd+@)
- ✅ Historique navigable dans sidebar VS Code

**Limitations**:
- ❌ Extension = fonctionnalités limitées vs CLI
- ❌ Voice Ink : macOS uniquement (25-39$)
- ❌ Transcription vocale nécessite débit fluide

**Cas d'usage**:
- **Extension VS Code** : Débutants Claude Code, workflows visuels
- **Voice Input** : Prompts longs (spécifications features), accessibilité
- **Terminal intégré** : Développement sans quitter VS Code

---

## Citations Marquantes

> "Cloud Code est l'outil créé par Anthropic pour t'aider à coder ou à faire n'importe quoi avec ton ordinateur."

> "Faites attention au MCP. En règle générale, je déconseille tous les MCP et je vous conseille d'utiliser des CLI."

> "Plus tu as de MCP, plus tu vas utiliser du contexte et moins tu auras de la place pour ce qui est important."

> "Le fichier CLAUDE.md agit comme une mémoire de Claude et va influencer chaque fois le résultat de Claude."

> "Le Thinking Mode va permettre à l'IA d'avoir plus de génération de tokens et de réfléchir à ta fonctionnalité. L'IA va généralement être plus intelligente."

---

## Points d'Action

### ✅ Immédiat (< 1h)

1. **Installer Claude Code**
   - Vérifier Node.js installé (`node -v`)
   - Exécuter `npx claude-code`
   - Se connecter avec abonnement ou API key
   - Tester `claude -v` pour vérifier installation

2. **Premier Projet Test**
   - Créer dossier test : `mkdir test-claude && cd test-claude`
   - Lancer `claude` dans le dossier
   - Demander : "Crée un fichier index.html simple"
   - Ouvrir dans VS Code : `!code .`

3. **Installer Extension VS Code**
   - Marketplace VS Code → "Claude Code for VS Code"
   - Vérifier version 2.0+
   - Tester panneau latéral (icône Claude)

### 🔄 Court Terme (1 jour - 1 semaine)

4. **Créer fichier CLAUDE.md personnalisé**
   - Lancer `/init` pour générer template
   - Ajouter règles de style (couleurs, conventions)
   - Lister commandes npm du projet
   - Documenter stack technique

5. **Créer commande EPCT**
   - Créer `.claude/commands/epct.md`
   - Demander à Claude de rédiger le workflow EPCT
   - Redémarrer Claude Code
   - Tester avec feature simple (nouvelle page)

6. **Maîtriser raccourcis essentiels**
   - `Shift+Tab` : Changer mode édition
   - `Tab` : Toggle thinking mode
   - `Échap Échap` : Historique/Rewind
   - `Ctrl+O` : Voir thinking process
   - `Ctrl+T` : Afficher todo
   - `!` : Mode bash pour commandes directes

7. **Installer Context7 MCP**
   - Créer compte sur context7.co
   - Copier API key
   - `claude mcp transport https://... --api-key YOUR_KEY`
   - Tester : "Utilise Context7 pour doc Vite"

### 💪 Long Terme (> 1 semaine)

8. **Bibliothèque de commandes personnelles**
   - Créer `~/.claude/commands/`
   - Commandes utiles : `/debug`, `/commit`, `/refactor`, `/prompt`
   - Partager commandes projet dans `.claude/commands/`
   - Documenter chaque commande avec exemples

9. **Créer agents spécialisés**
   - `explore-code.md` : Exploration codebase
   - `analyze-deps.md` : Audit dépendances
   - `security-audit.md` : Scan sécurité
   - Tester parallélisation avec EPCT

10. **Automatiser workflows Git**
    - Installer GitHub CLI (`brew install gh`)
    - Configurer autorisation : `gh auth login`
    - Créer commande `/ship` : commit + push + PR
    - Ajouter commandes repos : `gh repo create`

11. **Optimiser contexte et performance**
    - Monitorer usage avec `/usage`
    - Éviter MCP non essentiels
    - Utiliser agents pour tâches lourdes
    - Activer thinking mode pour code complexe uniquement

---

## Ressources Mentionnées

### 🔗 Outils

- **Claude Code CLI** : [https://claude.com/product/claudecode](https://claude.com/product/claudecode)
  - Installation, documentation officielle

- **Node.js** : [https://nodejs.org](https://nodejs.org)
  - Prérequis pour installer Claude Code (npm)

- **Visual Studio Code** : [https://code.visualstudio.com](https://code.visualstudio.com)
  - Éditeur de code avec extension Claude Code

- **Voice Ink** : [https://voiceink.app](https://voiceink.app) (macOS)
  - Transcription vocale pour terminal (25-39$)
  - Alternative : Super Whisper (9$/mois)

- **GitHub CLI** : [https://cli.github.com](https://cli.github.com)
  - Alternative recommandée aux MCP GitHub
  - Installation : `brew install gh`

- **Context7** : [https://context7.co](https://context7.co)
  - Seul MCP recommandé pour documentation frameworks

### 📚 Documentation

- **Setup CLI Melvynx** : [https://mlv.sh/cc-cli](https://mlv.sh/cc-cli)
  - CLI Melvynx pour installer toutes ses commandes

- **Formation gratuite Claude Code AI** : [https://mlv.sh/ai](https://mlv.sh/ai)
  - Masterclass complète avec configurations avancées

- **Prompt Engineering Best Practices** : [https://docs.anthropic.com/claude/docs/prompt-engineering](https://docs.anthropic.com/claude/docs/prompt-engineering)
  - Guide officiel Anthropic pour optimiser prompts

- **Sub-Agents Documentation** : [https://docs.anthropic.com/claude/docs/sub-agents](https://docs.anthropic.com/claude/docs/sub-agents)
  - Documentation officielle création d'agents

### 🎥 Ressources Melvynx

- **Twitter** : [https://mlv.sh/twitter](https://mlv.sh/twitter)
- **GitHub** : [https://mlv.sh/github](https://mlv.sh/github)
- **Blog** : [https://mlv.sh/blog](https://mlv.sh/blog)
- **Discord** : [https://mlv.sh/discord](https://mlv.sh/discord)
- **Cours gratuit JavaScript** : [https://mlv.sh/js](https://mlv.sh/js)
- **Cours gratuit React** : [https://mlv.sh/react](https://mlv.sh/react)
- **Cours gratuit Next.js** : [https://mlv.sh/nextjs](https://mlv.sh/nextjs)
- **Masterclass SaaS** : [https://mlv.sh/nowts-masterclass](https://mlv.sh/nowts-masterclass)

---

## Schéma Récapitulatif

```
╔════════════════════════════════════════════════════════════════════╗
║                 ÉCOSYSTÈME CLAUDE CODE 2.0                         ║
╚════════════════════════════════════════════════════════════════════╝

                         👤 DÉVELOPPEUR
                               │
                ┌──────────────┼──────────────┐
                ▼              ▼              ▼
        ┌───────────┐  ┌───────────┐  ┌──────────┐
        │ TERMINAL  │  │  VS CODE  │  │  VOICE   │
        │   CLI     │  │ EXTENSION │  │  INPUT   │
        └─────┬─────┘  └─────┬─────┘  └────┬─────┘
              │              │              │
              └──────────────┼──────────────┘
                             ▼
                    ┌─────────────────┐
                    │  CLAUDE CODE    │
                    │   (Main Agent)  │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
┌───────────────┐    ┌──────────────┐    ┌─────────────┐
│   MÉMOIRE     │    │  COMMANDES   │    │   AGENTS    │
│               │    │   SLASH      │    │ PARALLÈLES  │
├───────────────┤    ├──────────────┤    ├─────────────┤
│ CLAUDE.md     │    │ /epct        │    │ explore-    │
│ - Règles      │    │ /commit      │    │   code      │
│ - Commandes   │    │ /debug       │    │ analyze-    │
│ - Contexte    │    │ /prompt      │    │   deps      │
└───────┬───────┘    └──────┬───────┘    └──────┬──────┘
        │                   │                    │
        └───────────────────┼────────────────────┘
                            ▼
                    ┌─────────────────┐
                    │   OUTILS CLI    │
                    ├─────────────────┤
                    │ • GitHub CLI    │
                    │ • npm/pnpm      │
                    │ • git           │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ MCP          │    │ BACKGROUND   │    │  REWIND /    │
│ (Context7)   │    │   TASKS      │    │  HISTORIQUE  │
│              │    │              │    │              │
│ Docs         │    │ Serveurs     │    │ Restauration │
│ Frameworks   │    │ Builds       │    │ Code/Conv.   │
└──────────────┘    └──────────────┘    └──────────────┘

╔════════════════════════════════════════════════════════════════════╗
║                     WORKFLOW TYPIQUE                               ║
╚════════════════════════════════════════════════════════════════════╝

1. Demande Feature → Claude lit CLAUDE.md (mémoire)
2. Mode EPCT → Agents parallèles explorent codebase
3. Plan proposé → Validation humaine
4. Code généré → Modifications multiples fichiers
5. Background task → Serveur lancé automatiquement
6. Tests automatiques → Build + ESLint
7. Si erreur → Rewind (Échap Échap) pour annuler
8. Commit → Commande /commit ou GitHub CLI
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Comment créer des agents qui communiquent entre eux (agent orchestration) ?
- Peut-on intégrer Claude Code dans CI/CD pour reviews automatiques ?
- Quelle limite de tokens pour commandes EPCT sur projets > 100 fichiers ?
- Est-il possible de synchroniser CLAUDE.md entre projets similaires ?

### 💡 Idées d'Amélioration

- Créer template CLAUDE.md par stack (React, Vue, Next.js, Svelte)
- Commande `/onboard` pour générer documentation projet automatiquement
- Agent `security-audit` avec intégration Snyk/Dependabot
- Commande `/translate` pour internationalisation de projet

### 🔗 À Combiner Avec

- [Vidéo Melvynx - Sub-agents Usage](./subagents-usage-melvynx.md) : Approfondir agents parallèles
- [Guide Commands](../../themes/commands/guide.md) : Créer bibliothèque de commandes
- [Guide Memory](../../themes/memory/guide.md) : Optimiser fichier CLAUDE.md
- [Cheatsheet Shortcuts](../../themes/shortcuts/cheatsheet.md) : Raccourcis terminal

---

## Conclusion

**Message clé** : Claude Code 2.0 transforme le terminal en environnement de développement augmenté par IA, offrant contrôle total sur workflows via mémoire persistante (CLAUDE.md), commandes slash réutilisables, agents parallèles, et historique temporel (rewind). L'approche CLI + Context7 (vs MCP multiple) optimise le contexte pour code plutôt que métadonnées.

**Action immédiate** : Installer Claude Code (`npx claude-code`), créer un projet test, générer CLAUDE.md avec `/init`, et créer première commande EPCT pour expérimenter le workflow Explore-Plan-Code-Test sur une feature simple.

---

**🎓 Niveau de difficulté** : 🟡 Intermédiaire (nécessite bases terminal + Node.js)
**⏱️ Temps de mise en pratique** : 2-3 heures (setup + premier projet EPCT complet)
**💪 Impact** : 🔥🔥🔥 Révolutionnaire (change workflow développement quotidien)
