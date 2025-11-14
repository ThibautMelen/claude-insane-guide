# Workflows - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs

## 📚 Théorie

### Qu'est-ce qu'un Workflow ?

Un **Workflow** = Processus structuré en **étapes séquentielles** pour accomplir une tâche complexe de manière **systématique** et **reproductible**.

```
╔══════════════════════════════════════════╗
║     WORKFLOWS - VUE D'ENSEMBLE           ║
╚══════════════════════════════════════════╝

Tâche Complexe Sans Workflow:
├── Approche désordonnée
├── Étapes oubliées
├── Résultats incohérents
└── Difficile à reproduire ❌

Tâche Complexe Avec Workflow:
├── Étapes claires définies
├── Ordre logique respecté
├── Résultats consistants
├── Facilement reproductible
└── Optimisé pour succès ✅
```

**Source** : Formation Melvynx Claude Code 2.0

---

### 🎯 Problème Résolu

**Avant Workflows** :
```
Feature complexe :
├── "Claude, crée une page de pricing"
├── Claude code directement
├── Hallucinations possibles (architecture inconnue)
├── Pas de validation avant implémentation
├── Tests oubliés
└── Résultat : 50% de chances de succès ❌
```

**Avec Workflow EPCT** :
```
Feature complexe :
├── EXPLORE : Comprendre architecture existante
├── PLAN : Proposer approche + validation
├── CODE : Implémenter selon plan validé
├── TEST : Vérifier fonctionnement
└── Résultat : 95% de chances de succès ✅
```

---

## 🔍 Workflow EPCT (Explore-Plan-Code-Test)

### Méthodologie Structurée

**EPCT** est une **méthodologie en 4 phases** pour créer des features complexes avec **contexte optimal**, **validation humaine** et **qualité maximale**.

```
╔════════════════════════════════════════════════════════╗
║              WORKFLOW EPCT DÉTAILLÉ                    ║
╚════════════════════════════════════════════════════════╝

┌──────────────────────────────────────────────────────┐
│  PHASE 1 : 🔍 EXPLORE (Exploration)                  │
├──────────────────────────────────────────────────────┤
│  Objectif : Comprendre contexte existant             │
│                                                       │
│  Actions :                                            │
│  • Rechercher documentation (WebFetch/Context7)       │
│  • Lire fichiers projet pertinents (Read, Grep)      │
│  • Analyser architecture existante                   │
│  • Identifier dépendances nécessaires                │
│                                                       │
│  Outils : WebSearch, Grep, Read, Context7            │
│  Résultat : Contexte complet pour décision éclairée  │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 2 : 📋 PLAN (Planification)                   │
├──────────────────────────────────────────────────────┤
│  Objectif : Proposer architecture et valider         │
│                                                       │
│  Actions :                                            │
│  • Proposer plan structuré en étapes                 │
│  • ⚠️ STOP : Demander validation utilisateur         │
│  • Poser questions sur points ambigus                │
│  • Ajuster plan selon feedback                       │
│                                                       │
│  ⚠️ CRITIQUE : Validation OBLIGATOIRE                │
│  Résultat : Plan approuvé par l'utilisateur          │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 3 : 💻 CODE (Implémentation)                  │
├──────────────────────────────────────────────────────┤
│  Objectif : Développer selon plan validé             │
│                                                       │
│  Actions :                                            │
│  • Implémenter selon plan validé                     │
│  • Respecter conventions CLAUDE.md                   │
│  • Modifier/créer fichiers multiples                 │
│  • Installer dépendances (npm install)               │
│                                                       │
│  Outils : Write, Edit, Bash                          │
│  Résultat : Feature complète implémentée             │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 4 : ✅ TEST (Vérification)                    │
├──────────────────────────────────────────────────────┤
│  Objectif : Vérifier fonctionnement                  │
│                                                       │
│  Actions :                                            │
│  • Lire package.json pour tests configurés          │
│  • Exécuter tests existants UNIQUEMENT              │
│  • Linting (ESLint) si configuré                    │
│  • Build de vérification                            │
│                                                       │
│  ❌ Ne pas créer tests inexistants                  │
│  ✅ Exécuter tests existants seulement              │
│  Résultat : Feature testée et fonctionnelle          │
└──────────────────────────────────────────────────────┘

        ✅ Feature complète, testée, qualité maximale
```

---

### 💡 Avantages EPCT

```
✅ Réduit hallucinations     → Exploration donne contexte
✅ Validation humaine        → Plan approuvé avant code
✅ Contexte optimal          → Décisions architecturales éclairées
✅ Tests automatiques        → Qualité vérifiée
✅ Reproductible             → Workflow systématique
✅ Qualité consistante       → Toujours mêmes étapes
```

**Quote Melvynx** :
> "Le workflow EPCT permet d'éviter les hallucinations en donnant à Claude le contexte complet avant de coder."

---

### ⚠️ Limitations EPCT

```
❌ Plus lent                 → 4 phases vs code direct
❌ Consomme plus tokens      → Exploration + thinking
❌ Overkill pour simple      → Utiliser pour features complexes
❌ Nécessite bon prompt      → Commande EPCT bien rédigée
```

**Quand utiliser** :
- ✅ Features complexes (nouvelle page, intégration API)
- ✅ Refactoring architecture
- ✅ Migration technologique
- ❌ Modifications simples (typo, CSS tweak)
- ❌ One-liners

---

### 🛠️ Créer Commande /epct

**Fichier** : `.claude/commands/epct.md`

```markdown
# EPCT Workflow : Explore-Plan-Code-Test

Quand l'utilisateur demande une feature avec /epct "description", suis ce workflow :

## Phase 1 : 🔍 EXPLORE

Explore le contexte pour comprendre le projet :

1. **Documentation** :
   - Utilise Context7 si framework connu (Next.js, Vite, React)
   - Sinon WebSearch pour documentation officielle

2. **Architecture Existante** :
   - Lis package.json pour comprendre stack
   - Lis fichiers pertinents (Grep pour patterns)
   - Identifie structure dossiers (src/, components/, etc.)

3. **Dépendances** :
   - Note librairies déjà installées
   - Identifie besoins nouveaux

**Output** : Résumé contexte avec fichiers lus et dépendances identifiées.

---

## Phase 2 : 📋 PLAN

Propose un plan structuré :

1. **Architecture** :
   - Fichiers à créer/modifier
   - Composants/fonctions nécessaires
   - Dépendances à installer

2. **Étapes** :
   - Liste numérotée d'étapes claires
   - Ordre logique de développement

3. **⚠️ STOP - Validation OBLIGATOIRE** :
   - Demande : "Ce plan vous convient-il ?"
   - Pose questions sur points ambigus
   - Ajuste selon feedback utilisateur

**NE PAS CODER** avant validation !

---

## Phase 3 : 💻 CODE

Implémente selon plan validé :

1. **Respect Conventions** :
   - Applique règles CLAUDE.md automatiquement
   - Follow project structure existante

2. **Installation Dépendances** :
   - npm install si nouvelles dépendances
   - Vérifie package.json mis à jour

3. **Implémentation** :
   - Crée/modifie fichiers selon plan
   - Code quality (error handling, types, etc.)

---

## Phase 4 : ✅ TEST

Vérifie fonctionnement :

1. **Tests Existants** :
   - Lis package.json pour scripts test
   - Lance tests SEULEMENT s'ils existent
   - ❌ Ne crée PAS de tests inexistants

2. **Linting** :
   - Lance ESLint si configuré
   - Fix erreurs automatiquement

3. **Build** :
   - Lance build de vérification
   - Vérifie pas d'erreurs TypeScript

**Résultat Final** : Feature complète, testée, fonctionnelle.

---

## Exemple d'Usage

```bash
/epct "Créer une page About avec sections Mission, Team, Contact utilisant TailwindCSS"
```

Workflow :
1. EXPLORE : Lis structure projet, package.json, pages existantes
2. PLAN : Propose fichier About.tsx, sections, layout
3. VALIDATION : Utilisateur approuve
4. CODE : Crée About.tsx avec Tailwind
5. TEST : Build + ESLint
```

**Sauvegarder** dans `.claude/commands/epct.md` puis redémarrer Claude.

---

## 🆕 Nouvelles Fonctionnalités 2025

### ✅ Checkpoints Automatiques

Claude Code sauvegarde automatiquement l'état avant chaque édition :

```
╔═══════════════════════════════════════════╗
║     CHECKPOINTS SYSTEM                    ║
╚═══════════════════════════════════════════╝

Avant chaque Edit/Write:
├── 📸 Snapshot automatique
├── 💾 État sauvegardé
└── 🔄 Retour possible

Commandes:
├── Esc+Esc : Annuler dernière action
├── /rewind : Retour au checkpoint
└── /checkpoint : Créer manuel

Bénéfices:
✅ Expérimentation sans risque
✅ Recovery rapide
✅ Historique complet
```

## 🔄 Tâches Background & Todo Dynamique

### Tâches Background Améliorées (2025)

Claude Code peut **exécuter commandes longues en arrière-plan** (serveurs, builds) pour continuer à travailler pendant l'exécution.

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
           ↓ Flèche ↓ pour voir logs

Nouvelles Commandes 2025:
├── /bashes : Lister toutes les tâches
├── /kill [id] : Terminer une tâche
└── /logs [id] : Voir logs complets

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
```

**Avantages** :
```
✅ Serveurs dev continuent pendant qu'on code
✅ Builds longs en arrière-plan
✅ Kill processus depuis Claude (touche K)
✅ Logs en temps réel disponibles
```

---

### Todo Dynamique

Claude génère **automatiquement** des **todo-lists** suivies en temps réel durant l'exécution de workflows complexes.

```
╔═══════════════════════════════════════════╗
║       TODO DYNAMIQUE                      ║
╚═══════════════════════════════════════════╝

Affichage : Ctrl+T

📋 Todo List Active
┣━━ ✅ Lire fichier about.html
┣━━ ✅ Ajouter lien navigation
┣━━ 🔄 Modifier style header
┣━━ ⏳ Tester responsive mobile
┗━━ ⏳ Build de vérification

Statuts :
• ✅ Terminé
• 🔄 En cours
• ⏳ En attente
```

**Utilité** :
```
✅ Visualisation progression sur tâches complexes
✅ Transparence sur ce que Claude fait
✅ Estimation temps restant
✅ Tracking automatique (pas de TodoWrite manuel)
```

**Limitations** :
```
❌ Todo disparaît après session (pas de persistance)
❌ Pas d'export vers outils externes (Notion, Jira)
❌ Gestion limitée de processus multiples
```

---

### 🎯 Cas d'Usage

**Scenario 1 : Dev Server + Feature** :
```bash
# 1. Lancer serveur en background
claude
> "Lance npm run dev en background"
→ Serveur démarre, continue en arrière-plan

# 2. Développer pendant que serveur tourne
> "/epct 'Créer page contact'"
→ EPCT workflow exécuté
→ Serveur toujours actif

# 3. Hot reload automatique
→ Changements visibles immédiatement
```

**Scenario 2 : Build Long** :
```bash
# Build Next.js (peut prendre 2-5 min)
> "Lance build production en background"
→ Build démarre
→ Ctrl+T : Voir progression
→ Continue à coder autre chose

# Build terminé
→ Notification
→ Vérifier résultats
```

**Scenario 3 : Workflow Complexe avec Todo** :
```bash
> "/epct 'Migration TypeScript → strict mode'"

📋 Todo Auto-Généré:
┣━━ 🔄 Analyser fichiers TypeScript existants
┣━━ ⏳ Activer strict mode dans tsconfig.json
┣━━ ⏳ Fixer erreurs type fichier par fichier
┣━━ ⏳ Vérifier build passe
┗━━ ⏳ Lancer tests

→ Progression visible en temps réel
→ Ctrl+T pour voir état
```

---

## 📋 Cheatsheet

### Commande EPCT

```bash
# Utilisation
/epct "Description de la feature"

# Exemple
/epct "Créer formulaire contact avec validation email et téléphone"
/epct "Intégrer Stripe pour paiements"
/epct "Ajouter dark mode avec toggle"
```

### Background Tasks

```bash
# Lancer en background
"Lance npm run dev en background"
"Build production en background"

# Contrôles
Flèche ↓ : Voir logs
K        : Kill process

# Status
"Vérifie status des processus background"
```

### Todo Dynamique

```bash
# Afficher
Ctrl+T

# Todo auto-généré par workflows complexes
/epct → Todo automatique
Workflows multi-étapes → Todo tracking
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **EPCT = Méthodologie** : Explore → Plan → Code → Test
✅ **Validation Critique** : Plan approuvé AVANT code
✅ **Background Tasks** : Serveurs/builds en arrière-plan
✅ **Todo Dynamique** : Tracking automatique progression
✅ **Contexte Optimal** : Exploration réduit hallucinations

### Commandes Clés

| Commande | Description |
|----------|-------------|
| `/epct "feature"` | Workflow complet EPCT |
| `Ctrl+T` | Afficher todo dynamique |
| `Flèche ↓` | Voir logs background task |
| `K` | Kill background process |

### Workflow EPCT

```
1. EXPLORE : Contexte complet (docs + code)
2. PLAN    : Architecture proposée + VALIDATION
3. CODE    : Implémentation selon plan
4. TEST    : Vérification automatique
```

**Résultat** : 95% succès vs 50% sans workflow

---

## 📚 Ressources

- 📄 **Claude Code Docs** : https://code.claude.com/docs
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw
  - 30:00 - Workflow EPCT
  - 27:00 - Background Tasks
  - 39:00 - Todo Dynamique
- 📄 **Voir aussi** : [Commands](../commands/guide.md) | [Agents](../agents/guide.md) | [Best Practices](../best-practices/guide.md)

---

## Conclusion

Les **Workflows** transforment tâches complexes en processus **systématiques** et **reproductibles**.

**EPCT** = Méthodologie **production-ready** :
- **Explore** : Contexte optimal
- **Plan** : Validation humaine
- **Code** : Implémentation qualité
- **Test** : Vérification automatique

**Background Tasks** = Productivité :
- Serveurs continuent en arrière-plan
- Builds longs n'bloquent pas workflow

**Setup recommandé** :
```
.claude/commands/
├── epct.md        → Workflow features complexes
├── commit.md      → Git conventionnel
└── deploy.md      → Déploiement automatisé

Workflow quotidien:
1. /epct pour features → Plan validé → Implémentation
2. Serveurs background → Dev sans interruption
3. Todo dynamique → Transparence progression
```

**Quote Melvynx** :
> "Le workflow EPCT permet d'éviter les hallucinations et d'avoir un résultat de qualité à chaque fois."

**Impact** : **95% de succès** sur features complexes vs 50% sans workflow.
