# Interactive UI - AskUserQuestion Patterns

**Niveau** : Expert
**Prérequis** : Commands, Multi-Dialog Patterns

---

## 📚 Vue d'Ensemble

L'**Interactive UI** transforme Claude Code en assistant intelligent capable de prendre des décisions complexes avec l'utilisateur via des dialogues structurés.

**Outil principal** : `AskUserQuestion`

```
Workflow Traditionnel:
└─> Claude devine ou fait des suppositions ❌

Workflow Interactif:
├─> Claude pose questions structurées
├─> Utilisateur choisit parmi options claires
├─> Décisions basées sur réponses
└─> Résultat précis et adapté ✅
```

---

## 🎯 Cas d'Usage

### 1. Migration Cloud Wizard

```javascript
// 10+ étapes de configuration interactive
const migration = await askUserQuestion({
  questions: [
    {
      question: "Quel type d'application migrez-vous ?",
      header: "App Type",
      options: [
        { label: "SaaS B2B", description: "Multi-tenant, HA" },
        { label: "E-commerce", description: "Pics trafic, CDN" },
        { label: "API Backend", description: "Microservices" }
      ]
    },
    // ... 9 autres étapes adaptées au type choisi
  ]
});
```

**Résultat** : Configuration Terraform complète en 3 minutes (vs 2 heures manuel)

### 2. Monorepo Setup

```javascript
// Decision tree 20+ branches
const setup = await orchestrateMonorepo([
  "Structure (apps/packages/tools)",
  "Tooling (Turborepo/Nx/pnpm)",
  "TypeScript config",
  "Testing strategy",
  "CI/CD pipeline"
]);
// → Génère 50+ fichiers config automatiquement
```

### 3. Onboarding Développeur

```javascript
// Profil detection + questions adaptatives
const profile = await detectDeveloperProfile();
const onboarding = await customizeOnboarding(profile);
// → Setup complet en 5 minutes
```

---

## 🏗️ Anatomie AskUserQuestion

```typescript
AskUserQuestion({
  questions: [
    {
      question: "Question claire et spécifique ?",
      header: "Label court (max 12 chars)",
      multiSelect: false, // true pour choix multiples
      options: [
        {
          label: "Option 1",
          description: "Explication + implications"
        },
        {
          label: "Option 2",
          description: "Trade-offs clairs"
        }
      ]
    }
  ]
})
```

**Best Practices** :
- ✅ 2-4 options par question (pas plus)
- ✅ Descriptions claires des implications
- ✅ Labels courts et explicites
- ✅ Questions progressives (pas tout d'un coup)
- ✅ Validation à chaque étape critique

---

## 📊 Patterns Avancés

### Sequential Chaining

```
Question 1 → Réponse → Question 2 (adaptée) → Réponse → ...
```

Voir [Multi-Dialog Patterns](./multi-dialog-patterns.md)

### Conditional Branching

```
Question générale
├─ Si réponse A → Questions spécifiques A
├─ Si réponse B → Questions spécifiques B
└─ Si réponse C → Questions spécifiques C
```

### Validation Chains

```
Question → Réponse → Validation
                      ├─ Valid → Continue
                      └─ Invalid → Re-ask (contexte amélioré)
```

---

## 🎯 Quand Utiliser

**✅ Utiliser Interactive UI pour** :
- Configuration complexe (10+ décisions)
- Decision trees (branches multiples)
- Workflows adaptatifs (réponses influencent suite)
- Validation critique (destructive operations)
- Onboarding/Setup wizards

**❌ Ne PAS utiliser pour** :
- Questions simples oui/non (demander directement)
- Choix évidents (utiliser Memory/conventions)
- Workflows linéaires simples (Commands suffisent)

---

## 💡 Exemples Concrets

### Command avec AskUserQuestion

```markdown
# .claude/commands/setup-project.md
---
description: Setup new project with interactive wizard
---

Use AskUserQuestion to configure:
1. Project type (Web app, CLI, Library, etc.)
2. Framework based on type
3. Testing strategy
4. CI/CD preferences
5. Deployment target

Then generate complete project structure automatically.
```

### Agent avec Validation

```markdown
# .claude/agents/destructive-task.md

For destructive operations, use AskUserQuestion to:
1. Show what will be deleted/modified
2. Ask confirmation with clear consequences
3. Provide rollback option if available
```

---

## 📚 Ressources

### Documentation Officielle
- 📄 [AskUserQuestion API](https://code.claude.com/docs/en/tools#askuserquestion)
- 📄 [Best Practices Interactive](https://www.anthropic.com/engineering/claude-code-best-practices)

### Patterns Connexes
- 🎓 [Multi-Dialog Patterns](./multi-dialog-patterns.md) - Sequential, Conditional, Parallel
- 🚀 [Workflows](../workflow-pattern-orchestration/README.md) - Orchestration complète
- 🏗️ [Command-Agent-Skill](../patterns/command-agent-skill.md) - Hierarchical coordination

### Articles
- 📝 [Multi-Dialog Patterns Note](https://share.note.sx/8k50udm8#ME3MD6walWogaQZxAVIdsAMaYPFQvw694zbFb622c0Y)

---

## 🎓 Points Clés

✅ **AskUserQuestion** = Dialogue structuré avec options claires
✅ **Progressive** = Questions adaptées aux réponses précédentes
✅ **Validation** = Confirmation avant opérations critiques
✅ **Multi-dialog** = Enchaînements complexes (10+ étapes)
✅ **Production-ready** = Wizards, setup, onboarding, migration

**Impact** : Configuration 2h → 3 minutes avec zéro erreur ✨

---

**Prochaines Étapes** :
1. Lire [Multi-Dialog Patterns](./multi-dialog-patterns.md)
2. Créer votre premier wizard interactif
3. Combiner avec [Workflows](../workflow-pattern-orchestration/README.md) pour orchestration complète
