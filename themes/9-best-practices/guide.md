# Best Practices - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs

## 📚 Théorie

### Pourquoi des Best Practices ?

Les **Best Practices** permettent d'optimiser votre workflow Claude Code pour **productivité maximale**, **qualité de code** et **coût optimisé**.

```
╔══════════════════════════════════════════╗
║     BEST PRACTICES - VUE D'ENSEMBLE      ║
╚══════════════════════════════════════════╝

Sans Best Practices:
├── Répéter instructions à chaque session
├── Prompts imprécis = résultats aléatoires
├── Pas d'optimisation coût/vitesse
├── Temps perdu sur tâches répétitives
└── Contexte mal utilisé ❌

Avec Best Practices:
├── Memory = instructions automatiques
├── Commands = workflows répétitifs
├── Modes d'édition = contrôle fin
├── Thinking mode = qualité code
├── Rewind = annulation granulaire
└── Workflow optimisé 10x ✅
```

---

## 📚 Principes Fondamentaux

### 1. DRY (Don't Repeat Yourself)

**Quote Edmund Yong (800h Claude Code)** :
> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"

```
❌ AVANT : Répéter chaque fois
"Use TypeScript strict mode"
"Follow Airbnb style guide"
"Add error handling"
[... chaque session]

✅ APRÈS : Memory (.claude/CLAUDE.md)
→ Instructions appliquées automatiquement
→ Pas de répétition
```

---

### 2. Single Responsibility

**Principe** : Une commande/agent = une responsabilité claire.

```
❌ BAD
/do-everything
→ Trop vague, fait quoi ?

✅ GOOD
/create-endpoint → Créer endpoint API
/generate-test   → Générer tests
/review-code     → Review qualité
```

---

### 3. Composition over Duplication

**Principe** : Réutiliser plutôt que dupliquer.

```
✅ Memory Imports
@~/.claude/preferences.md
@.claude/config/style.md

✅ Commands Réutilisables
/epct pour toutes features

✅ Plugins Modulaires
Combiner hooks + commands + agents
```

---

## ⚙️ Modes d'Édition

### Contrôle Fin de Claude

Claude Code offre **3 modes d'édition** pour contrôler comment l'IA modifie vos fichiers.

```
╔═════════════════════════════════════════╗
║         MODES D'ÉDITION                 ║
╚═════════════════════════════════════════╝

┌─────────────────────────────────────────┐
│  🟠 ASK BEFORE EDIT (Défaut)            │
│  → Demande confirmation avant           │
│     chaque modification                 │
│  → Idéal pour débutants                 │
│  → Sécurité maximale                    │
└─────────────────────────────────────────┘
              ▼ Shift+Tab
┌─────────────────────────────────────────┐
│  ⚪ EDIT AUTOMATICALLY                   │
│  → Modifications automatiques           │
│  → Pas de confirmation                  │
│  → Idéal pour workflow rapide           │
│  → Prototypes, itérations rapides       │
└─────────────────────────────────────────┘
              ▼ Shift+Tab
┌─────────────────────────────────────────┐
│  🔵 PLAN MODE                            │
│  → Interdit les modifications           │
│  → Propose un plan avant de coder       │
│  → Idéal pour features complexes        │
│  → Validation avant implémentation      │
└─────────────────────────────────────────┘
```

**Raccourci** : `Shift+Tab` pour cycler entre modes.

---

### 🎯 Quand Utiliser Chaque Mode ?

**Ask Before Edit (Défaut)** :
```
✅ Apprentissage Claude Code
✅ Code sensible/critique
✅ Modifications importantes
✅ Première fois sur projet
```

**Edit Automatically** :
```
✅ Prototypes rapides
✅ Modifications mineures
✅ Code expérimental
✅ Confiance établie avec Claude
```

**Plan Mode** :
```
✅ Features complexes
✅ Refactoring majeur
✅ Architecture nouvelle
✅ Besoin validation avant code
```

---

### 💡 Workflow Recommandé (Melvynx)

```
┌────────────────────────────────────────────┐
│  WORKFLOW OPTIMAL PAR SITUATION            │
├────────────────────────────────────────────┤
│                                            │
│  Nouvelle feature complexe :               │
│  1. PLAN MODE → valider approche           │
│  2. EDIT AUTO → implémenter rapidement     │
│  3. ASK MODE  → modifications finales      │
│                                            │
│  Bug fix simple :                          │
│  1. ASK MODE → voir changement proposé     │
│  2. Valider → appliquer                    │
│                                            │
│  Prototype rapide :                        │
│  1. EDIT AUTO → itérer vite                │
│  2. Rewind si erreur                       │
└────────────────────────────────────────────┘
```

---

## 🧠 Thinking Mode

### Augmenter Intelligence de Claude

Le **Thinking Mode** permet à Claude d'utiliser **plus de tokens de réflexion** avant d'agir, améliorant significativement la **qualité du code**.

```
╔════════════════════════════════════════╗
║       THINKING MODE                    ║
╚════════════════════════════════════════╝

🔲 THINKING OFF (bordure grise)
┌────────────────────────────────────┐
│  Réponses rapides                  │
│  Moins de réflexion                │
│  Économie de tokens                │
│  Idéal : tâches simples            │
└────────────────────────────────────┘

🧠 THINKING ON (bordure bleue)
┌────────────────────────────────────┐
│  Plus de tokens de réflexion       │
│  Meilleure qualité code            │
│  Analyse approfondie               │
│  Idéal : tâches complexes          │
│                                    │
│  Ctrl+O : Voir pensées de Claude   │
└────────────────────────────────────┘
```

**Raccourci** : `Tab` pour toggle Thinking Mode.

**Visualiser Pensées** : `Ctrl+O` pour voir le raisonnement de Claude.

---

### 🎯 Quand Activer Thinking Mode ?

**✅ ACTIVER (Thinking ON)** :
```
Situations complexes :
├── Résolution bugs complexes
├── Architecture système
├── Refactoring majeur
├── Création workflows (EPCT, agents)
├── Code critique (sécurité, perf)
└── Premières fois sur tech nouvelle
```

**❌ DÉSACTIVER (Thinking OFF)** :
```
Tâches simples :
├── Formatting code
├── Rename variables
├── Ajout commentaires
├── Modifications mineures CSS
└── Questions simples
```

**Quote Melvynx** :
> "Le Thinking Mode va permettre à l'IA d'avoir plus de génération de tokens et de réfléchir à ta fonctionnalité. L'IA va généralement être plus intelligente."

---

### 💡 Workflow Thinking Mode

```
1. Feature Complexe
   → Activer Thinking (Tab)
   → Claude analyse en profondeur
   → Meilleure architecture

2. Implémentation
   → Désactiver Thinking (économiser tokens)
   → Appliquer plan validé

3. Review / Debugging
   → Réactiver Thinking
   → Analyse approfondie erreurs

💰 Optimisation Coût/Qualité
→ Thinking ON : planification, review, debug
→ Thinking OFF : implémentation, tâches simples
```

---

## ⏪ Rewind - Navigation Temporelle

### Annuler Granulaire

**Rewind** = Système de **navigation temporelle** permettant de revenir à un état antérieur de la **conversation** et/ou du **code**.

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
│     → Code INCHANGÉ                       │
│     → Rebrancher conversation             │
│                                           │
│  2️⃣ Restore Code                          │
│     → Annule modifications fichiers       │
│     → Conversation INTACTE                │
│     → Rollback code seulement             │
│                                           │
│  3️⃣ Restore Code & Conversation           │
│     → Annule TOUT (message + fichiers)    │
│     → Repart de zéro depuis ce point      │
│     → Reset complet                       │
└───────────────────────────────────────────┘

Indicateur : [X 📄] = X fichiers modifiés
```

---

### 🎯 Cas d'Usage Rewind

**Scenario 1 : Tester Plusieurs Approches** :
```
1. Implémenter approche A
2. Tester
3. Rewind (Restore Code)
4. Implémenter approche B
5. Comparer résultats
→ Choisir meilleure solution
```

**Scenario 2 : Erreur dans Workflow** :
```
1. Feature complète créée
2. Erreur détectée étape 3/5
3. Rewind à étape 2
4. Recommencer depuis là
→ Pas besoin tout refaire
```

**Scenario 3 : Exploration Sans Risque** :
```
1. Code stable
2. Expérimenter refactoring
3. Si mauvais résultat : Rewind
4. Code stable restauré
→ Zéro risque d'expérimentation
```

---

### 💡 Best Practices Rewind

**DO ✅** :
```
✅ Tester plusieurs solutions (A/B testing)
✅ Rollback après erreur
✅ Explorer sans risque
✅ Revenir à point stable avant bug
```

**DON'T ❌** :
```
❌ Compter sur Rewind pour backup
   → Utiliser Git pour versioning
❌ Oublier que Rewind = session only
   → Pas persistant entre redémarrages
❌ Rewind sans comprendre ce qui change
   → Vérifier avant de restaurer
```

---

## 💾 Checkpoints - Sauvegarde de Session (2025)

### Système de Points de Sauvegarde

**Checkpoints** = Nouveau système Claude Code 2.0 permettant de **sauvegarder l'état complet** d'une session de travail pour y revenir plus tard.

```
╔═══════════════════════════════════════════╗
║          SYSTÈME DE CHECKPOINTS           ║
╚═══════════════════════════════════════════╝

Création Automatique :
├── Toutes les 10 min d'activité
├── Avant opérations critiques
├── Après étapes majeures
└── Sur demande manuelle

┌───────────────────────────────────────────┐
│  CHECKPOINT SAUVEGARDÉ                     │
├───────────────────────────────────────────┤
│  📸 État conversation                      │
│  📁 Fichiers modifiés                     │
│  🧠 Contexte Claude                       │
│  🔧 Configuration session                 │
│  📝 Historique commandes                  │
│  ⏱️  Timestamp : 2025-11-10 14:30:00      │
└───────────────────────────────────────────┘
```

### 🎯 Commandes Checkpoints

```bash
# Créer checkpoint manuel
/checkpoint save "Avant refactoring majeur"

# Lister checkpoints disponibles
/checkpoint list

# Restaurer checkpoint
/checkpoint restore <id>

# Supprimer checkpoint
/checkpoint delete <id>

# Info checkpoint
/checkpoint info <id>
```

### 💡 Use Cases Checkpoints

**Expérimentation Sans Risque** :
```
1. Créer checkpoint
2. Tester approche A
3. Si échec → restore checkpoint
4. Tester approche B
```

**Travail Multi-Sessions** :
```
Matin : Développer feature → checkpoint
Pause déjeuner : Claude fermé
Après-midi : Restore checkpoint → continuer
```

**Collaboration Asynchrone** :
```
Dev 1 : Feature → checkpoint → partage ID
Dev 2 : Restore checkpoint → continue travail
```

### ⚡ Différence Checkpoint vs Rewind

```
┌────────────────┬──────────────┬──────────────┐
│   Feature      │  Checkpoint  │    Rewind    │
├────────────────┼──────────────┼──────────────┤
│ Persistance    │ ✅ Permanent │ ❌ Session   │
│ Partage        │ ✅ Possible  │ ❌ Local     │
│ Granularité    │ État complet │ Par message  │
│ Automatique    │ ✅ Oui       │ ❌ Manuel    │
│ Cross-session  │ ✅ Oui       │ ❌ Non       │
└────────────────┴──────────────┴──────────────┘
```

### 💾 Configuration Checkpoints

```json
// .claude/settings.json
{
  "checkpoints": {
    "autoSave": true,
    "interval": 600,        // secondes (10 min)
    "maxCheckpoints": 10,
    "beforeCritical": true, // avant opérations critiques
    "compression": true,
    "includeOutput": false  // économiser espace
  }
}
```

### 📊 Best Practices Checkpoints

**DO ✅** :
```
✅ Checkpoint avant refactoring majeur
✅ Nommer checkpoints descriptifs
✅ Nettoyer vieux checkpoints régulièrement
✅ Partager checkpoint ID dans README équipe
✅ Checkpoint avant expérimentation risquée
```

**DON'T ❌** :
```
❌ Garder 100+ checkpoints (pollution)
❌ Se fier uniquement aux checkpoints (Git reste essentiel)
❌ Checkpoint avec secrets/credentials exposés
❌ Oublier de documenter checkpoint important
```

---

## 📋 Best Practices par Outil

### Memory

**DO ✅** :
```
✅ Memory globale : préférences personnelles
✅ Memory locale : règles projet spécifiques
✅ Être spécifique : "2 spaces" pas "bien formater"
✅ Organiser en sections claires (Stack, Conventions, Testing)
✅ Versionner .claude/CLAUDE.md dans Git (partage équipe)
```

**DON'T ❌** :
```
❌ Trop d'instructions (pollution contexte)
❌ Instructions vagues ("code propre")
❌ Secrets/credentials dans Memory
❌ Instructions contradictoires (tabs ET spaces)
```

---

### Commands

**DO ✅** :
```
✅ Créer commande si tâche répétée 3+ fois
✅ Noms descriptifs (/epct, /commit, /deploy)
✅ Organisation par domaine (.claude/commands/workflows/)
✅ Documentation claire dans fichier .md
✅ Redémarrer Claude après création/modification
```

**DON'T ❌** :
```
❌ Commands pour tâches one-shot
❌ Prompts vagues ("aide moi")
❌ Trop de commands (50+) = confusion
❌ Oublier de maintenir (commands obsolètes)
```

---

### Sub-Agents

**DO ✅** :
```
✅ Tâches très spécialisées (security audit, perf analysis)
✅ System prompt dédié et précis
✅ Context isolé nécessaire
✅ Paralléliser quand possible (gain temps)
✅ Documenter objectif et modèle utilisé
```

**DON'T ❌** :
```
❌ Trop de sub-agents (20+) = confusion
❌ Pour tâches simples (formatter code)
❌ Duplication avec commands existants
❌ Opus pour tâches simples (coût ↑↑↑)
```

---

### MCP

**DO ✅** :
```
✅ Context7 pour documentation frameworks (recommandé)
✅ CLI natives (gh, git, curl, jq) plutôt que MCP
✅ Sécuriser API keys dans env vars
✅ Rate limiting awareness (limites APIs)
```

**DON'T ❌** :
```
❌ Installer tous les MCP (pollution contexte)
❌ Hard-coder secrets dans config
❌ MCP quand CLI équivalent existe (gh > MCP GitHub)
❌ Ignorer limites API (quota dépassé)
```

**Quote Melvynx** :
> "Faites attention au MCP. Plus tu as de MCP, plus tu vas utiliser du contexte et moins tu auras de la place pour ce qui est important."

---

## 📋 Cheatsheet

### Raccourcis Essentiels

| Raccourci | Action | Usage |
|-----------|--------|-------|
| `Shift+Tab` | Cycler modes d'édition | Ask → Auto → Plan |
| `Tab` | Toggle Thinking Mode | ON (bleu) ↔ OFF (gris) |
| `Échap Échap` | Ouvrir Rewind | Historique messages |
| `Ctrl+O` | Voir pensées Claude | Thinking Mode actif |
| `Ctrl+T` | Afficher Todo | Liste tâches dynamique |
| `!` | Mode bash | Commandes directes terminal |

### Workflow Optimal

```bash
# 1. Setup Projet
claude
/init                    # Créer .claude/CLAUDE.md
# Éditer CLAUDE.md : stack, rules, commands

# 2. Feature Complexe
Shift+Tab → PLAN MODE    # Valider approche
Tab → THINKING ON        # Activer réflexion
/epct "Ma feature"       # Workflow EPCT
# Validation plan
Shift+Tab → EDIT AUTO    # Implémenter rapidement
Tab → THINKING OFF       # Économiser tokens

# 3. Review
Tab → THINKING ON        # Réactiver réflexion
# Review code
Shift+Tab → ASK MODE     # Modifications finales avec validation

# 4. Si Erreur
Échap Échap → Rewind     # Restaurer point stable
```

---

## ✏️ Exercices

### 🟢 Niveau 1 : Découverte (10 min)

**Objectif** : Maîtriser raccourcis de base

**Exercice** :
1. Lance Claude Code
2. Teste les raccourcis :
   - `Shift+Tab` : Change mode édition 3 fois (Ask → Auto → Plan → Ask)
   - `Tab` : Toggle Thinking Mode (observe bordure)
   - `Ctrl+O` : Voir pensées (si Thinking ON)
   - `Ctrl+T` : Afficher Todo

**Résultat attendu** : Familiarité avec tous les raccourcis

---

### 🟡 Niveau 2 : Utilisation (15 min)

**Objectif** : Workflow complet avec modes

**Exercice** :
1. Créer petit projet (index.html)
2. Demander feature en **Plan Mode** :
   ```
   "Ajoute formulaire contact avec validation"
   ```
3. Valider plan
4. Passer **Edit Auto** + **Thinking OFF** pour implémentation
5. Observer différence vitesse vs qualité

**Résultat attendu** : Comprendre trade-offs modes

---

### 🟠 Niveau 3 : Maîtrise (20 min)

**Objectif** : Tester Rewind et approches multiples

**Exercice** :
1. Projet Vite
2. Implémenter feature "Dark Mode" (approche A : useState)
3. Noter résultat
4. `Échap Échap` → Rewind (Restore Code)
5. Implémenter feature "Dark Mode" (approche B : Context)
6. Comparer les deux approches

**Résultat attendu** : Maîtrise Rewind pour A/B testing

---

### 🔴 Niveau 4 : Expert (25 min)

**Objectif** : Workflow complet optimisé

**Exercice** :
1. Nouveau projet Next.js
2. Setup `.claude/CLAUDE.md` avec :
   - Stack (Next.js 14, TypeScript, TailwindCSS)
   - Conventions (functional components, strict typing)
3. Créer commande `/feature` :
   ```markdown
   # Feature Creator

   1. PLAN MODE : Propose architecture
   2. Validation utilisateur
   3. EDIT AUTO + THINKING OFF : Implémentation
   4. THINKING ON : Review code
   ```
4. Tester commande sur feature "Page About"

**Résultat attendu** : Workflow production-ready optimisé

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **DRY** : Memory + Commands = Pas de répétition
✅ **3 Modes Édition** : Ask (sécurité) / Auto (vitesse) / Plan (validation)
✅ **Thinking Mode** : ON (qualité) / OFF (vitesse + économie)
✅ **Rewind** : Navigation temporelle, annulation granulaire
✅ **MCP vs CLI** : Privilégier CLI (contexte optimisé)

### Raccourcis Essentiels

| Raccourci | Action |
|-----------|--------|
| `Shift+Tab` | Cycler modes édition |
| `Tab` | Toggle Thinking |
| `Échap Échap` | Rewind |
| `Ctrl+O` | Voir pensées |
| `Ctrl+T` | Todo |

### Workflow Production

```
1. Setup : Memory + Commands
2. Feature : Plan Mode → valider → Edit Auto
3. Thinking : ON (plan/review) / OFF (implémentation)
4. Erreur : Rewind au point stable
5. Review : Thinking ON + Ask Mode
```

---

## 📚 Ressources

- 📄 **Claude Code Docs** : https://code.claude.com/docs
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw
  - 15:00 - Modes d'édition
  - 18:00 - Thinking Mode
  - 36:00 - Rewind
- 🎥 **Edmund Yong - 800h Claude Code** : https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- 📄 **Voir aussi** : [Memory](../memory/guide.md) | [Commands](../commands/guide.md) | [Workflows](../workflows/guide.md)

---

## Conclusion

Les **Best Practices** transforment Claude Code d'outil puissant en **workflow production optimisé**.

**Principes clés** :
- **DRY** : Automatiser répétitif
- **Contrôle** : Modes édition selon besoin
- **Qualité** : Thinking Mode sur complexe
- **Sécurité** : Rewind pour expérimentation

**Setup recommandé** :
```
~/.claude/
├── CLAUDE.md (global preferences)
└── commands/ (personal workflows)

projet/.claude/
├── CLAUDE.md (project rules)
└── commands/ (team workflows)

Raccourcis mémorisés:
├── Shift+Tab (modes)
├── Tab (thinking)
└── Échap Échap (rewind)
```

**Impact** : **Productivité 10x**, code quality, workflow optimisé.

**Quote Melvynx** :
> "Le Thinking Mode va permettre à l'IA de réfléchir à ta fonctionnalité. L'IA va généralement être plus intelligente."
