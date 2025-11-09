# 🟢 Niveau 1 : Découverte des Hooks

> **Objectif** : Créer vos premiers hooks et comprendre les événements de base
>
> **Durée estimée** : 15-20 minutes

---

## 🎯 Ce que vous allez apprendre

- ✅ Configurer des hooks dans `settings.json`
- ✅ Utiliser les événements `SessionStart` et `PostToolUse`
- ✅ Comprendre le cycle de vie des hooks
- ✅ Tester et debugger des hooks simples

---

## 📋 Prérequis

- Claude Code installé
- Un projet de test (ou créer `~/claude-hooks-test/`)
- Terminal bash

---

## 🚀 Exercice 1 : Premier Hook "Hello World"

### Objectif

Créer un hook qui affiche un message au démarrage de Claude.

### Instructions

1. **Créer un projet test**

```bash
mkdir -p ~/claude-hooks-test
cd ~/claude-hooks-test
```

2. **Créer la configuration Claude**

```bash
mkdir .claude
```

3. **Créer `settings.json` avec votre premier hook**

```bash
cat > .claude/settings.json << 'EOF'
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '👋 Bienvenue ! Hook activé avec succès !'"
    }
  ]
}
EOF
```

4. **Démarrer Claude et vérifier**

```bash
claude
```

### ✅ Validation

Vous devez voir au démarrage :
```
👋 Bienvenue ! Hook activé avec succès !
```

### 💡 Explication

- `event: "SessionStart"` → Hook se déclenche au démarrage
- `script: "echo ..."` → Commande bash simple
- Le message s'affiche dans la console Claude

---

## 🚀 Exercice 2 : Hook sur Édition de Fichier

### Objectif

Créer un hook qui s'exécute **après** chaque modification de fichier.

### Instructions

1. **Créer un fichier test**

```bash
echo "console.log('test')" > test.js
```

2. **Modifier `settings.json`**

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '👋 Session démarrée'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "echo '✏️ Fichier modifié : $FILE'"
    }
  ]
}
```

3. **Redémarrer Claude et demander une modification**

```bash
claude
```

Puis demandez à Claude :
```
Modifie test.js pour ajouter un commentaire
```

### ✅ Validation

Après la modification, vous devez voir :
```
✏️ Fichier modifié : /path/to/claude-hooks-test/test.js
```

### 💡 Explication

- `event: "PostToolUse"` → Après utilisation d'un outil
- `tool: "Edit"` → Seulement quand Claude modifie un fichier
- `$FILE` → Variable automatique contenant le chemin du fichier

---

## 🚀 Exercice 3 : Hook avec Script Externe

### Objectif

Créer un script bash externe et l'appeler via un hook.

### Instructions

1. **Créer un dossier pour les scripts**

```bash
mkdir scripts
```

2. **Créer un script bash**

```bash
cat > scripts/log-edit.sh << 'EOF'
#!/bin/bash

# Récupérer variables
FILE=$1
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Logger dans un fichier
echo "[$TIMESTAMP] Fichier modifié : $FILE" >> edits.log

# Afficher message
echo "📝 Édition loggée dans edits.log"
EOF

chmod +x scripts/log-edit.sh
```

3. **Mettre à jour `settings.json`**

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash scripts/log-edit.sh $FILE"
    }
  ]
}
```

4. **Tester**

Demandez à Claude de modifier `test.js`, puis vérifiez :

```bash
cat edits.log
```

### ✅ Validation

`edits.log` doit contenir :
```
[2025-11-07 10:30:15] Fichier modifié : /path/to/test.js
```

### 💡 Explication

- Script bash externe = Logique réutilisable
- `$FILE` passé en argument au script
- Logs persistants pour traçabilité

---

## 🚀 Exercice 4 : Hooks Multiples

### Objectif

Combiner plusieurs hooks pour un workflow complet.

### Instructions

1. **Créer plusieurs scripts**

```bash
# Script bienvenue
cat > scripts/welcome.sh << 'EOF'
#!/bin/bash
echo "🚀 Claude Hooks Training - Session démarrée"
echo "📂 Projet : $(basename $(pwd))"
echo "🕐 Heure  : $(date)"
EOF

# Script post-edit
cat > scripts/post-edit.sh << 'EOF'
#!/bin/bash
echo "✅ Fichier $1 modifié avec succès"
echo "📊 Nombre d'éditions : $(cat edits.log 2>/dev/null | wc -l)"
EOF

chmod +x scripts/*.sh
```

2. **Configuration complète**

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "bash scripts/welcome.sh"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash scripts/log-edit.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash scripts/post-edit.sh $FILE"
    },
    {
      "event": "SessionEnd",
      "script": "echo '👋 Session terminée. Total éditions : $(cat edits.log | wc -l)'"
    }
  ]
}
```

3. **Tester le workflow complet**

- Démarrer Claude → Message de bienvenue
- Modifier des fichiers → Logs + compteur
- Fermer Claude → Résumé

### ✅ Validation

**Au démarrage** :
```
🚀 Claude Hooks Training - Session démarrée
📂 Projet : claude-hooks-test
🕐 Heure  : Thu Nov  7 10:30:15 CET 2025
```

**Après édition** :
```
📝 Édition loggée dans edits.log
✅ Fichier test.js modifié avec succès
📊 Nombre d'éditions : 3
```

**À la fermeture** :
```
👋 Session terminée. Total éditions : 3
```

---

## 🎓 Quiz de Validation

### Question 1
Quel événement se déclenche **avant** l'exécution d'un outil ?

- [ ] A) PostToolUse
- [ ] B) SessionStart
- [x] C) PreToolUse
- [ ] D) UserPromptSubmit

### Question 2
Quelle variable contient le chemin du fichier modifié ?

- [ ] A) $PATH
- [x] B) $FILE
- [ ] C) $FILENAME
- [ ] D) $DOCUMENT

### Question 3
Comment rendre un script bash exécutable ?

- [ ] A) sudo script.sh
- [x] B) chmod +x script.sh
- [ ] C) exec script.sh
- [ ] D) run script.sh

### Question 4
Où placer `settings.json` pour hooks projet-specific ?

- [ ] A) ~/.claude/settings.json
- [x] B) .claude/settings.json
- [ ] C) /etc/claude/settings.json
- [ ] D) claude-settings.json

---

## 🏆 Challenge Bonus

### Mini-Projet : Hook de Validation

Créer un hook qui :
1. Compte le nombre de lignes modifiées
2. Affiche un warning si > 100 lignes
3. Log tout dans `big-changes.log`

**Indices** :
- Utiliser `wc -l $FILE`
- Condition bash : `if [ $LINES -gt 100 ]; then ... fi`
- Logger avec `echo "..." >> big-changes.log`

### Solution (à essayer d'abord !)

<details>
<summary>Voir la solution</summary>

```bash
# scripts/validate-size.sh
#!/bin/bash

FILE=$1
LINES=$(wc -l < "$FILE")

if [ $LINES -gt 100 ]; then
  echo "⚠️ WARNING: $FILE contient $LINES lignes (> 100)"
  echo "[$(date)] $FILE - $LINES lignes" >> big-changes.log
else
  echo "✅ $FILE : $LINES lignes (OK)"
fi
```

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash scripts/validate-size.sh $FILE"
    }
  ]
}
```

</details>

---

## 📚 Ressources

- 📖 [Guide Hooks Complet](../guide.md)
- 📋 [Cheatsheet Hooks](../cheatsheet.md)
- 🎯 [Niveau 2 : Filtrage & Patterns](./niveau-2.md)

---

**🎉 Bravo !** Vous maîtrisez les bases des hooks. Passez au [Niveau 2](./niveau-2.md) pour apprendre le filtrage avancé ! 🚀
