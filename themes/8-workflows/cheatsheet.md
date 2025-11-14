# 🔄 Workflows - Cheatsheet

> **Référence rapide Workflows**

## ⚡ Quick Start

Workflow = orchestration commands + agents + hooks

## 📋 Pattern Standard

1. Command déclencheur (`/deploy`)
2. Agents spécialisés (build, test)
3. Hooks validation (pre/post)
4. Résultat orchestré

## 🎯 Exemple

```
/deploy production
  ↓ PreToolUse Hook (security check)
  ↓ Agent: build-manager
  ↓ Agent: test-runner
  ↓ Deploy
  ↓ PostToolUse Hook (notify)
```

---

📖 [Guide](./guide.md)
