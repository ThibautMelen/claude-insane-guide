# Exemples Pratiques

## 1. Utilisation d'un Agent Explore

### Objectif
Trouver tous les fichiers de configuration dans un projet.

### Commande
```
"Trouve tous les fichiers de configuration (.json, .yaml, .env)"
```

### Ce qui se passe
1. Agent Explore est lancé
2. Utilise Glob pour chercher les patterns
3. Retourne la liste des fichiers

### Notes
- Rapide et efficace
- Spécialisé pour cette tâche

---

## 2. Agents Parallèles

### Objectif
Analyser un projet rapidement sur plusieurs aspects.

### Commande
```
"En parallèle:
- Analyse la structure du projet
- Trouve les dépendances
- Liste les tests"
```

### Ce qui se passe
1. Claude lance 3 subagents en parallèle
2. Chacun travaille indépendamment
3. Résultats combinés

### Notes
- Plus rapide que séquentiel
- Tâches indépendantes

---

## 3. Utilisation de MCP GitHub

### Objectif
Créer un PR automatiquement.

### Commande
```
"Crée un PR avec mes changements sur la branche feature/new-auth"
```

### Ce qui se passe
1. Claude utilise `mcp__MCP_DOCKER__create_pull_request`
2. Envoie les données via MCP Server
3. GitHub API crée le PR

### Notes
- Pas besoin de quitter le terminal
- Automatisation complète

---

## 4. Workflow Complet

### Objectif
Refactoring complet d'une feature.

### Étapes
```markdown
1. User: "Refactorise le système d'auth pour utiliser JWT"

2. Claude:
   ├── Lance Explore → trouve fichiers d'auth
   ├── Lance Plan → crée roadmap
   └── Exécute:
       ├── Lit les fichiers
       ├── Modifie le code
       ├── Écrit les tests
       └── Crée un PR (via MCP)
```

### Ce qui se passe
- Combinaison d'agents, subagents, MCP
- Workflow orchestré automatiquement
- Résultat complet

---

## 5. Utilisation d'un Skill

### Objectif
Traiter un document PDF.

### Commande
```
"Analyse report.pdf et extrait les tableaux de données"
```

### Ce qui se passe
1. Claude détecte → tâche PDF
2. Invoque skill "pdf"
3. Applique expertise PDF
4. Extrait et formate les données

### Notes
- Skill apporte l'expertise
- Best practices automatiques

---

## Template pour vos Exemples

### Objectif
[Ce que vous voulez accomplir]

### Commande
```
[La commande donnée à Claude]
```

### Ce qui se passe
1. [Étape 1]
2. [Étape 2]
3. [Résultat]

### Notes
- [Observation 1]
- [Observation 2]

---

## Vos Exemples Personnels

<!-- Ajoutez vos propres exemples ici au fur et à mesure -->
