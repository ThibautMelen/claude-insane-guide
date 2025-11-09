# 📋 Cheatsheet - AskUserQuestion

## ⚡ Quick Reference

### 🔧 API Basique

```javascript
// Single question
const answer = await ask(
  "Question text?",
  ["Option 1", "Option 2", "Option 3"]
);

// With descriptions
const answer = await ask({
  question: "Your question here?",
  header: "ShortLabel",  // ≤12 chars
  multiSelect: false,     // ou true pour multi-sélection
  options: [
    { label: "Option 1", description: "Details about option 1" },
    { label: "Option 2", description: "Details about option 2" }
  ]
});

// Multiple questions (max 4)
const answers = await ask([
  { question: "Q1?", header: "Label1", ... },
  { question: "Q2?", header: "Label2", ... }
]);
```

### 📊 Contraintes

| Élément | Min | Max | Optimal |
|---------|-----|-----|---------|
| Questions/appel | 1 | 4 | 2-3 |
| Options/question | 2 | 4 | 3 |
| Header | 1 char | 12 chars | 6-10 |
| Label | 1 mot | 5 mots | 1-2 |

---

## 🎯 Patterns Essentiels

### 1️⃣ Sequential (Linéaire)
```javascript
const q1 = await ask("Question 1?", [...]);
const q2 = await ask("Question 2?", [...]);
const q3 = await ask("Question 3?", [...]);
```

### 2️⃣ Conditional (Branching)
```javascript
const type = await ask("Type?", ["Simple", "Advanced"]);

if (type === "Advanced") {
  const advanced = await ask("Advanced options?", [...]);
} else {
  const simple = await ask("Simple setup?", [...]);
}
```

### 3️⃣ Parallel (Batching)
```javascript
const config = await ask([
  { question: "Name?", header: "Name", ... },
  { question: "Type?", header: "Type", ... },
  { question: "Features?", header: "Features", multiSelect: true, ... }
]);
```

### 4️⃣ Multi-Select
```javascript
const features = await ask({
  question: "Which features to enable?",
  header: "Features",
  multiSelect: true,  // ← Important
  options: [
    { label: "Auth", description: "User authentication" },
    { label: "DB", description: "Database integration" },
    { label: "API", description: "API endpoints" }
  ]
});
// Returns: string[] au lieu de string
```

### 5️⃣ With Validation
```javascript
const port = await ask("Port?", ["3000", "8080", "Custom"]);

if (port === "Custom") {
  let validPort = false;
  while (!validPort) {
    const custom = await ask("Enter port:", ...);
    if (isValidPort(custom)) {
      validPort = true;
    } else {
      await ask("Invalid. Retry?", ["Yes", "Cancel"]);
    }
  }
}
```

---

## 💡 Best Practices

### ✅ DO

```javascript
// Contexte clair
options: [
  {
    label: "PostgreSQL",
    description: "ACID, relations, mature (best for complex queries)"
  }
]

// Adaptive questions
const existing = detectExisting();
if (existing) {
  await ask(`Found ${existing}. Replace?`, ...);
}

// Error handling
try {
  await execute(answer);
} catch (e) {
  await ask(`Error: ${e}. Retry?`, ...);
}
```

### ❌ DON'T

```javascript
// Pas de contexte
await ask("DB?", ["psql", "mongo"]);

// Trop d'options
await ask("Choose:", [opt1, opt2, opt3, opt4, opt5]); // Max 4!

// Questions répétitives
for (file of files) {
  await ask(`Process ${file}?`, ...); // Use multiSelect instead
}
```

---

## 🔍 Response Format

```typescript
// Single select
{ "Question?": "Selected option" }

// Multi-select
{ "Question?": ["Option1", "Option2"] }

// Multiple questions
{
  "Question 1?": "Answer 1",
  "Question 2?": ["Multi", "Select"],
  "Question 3?": "Answer 3"
}
```

---

## 🎨 UI Guidelines

### Headers (Labels Courts)
```
✅ "Framework"    (9 chars)
✅ "DB"           (2 chars)
✅ "Deploy"       (6 chars)
❌ "DeploymentTarget" (16 chars - trop long!)
```

### Option Labels
```
✅ "Next.js"      (1 mot)
✅ "App Router"   (2 mots)
❌ "Next.js App Router with TypeScript" (6 mots)
```

### Descriptions
```
✅ "Fast builds, zero-config, Vercel optimized" (40 chars)
❌ "This option provides fast builds with zero configuration needed and is specifically optimized for deployment on Vercel's platform with automatic optimizations" (160 chars)
```

---

## 🚀 Advanced Patterns

### Decision Tree
```javascript
const tree = {
  root: "Project type?",
  branches: {
    "Web App": ["Next.js", "Nuxt", "SvelteKit"],
    "API": ["Express", "Fastify", "Nest.js"],
    "Mobile": ["React Native", "Flutter", "Native"]
  }
};

const type = await ask(tree.root, Object.keys(tree.branches));
const framework = await ask("Framework?", tree.branches[type]);
```

### Progressive Disclosure
```javascript
const level = await ask("Setup level?", ["Quick", "Custom", "Expert"]);

const config = {
  quick: 1,   // 1 question
  custom: 3,  // 3 questions
  expert: 10  // 10 questions
}[level];

for (let i = 0; i < config; i++) {
  // Ask progressively more detailed questions
}
```

### Smart Defaults
```javascript
const detected = {
  typescript: fileExists("tsconfig.json"),
  testing: fileExists("jest.config.js"),
  docker: fileExists("Dockerfile")
};

const options = Object.entries(detected)
  .filter(([_, exists]) => !exists)
  .map(([tech, _]) => ({
    label: `Add ${tech}`,
    description: `Setup ${tech} with best practices`
  }));

if (options.length > 0) {
  await ask("Add missing tools?", options);
}
```

---

## 🛠️ Utility Functions

```javascript
// Helper: Format options quickly
const quickOptions = (items, descriptions) =>
  items.map((item, i) => ({
    label: item,
    description: descriptions?.[i] || ""
  }));

// Helper: Conditional questions
const askIf = async (condition, question, options) => {
  if (condition) {
    return await ask(question, options);
  }
  return null;
};

// Helper: Retry on error
const askWithRetry = async (question, options, validator) => {
  let valid = false;
  let answer;

  while (!valid) {
    answer = await ask(question, options);
    if (validator(answer)) {
      valid = true;
    } else {
      const retry = await ask("Invalid. Retry?", ["Yes", "Cancel"]);
      if (retry === "Cancel") throw new Error("Cancelled");
    }
  }

  return answer;
};
```

---

## 📝 Common Scenarios

```javascript
// Database selection
const db = await ask({
  question: "Database for your app?",
  header: "Database",
  options: [
    { label: "PostgreSQL", description: "ACID, complex queries" },
    { label: "MongoDB", description: "Flexible, horizontal scale" },
    { label: "SQLite", description: "Embedded, zero-config" },
    { label: "None", description: "Skip database setup" }
  ]
});

// Feature flags
const features = await ask({
  question: "Enable features?",
  header: "Features",
  multiSelect: true,
  options: [
    { label: "Auth", description: "User authentication" },
    { label: "i18n", description: "Multi-language support" },
    { label: "PWA", description: "Progressive Web App" }
  ]
});

// Environment setup
const env = await ask({
  question: "Target environment?",
  header: "Environment",
  options: [
    { label: "Development", description: "Local, hot-reload" },
    { label: "Staging", description: "Pre-prod testing" },
    { label: "Production", description: "Optimized, minified" }
  ]
});
```

---

## ⚠️ Notes Importantes

1. **"Other" automatique** : Toujours ajouté par le système
2. **Réponses dans contexte** : Accessibles durant toute la conversation
3. **Pas de validation inline** : Faire la validation après réception
4. **Token optimization** : Descriptions concises mais claires
5. **UX First** : Clarté > Brièveté

---

> 💡 **Pro Tip** : Utilisez `multiSelect: true` pour réduire le nombre d'interactions
> et améliorer l'UX quand plusieurs choix sont possibles.