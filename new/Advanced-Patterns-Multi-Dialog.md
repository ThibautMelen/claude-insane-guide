# AskUserQuestion - Advanced Patterns: Multi-Dialog & Decision Trees

> **Version:** 2.0.0
> **Date:** 2025-11-08
> **Basé sur:** Anthropic 2025 Best Practices + Context7 Research

---

## Table des Matières

1. [Multi-Dialog Patterns](#multi-dialog-patterns)
2. [Decision Tree Architectures](#decision-tree-architectures)
3. [Real-World Complex Examples](#real-world-complex-examples)
4. [Testing & Validation](#testing--validation)

---

## Multi-Dialog Patterns

Les patterns multi-dialogues permettent d'enchaîner plusieurs `AskUserQuestion` de manière intelligente et contextuelle.

### Pattern 1: Sequential Chaining (Chaîne Séquentielle Simple)

**Cas d'usage:** Chaque question dépend de la précédente, progression linéaire.

<example>
<context>
User configure un nouveau projet API. Chaque choix influence les options suivantes.
</context>

<thinking>
**Analyse du problème:**
- 7 questions totales (dépasse limite de 4)
- Chaque réponse filtre les options suivantes
- Besoin de validation inter-questions

**Stratégie:**
1. Batching intelligent : 3 questions → 3 questions → 1 confirmation
2. Utiliser les réponses précédentes comme contexte
3. Validation après chaque batch

**Critères de succès:**
✅ Pas de questions inutiles (filtrées par contexte)
✅ Temps total < 4 minutes
✅ Configuration valide garantie
</thinking>

<implementation>
```javascript
async function setupAPIProject() {
  // ═══════════════════════════════════════════════════════
  // BATCH 1: Core Architecture (3 questions)
  // ═══════════════════════════════════════════════════════

  const batch1 = await AskUserQuestion({
    questions: [
      {
        question: "What type of API are you building?",
        header: "API Type",
        multiSelect: false,
        options: [
          {
            label: "REST API",
            description: "Resource-based, HTTP verbs, stateless, cacheable, widely supported"
          },
          {
            label: "GraphQL API",
            description: "Query language, single endpoint, typed schema, flexible queries"
          },
          {
            label: "tRPC",
            description: "End-to-end type safety, TypeScript only, RPC style"
          },
          {
            label: "gRPC",
            description: "Binary protocol, high performance, streaming support, protobuf"
          }
        ]
      },
      {
        question: "Which programming language?",
        header: "Language",
        multiSelect: false,
        options: [
          { label: "TypeScript", description: "Type safety, modern tooling, great DX" },
          { label: "JavaScript", description: "Simpler, faster iteration, no build step" },
          { label: "Python", description: "FastAPI, async support, ML integration" },
          { label: "Go", description: "Performance, concurrency, compiled" }
        ]
      },
      {
        question: "Expected scale?",
        header: "Scale",
        multiSelect: false,
        options: [
          { label: "Small (<1k req/day)", description: "Simple hosting, low cost" },
          { label: "Medium (1k-100k)", description: "Load balancing, caching" },
          { label: "Large (100k-1M)", description: "Horizontal scaling, CDN" },
          { label: "Massive (>1M)", description: "Multi-region, edge computing" }
        ]
      }
    ]
  });

  // Extract answers
  const apiType = batch1["What type of API are you building?"];
  const language = batch1["Which programming language?"];
  const scale = batch1["Expected scale?"];

  // ═══════════════════════════════════════════════════════
  // BATCH 2: Infrastructure (3 questions, FILTERED by Batch 1)
  // ═══════════════════════════════════════════════════════

  // Conditional framework options based on API type + language
  const getFrameworkOptions = () => {
    if (apiType === "REST API" && language === "TypeScript") {
      return [
        { label: "Express", description: "Minimal, flexible, huge ecosystem" },
        { label: "Fastify", description: "Fast, schema-based, plugins" },
        { label: "NestJS", description: "Angular-like, structured, enterprise" },
        { label: "Hono", description: "Ultra-light, edge-first, fast" }
      ];
    } else if (apiType === "GraphQL API" && language === "TypeScript") {
      return [
        { label: "Apollo Server", description: "Full-featured, caching, federation" },
        { label: "Pothos", description: "Code-first, type-safe schema builder" },
        { label: "GraphQL Yoga", description: "Flexible, plugins, SSE support" }
      ];
    } else if (apiType === "tRPC") {
      return [
        { label: "tRPC Standalone", description: "No framework, max control" },
        { label: "Next.js + tRPC", description: "Full-stack, API routes" },
        { label: "Express + tRPC", description: "Traditional backend" }
      ];
    }
    // ... autres combinaisons
  };

  const batch2 = await AskUserQuestion({
    questions: [
      {
        question: `Which ${apiType} framework for ${language}?`,
        header: "Framework",
        multiSelect: false,
        options: getFrameworkOptions()
      },
      {
        question: "Database choice?",
        header: "Database",
        multiSelect: false,
        options: [
          { label: "PostgreSQL", description: "Relational, ACID, JSON support" },
          { label: "MongoDB", description: "Document store, flexible schema" },
          { label: "Redis", description: "In-memory, caching, pub/sub" },
          { label: "None", description: "Stateless API, no DB needed" }
        ]
      },
      {
        question: "Hosting platform?",
        header: "Hosting",
        multiSelect: false,
        options: getHostingOptions(scale) // Filtered by scale
      }
    ]
  });

  const framework = batch2[`Which ${apiType} framework for ${language}?`];
  const database = batch2["Database choice?"];
  const hosting = batch2["Hosting platform?"];

  // ═══════════════════════════════════════════════════════
  // BATCH 3: Features & Security (1 confirmation question)
  // ═══════════════════════════════════════════════════════

  const summary = `
📋 Configuration Summary
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 Architecture
   API Type:    ${apiType}
   Language:    ${language}
   Framework:   ${framework}

💾 Data & Scale
   Database:    ${database}
   Scale:       ${scale}
   Hosting:     ${hosting}

📦 Estimated Setup
   Time:        ${estimateSetupTime({ apiType, framework, database })}
   Cost/month:  ${estimateMonthlyCost({ scale, hosting, database })}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
`;

  const confirmation = await AskUserQuestion({
    questions: [{
      question: summary + "\n\nProceed with this configuration?",
      header: "Confirm",
      multiSelect: false,
      options: [
        {
          label: "Yes, create project",
          description: "Generate project structure with these settings"
        },
        {
          label: "Modify architecture",
          description: "Go back to API type/language/scale"
        },
        {
          label: "Modify infrastructure",
          description: "Change framework/database/hosting"
        },
        {
          label: "Cancel",
          description: "Abort project setup"
        }
      ]
    }]
  });

  const action = confirmation["Proceed with this configuration?"];

  // ═══════════════════════════════════════════════════════
  // DECISION HANDLING
  // ═══════════════════════════════════════════════════════

  if (action === "Yes, create project") {
    return {
      apiType,
      language,
      framework,
      database,
      hosting,
      scale
    };
  } else if (action === "Modify architecture") {
    // Restart from Batch 1
    return setupAPIProject();
  } else if (action === "Modify infrastructure") {
    // Replay Batch 2 with same Batch 1 answers
    // (implementation omitted for brevity)
  } else {
    return null; // Cancelled
  }
}

// ═══════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════

function getHostingOptions(scale) {
  if (scale === "Small (<1k req/day)") {
    return [
      { label: "Vercel", description: "Serverless, easy deploy, free tier" },
      { label: "Railway", description: "Simple, affordable, auto-deploy" },
      { label: "Render", description: "Free tier, Docker support" }
    ];
  } else if (scale === "Medium (1k-100k)") {
    return [
      { label: "AWS Lambda", description: "Serverless, pay-per-use, scalable" },
      { label: "Google Cloud Run", description: "Containers, auto-scaling" },
      { label: "Fly.io", description: "Edge deployment, global" }
    ];
  } else {
    return [
      { label: "AWS ECS", description: "Containers, full control, scalable" },
      { label: "Kubernetes", description: "Complex, enterprise, multi-cloud" },
      { label: "Cloudflare Workers", description: "Edge, ultra-fast, global" }
    ];
  }
}

function estimateSetupTime({ apiType, framework, database }) {
  let minutes = 10; // Base

  if (apiType === "GraphQL API") minutes += 15;
  if (apiType === "gRPC") minutes += 30;
  if (database !== "None") minutes += 20;
  if (framework.includes("NestJS")) minutes += 10;

  return `${minutes} minutes`;
}

function estimateMonthlyCost({ scale, hosting, database }) {
  let cost = 0;

  if (scale === "Small (<1k req/day)") cost += 0;
  else if (scale === "Medium (1k-100k)") cost += 25;
  else if (scale === "Large (100k-1M)") cost += 100;
  else cost += 500;

  if (database !== "None") cost += 25;
  if (hosting.includes("AWS") || hosting.includes("Google")) cost += 20;

  return cost === 0 ? "Free" : `$${cost}`;
}
```
</implementation>

<validation>
**Test Cases:**

```javascript
// Test 1: Full flow - Happy path
test('Complete setup without modifications', async () => {
  // Mock user selections
  mockUserAnswers([
    { batch: 1, answers: ["REST API", "TypeScript", "Small (<1k req/day)"] },
    { batch: 2, answers: ["Express", "PostgreSQL", "Vercel"] },
    { batch: 3, answers: ["Yes, create project"] }
  ]);

  const result = await setupAPIProject();

  expect(result).toEqual({
    apiType: "REST API",
    language: "TypeScript",
    framework: "Express",
    database: "PostgreSQL",
    hosting: "Vercel",
    scale: "Small (<1k req/day)"
  });
});

// Test 2: User modifies architecture (restart from Batch 1)
test('Modify architecture restarts from beginning', async () => {
  mockUserAnswers([
    { batch: 1, answers: ["GraphQL API", "Python", "Large (100k-1M)"] },
    { batch: 2, answers: ["Apollo Server", "MongoDB", "AWS Lambda"] },
    { batch: 3, answers: ["Modify architecture"] },
    // Second attempt
    { batch: 1, answers: ["tRPC", "TypeScript", "Medium (1k-100k)"] },
    { batch: 2, answers: ["tRPC Standalone", "PostgreSQL", "Fly.io"] },
    { batch: 3, answers: ["Yes, create project"] }
  ]);

  const result = await setupAPIProject();

  expect(result.apiType).toBe("tRPC");
  expect(result.language).toBe("TypeScript");
});

// Test 3: Conditional framework options
test('Framework options filtered by API type + language', async () => {
  const options1 = getFrameworkOptions("REST API", "TypeScript");
  expect(options1).toContainEqual(
    expect.objectContaining({ label: "Express" })
  );

  const options2 = getFrameworkOptions("GraphQL API", "TypeScript");
  expect(options2).toContainEqual(
    expect.objectContaining({ label: "Apollo Server" })
  );

  expect(options1).not.toEqual(options2); // Different options!
});

// Test 4: Hosting filtered by scale
test('Hosting options change based on scale', () => {
  const small = getHostingOptions("Small (<1k req/day)");
  expect(small.map(o => o.label)).toEqual(["Vercel", "Railway", "Render"]);

  const massive = getHostingOptions("Massive (>1M)");
  expect(massive.map(o => o.label)).toEqual(["AWS ECS", "Kubernetes", "Cloudflare Workers"]);
});

// Test 5: Cost estimation accuracy
test('Monthly cost calculation correct', () => {
  expect(estimateMonthlyCost({
    scale: "Small (<1k req/day)",
    hosting: "Vercel",
    database: "None"
  })).toBe("Free");

  expect(estimateMonthlyCost({
    scale: "Large (100k-1M)",
    hosting: "AWS ECS",
    database: "PostgreSQL"
  })).toBe("$145"); // 100 + 20 + 25
});
```

**Manual Testing Checklist:**
- [ ] Batch 1 completes in <60s
- [ ] Batch 2 shows correct filtered options
- [ ] Summary displays all answers correctly
- [ ] "Modify architecture" restarts from Batch 1
- [ ] "Modify infrastructure" keeps Batch 1 answers
- [ ] Cancellation returns null
- [ ] Final config is valid (no conflicting choices)
</validation>

<success_criteria>
✅ User can complete setup in <4 minutes
✅ Options are contextually filtered (no irrelevant choices)
✅ Summary is clear and comprehensive
✅ Modification flows work correctly
✅ Final configuration is always valid
✅ Zero impossible combinations (e.g., tRPC + Python)
</success_criteria>
</example>

---

### Pattern 2: Parallel Batching with Merge

**Cas d'usage:** Collecter des informations indépendantes en parallèle, puis les fusionner.

<example>
<context>
User configure un monorepo. Certaines décisions sont indépendantes et peuvent être posées simultanément, puis combinées intelligemment.
</context>

<thinking>
**Problème:**
- 12 questions totales (3× limite de 4)
- Certaines questions sont indépendantes (packages vs CI/CD)
- D'autres dépendent les unes des autres (framework → features)

**Stratégie:**
1. Identifier les blocs indépendants
2. Poser les questions indépendantes en parallèle (simulé via batching)
3. Merger intelligemment les résultats
4. Valider les combinaisons

**Optimisation:**
- Au lieu de 12 questions séquentielles (12× temps utilisateur)
- 3 batches stratégiques (3× temps utilisateur)
- Réduction de 75% du temps total
</thinking>

<implementation>
```javascript
async function setupMonorepo() {
  // ═══════════════════════════════════════════════════════
  // BATCH 1: Core Structure (4 questions - INDÉPENDANTES)
  // ═══════════════════════════════════════════════════════

  const coreStructure = await AskUserQuestion({
    questions: [
      {
        question: "Monorepo tool?",
        header: "Tool",
        multiSelect: false,
        options: [
          { label: "Turborepo", description: "Fast, Vercel, simple setup, remote caching" },
          { label: "Nx", description: "Powerful, plugins, complex projects, graph viz" },
          { label: "pnpm workspaces", description: "Simple, fast, no extra tooling" },
          { label: "Lerna", description: "Classic, publishing-focused, mature" }
        ]
      },
      {
        question: "Package manager?",
        header: "Pkg Manager",
        multiSelect: false,
        options: [
          { label: "pnpm", description: "Fast, disk efficient, strict deps" },
          { label: "npm", description: "Standard, widely supported" },
          { label: "yarn", description: "Fast, Plug'n'Play, Berry" }
        ]
      },
      {
        question: "TypeScript setup?",
        header: "TypeScript",
        multiSelect: false,
        options: [
          { label: "Strict mode", description: "Full type safety, recommended" },
          { label: "Relaxed", description: "Gradual adoption, fewer errors" },
          { label: "Per-package", description: "Each package decides" },
          { label: "None", description: "Pure JavaScript" }
        ]
      },
      {
        question: "Versioning strategy?",
        header: "Versioning",
        multiSelect: false,
        options: [
          { label: "Independent", description: "Each package own version" },
          { label: "Fixed", description: "All packages same version" },
          { label: "Changesets", description: "Automated, changelog generation" }
        ]
      }
    ]
  });

  // ═══════════════════════════════════════════════════════
  // BATCH 2: Packages & Apps (4 questions - PARALLÉLISABLES)
  // ═══════════════════════════════════════════════════════

  const packagesAndApps = await AskUserQuestion({
    questions: [
      {
        question: "Shared packages to create?",
        header: "Packages",
        multiSelect: true,
        options: [
          { label: "ui", description: "Shared React components library" },
          { label: "utils", description: "Common utilities and helpers" },
          { label: "config", description: "Shared configs (ESLint, TS, etc.)" },
          { label: "types", description: "Shared TypeScript type definitions" }
        ]
      },
      {
        question: "Applications to scaffold?",
        header: "Apps",
        multiSelect: true,
        options: [
          { label: "web", description: "Main web app (Next.js/Vite)" },
          { label: "docs", description: "Documentation site (Nextra/Docusaurus)" },
          { label: "api", description: "Backend API (Express/Fastify)" },
          { label: "admin", description: "Admin dashboard" }
        ]
      },
      {
        question: "Testing setup?",
        header: "Testing",
        multiSelect: true,
        options: [
          { label: "Vitest", description: "Unit tests, fast, Vite-native" },
          { label: "Playwright", description: "E2E tests, cross-browser" },
          { label: "Storybook", description: "Component development & testing" }
        ]
      },
      {
        question: "Code quality tools?",
        header: "Quality",
        multiSelect: true,
        options: [
          { label: "ESLint", description: "Linting, best practices" },
          { label: "Prettier", description: "Code formatting" },
          { label: "Husky", description: "Git hooks" },
          { label: "lint-staged", description: "Pre-commit checks" }
        ]
      }
    ]
  });

  // ═══════════════════════════════════════════════════════
  // BATCH 3: CI/CD & DevOps (4 questions - INDÉPENDANTES DES PRÉCÉDENTES)
  // ═══════════════════════════════════════════════════════

  const cicdAndDevOps = await AskUserQuestion({
    questions: [
      {
        question: "CI/CD platform?",
        header: "CI/CD",
        multiSelect: false,
        options: [
          { label: "GitHub Actions", description: "Free for public, matrix builds" },
          { label: "GitLab CI", description: "Self-hosted option, powerful" },
          { label: "CircleCI", description: "Fast, caching, orbs" },
          { label: "None", description: "Manual deployment only" }
        ]
      },
      {
        question: "CI/CD features?",
        header: "Features",
        multiSelect: true,
        options: [
          { label: "Auto-test", description: "Run tests on every commit" },
          { label: "Auto-deploy", description: "Deploy on merge to main" },
          { label: "Preview deploys", description: "Deploy PRs for review" },
          { label: "Changesets bot", description: "Automated version bumps" }
        ]
      },
      {
        question: "Docker support?",
        header: "Docker",
        multiSelect: false,
        options: [
          { label: "Full", description: "Dockerfiles for all apps + compose" },
          { label: "Production only", description: "Dockerfiles for deployment" },
          { label: "Development only", description: "Dev containers only" },
          { label: "None", description: "No Docker" }
        ]
      },
      {
        question: "Monitoring & Analytics?",
        header: "Monitoring",
        multiSelect: true,
        options: [
          { label: "Sentry", description: "Error tracking" },
          { label: "LogRocket", description: "Session replay" },
          { label: "Vercel Analytics", description: "Web vitals" },
          { label: "None", description: "No monitoring" }
        ]
      }
    ]
  });

  // ═══════════════════════════════════════════════════════
  // MERGE & VALIDATE
  // ═══════════════════════════════════════════════════════

  const config = mergeAndValidate({
    ...coreStructure,
    ...packagesAndApps,
    ...cicdAndDevOps
  });

  // Validation des conflits
  const conflicts = detectConflicts(config);

  if (conflicts.length > 0) {
    const resolution = await AskUserQuestion({
      questions: [{
        question: `⚠️  Detected ${conflicts.length} configuration conflicts:\n\n${formatConflicts(conflicts)}\n\nHow to resolve?`,
        header: "Conflicts",
        multiSelect: false,
        options: [
          { label: "Auto-resolve", description: "Apply recommended fixes" },
          { label: "Manual resolve", description: "Choose for each conflict" },
          { label: "Reconfigure", description: "Start over" }
        ]
      }]
    });

    if (resolution["How to resolve?"] === "Reconfigure") {
      return setupMonorepo(); // Restart
    }
  }

  // ═══════════════════════════════════════════════════════
  // CONFIRMATION
  // ═══════════════════════════════════════════════════════

  const summary = generateMonorepoSummary(config);

  const confirmation = await AskUserQuestion({
    questions: [{
      question: summary + "\n\nCreate monorepo with this configuration?",
      header: "Confirm",
      multiSelect: false,
      options: [
        { label: "Create", description: "Generate monorepo structure" },
        { label: "Export config", description: "Save config for later" },
        { label: "Modify", description: "Change specific sections" },
        { label: "Cancel", description: "Abort" }
      ]
    }]
  });

  const action = confirmation["Create monorepo with this configuration?"];

  if (action === "Create") {
    return config;
  } else if (action === "Modify") {
    // Show modification menu
    const section = await AskUserQuestion({
      questions: [{
        question: "Which section to modify?",
        header: "Modify",
        multiSelect: false,
        options: [
          { label: "Core structure", description: "Tool, pkg manager, TS, versioning" },
          { label: "Packages & Apps", description: "Packages, apps, testing, quality" },
          { label: "CI/CD & DevOps", description: "CI/CD, Docker, monitoring" }
        ]
      }]
    });

    // Re-run specific batch based on choice
    // (implementation omitted for brevity)
  }

  return config;
}

// ═══════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════

function mergeAndValidate(responses) {
  // Merge all responses into single config object
  return {
    tool: responses["Monorepo tool?"],
    packageManager: responses["Package manager?"],
    typescript: responses["TypeScript setup?"],
    versioning: responses["Versioning strategy?"],
    packages: responses["Shared packages to create?"],
    apps: responses["Applications to scaffold?"],
    testing: responses["Testing setup?"],
    quality: responses["Code quality tools?"],
    cicd: responses["CI/CD platform?"],
    cicdFeatures: responses["CI/CD features?"],
    docker: responses["Docker support?"],
    monitoring: responses["Monitoring & Analytics?"]
  };
}

function detectConflicts(config) {
  const conflicts = [];

  // Exemple: Turborepo + Changesets = conflict (Turborepo has own versioning)
  if (config.tool === "Turborepo" && config.versioning === "Changesets") {
    conflicts.push({
      type: "incompatible",
      description: "Turborepo has built-in versioning that conflicts with Changesets",
      suggested: "Use 'Independent' versioning with Turborepo or switch to Nx"
    });
  }

  // Exemple: pnpm + Lerna = conflict (Lerna designed for npm/yarn)
  if (config.packageManager === "pnpm" && config.tool === "Lerna") {
    conflicts.push({
      type: "incompatible",
      description: "Lerna works best with npm or yarn, not pnpm",
      suggested: "Use 'pnpm workspaces' tool or switch package manager"
    });
  }

  // Exemple: No apps selected but CI/CD auto-deploy enabled
  if (config.apps.length === 0 && config.cicdFeatures.includes("Auto-deploy")) {
    conflicts.push({
      type: "warning",
      description: "Auto-deploy enabled but no apps selected to deploy",
      suggested: "Add at least one app or disable auto-deploy"
    });
  }

  return conflicts;
}

function formatConflicts(conflicts) {
  return conflicts.map((c, i) =>
    `${i + 1}. [${c.type.toUpperCase()}] ${c.description}\n   → ${c.suggested}`
  ).join('\n\n');
}

function generateMonorepoSummary(config) {
  return `
╔════════════════════════════════════════════════════════════╗
║           MONOREPO CONFIGURATION SUMMARY                   ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║  📦 CORE STRUCTURE                                         ║
║  ├─ Tool:            ${config.tool.padEnd(35)}║
║  ├─ Pkg Manager:     ${config.packageManager.padEnd(35)}║
║  ├─ TypeScript:      ${config.typescript.padEnd(35)}║
║  └─ Versioning:      ${config.versioning.padEnd(35)}║
║                                                            ║
║  🔧 PACKAGES & APPS                                        ║
║  ├─ Shared Packages: ${config.packages.join(', ').padEnd(35)}║
║  ├─ Applications:    ${config.apps.join(', ').padEnd(35)}║
║  ├─ Testing:         ${config.testing.join(', ').padEnd(35)}║
║  └─ Quality Tools:   ${config.quality.join(', ').padEnd(35)}║
║                                                            ║
║  🚀 CI/CD & DEVOPS                                         ║
║  ├─ CI/CD:           ${config.cicd.padEnd(35)}║
║  ├─ Features:        ${config.cicdFeatures.join(', ').padEnd(35)}║
║  ├─ Docker:          ${config.docker.padEnd(35)}║
║  └─ Monitoring:      ${config.monitoring.join(', ').padEnd(35)}║
║                                                            ║
║  📊 ESTIMATED METRICS                                      ║
║  ├─ Setup Time:      ${estimateMonorepoSetupTime(config).padEnd(35)}║
║  ├─ Initial Size:    ${estimateInitialSize(config).padEnd(35)}║
║  └─ Monthly Cost:    ${estimateMonthlyCost(config).padEnd(35)}║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
`;
}
```
</implementation>

<success_criteria>
✅ 3 batches au lieu de 12 questions séquentielles
✅ Conflits détectés et résolus automatiquement
✅ Configuration valide garantie
✅ Temps total réduit de ~75%
✅ Summary visuel clair et complet
</success_criteria>
</example>

---

### Pattern 3: Progressive Depth (Drill-Down)

**Cas d'usage:** Commencer large, puis approfondir selon le niveau d'expertise de l'utilisateur.

<example>
<context>
Configuration d'une infrastructure cloud. Les débutants ont besoin de guidance simple, les experts veulent du contrôle granulaire.
</context>

<thinking>
**Problème:**
- Utilisateurs novices submergés par trop d'options
- Utilisateurs experts frustrés par manque de contrôle
- Besoin d'adaptation dynamique au niveau d'expertise

**Stratégie:**
1. Détecter le niveau d'expertise (simple/advanced/expert)
2. Ajuster la profondeur des questions
3. Permettre "drill-down" optionnel pour les curieux

**Résultat:**
- Novices: 3 questions simples
- Intermédiaires: 6 questions (3 + 3 drill-down)
- Experts: 10+ questions (full control)
</thinking>

<implementation>
```javascript
async function setupCloudInfrastructure() {
  // ═══════════════════════════════════════════════════════
  // STEP 0: Detect expertise level
  // ═══════════════════════════════════════════════════════

  const expertiseLevel = await AskUserQuestion({
    questions: [{
      question: "What's your cloud infrastructure experience level?",
      header: "Experience",
      multiSelect: false,
      options: [
        {
          label: "Beginner",
          description: "First time deploying, need simple setup with defaults"
        },
        {
          label: "Intermediate",
          description: "Deployed before, want some customization"
        },
        {
          label: "Advanced",
          description: "Experienced, need fine-grained control"
        },
        {
          label: "Expert",
          description: "Full control, custom everything, know what I'm doing"
        }
      ]
    }]
  });

  const level = expertiseLevel["What's your cloud infrastructure experience level?"];

  // ═══════════════════════════════════════════════════════
  // LEVEL 1: Basic Questions (EVERYONE)
  // ═══════════════════════════════════════════════════════

  const basicConfig = await AskUserQuestion({
    questions: [
      {
        question: "Which cloud provider?",
        header: "Provider",
        multiSelect: false,
        options: [
          { label: "AWS", description: "Largest, most services, complex pricing" },
          { label: "Google Cloud", description: "Data & ML focus, simpler pricing" },
          { label: "Azure", description: "Enterprise, Microsoft integration" },
          { label: "Vercel", description: "Simplest, frontend-focused, limited backend" }
        ]
      },
      {
        question: "Application type?",
        header: "App Type",
        multiSelect: false,
        options: [
          { label: "Web App", description: "Frontend + backend, database, users" },
          { label: "API only", description: "Backend service, no frontend" },
          { label: "Static site", description: "HTML/CSS/JS, no backend" },
          { label: "Microservices", description: "Multiple services, complex" }
        ]
      },
      {
        question: "Expected traffic?",
        header: "Traffic",
        multiSelect: false,
        options: [
          { label: "Low (<1k users/day)", description: "Personal project, prototype" },
          { label: "Medium (1k-50k)", description: "Small business, startup" },
          { label: "High (50k-500k)", description: "Growing company, scaling needed" },
          { label: "Very high (>500k)", description: "Enterprise, global scale" }
        ]
      }
    ]
  });

  let config = { level, ...basicConfig };

  // ═══════════════════════════════════════════════════════
  // LEVEL 2: Intermediate Questions (INTERMEDIATE+)
  // ═══════════════════════════════════════════════════════

  if (level !== "Beginner") {
    const intermediateConfig = await AskUserQuestion({
      questions: [
        {
          question: "Deployment strategy?",
          header: "Deployment",
          multiSelect: false,
          options: [
            { label: "Serverless", description: "Auto-scaling, pay-per-use, cold starts" },
            { label: "Containers", description: "Docker, more control, always-on" },
            { label: "VMs", description: "Full control, manual scaling, complex" },
            { label: "Auto (recommend)", description: "Let me decide based on your app" }
          ]
        },
        {
          question: "Database requirements?",
          header: "Database",
          multiSelect: true,
          options: [
            { label: "Relational (SQL)", description: "Transactions, structured data" },
            { label: "Document (NoSQL)", description: "Flexible schema, scalable" },
            { label: "Cache (Redis)", description: "In-memory, fast reads" },
            { label: "Search (Elastic)", description: "Full-text search, analytics" }
          ]
        },
        {
          question: "Security features?",
          header: "Security",
          multiSelect: true,
          options: [
            { label: "WAF", description: "Web Application Firewall, DDoS protection" },
            { label: "SSL/TLS", description: "HTTPS encryption (recommended)" },
            { label: "Secrets manager", description: "Secure credential storage" },
            { label: "IAM roles", description: "Fine-grained access control" }
          ]
        }
      ]
    });

    config = { ...config, ...intermediateConfig };
  }

  // ═══════════════════════════════════════════════════════
  // LEVEL 3: Advanced Questions (ADVANCED+)
  // ═══════════════════════════════════════════════════════

  if (level === "Advanced" || level === "Expert") {
    const advancedConfig = await AskUserQuestion({
      questions: [
        {
          question: "Networking setup?",
          header: "Network",
          multiSelect: true,
          options: [
            { label: "VPC", description: "Isolated network, subnets, security groups" },
            { label: "Load balancer", description: "Distribute traffic, health checks" },
            { label: "CDN", description: "Global edge caching, fast static assets" },
            { label: "Private subnets", description: "Database in private subnet" }
          ]
        },
        {
          question: "Monitoring & Logging?",
          header: "Observability",
          multiSelect: true,
          options: [
            { label: "CloudWatch/Stackdriver", description: "Native cloud monitoring" },
            { label: "Prometheus + Grafana", description: "Self-hosted, powerful" },
            { label: "Datadog", description: "SaaS, comprehensive, expensive" },
            { label: "Custom", description: "I'll configure myself" }
          ]
        },
        {
          question: "Backup & Disaster Recovery?",
          header: "Backup",
          multiSelect: false,
          options: [
            { label: "Automated daily", description: "Daily backups, 30-day retention" },
            { label: "Automated hourly", description: "Hourly backups, 7-day retention" },
            { label: "Continuous (PITR)", description: "Point-in-time recovery, expensive" },
            { label: "Manual only", description: "I'll handle backups myself" }
          ]
        }
      ]
    });

    config = { ...config, ...advancedConfig };
  }

  // ═══════════════════════════════════════════════════════
  // LEVEL 4: Expert Questions (EXPERT ONLY)
  // ═══════════════════════════════════════════════════════

  if (level === "Expert") {
    const expertConfig = await AskUserQuestion({
      questions: [
        {
          question: "Infrastructure as Code tool?",
          header: "IaC",
          multiSelect: false,
          options: [
            { label: "Terraform", description: "Multi-cloud, HCL, state management" },
            { label: "CloudFormation", description: "AWS native, YAML/JSON" },
            { label: "Pulumi", description: "Real programming languages, modern" },
            { label: "CDK", description: "AWS CDK, TypeScript/Python" }
          ]
        },
        {
          question: "CI/CD integration?",
          header: "CI/CD",
          multiSelect: true,
          options: [
            { label: "GitHub Actions", description: "Native GitHub, matrix builds" },
            { label: "GitLab CI", description: "Self-hosted, powerful" },
            { label: "Jenkins", description: "Self-hosted, plugins, complex" },
            { label: "Custom pipeline", description: "I'll build my own" }
          ]
        },
        {
          question: "Cost optimization strategies?",
          header: "Cost",
          multiSelect: true,
          options: [
            { label: "Reserved instances", description: "Commit 1-3 years, save 40-60%" },
            { label: "Spot instances", description: "Use spare capacity, save 70-90%" },
            { label: "Auto-scaling", description: "Scale down during off-hours" },
            { label: "Budget alerts", description: "Get notified at spending thresholds" }
          ]
        },
        {
          question: "Compliance requirements?",
          header: "Compliance",
          multiSelect: true,
          options: [
            { label: "SOC 2", description: "Security, availability, confidentiality" },
            { label: "HIPAA", description: "Healthcare data protection (US)" },
            { label: "GDPR", description: "EU data protection regulation" },
            { label: "PCI DSS", description: "Payment card data security" }
          ]
        }
      ]
    });

    config = { ...config, ...expertConfig };
  }

  // ═══════════════════════════════════════════════════════
  // OPTIONAL DRILL-DOWN: Ask if user wants more control
  // ═══════════════════════════════════════════════════════

  if (level === "Intermediate") {
    const drillDown = await AskUserQuestion({
      questions: [{
        question: "Want more control over advanced settings? (networking, compliance, IaC)",
        header: "Advanced",
        multiSelect: false,
        options: [
          { label: "Yes, show advanced", description: "I want fine-grained control" },
          { label: "No, use defaults", description: "Recommended settings are fine" }
        ]
      }]
    });

    if (drillDown["Want more control over advanced settings? (networking, compliance, IaC)"] === "Yes, show advanced") {
      // Unlock expert questions for intermediate users
      // (recursively call expert section)
    }
  }

  // ═══════════════════════════════════════════════════════
  // CONFIRMATION
  // ═══════════════════════════════════════════════════════

  const summary = generateInfrastructureSummary(config);

  const confirmation = await AskUserQuestion({
    questions: [{
      question: summary + "\n\nDeploy this infrastructure?",
      header: "Confirm",
      multiSelect: false,
      options: [
        { label: "Deploy", description: "Create infrastructure now" },
        { label: "Export IaC", description: "Generate Terraform/CDK code for review" },
        { label: "Estimate cost", description: "Show monthly cost breakdown first" },
        { label: "Cancel", description: "Abort" }
      ]
    }]
  });

  return { config, action: confirmation["Deploy this infrastructure?"] };
}
```
</implementation>

<success_criteria>
✅ Beginners: 3 questions, <2 min, simple setup
✅ Intermediates: 6 questions, <4 min, balanced control
✅ Advanced: 9 questions, <6 min, fine-grained control
✅ Experts: 13 questions, <8 min, full control
✅ Drill-down option permet flexibilité
✅ Pas de frustration (trop simple OU trop complexe)
</success_criteria>
</example>

---

## Decision Tree Architectures

Les arbres décisionnels permettent de créer des workflows complexes avec branches conditionnelles.

### Architecture 1: Binary Decision Tree (Arbre Binaire)

**Structure:** Chaque question a 2-3 options, créant un arbre de décision clair.

```
                        Q1: Type de projet?
                       /                    \
                   Web App                  API
                  /       \                /    \
            Q2: Framework? Q2: Backend?  Q2: Type? Q2: Scale?
           /    |    \       /     \      /    \      /    \
        React Vue Svelte  Node  Python REST GraphQL Small Large
          |     |    |      |      |      |      |      |      |
        [Config A-H basé sur tous les choix précédents]
```

<example>
<context>
Créer un wizard de déploiement avec arbre binaire strict pour garantir des configurations valides.
</context>

<implementation>
```javascript
async function binaryDecisionTreeWizard() {
  // NODE 1: Root
  const projectType = await AskUserQuestion({
    questions: [{
      question: "What are you deploying?",
      header: "Type",
      multiSelect: false,
      options: [
        { label: "Web Application", description: "Frontend + backend" },
        { label: "API Service", description: "Backend only" },
        { label: "Static Site", description: "HTML/CSS/JS only" }
      ]
    }]
  });

  const type = projectType["What are you deploying?"];

  // BRANCH A: Web Application
  if (type === "Web Application") {
    const framework = await AskUserQuestion({
      questions: [{
        question: "Which frontend framework?",
        header: "Framework",
        multiSelect: false,
        options: [
          { label: "React (Next.js)", description: "React with SSR/SSG" },
          { label: "Vue (Nuxt)", description: "Vue with SSR/SSG" },
          { label: "Svelte (SvelteKit)", description: "Compiled, fast" }
        ]
      }]
    });

    const fw = framework["Which frontend framework?"];

    // SUB-BRANCH A1: Next.js
    if (fw === "React (Next.js)") {
      const nextjsConfig = await AskUserQuestion({
        questions: [
          {
            question: "Next.js rendering strategy?",
            header: "Rendering",
            multiSelect: false,
            options: [
              { label: "SSG", description: "Static site generation, fastest" },
              { label: "SSR", description: "Server-side rendering, dynamic" },
              { label: "ISR", description: "Incremental static regeneration" },
              { label: "Hybrid", description: "Mix of SSG, SSR, CSR per page" }
            ]
          },
          {
            question: "Deployment target?",
            header: "Target",
            multiSelect: false,
            options: [
              { label: "Vercel", description: "Zero-config, optimized for Next.js" },
              { label: "Netlify", description: "Good DX, edge functions" },
              { label: "AWS", description: "Full control, complex" },
              { label: "Self-hosted", description: "Docker, manual setup" }
            ]
          }
        ]
      });

      return {
        type: "Web Application",
        framework: "Next.js",
        rendering: nextjsConfig["Next.js rendering strategy?"],
        deployment: nextjsConfig["Deployment target?"]
      };
    }

    // SUB-BRANCH A2: Nuxt
    else if (fw === "Vue (Nuxt)") {
      const nuxtConfig = await AskUserQuestion({
        questions: [
          {
            question: "Nuxt mode?",
            header: "Mode",
            multiSelect: false,
            options: [
              { label: "Universal (SSR)", description: "Server-side rendering" },
              { label: "Static (SSG)", description: "Pre-rendered static site" },
              { label: "SPA", description: "Client-side only" }
            ]
          },
          {
            question: "Hosting?",
            header: "Hosting",
            multiSelect: false,
            options: [
              { label: "Netlify", description: "Vue-friendly, easy deploy" },
              { label: "Vercel", description: "Good support for Nuxt" },
              { label: "Cloudflare Pages", description: "Edge deployment, fast" }
            ]
          }
        ]
      });

      return {
        type: "Web Application",
        framework: "Nuxt",
        mode: nuxtConfig["Nuxt mode?"],
        hosting: nuxtConfig["Hosting?"]
      };
    }

    // SUB-BRANCH A3: SvelteKit
    else {
      const svelteConfig = await AskUserQuestion({
        questions: [
          {
            question: "Adapter?",
            header: "Adapter",
            multiSelect: false,
            options: [
              { label: "Auto", description: "Detect platform automatically" },
              { label: "Node", description: "Node.js server" },
              { label: "Static", description: "Static site generation" },
              { label: "Vercel/Netlify", description: "Platform-specific" }
            ]
          }
        ]
      });

      return {
        type: "Web Application",
        framework: "SvelteKit",
        adapter: svelteConfig["Adapter?"]
      };
    }
  }

  // BRANCH B: API Service
  else if (type === "API Service") {
    const apiType = await AskUserQuestion({
      questions: [{
        question: "API type?",
        header: "API",
        multiSelect: false,
        options: [
          { label: "REST", description: "RESTful API, HTTP verbs" },
          { label: "GraphQL", description: "Query language, single endpoint" },
          { label: "tRPC", description: "Type-safe RPC, TypeScript" }
        ]
      }]
    });

    const api = apiType["API type?"];

    // SUB-BRANCH B1: REST
    if (api === "REST") {
      const restConfig = await AskUserQuestion({
        questions: [
          {
            question: "Node.js framework?",
            header: "Framework",
            multiSelect: false,
            options: [
              { label: "Express", description: "Minimal, flexible, mature" },
              { label: "Fastify", description: "Fast, schema-based" },
              { label: "Hono", description: "Ultra-light, edge-first" }
            ]
          },
          {
            question: "Deployment?",
            header: "Deploy",
            multiSelect: false,
            options: [
              { label: "AWS Lambda", description: "Serverless, auto-scale" },
              { label: "Google Cloud Run", description: "Containers, simple" },
              { label: "Fly.io", description: "Global edge deployment" },
              { label: "Traditional server", description: "VPS, self-managed" }
            ]
          }
        ]
      });

      return {
        type: "API Service",
        apiType: "REST",
        framework: restConfig["Node.js framework?"],
        deployment: restConfig["Deployment?"]
      };
    }

    // SUB-BRANCH B2: GraphQL
    else if (api === "GraphQL") {
      const graphqlConfig = await AskUserQuestion({
        questions: [
          {
            question: "GraphQL server?",
            header: "Server",
            multiSelect: false,
            options: [
              { label: "Apollo Server", description: "Full-featured, caching" },
              { label: "GraphQL Yoga", description: "Flexible, plugins" },
              { label: "Mercurius", description: "Fastify plugin, fast" }
            ]
          }
        ]
      });

      return {
        type: "API Service",
        apiType: "GraphQL",
        server: graphqlConfig["GraphQL server?"]
      };
    }

    // SUB-BRANCH B3: tRPC
    else {
      return {
        type: "API Service",
        apiType: "tRPC",
        framework: "tRPC Standalone",
        deployment: "Determined by integration (Next.js, Express, etc.)"
      };
    }
  }

  // BRANCH C: Static Site
  else {
    const staticConfig = await AskUserQuestion({
      questions: [
        {
          question: "Static site generator?",
          header: "Generator",
          multiSelect: false,
          options: [
            { label: "None (Vanilla)", description: "Pure HTML/CSS/JS" },
            { label: "Astro", description: "Island architecture, fast" },
            { label: "11ty", description: "Flexible, template languages" },
            { label: "Hugo", description: "Go-based, very fast" }
          ]
        },
        {
          question: "Hosting?",
          header: "Hosting",
          multiSelect: false,
          options: [
            { label: "Netlify", description: "Easy deploy, free tier" },
            { label: "Vercel", description: "Fast CDN, good DX" },
            { label: "GitHub Pages", description: "Free, simple, limited" },
            { label: "Cloudflare Pages", description: "Global edge, fast" }
          ]
        }
      ]
    });

    return {
      type: "Static Site",
      generator: staticConfig["Static site generator?"],
      hosting: staticConfig["Hosting?"]
    };
  }
}
```
</implementation>

<success_criteria>
✅ Chaque branche mène à une configuration valide
✅ Pas d'options impossibles (filtrage strict)
✅ Arbre complet couvert en 2-4 questions max
✅ Configuration finale déterministe (même chemin = même config)
</success_criteria>
</example>

---

### Architecture 2: Conditional Multi-Branch (Branches Multiples Conditionnelles)

**Structure:** Plusieurs branches peuvent être actives simultanément selon les réponses.

<example>
<context>
Configuration d'une application e-commerce. Certaines fonctionnalités débloquent d'autres questions (ex: Paiements → Quelle gateway? Auth → Quel provider?).
</context>

<implementation>
```javascript
async function ecommerceConditionalTree() {
  // ═══════════════════════════════════════════════════════
  // LAYER 1: Core Features Selection (Multi-Select)
  // ═══════════════════════════════════════════════════════

  const coreFeatures = await AskUserQuestion({
    questions: [{
      question: "Which e-commerce features to enable?",
      header: "Features",
      multiSelect: true, // ← KEY: Multiple branches can activate
      options: [
        { label: "User Authentication", description: "Login, signup, profiles" },
        { label: "Product Catalog", description: "Browse, search, filter products" },
        { label: "Shopping Cart", description: "Add to cart, persist across sessions" },
        { label: "Payments", description: "Checkout, payment processing" },
        { label: "Admin Dashboard", description: "Manage products, orders, users" },
        { label: "Reviews & Ratings", description: "User-generated content" }
      ]
    }]
  });

  const features = coreFeatures["Which e-commerce features to enable?"];

  let config = { features };

  // ═══════════════════════════════════════════════════════
  // LAYER 2: Conditional Sub-Questions (PARALLEL BRANCHES)
  // ═══════════════════════════════════════════════════════

  // Prepare all conditional questions
  const conditionalQuestions = [];

  // BRANCH A: Authentication selected → Ask auth details
  if (features.includes("User Authentication")) {
    conditionalQuestions.push({
      question: "Authentication method?",
      header: "Auth",
      multiSelect: false,
      options: [
        { label: "Email/Password", description: "Classic, simple, requires DB" },
        { label: "OAuth (Google/GitHub)", description: "Social login, no password management" },
        { label: "Magic Links", description: "Passwordless, email-based" },
        { label: "All of the above", description: "Maximum flexibility" }
      ]
    });
  }

  // BRANCH B: Payments selected → Ask payment gateway
  if (features.includes("Payments")) {
    conditionalQuestions.push({
      question: "Payment gateway?",
      header: "Payments",
      multiSelect: false,
      options: [
        { label: "Stripe", description: "Easiest integration, 2.9% + $0.30" },
        { label: "PayPal", description: "Trusted brand, higher fees" },
        { label: "Square", description: "In-person + online, unified" },
        { label: "Multiple", description: "Offer all payment methods" }
      ]
    });
  }

  // BRANCH C: Product Catalog selected → Ask inventory management
  if (features.includes("Product Catalog")) {
    conditionalQuestions.push({
      question: "Inventory management?",
      header: "Inventory",
      multiSelect: false,
      options: [
        { label: "Manual", description: "Update quantities manually" },
        { label: "Auto-decrement", description: "Reduce stock on purchase" },
        { label: "Shopify Sync", description: "Sync with Shopify inventory" },
        { label: "None", description: "Digital products, unlimited stock" }
      ]
    });
  }

  // BRANCH D: Admin Dashboard selected → Ask admin features
  if (features.includes("Admin Dashboard")) {
    conditionalQuestions.push({
      question: "Admin dashboard features?",
      header: "Admin",
      multiSelect: true,
      options: [
        { label: "Analytics", description: "Sales charts, revenue tracking" },
        { label: "Bulk editing", description: "Edit multiple products at once" },
        { label: "Export data", description: "CSV/Excel exports" },
        { label: "Role management", description: "Admin, editor, viewer roles" }
      ]
    });
  }

  // Execute conditional questions (if any)
  if (conditionalQuestions.length > 0) {
    // Batch conditional questions (max 4, split if needed)
    const batch1 = conditionalQuestions.slice(0, 4);
    const batch2 = conditionalQuestions.slice(4, 8);

    const conditionalAnswers1 = await AskUserQuestion({ questions: batch1 });
    config = { ...config, ...conditionalAnswers1 };

    if (batch2.length > 0) {
      const conditionalAnswers2 = await AskUserQuestion({ questions: batch2 });
      config = { ...config, ...conditionalAnswers2 };
    }
  }

  // ═══════════════════════════════════════════════════════
  // LAYER 3: Deep Conditional (2nd-level dependencies)
  // ═══════════════════════════════════════════════════════

  // If user selected "Payments" AND "Stripe", ask about Stripe features
  if (features.includes("Payments") && config["Payment gateway?"] === "Stripe") {
    const stripeFeatures = await AskUserQuestion({
      questions: [{
        question: "Stripe features to enable?",
        header: "Stripe",
        multiSelect: true,
        options: [
          { label: "Subscriptions", description: "Recurring billing support" },
          { label: "Invoicing", description: "Send invoices to customers" },
          { label: "Customer Portal", description: "Self-service billing portal" },
          { label: "Webhooks", description: "Real-time event notifications" }
        ]
      }]
    });

    config.stripeFeatures = stripeFeatures["Stripe features to enable?"];
  }

  // If "Authentication" + "OAuth", ask which providers
  if (features.includes("User Authentication") &&
      (config["Authentication method?"] === "OAuth (Google/GitHub)" ||
       config["Authentication method?"] === "All of the above")) {
    const oauthProviders = await AskUserQuestion({
      questions: [{
        question: "OAuth providers?",
        header: "OAuth",
        multiSelect: true,
        options: [
          { label: "Google", description: "Most popular, easy setup" },
          { label: "GitHub", description: "Developer-friendly" },
          { label: "Facebook", description: "Wide audience, complex" },
          { label: "Twitter", description: "Quick login" }
        ]
      }]
    });

    config.oauthProviders = oauthProviders["OAuth providers?"];
  }

  // ═══════════════════════════════════════════════════════
  // VALIDATION: Check dependencies
  // ═══════════════════════════════════════════════════════

  const validationIssues = [];

  // Payments requires Shopping Cart
  if (features.includes("Payments") && !features.includes("Shopping Cart")) {
    validationIssues.push({
      severity: "error",
      message: "Payments require Shopping Cart feature",
      fix: "Add 'Shopping Cart' to enabled features or remove 'Payments'"
    });
  }

  // Admin Dashboard requires User Authentication
  if (features.includes("Admin Dashboard") && !features.includes("User Authentication")) {
    validationIssues.push({
      severity: "warning",
      message: "Admin Dashboard works best with User Authentication",
      fix: "Consider adding 'User Authentication' for admin login"
    });
  }

  if (validationIssues.length > 0) {
    const validationSummary = validationIssues.map(issue =>
      `[${issue.severity.toUpperCase()}] ${issue.message}\n  → ${issue.fix}`
    ).join('\n\n');

    const resolution = await AskUserQuestion({
      questions: [{
        question: `⚠️ Configuration issues detected:\n\n${validationSummary}\n\nHow to proceed?`,
        header: "Validation",
        multiSelect: false,
        options: [
          { label: "Auto-fix", description: "Apply recommended fixes automatically" },
          { label: "Ignore warnings", description: "Proceed with current config" },
          { label: "Reconfigure", description: "Start over from feature selection" }
        ]
      }]
    });

    if (resolution["How to proceed?"] === "Auto-fix") {
      // Apply fixes
      if (!features.includes("Shopping Cart") && features.includes("Payments")) {
        features.push("Shopping Cart");
      }
      if (!features.includes("User Authentication") && features.includes("Admin Dashboard")) {
        features.push("User Authentication");
      }
    } else if (resolution["How to proceed?"] === "Reconfigure") {
      return ecommerceConditionalTree(); // Restart
    }
  }

  // ═══════════════════════════════════════════════════════
  // CONFIRMATION
  // ═══════════════════════════════════════════════════════

  const summary = generateEcommerceSummary(config);

  const confirmation = await AskUserQuestion({
    questions: [{
      question: summary + "\n\nGenerate e-commerce app?",
      header: "Confirm",
      multiSelect: false,
      options: [
        { label: "Generate", description: "Create app with this config" },
        { label: "Export config", description: "Save as JSON for later" },
        { label: "Modify", description: "Change specific features" },
        { label: "Cancel", description: "Abort" }
      ]
    }]
  });

  return { config, action: confirmation["Generate e-commerce app?"] };
}

function generateEcommerceSummary(config) {
  return `
╔══════════════════════════════════════════════════════════════╗
║         E-COMMERCE CONFIGURATION SUMMARY                      ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  🛒 ENABLED FEATURES                                          ║
║  ${config.features.map(f => `✓ ${f}`).join('\n║  ')}
║                                                              ║
${config["Authentication method?"] ? `║  🔐 AUTHENTICATION
║  Method: ${config["Authentication method?"]}
${config.oauthProviders ? `║  OAuth: ${config.oauthProviders.join(', ')}` : ''}
║` : ''}
${config["Payment gateway?"] ? `║  💳 PAYMENTS
║  Gateway: ${config["Payment gateway?"]}
${config.stripeFeatures ? `║  Stripe: ${config.stripeFeatures.join(', ')}` : ''}
║` : ''}
${config["Inventory management?"] ? `║  📦 INVENTORY
║  Management: ${config["Inventory management?"]}
║` : ''}
${config["Admin dashboard features?"] ? `║  👨‍💼 ADMIN DASHBOARD
║  Features: ${config["Admin dashboard features?"].join(', ')}
║` : ''}
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
`;
}
```
</implementation>

<success_criteria>
✅ Questions conditionnelles activées dynamiquement
✅ Dépendances validées automatiquement
✅ Pas de configuration invalide possible
✅ Branches parallèles gérées correctement
✅ Deep nesting (2-3 niveaux) supporté
</success_criteria>
</example>

---

## Real-World Complex Examples

### Example 1: Cloud Migration Wizard (10+ steps, validation, rollback)

<implementation>
```javascript
async function cloudMigrationWizard() {
  let migrationState = {
    currentStep: 1,
    totalSteps: 5,
    canRollback: false,
    backup: null
  };

  // STEP 1: Assessment
  const assessment = await AskUserQuestion({
    questions: [
      {
        question: "Current infrastructure?",
        header: "Current",
        multiSelect: false,
        options: [
          { label: "On-premise servers", description: "Physical/VM servers in datacenter" },
          { label: "Competitor cloud", description: "AWS, Google Cloud, Azure" },
          { label: "Hybrid", description: "Mix of on-premise + cloud" },
          { label: "Other", description: "Colocation, managed hosting, etc." }
        ]
      },
      {
        question: "Migration urgency?",
        header: "Urgency",
        multiSelect: false,
        options: [
          { label: "Immediate (<1 month)", description: "Contract ending, emergency" },
          { label: "Planned (1-3 months)", description: "Strategic migration" },
          { label: "Gradual (3-6 months)", description: "Low-risk, phased approach" },
          { label: "Exploratory", description: "Just researching options" }
        ]
      },
      {
        question: "Acceptable downtime?",
        header: "Downtime",
        multiSelect: false,
        options: [
          { label: "Zero (mission-critical)", description: "24/7 uptime required" },
          { label: "Minutes", description: "<5 min maintenance window" },
          { label: "Hours", description: "Weekend/night migration OK" },
          { label: "Flexible", description: "No strict requirements" }
        ]
      }
    ]
  });

  migrationState.currentStep = 2;

  // STEP 2: Workload Analysis
  const workloads = await AskUserQuestion({
    questions: [
      {
        question: "Workload types to migrate?",
        header: "Workloads",
        multiSelect: true,
        options: [
          { label: "Web applications", description: "Frontend + backend apps" },
          { label: "Databases", description: "SQL, NoSQL databases" },
          { label: "File storage", description: "Object storage, file servers" },
          { label: "Batch jobs", description: "Scheduled tasks, cron jobs" }
        ]
      },
      {
        question: "Data volume?",
        header: "Data",
        multiSelect: false,
        options: [
          { label: "Small (<100 GB)", description: "Quick transfer, low cost" },
          { label: "Medium (100GB - 1TB)", description: "Overnight transfer possible" },
          { label: "Large (1TB - 10TB)", description: "Multi-day transfer, plan carefully" },
          { label: "Massive (>10TB)", description: "Requires physical transfer (AWS Snowball)" }
        ]
      }
    ]
  });

  migrationState.currentStep = 3;

  // STEP 3: Migration Strategy
  const strategy = await AskUserQuestion({
    questions: [{
      question: `Given:\n- Downtime: ${assessment["Acceptable downtime?"]}\n- Data: ${workloads["Data volume?"]}\n- Urgency: ${assessment["Migration urgency?"]}\n\nRecommended migration strategy?`,
      header: "Strategy",
      multiSelect: false,
      options: [
        {
          label: "Lift & Shift",
          description: "Fastest, move VMs as-is, minimal refactoring"
        },
        {
          label: "Replatform",
          description: "Optimize for cloud (containers, managed DBs)"
        },
        {
          label: "Refactor",
          description: "Rebuild apps cloud-native (serverless, microservices)"
        },
        {
          label: "Hybrid (phased)",
          description: "Start with lift & shift, refactor later"
        }
      ]
    }]
  });

  migrationState.currentStep = 4;

  // STEP 4: Risk Assessment & Backup
  const riskManagement = await AskUserQuestion({
    questions: [
      {
        question: "Backup strategy before migration?",
        header: "Backup",
        multiSelect: true,
        options: [
          { label: "Full system backup", description: "Complete snapshot of current state" },
          { label: "Database dumps", description: "Export all database data" },
          { label: "File system backup", description: "Copy all files to safe location" },
          { label: "Configuration backup", description: "Export all configs, env vars" }
        ]
      },
      {
        question: "Rollback plan?",
        header: "Rollback",
        multiSelect: false,
        options: [
          { label: "Automated rollback", description: "Auto-revert on critical failure" },
          { label: "Manual rollback", description: "I'll manually restore from backup" },
          { label: "No rollback", description: "One-way migration, no going back" }
        ]
      }
    ]
  });

  migrationState.canRollback = riskManagement["Rollback plan?"] !== "No rollback";
  migrationState.currentStep = 5;

  // STEP 5: Execution Plan
  const executionPlan = await AskUserQuestion({
    questions: [{
      question: "When to start migration?",
      header: "Schedule",
      multiSelect: false,
      options: [
        { label: "Now", description: "Start migration immediately" },
        { label: "Tonight (off-hours)", description: "Minimize user impact" },
        { label: "This weekend", description: "Maximum time window" },
        { label: "Custom date", description: "Schedule for specific date/time" }
      ]
    }]
  });

  // CONFIRMATION WITH FULL SUMMARY
  const summary = `
╔══════════════════════════════════════════════════════════════╗
║           CLOUD MIGRATION EXECUTION PLAN                      ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  📊 ASSESSMENT                                                ║
║  Current:        ${assessment["Current infrastructure?"]}
║  Urgency:        ${assessment["Migration urgency?"]}
║  Downtime OK:    ${assessment["Acceptable downtime?"]}
║                                                              ║
║  🔧 WORKLOADS                                                 ║
║  Types:          ${workloads["Workload types to migrate?"].join(', ')}
║  Data Volume:    ${workloads["Data volume?"]}
║                                                              ║
║  🎯 STRATEGY                                                  ║
║  Approach:       ${strategy["Recommended migration strategy?"]}
║  Rollback:       ${riskManagement["Rollback plan?"]}
║  Backups:        ${riskManagement["Backup strategy before migration?"].join(', ')}
║                                                              ║
║  ⏱️  EXECUTION                                                 ║
║  Start:          ${executionPlan["When to start migration?"]}
║  Est. Duration:  ${estimateMigrationDuration(assessment, workloads, strategy)}
║  Risk Level:     ${calculateRiskLevel(assessment, riskManagement)}
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
`;

  const finalConfirmation = await AskUserQuestion({
    questions: [{
      question: summary + "\n\nProceed with migration?",
      header: "CONFIRM",
      multiSelect: false,
      options: [
        { label: "Execute migration", description: "Start the migration process" },
        { label: "Generate runbook", description: "Create step-by-step manual" },
        { label: "Export plan", description: "Save plan as JSON for review" },
        { label: "Abort", description: "Cancel migration" }
      ]
    }]
  });

  return {
    ...assessment,
    ...workloads,
    ...strategy,
    ...riskManagement,
    ...executionPlan,
    action: finalConfirmation["Proceed with migration?"],
    migrationState
  };
}

function estimateMigrationDuration(assessment, workloads, strategy) {
  let hours = 0;

  // Base time by data volume
  if (workloads["Data volume?"] === "Small (<100 GB)") hours += 2;
  else if (workloads["Data volume?"] === "Medium (100GB - 1TB)") hours += 8;
  else if (workloads["Data volume?"] === "Large (1TB - 10TB)") hours += 48;
  else hours += 168; // 1 week for massive

  // Add time for refactoring
  if (strategy["Recommended migration strategy?"] === "Refactor") hours *= 3;
  else if (strategy["Recommended migration strategy?"] === "Replatform") hours *= 1.5;

  return hours < 24 ? `${hours} hours` : `${Math.ceil(hours / 24)} days`;
}

function calculateRiskLevel(assessment, riskManagement) {
  let risk = 0;

  if (assessment["Acceptable downtime?"] === "Zero (mission-critical)") risk += 3;
  if (riskManagement["Rollback plan?"] === "No rollback") risk += 2;
  if (assessment["Migration urgency?"] === "Immediate (<1 month)") risk += 1;

  if (risk >= 5) return "🔴 HIGH";
  if (risk >= 3) return "🟡 MEDIUM";
  return "🟢 LOW";
}
```
</implementation>

---

## Testing & Validation

### Test Suite Template

```javascript
describe('Multi-Dialog Decision Tree', () => {
  describe('Sequential Chaining', () => {
    test('Batch 1 → Batch 2 → Batch 3 completes successfully', async () => {
      // Mock user answers for all batches
      const mockAnswers = [
        { batch: 1, answers: ["Answer1", "Answer2", "Answer3"] },
        { batch: 2, answers: ["FilteredAnswer1", "FilteredAnswer2"] },
        { batch: 3, answers: ["Yes, confirm"] }
      ];

      const result = await setupAPIProject(mockAnswers);

      expect(result).toBeDefined();
      expect(result.apiType).toBe("Answer1");
    });

    test('Modification flow restarts from correct batch', async () => {
      // Test "Modify architecture" functionality
    });
  });

  describe('Conditional Branching', () => {
    test('Authentication selected → Auth questions appear', async () => {
      // Test conditional question logic
    });

    test('No authentication → Auth questions skipped', async () => {
      // Test branch pruning
    });
  });

  describe('Validation', () => {
    test('Incompatible selections detected', async () => {
      // Test conflict detection
    });

    test('Auto-fix resolves conflicts', async () => {
      // Test auto-fix logic
    });
  });
});
```

---

## Conclusion

Ces patterns avancés permettent de créer des workflows sophistiqués tout en respectant les contraintes d'`AskUserQuestion` :

### ✅ Best Practices Résumé

1. **Sequential Chaining** : Questions en série avec context retention
2. **Parallel Batching** : Questions indépendantes regroupées
3. **Conditional Branching** : Arbres décisionnels avec validation
4. **Progressive Depth** : Adapter complexité au niveau utilisateur
5. **Validation & Rollback** : Toujours permettre retour arrière

### 🎯 Quand utiliser chaque pattern

| Pattern | Use Case | Complexité |
|---------|----------|------------|
| Sequential | Setup linéaire, dépendances fortes | ⭐⭐ |
| Parallel | Config indépendantes, gain de temps | ⭐⭐⭐ |
| Conditional | Features optionnelles, branches multiples | ⭐⭐⭐⭐ |
| Progressive Depth | Différents niveaux expertise | ⭐⭐⭐⭐⭐ |

---

**Version:** 2.0.0
**Last Updated:** 2025-11-08
**Basé sur:** Anthropic 2025 + Context7 Research
