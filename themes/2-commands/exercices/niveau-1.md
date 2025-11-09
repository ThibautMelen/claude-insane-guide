# 🟢 Niveau 1 : Première Command

> **Objectif** : Créer votre première slash command fonctionnelle
> **Durée** : 10-15 min

## 🎯 Objectif

Créer et utiliser une command simple sans arguments.

## 📋 Exercice

1. **Créer structure**
```bash
mkdir -p .claude/commands
```

2. **Créer première command**
```markdown
---
name: hello
description: Dire bonjour
---

Dis bonjour à l'utilisateur de manière amicale et professionnelle.
```

3. **Tester**
```
/hello
```

## ✅ Validation

Claude répond avec un message amical.

## 🏆 Challenge

Créer `/status` qui affiche l'état du projet (Git, tests, build).

---

📖 [Niveau 2](./niveau-2.md) →
