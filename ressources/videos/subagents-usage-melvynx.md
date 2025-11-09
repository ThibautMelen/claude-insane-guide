# Sub-Agents : Comment les utiliser correctement

![Miniature vidéo](https://img.youtube.com/vi/bsQ5Sz-qEh0/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: J'utilisais les Sub-Agent n'importe comment : voici comment il faut faire
- **Auteur**: Melvynx • Apprendre à coder
- **Durée**: 22 minutes
- **Date**: 4 septembre 2025
- **Lien**: [https://youtu.be/bsQ5Sz-qEh0](https://youtu.be/bsQ5Sz-qEh0)

## Tags

`#subagents` `#workflow` `#context-management` `#autofix` `#sniper` `#parallel-tasks` `#nextjs` `#typescript` `#best-practices` `#anti-patterns`

---

## Résumé Exécutif

Cette vidéo démontre **la mauvaise et la bonne façon d'utiliser les sub-agents** dans Claude Code. Melvynx critique l'usage massif et simultané de multiples agents (vu sur Twitter) et explique les **2 seuls cas d'usage vraiment pertinents** :

1. ✅ **Éviter de polluer le contexte principal** (recherches isolées)
2. ✅ **Tâches définies en parallèle** (workflow orchestré)

**Message clé** : Les sub-agents ne sont PAS des "employés d'une startup" - ce sont des outils spécialisés à utiliser avec parcimonie.

---

## Timecodes

- `0:00` - Introduction & critique des subagents
- `2:30` - Exemple : recherche prix GPT-5 et limites
- `4:50` - Pourquoi éviter usage massif sur Twitter
- `7:10` - Cas utile : isoler recherches (Next.js)
- `9:30` - Créer Agent Next.js : prompt & tokens
- `11:50` - Résultats et économie de contexte
- `14:10` - Autres agents utiles et bonnes pratiques
- `16:30` - Usage 2 : tâches parallèles (autofix)
- `18:50` - Démo sniper : workflow et sécurité fichiers
- `21:10` - Conclusion, cours et liens utiles

---

## Concepts Clés

### 1. Architecture Main Thread vs Sub-Agents

```
┌──────────────────────────────────────────────────────────┐
│  MAIN THREAD (Conversation Principale)                  │
│  ┌────────────────────────────────────────────────────┐  │
│  │ • Contexte complet                                 │  │
│  │ • Historique conversations                         │  │
│  │ • CLAUDE.md                                        │  │
│  │ • Système prompts                                  │  │
│  │ • MCP Tools                                        │  │
│  └────────────────────────────────────────────────────┘  │
│                                                          │
│  Lance Sub-Agent ──────────────────────┐                │
└────────────────────────────────────────┼────────────────┘
                                         │
                                         ▼
        ┌────────────────────────────────────────┐
        │  SUB-AGENT (Boîte Noire)               │
        │  ┌──────────────────────────────────┐  │
        │  │ INPUT:                           │  │
        │  │ • Description                    │  │
        │  │ • Prompt spécifique              │  │
        │  │ • SubAgent Type                  │  │
        │  ├──────────────────────────────────┤  │
        │  │ CONTEXTE PROPRE:                 │  │
        │  │ • CLAUDE.md (copie)              │  │
        │  │ • Système prompts (copie)        │  │
        │  │ • MCP Tools (copie)              │  │
        │  │ ❌ PAS d'historique main         │  │
        │  ├──────────────────────────────────┤  │
        │  │ OUTPUT:                          │  │
        │  │ • Résultat final uniquement      │  │
        │  └──────────────────────────────────┘  │
        └────────────────────────────────────────┘
```

**Point crucial** : Le sub-agent n'a AUCUNE information sur ce qui s'est passé avant dans la conversation principale.

---

### 2. Limitations des Sub-Agents

```
╔═══════════════════════════════════════════════════════╗
║  ⚠️  CONTRAINTES SUB-AGENTS - CE QU'ON NE PEUT PAS   ║
╚═══════════════════════════════════════════════════════╝

❌ Stopper et reprendre
   └─> Une fois lancé : soit il termine, soit on l'arrête
       (et on perd tout le travail)

❌ Lui donner du contexte manuellement
   └─> Doit passer par le main agent qui prompte le tool

❌ Modifier en cours de route
   └─> Pas de "Arrête-toi, fais autre chose"

❌ Visibilité détaillée
   └─> On voit uniquement le résultat final
   └─> Pas de feedback intermédiaire

❌ Persistance de l'historique
   └─> Contexte isolé, pas de mémoire entre appels
```

---

### 3. ❌ Anti-Pattern : L'Erreur Twitter

**Ce qu'on voit souvent (et qu'il NE FAUT PAS faire)** :

```
Startup Mode (❌ BULLSHIT)
┌─────────────────────────────────────────────────────┐
│  🤖 Product Engineer     → Code features            │
│  🤖 Customer Manager     → ??? (inutile)            │
│  🤖 QA Engineer          → Run tests                │
│  🤖 Customer Support     → ??? (à quoi ça sert?)    │
│  🤖 DevOps Engineer      → Deploy stuff             │
│  ... 20 autres agents en même temps ...            │
└─────────────────────────────────────────────────────┘

Problèmes:
├─> Aucune vision sur ce qui se passe
├─> Peu d'historique
├─> Résultats incohérents
├─> Impossible de debugger
└─> Pure perte de temps et d'argent
```

**Citation** : *"C'est la pire manière de coder avec Claude Code, c'est d'utiliser des subagents pour faire 25 trucs en même temps."*

---

### 4. ✅ Usage 1 : Éviter la Pollution du Contexte

**Problème** : Rechercher des infos complexes pollue le main thread

#### Sans Sub-Agent (❌)

```
MAIN THREAD - Contexte Pollué
┌─────────────────────────────────────────────┐
│ User: "Comment utiliser Next.js 14?"        │
├─────────────────────────────────────────────┤
│ Agent: WebFetch docs.next.js...             │
│ Agent: WebSearch "Next.js 14 features"...   │
│ Agent: Context7 query...                    │
│ ├─> Résumé 1 (1500 tokens)                  │
│ ├─> Résumé 2 (2300 tokens)                  │
│ ├─> Résumé 3 (1800 tokens)                  │
│ ├─> Résumé 4 (2100 tokens)                  │
│ └─> Total: ~8000 tokens de contexte         │
├─────────────────────────────────────────────┤
│ Agent: "Voici comment faire..."             │
│ [Mais 8000 tokens déjà utilisés!]           │
└─────────────────────────────────────────────┘

Résultat: 25% du contexte perdu pour une recherche!
```

#### Avec Sub-Agent (✅)

```
MAIN THREAD - Contexte Propre
┌─────────────────────────────────────────────┐
│ User: "Comment utiliser Next.js 14?"        │
├─────────────────────────────────────────────┤
│ Agent: Lance NextJS Expert Agent            │
│        ├─> Prompt: 200 tokens               │
│        └─> Result: 800 tokens               │
├─────────────────────────────────────────────┤
│ Agent: "Voici comment faire..."             │
│ [Seulement 1000 tokens utilisés!]           │
└─────────────────────────────────────────────┘

      SUB-AGENT (Contexte Isolé)
      ┌──────────────────────────┐
      │ WebFetch (18K tokens)    │
      │ Context7 (56K tokens)    │
      │ WebSearch (12K tokens)   │
      │                          │
      │ Total: 86K tokens        │
      │ ✅ N'impacte PAS le main │
      └──────────────────────────┘
```

**Gain** : Économie de ~85% du contexte principal !

---

### 5. Exemple Concret : Agent Next.js

**Créer l'agent** :

```bash
/agent create --type project
```

**Contenu minimal** (après optimisation) :

```markdown
---
name: nextjs-doc-expert
description: Expert Next.js doc search
---

You are a Next.js documentation expert.

TOOLS:
- Context7 (get-library-docs)
- WebFetch
- WebSearch

OUTPUT REQUIREMENTS:
- Provide code examples
- Give all links from documentation
- Focus on latest Next.js version
```

**Optimisation tokens** :
- Description verbeuse : 289 tokens ❌
- Description optimisée : 72 tokens ✅
- **Gain : 217 tokens par message !**

**Conseil** : Garder les descriptions courtes, instancier l'agent manuellement.

---

### 6. Agents Utiles pour Recherches

```
📚 Agents Recommandés (Usage 1)
├─ 🔍 web-search
│  └─> Recherches web isolées
├─ 📖 nextjs-expert
│  └─> Documentation Next.js
├─ 🗄️ explore-codebase
│  └─> Explorer le code sans polluer
├─ 🔌 explore-backend
│  └─> Analyser APIs externes
└─ 📦 tstack-query-expert
   └─> Recherches librairies spécifiques
```

**Principe** : Toujours préciser l'**OUTPUT** attendu dans le prompt de l'agent.

---

### 7. ✅ Usage 2 : Tâches Définies en Parallèle

**Cas d'usage** : Workflow orchestré avec fichiers clairement séparés

#### Architecture Autofix + Sniper

```
╔════════════════════════════════════════════════════════╗
║  MAIN AGENT - Orchestrateur                            ║
║  ┌──────────────────────────────────────────────────┐  ║
║  │ Commande: /autofix                               │  ║
║  │                                                  │  ║
║  │ 1. Lance build: tsc --noEmit                    │  ║
║  │ 2. Récupère erreurs (20 erreurs trouvées)       │  ║
║  │ 3. Groupe par dossier/area                       │  ║
║  │    ├─> Area 1: 5 erreurs (3 fichiers)           │  ║
║  │    ├─> Area 2: 7 erreurs (2 fichiers)           │  ║
║  │    └─> Area 3: 8 erreurs (4 fichiers)           │  ║
║  │                                                  │  ║
║  │ 4. Lance Sniper agents EN PARALLÈLE ──┐         │  ║
║  └───────────────────────────────────────┼─────────┘  ║
╚═════════════════════════════════════════┼═════════════╝
                                          │
           ┌──────────────────────────────┼───────────────────┐
           │                              │                   │
           ▼                              ▼                   ▼
    ┌────────────┐              ┌────────────┐       ┌────────────┐
    │ SNIPER 1   │              │ SNIPER 2   │       │ SNIPER 3   │
    ├────────────┤              ├────────────┤       ├────────────┤
    │ Files:     │              │ Files:     │       │ Files:     │
    │ • auth.ts  │              │ • api.ts   │       │ • ui.tsx   │
    │ • user.ts  │              │ • db.ts    │       │ • form.tsx │
    │ • index.ts │              │            │       │ • btn.tsx  │
    │            │              │            │       │ • card.tsx │
    ├────────────┤              ├────────────┤       ├────────────┤
    │ Actions:   │              │ Actions:   │       │ Actions:   │
    │ 1. Read    │              │ 1. Read    │       │ 1. Read    │
    │ 2. Fix     │              │ 2. Fix     │       │ 2. Fix     │
    │ 3. Edit    │              │ 3. Edit    │       │ 3. Edit    │
    ├────────────┤              ├────────────┤       ├────────────┤
    │ Output:    │              │ Output:    │       │ Output:    │
    │ ✅ 5 fixed │              │ ✅ 7 fixed │       │ ✅ 8 fixed │
    └────────────┘              └────────────┘       └────────────┘
           │                              │                   │
           └──────────────────────────────┴───────────────────┘
                                          │
                                          ▼
           ┌──────────────────────────────────────────────┐
           │  MAIN AGENT - Validation                     │
           │  1. Récupère résultats                       │
           │  2. Relance build                            │
           │  3. Vérifie: 0 erreurs ✅                    │
           │  4. Termine le workflow                      │
           └──────────────────────────────────────────────┘
```

**Sécurité cruciale** : Chaque Sniper travaille sur des **fichiers différents** pour éviter les conflits.

---

### 8. Commande /autofix

**Fichier** : `.claude/commands/autofix.md`

```markdown
Tu es un agent de correction automatique.

OBJECTIF: Résoudre toutes les erreurs TypeScript/Prettier/ESLint

WORKFLOW:
1. Lance les commandes:
   - npm run type-check
   - npm run lint
   - npm run format:check

2. Récupère toutes les erreurs

3. Split les erreurs par area (dossiers)
   - Maximum 5 fichiers par area

4. Pour chaque area, lance agent 'sniper':
   - Description: "Autofix file1.ts, file2.ts, file3.ts"
   - Prompt: Liste des fichiers + erreurs détaillées

5. Attends que tous les snipers terminent

6. Relance les commandes pour vérifier

7. Si erreurs persistent, répète jusqu'à 0 erreur
```

---

### 9. Agent Sniper

**Fichier** : `.claude/agents/sniper.md`

```markdown
---
name: sniper
description: Fix specific files with surgical precision
---

Tu es un sniper qui corrige des fichiers précis.

INPUT:
- Liste spécifique de fichiers (max 5)
- Erreurs exactes à corriger

ACTIONS:
1. Utilise Read tool pour lire TOUS les fichiers
2. Analyse les erreurs
3. Corrige avec Edit tool
4. Ne touche AUCUN autre fichier

OUTPUT:
Retourne la liste des fichiers modifiés:
- file1.ts ✅
- file2.ts ✅
- file3.ts ✅

IMPORTANT:
❌ Ne modifie que les fichiers spécifiés
❌ Ne fais pas de refactoring non demandé
✅ Corrections chirurgicales uniquement
```

**Nom "Sniper"** : Métaphore de précision - vise des fichiers spécifiques sans toucher au reste.

---

### 10. Workflow Complet

```
┌─────────────────────────────────────────────────────┐
│  USER                                               │
│  /autofix                                           │
└───────────┬─────────────────────────────────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────┐
│  MAIN AGENT (Orchestrator)                          │
│  ┌───────────────────────────────────────────────┐  │
│  │ 1. Run: npm run type-check                    │  │
│  │    Output: 20 errors found                    │  │
│  │                                               │  │
│  │ 2. Group by area:                             │  │
│  │    Area auth/ : 5 errors (3 files)            │  │
│  │    Area api/  : 7 errors (2 files)            │  │
│  │    Area ui/   : 8 errors (4 files)            │  │
│  └───────────────────────────────────────────────┘  │
│                                                     │
│  ┌───────────────────────────────────────────────┐  │
│  │ 3. Launch Snipers (PARALLEL)                  │  │
│  │    • Sniper Auth (3 files)                    │  │
│  │    • Sniper API (2 files)                     │  │
│  │    • Sniper UI (4 files)                      │  │
│  └───────────────────────────────────────────────┘  │
│                                                     │
│  ┌───────────────────────────────────────────────┐  │
│  │ 4. Wait for completion                        │  │
│  │    ✅ Sniper Auth done                        │  │
│  │    ✅ Sniper API done                         │  │
│  │    ✅ Sniper UI done                          │  │
│  └───────────────────────────────────────────────┘  │
│                                                     │
│  ┌───────────────────────────────────────────────┐  │
│  │ 5. Re-run checks                              │  │
│  │    npm run type-check                         │  │
│  │    Output: 0 errors ✅                        │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

---

### 11. Optimisations Prompt Engineering

**Leçon apprise** : Les prompts doivent évoluer avec l'usage

#### Problème initial

```bash
# Prompt trop vague
"Fix errors in page.tsx"

Résultat:
❌ Trouve 20 fichiers nommés "page.tsx"
❌ Prend 1 heure pour décider lequel modifier
```

#### Solution

```bash
# Prompt précis avec chemin complet
"Fix errors in src/app/auth/page.tsx
Full path: /project/src/app/auth/page.tsx"

Résultat:
✅ Fichier unique identifié
✅ Fix en 2 minutes
```

**Citation** : *"Le prompt engineering, c'est aussi de la modification au fil et à mesure du temps."*

---

### 12. Quand NE PAS utiliser Sub-Agents

```
╔════════════════════════════════════════════════════╗
║  ❌ CAS OÙ ÉVITER LES SUB-AGENTS                   ║
╚════════════════════════════════════════════════════╝

❌ Recherches App Store multiples
   └─> Mieux: Plusieurs MAIN threads séparés
   └─> Permet monitoring et contrôle

❌ Création de features complexes
   └─> Besoin d'itération et feedback
   └─> Sub-agent = boîte noire non modifiable

❌ Exploration ouverte du code
   └─> Contexte changeant
   └─> Mieux: Discussion interactive

❌ Debug et troubleshooting
   └─> Besoin de visibilité étape par étape
   └─> Sub-agent cache les détails

✅ Recommandation:
   Préférer plusieurs MAIN threads quand:
   • Besoin de monitoring
   • Tâches indépendantes
   • Pas de partage de contexte nécessaire
```

---

## Citations Marquantes

> "C'est la pire manière de coder avec Claude Code, c'est d'utiliser des subagents pour faire 25 trucs en même temps. Tout ça pour se retrouver avec une interface comme ça mais en réalité il n'y a pas de résultat."

> "Le subagent n'a aucune information sur ce que tu as fait précédemment."

> "Tout ceci c'est une boîte noire. On n'est pas capable de le modifier, on n'est pas capable de lui dire quoi faire."

> "À l'instant où tu le stoppes, ça va complètement arrêter le sub agents et donc tu vas perdre tout le travail qui avait déjà été fait."

> "Ce genre de poste Twitter qu'on a tous vu où il nous dit 'on est dans la meilleure time du history, cloud code subagents permettre d'organiser tes agents comme une startup' - c'est du pur bullshit et ça sert pas à grand-chose en réalité."

> "Ce serait presque 25% de notre contexte si j'avais utilisé directement le chat."

> "Le prompt engineering, c'est aussi de la modification au fil et à mesure du temps."

> "Le sniper, c'est parce qu'il vient sniper des modifications précises de fichiers."

---

## Points d'Action

### ✅ Immédiat

1. **Auditer vos agents actuels**
   - Supprimer les agents "startup mode" inutiles
   - Garder uniquement recherches et workflows orchestrés

2. **Optimiser les descriptions**
   - Descriptions courtes (< 100 tokens)
   - Spécifier l'OUTPUT attendu
   - Appel manuel plutôt qu'automatique

3. **Créer agents de recherche**
   - Web Search (isoler recherches web)
   - Explore Codebase (analyse sans pollution)
   - Framework Experts (Next.js, React, etc.)

### 🔄 Court Terme

4. **Implémenter workflow Autofix**
   - Créer commande `/autofix`
   - Créer agent `sniper`
   - Tester sur petit projet

5. **Documenter vos agents**
   - INPUT : Ce qu'ils reçoivent
   - ACTIONS : Ce qu'ils font
   - OUTPUT : Ce qu'ils retournent

6. **Mesurer l'économie de contexte**
   - Comparer avant/après sub-agents
   - Tracker tokens utilisés

### 💪 Long Terme

7. **Créer bibliothèque d'agents réutilisables**
   - Par framework (Next.js, React, Vue)
   - Par type de tâche (fix, refactor, test)
   - Partager avec la communauté

8. **Optimiser prompts en continu**
   - Logger les problèmes rencontrés
   - Affiner les instructions
   - Ajouter cas d'edge découverts

---

## Ressources Mentionnées

### 🔗 Outils

- **CLI Melvynx** : [i.blueprint.de/cccicli](https://i.blueprint.de/cccicli)
  - Installation : `bunx cloud-code-setup`
  - Contenu : Shell shortcuts, validations, commandes, agents, output styles, notifications

### 📚 Formation

- **Formation IA Melvynx** : [mlv.sh/ai](https://mlv.sh/ai)
  - Contenu : Usages avancés des agents
  - Documentation persistante
  - Workflows complexes

### 👥 Communauté

- Twitter : [mlv.sh/twitter](https://mlv.sh/twitter)
- GitHub : [mlv.sh/github](https://mlv.sh/github)
- Blog : [mlv.sh/blog](https://mlv.sh/blog)
- Discord : [mlv.sh/discord](https://mlv.sh/discord)

### 🎓 Cours Gratuits

- JavaScript : [mlv.sh/js](https://mlv.sh/js)
- React : [mlv.sh/react](https://mlv.sh/react)
- Next.js : [mlv.sh/nextjs](https://mlv.sh/nextjs)
- Masterclass SaaS : [mlv.sh/nowts-masterclass](https://mlv.sh/nowts-masterclass)

---

## Différences avec Autres Approches

### vs Solo Swift Crafter

| Aspect | Melvynx | Solo Swift Crafter |
|--------|---------|-------------------|
| **Focus** | 2 usages précis des sub-agents | Comparaison Skills/MCP/Subagents |
| **Approche** | Anti-patterns + solutions | Exploration options |
| **Tooling** | CLI setup automatique | Fine-tuned OSS model |
| **Public** | Développeurs web (Next.js) | Développeurs iOS (Swift) |

**Complémentarité** :
- Solo Swift → **Quoi** choisir (Skills vs MCP vs Subagents)
- Melvynx → **Comment** bien utiliser les Subagents

---

## Schéma Récapitulatif

```
╔════════════════════════════════════════════════════════╗
║  SUB-AGENTS : GUIDE COMPLET D'UTILISATION             ║
╚════════════════════════════════════════════════════════╝

🎯 QUAND UTILISER ?
├─ ✅ Usage 1: Éviter Pollution Contexte
│  ├─ Web Search isolées
│  ├─ Documentation recherches
│  └─ Exploration codebase
│
└─ ✅ Usage 2: Tâches Parallèles Orchestrées
   ├─ Autofix workflow
   ├─ Batch operations
   └─ Fichiers clairement séparés

⚠️ QUAND ÉVITER ?
├─ ❌ Mode "startup" (25 agents simultanés)
├─ ❌ Features complexes nécessitant itération
├─ ❌ Debug nécessitant visibilité
└─ ❌ Exploration ouverte

🔧 BEST PRACTICES
├─ Descriptions courtes (< 100 tokens)
├─ Spécifier OUTPUT attendu
├─ Appel manuel > automatique
├─ Prompts précis (chemins complets)
└─ Monitor et améliorer en continu

📊 GAINS
├─ Contexte: -85% (recherches)
├─ Temps: -70% (tâches parallèles)
└─ Qualité: +50% (fixes ciblés)
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Comment adapter le workflow Autofix à d'autres langages (Python, Go) ?
- Peut-on créer un agent "Orchestrator" générique ?
- Comment logger les performances des sub-agents ?

### 💡 Idées d'Amélioration

- **Agent Metrics** : Tracker tokens/temps par agent
- **Agent Templates** : Bibliothèque de templates réutilisables
- **Agent Validator** : Vérifier qu'un agent suit les best practices

### 🔗 À Combiner Avec

- Vidéo Solo Swift Crafter : Comprendre quand choisir sub-agents vs Skills/MCP
- Vidéo Edmund Yong : CLAUDE.md pour configurer agents persistants
- Vidéo NetworkChuck : Integration dans workflow terminal global

---

## Conclusion

**Message clé de Melvynx** : Les sub-agents ne sont PAS une solution miracle. Ce sont des outils spécialisés avec 2 cas d'usage précis :

1. 🧠 **Isoler recherches** → Économie de contexte
2. ⚡ **Paralléliser tâches** → Gain de temps

Tout le reste relève du **bullshit Twitter** et génère plus de problèmes que de solutions.

**Action immédiate** : Auditer vos agents et supprimer ceux qui ne rentrent pas dans ces 2 catégories.

---

**🎓 Niveau de difficulté** : 🟡 Intermédiaire
**⏱️ Temps de mise en pratique** : 2-3 heures
**💪 Impact** : 🔥 Très élevé (économie contexte + productivité)
