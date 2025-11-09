# 🎮 Theme 10 : Interactive UI avec AskUserQuestion

## 🎯 Objectif

**Transformer Claude Code en assistant interactif intelligent** capable de prendre des décisions complexes avec l'utilisateur à travers des dialogues structurés et contextuels.

> **Temps estimé** : 1h30 (guide 45min + exercices 45min)
> **Prérequis** : Themes 1-2 (Memory & Commands)
> **Niveau** : Intermédiaire → Expert

---

## 🚀 Cas Réels Impressionnants

### 💎 Exemple 1: Migration Cloud Complète (10+ étapes)

Regardez comment AskUserQuestion peut orchestrer une migration cloud complexe :

```javascript
// 🎯 Résultat: Configuration complète AWS/GCP/Azure en 3 minutes

const migrateToCloud = async () => {
  // Étape 1: Analyse du contexte projet
  const context = await ask([{
    question: "Quelle est la nature de votre application ?",
    header: "Type app",
    multiSelect: false,
    options: [
      { label: "SaaS B2B", description: "Multi-tenant, haute disponibilité, compliance" },
      { label: "E-commerce", description: "Pics de trafic, CDN, paiements sécurisés" },
      { label: "API/Backend", description: "Microservices, scalabilité horizontale" },
      { label: "Site statique", description: "JAMstack, CDN, serverless" }
    ]
  }]);

  // Étape 2: Choix provider (adapté au contexte)
  const provider = await ask({
    question: `Pour votre ${context["Type app"]}, quel cloud provider ?`,
    header: "Provider",
    options: getProvidersForAppType(context["Type app"])
    // AWS pour enterprise, Vercel pour JAMstack, etc.
  });

  // Étape 3-10: Configuration progressive basée sur les choix
  // - Régions, zones
  // - Services (DB, Cache, CDN)
  // - Monitoring & Logging
  // - CI/CD pipeline
  // - Budget & Scaling
  // - Security & Compliance

  return generateTerraformConfig(allAnswers);
};
```

**Impact réel** :
- ✅ 2 heures → 3 minutes
- ✅ Zéro erreur de configuration
- ✅ Best practices automatiques
- ✅ Documentation générée

### 🛠️ Exemple 2: Setup Monorepo Entreprise

```javascript
// 🎯 Configuration complète Turborepo/Nx avec 15+ packages

const setupMonorepo = async () => {
  // Decision tree complexe avec 20+ branches possibles

  const decisions = await orchestrateSetup([
    "Structure",      // apps/*, packages/*, tools/*
    "Tooling",        // Turborepo vs Nx vs pnpm
    "TypeScript",     // Config partagée, paths, strict mode
    "Testing",        // Jest vs Vitest, E2E strategy
    "Linting",        // ESLint + Prettier config
    "CI/CD",          // GitHub Actions vs CircleCI
    "Deployment"      // Vercel vs AWS vs self-hosted
  ]);

  // Génère 50+ fichiers de config automatiquement
  await generateMonorepoStructure(decisions);
};
```

### 🏗️ Exemple 3: Wizard Onboarding Développeur

```javascript
// 🎯 Onboarding complet nouveau dev en 5 minutes

const onboardDeveloper = async () => {
  // Profil détection intelligente
  const profile = await detectDeveloperProfile();

  // Questions adaptatives basées sur le profil
  if (profile.level === "senior") {
    // Questions architecture, patterns, optimisation
  } else if (profile.level === "junior") {
    // Questions setup, tutorials, mentoring
  }

  // Génère:
  // - .claude/CLAUDE.md personnalisé
  // - Commands adaptées au rôle
  // - Git hooks configurés
  // - Extensions VS Code
  // - Documentation projet
};
```

---

## 📊 Architecture & Patterns

### 🎯 Pattern 1: Sequential Chaining (Linéaire)

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│   Q1    │───▶│   Q2    │───▶│   Q3    │───▶│  Result │
└─────────┘    └─────────┘    └─────────┘    └─────────┘
     ▲              ▲              ▲
     │              │              │
  Context       Filtered       Optimized
```

**Cas d'usage**: Wizards de configuration, setup progressif

```javascript
// Implémentation
const answers = {};

// Q1: Base
answers.framework = await ask("Framework?", ["Next.js", "Nuxt", "SvelteKit"]);

// Q2: Filtré par Q1
if (answers.framework === "Next.js") {
  answers.router = await ask("Router?", ["App Router", "Pages Router"]);
}

// Q3: Optimisé pour Q1+Q2
answers.features = await ask({
  question: "Features to enable?",
  multiSelect: true,
  options: getFeaturesForSetup(answers)
});
```

### 🔀 Pattern 2: Conditional Branching (Arbre)

```
                    ┌─────────┐
                    │   Q1    │
                    └────┬────┘
                         │
                    ┌────▼────┐
                    │ Switch  │
                    └────┬────┘
                         │
            ┌────────────┼────────────┐
            │            │            │
       ┌────▼───┐   ┌───▼────┐  ┌───▼────┐
       │  Path A │   │ Path B  │  │ Path C  │
       └────┬───┘   └────┬────┘  └────┬────┘
            │            │             │
       ┌────▼───┐   ┌───▼────┐       │
       │   Q2a  │   │   Q2b   │       │
       └────┬───┘   └────┬────┘       │
            │            │             │
            └────────────┴─────────────┘
                         │
                    ┌────▼────┐
                    │  Merge   │
                    └─────────┘
```

**Cas d'usage**: Troubleshooting, diagnostic, parcours adaptatifs

### ⚡ Pattern 3: Parallel Batching

```javascript
// 4 questions simultanées (max API)
const config = await ask([
  { question: "Project name?", header: "Name", ... },
  { question: "Framework?", header: "Framework", ... },
  { question: "Features?", header: "Features", multiSelect: true, ... },
  { question: "Deploy target?", header: "Deploy", ... }
]);

// Traitement parallèle des réponses
await Promise.all([
  setupFramework(config["Framework?"]),
  enableFeatures(config["Features?"]),
  configureDeployment(config["Deploy target?"])
]);
```

### 🧠 Pattern 4: Intelligent Defaults

```javascript
const smartDefaults = async () => {
  // Détection contexte
  const detected = {
    hasTypeScript: await fileExists("tsconfig.json"),
    hasReact: packageHas("react"),
    hasTests: await folderExists("__tests__")
  };

  // Questions adaptées avec defaults intelligents
  const setup = await ask({
    question: "TypeScript configuration?",
    options: [
      {
        label: detected.hasTypeScript ? "Upgrade (detected)" : "Add TypeScript",
        description: detected.hasTypeScript
          ? "Update to latest with strict mode"
          : "Setup TypeScript with recommended config"
      }
    ]
  });
};
```

### 🔄 Pattern 5: Progressive Disclosure

```javascript
const progressiveSetup = async () => {
  // Niveau 1: Simple
  const basic = await ask("Quick or Custom setup?", ["Quick (defaults)", "Custom"]);

  if (basic === "Quick (defaults)") {
    return applyDefaults();
  }

  // Niveau 2: Intermédiaire
  const intermediate = await ask([
    { question: "Framework?", ... },
    { question: "Database?", ... }
  ]);

  // Niveau 3: Avancé (si nécessaire)
  if (needsAdvancedConfig(intermediate)) {
    const advanced = await ask([
      { question: "Caching strategy?", ... },
      { question: "Monitoring?", ... },
      { question: "Security policies?", ... }
    ]);
  }
};
```

---

## 🔧 API & Configuration

### 📋 Structure de Base

```typescript
interface Question {
  question: string;        // La question complète (avec ?)
  header: string;         // Label court (≤12 chars)
  multiSelect: boolean;   // Sélection multiple
  options: Option[];      // 2-4 options
}

interface Option {
  label: string;          // Texte affiché (1-5 mots)
  description: string;    // Explication détaillée
}

interface Response {
  [question: string]: string | string[];  // string[] si multiSelect
}
```

### ⚙️ Contraintes Techniques

```
╔═══════════════════╦══════════╦══════════╦════════════╗
║ Paramètre         ║ Minimum  ║ Maximum  ║ Optimal    ║
╠═══════════════════╬══════════╬══════════╬════════════╣
║ Questions/appel   ║ 1        ║ 4        ║ 2-3        ║
║ Options/question  ║ 2        ║ 4        ║ 3          ║
║ Header length     ║ 1 char   ║ 12 chars ║ 6-10 chars ║
║ Label length      ║ 1 mot    ║ 5 mots   ║ 1-2 mots   ║
║ Description       ║ -        ║ ~200chr  ║ 50-100 chr ║
╚═══════════════════╩══════════╩══════════╩════════════╝
```

### 🎯 Utilisation Optimale

```javascript
// ✅ BON: Questions contextuelles avec descriptions
const database = await ask({
  question: "Which database for your e-commerce platform?",
  header: "Database",
  multiSelect: false,
  options: [
    {
      label: "PostgreSQL",
      description: "ACID compliant, complex queries, proven at scale"
    },
    {
      label: "MongoDB",
      description: "Flexible schema, horizontal scaling, good for catalogs"
    },
    {
      label: "Supabase",
      description: "PostgreSQL + Auth + Realtime + Storage built-in"
    }
  ]
});

// ❌ MAUVAIS: Trop vague, pas de contexte
const db = await ask("Database?", ["PostgreSQL", "MongoDB", "MySQL"]);
```

---

## 💡 Best Practices

### ✅ DO: Donner du Contexte

```javascript
// Toujours expliquer POURQUOI et les CONSÉQUENCES
options: [
  {
    label: "Strict Mode",
    description: "Catch more bugs, slower initial build (+30s), recommended for production"
  },
  {
    label: "Loose Mode",
    description: "Faster builds, may miss type errors, good for prototyping"
  }
]
```

### ✅ DO: Adapter au Contexte

```javascript
// Détecter et s'adapter
const hasExistingConfig = await fileExists(".env");

if (hasExistingConfig) {
  const action = await ask(
    "Existing .env detected. How to proceed?",
    ["Backup & Replace", "Merge configs", "Keep existing"]
  );
}
```

### ✅ DO: Valider les Réponses

```javascript
const port = await ask("Which port?", ["3000", "8080", "Custom"]);

if (port === "Custom") {
  // Validation supplémentaire
  const customPort = await ask("Enter port (1024-65535):", ...);
  if (!isValidPort(customPort)) {
    // Retry with guidance
  }
}
```

### ❌ DON'T: Questions Répétitives

```javascript
// MAUVAIS: Même question en boucle
for (const file of files) {
  await ask(`Process ${file}?`, ["Yes", "No"]);
}

// BON: Une question multi-select
const toProcess = await ask({
  question: "Which files to process?",
  multiSelect: true,
  options: files.map(f => ({ label: f, description: getFileInfo(f) }))
});
```

### ❌ DON'T: Ignorer les Erreurs

```javascript
// MAUVAIS
const choice = await ask(...);
executeChoice(choice); // Peut crasher

// BON
try {
  const choice = await ask(...);
  await executeChoice(choice);
} catch (error) {
  const recovery = await ask(
    `Error: ${error.message}. How to proceed?`,
    ["Retry", "Skip", "Abort"]
  );
}
```

---

## 🎓 Points Clés à Retenir

### 🌟 Concepts Essentiels

1. **Progressive Disclosure** : Montrer la complexité graduellement
2. **Context Awareness** : S'adapter à l'environnement existant
3. **Intelligent Defaults** : Proposer des choix pertinents
4. **Error Recovery** : Toujours offrir des sorties de secours
5. **Batch Operations** : Grouper les questions liées (max 4)

### 📊 Patterns Principaux

```
Sequential → Configuration wizards
Branching  → Troubleshooting, diagnostic
Parallel   → Collection d'infos indépendantes
Progressive → Onboarding adaptatif
Validation → Saisie de données critiques
```

### 🚀 Optimisations Performances

- **Token Usage** : Descriptions concises mais informatives
- **Batching** : 4 questions max par appel
- **Caching** : Réutiliser les réponses dans la conversation
- **Smart Defaults** : Réduire les questions via détection

### ⚠️ Limitations à Connaître

- Maximum 4 questions par appel
- Maximum 4 options par question
- Header limité à 12 caractères
- Pas de validation custom inline
- "Other" toujours ajouté automatiquement

---

## 📚 Ressources & Suite

### 🔗 Documentation Avancée

- **[Patterns Multi-Dialog Avancés](../../advanced/multi-dialog-patterns.md)** : Decision trees complexes, validation chains
- **[Showcase Supernovae Studio](../../showcase/supernovae-studio/)** : Implémentation production réelle
- **[Cheatsheet](./cheatsheet.md)** : Référence rapide API

### 🎯 Prochaines Étapes

1. **Exercices Pratiques** :
   - 🟢 [Niveau 1](./exercices/niveau-1.md) : Dialog simple (15 min)
   - 🟡 [Niveau 2](./exercices/niveau-2.md) : Wizard multi-étapes (20 min)
   - 🟠 [Niveau 3](./exercices/niveau-3.md) : Branching conditionnel (25 min)
   - 🔴 [Niveau 4](./exercices/niveau-4.md) : Decision tree complet (30 min)

2. **Projets Suggérés** :
   - Créer un wizard de setup pour votre stack
   - Implémenter un diagnostic interactif
   - Builder un configurateur de CI/CD

### 💬 Communauté

- [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)
- [Discord Claude Code](https://discord.gg/claude-code)
- Partagez vos patterns : #AskUserQuestion

---

> 🎯 **Challenge Final** : Créez un wizard de 10+ étapes pour configurer entièrement un projet
> Next.js 14 avec : App Router, TypeScript, Tailwind, Supabase, Auth, Stripe, Tests, CI/CD.
> Partagez votre implémentation !