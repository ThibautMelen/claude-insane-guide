# 🟠 Niveau 3 : Workflows Complexes

> **Objectif** : Créer command avec workflow multi-étapes
> **Durée** : 20-25 min

## 🎯 Objectif

Implémenter workflow EPCT complet.

## 📋 Exercice

1. **Command EPCT**
```markdown
---
name: epct
description: Explore/Plan/Code/Test workflow
arguments:
  - name: feature
    description: Feature à implémenter
    required: true
---

# EPCT Workflow : {feature}

## E - Explore
1. Analyse architecture existante
2. Identifie fichiers concernés
3. Comprend patterns utilisés

## P - Plan
1. Propose approche détaillée
2. Liste fichiers à modifier
3. Identifie dépendances

## C - Code
1. Implémente selon plan
2. Suit conventions projet
3. Ajoute commentaires

## T - Test
1. Crée tests unitaires
2. Vérifie edge cases
3. Valide résultat
```

2. **Tester**
```
/epct "Login form avec validation"
```

## ✅ Validation

Claude suit workflow complet avec 4 étapes.

## 🏆 Challenge

Créer `/refactor <file>` avec analyse + plan + code.

---

📖 [Niveau 4](./niveau-4.md) →
