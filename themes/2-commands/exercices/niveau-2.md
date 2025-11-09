# 🟡 Niveau 2 : Commands avec Arguments

> **Objectif** : Créer commands avec paramètres dynamiques
> **Durée** : 15-20 min

## 🎯 Objectif

Maîtriser les arguments dans commands.

## 📋 Exercice

1. **Command avec 1 argument**
```markdown
---
name: create-component
description: Créer un composant React
arguments:
  - name: componentName
    description: Nom du composant
    required: true
---

Crée un composant React **{componentName}** avec :
- Fichier .tsx
- Props TypeScript
- Export named
```

2. **Tester**
```
/create-component Button
```

## ✅ Validation

Composant créé avec nom correct.

## 🏆 Challenge

Créer `/create-api <endpoint> <method>` avec 2 arguments.

---

📖 [Niveau 3](./niveau-3.md) →
