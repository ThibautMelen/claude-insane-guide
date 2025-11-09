# 🟠 Exercice Niveau 3 : Branching Conditionnel

## 📋 Objectif

Maîtriser les decision trees et le branching conditionnel complexe pour créer des workflows adaptatifs.

**Temps estimé** : 25 minutes
**Difficulté** : Avancé
**Prérequis** : Avoir complété les niveaux 1 et 2

---

## 🎯 Mission

Créer un assistant de diagnostic technique qui :
1. Identifie le type de problème
2. Navigue dans un arbre de décision complexe
3. Propose des solutions spécifiques
4. Vérifie la résolution avec retry logic

---

## 📊 Arbre de Décision

```
                 [Problème Principal]
                        │
        ┌───────────────┼───────────────┐
        │               │               │
    [Performance]   [Erreurs]      [Config]
        │               │               │
    ┌───┼───┐      ┌───┼───┐      ┌───┼───┐
    │   │   │      │   │   │      │   │   │
  [DB][API][UI]  [404][500][Auth] [ENV][DB][Deploy]
    │   │   │      │   │   │      │   │   │
  Solutions...  Solutions...    Solutions...
```

---

## 📝 Instructions

### Partie 1 : Structure du Decision Tree

```javascript
const technicalSupport = async () => {
  const decisionTree = {
    root: "performance|errors|config",

    performance: {
      question: "Where is the performance issue?",
      branches: {
        "Database": ["Slow queries", "Connection pool", "Indexing"],
        "API": ["Response time", "Memory leak", "CPU usage"],
        "Frontend": ["Bundle size", "Rendering", "Network"]
      }
    },

    errors: {
      question: "What type of error?",
      branches: {
        "404": ["Routes", "Assets", "API endpoints"],
        "500": ["Server crash", "Database", "Memory"],
        "Auth": ["Token expired", "Permissions", "Session"]
      }
    },

    config: {
      question: "Configuration issue with?",
      branches: {
        "Environment": ["Variables", "Secrets", "Paths"],
        "Database": ["Connection", "Migrations", "Schema"],
        "Deployment": ["Build", "Docker", "CI/CD"]
      }
    }
  };
};
```

### Partie 2 : Navigation Conditionnelle

```javascript
// Niveau 1: Problème principal
const mainIssue = await ask({
  question: "What's the main issue you're experiencing?",
  header: "Issue Type",
  multiSelect: false,
  options: [
    {
      label: "Performance",
      description: "Slow response, high CPU/memory, bottlenecks"
    },
    {
      label: "Errors",
      description: "404, 500, crashes, exceptions"
    },
    {
      label: "Configuration",
      description: "Setup, environment, deployment issues"
    }
  ]
});

// Niveau 2: Branching basé sur le choix
let secondLevel;
switch(mainIssue["What's the main issue you're experiencing?"]) {
  case "Performance":
    secondLevel = await askPerformanceBranch();
    break;
  case "Errors":
    secondLevel = await askErrorBranch();
    break;
  case "Configuration":
    secondLevel = await askConfigBranch();
    break;
}
```

### Partie 3 : Deep Dive Conditionnel

```javascript
const askPerformanceBranch = async () => {
  const location = await ask({
    question: "Where is the performance bottleneck?",
    header: "Location",
    options: [
      {
        label: "Database",
        description: "Queries taking too long, connection issues"
      },
      {
        label: "API",
        description: "Endpoints slow to respond"
      },
      {
        label: "Frontend",
        description: "UI sluggish, poor interactions"
      }
    ]
  });

  // Niveau 3: Plus spécifique selon la location
  if (location === "Database") {
    return await diagnoseDatabasePerformance();
  } else if (location === "API") {
    return await diagnoseAPIPerformance();
  } else {
    return await diagnoseFrontendPerformance();
  }
};
```

### Partie 4 : Solutions avec Vérification

```javascript
const proposeSolution = async (diagnosis) => {
  // Proposer solutions basées sur le diagnostic
  const solutions = getSolutionsFor(diagnosis);

  const chosenSolution = await ask({
    question: "Which solution would you like to try?",
    header: "Solution",
    options: solutions
  });

  // Appliquer la solution
  console.log(`Applying: ${chosenSolution}`);

  // Vérifier si résolu
  const resolved = await ask(
    "Did this solve your issue?",
    ["Yes, completely", "Partially", "No, still broken"]
  );

  // Retry logic
  if (resolved !== "Yes, completely") {
    const nextStep = await ask({
      question: "What would you like to do?",
      header: "Next Step",
      options: [
        {
          label: "Try another solution",
          description: "Explore alternative fixes"
        },
        {
          label: "Deeper diagnosis",
          description: "Run more specific tests"
        },
        {
          label: "Get expert help",
          description: "Escalate to senior dev"
        }
      ]
    });

    // Recursive retry ou escalation
    if (nextStep === "Try another solution") {
      return await proposeSolution(diagnosis);
    }
  }
};
```

### Partie 5 : Logging & Tracking

```javascript
const diagnosticSession = {
  startTime: Date.now(),
  path: [],
  attempts: [],

  logDecision(question, answer) {
    this.path.push({ question, answer, timestamp: Date.now() });
  },

  logAttempt(solution, result) {
    this.attempts.push({ solution, result, timestamp: Date.now() });
  },

  generateReport() {
    return {
      duration: Date.now() - this.startTime,
      steps: this.path.length,
      attempts: this.attempts.length,
      resolved: this.attempts.some(a => a.result === "success"),
      fullPath: this.path
    };
  }
};
```

---

## ✅ Solution Complète

<details>
<summary>Cliquez pour voir la solution complète (200+ lignes)</summary>

```javascript
const technicalDiagnosticWizard = async () => {
  console.log("🔧 Technical Diagnostic Assistant\n");

  // Tracking session
  const session = {
    startTime: Date.now(),
    path: [],
    attempts: [],
    context: {}
  };

  // NIVEAU 1: Identifier le problème principal
  const mainIssue = await ask({
    question: "What type of issue are you experiencing?",
    header: "Issue",
    multiSelect: false,
    options: [
      {
        label: "Performance",
        description: "Slow response, high resource usage, timeouts"
      },
      {
        label: "Errors",
        description: "Crashes, error codes, exceptions"
      },
      {
        label: "Configuration",
        description: "Setup problems, environment issues"
      },
      {
        label: "Unknown",
        description: "Not sure, need help identifying"
      }
    ]
  });

  session.path.push({ level: 1, choice: mainIssue });

  // Handle "Unknown" avec diagnostic guidé
  if (mainIssue["What type of issue are you experiencing?"] === "Unknown") {
    return await guidedDiagnosis(session);
  }

  // NIVEAU 2: Branching selon le type
  let diagnosis;
  const issueType = mainIssue["What type of issue are you experiencing?"];

  switch(issueType) {
    case "Performance":
      diagnosis = await diagnosePerformance(session);
      break;
    case "Errors":
      diagnosis = await diagnoseErrors(session);
      break;
    case "Configuration":
      diagnosis = await diagnoseConfiguration(session);
      break;
  }

  // NIVEAU 3-4: Solution et vérification
  await applySolutions(diagnosis, session);

  // Rapport final
  displayReport(session);
};

// BRANCH: Performance Issues
const diagnosePerformance = async (session) => {
  const perfLocation = await ask({
    question: "Where are you noticing performance issues?",
    header: "Location",
    multiSelect: true, // Peut être multiple!
    options: [
      {
        label: "Database",
        description: "Slow queries, connection timeouts"
      },
      {
        label: "API",
        description: "Slow endpoints, high latency"
      },
      {
        label: "Frontend",
        description: "UI lag, slow rendering"
      },
      {
        label: "Build/Deploy",
        description: "Long build times, deploy failures"
      }
    ]
  });

  const locations = perfLocation["Where are you noticing performance issues?"];
  session.path.push({ level: 2, choice: locations });

  // Diagnostic approfondi pour chaque location
  const diagnostics = [];

  for (const location of locations) {
    switch(location) {
      case "Database":
        diagnostics.push(await diagnoseDatabasePerf(session));
        break;
      case "API":
        diagnostics.push(await diagnoseAPIPerf(session));
        break;
      case "Frontend":
        diagnostics.push(await diagnoseFrontendPerf(session));
        break;
      case "Build/Deploy":
        diagnostics.push(await diagnoseBuildPerf(session));
        break;
    }
  }

  return { type: "performance", locations, diagnostics };
};

// SUB-BRANCH: Database Performance
const diagnoseDatabasePerf = async (session) => {
  const dbIssue = await ask({
    question: "What specific database issue?",
    header: "DB Issue",
    options: [
      {
        label: "Slow Queries",
        description: "SELECT/UPDATE taking too long"
      },
      {
        label: "Connection Pool",
        description: "Too many connections, pool exhausted"
      },
      {
        label: "Deadlocks",
        description: "Transaction locks, concurrent access"
      },
      {
        label: "Missing Indexes",
        description: "Full table scans, no optimization"
      }
    ]
  });

  const specific = dbIssue["What specific database issue?"];
  session.path.push({ level: 3, choice: specific });

  // Collecter plus d'infos
  const dbInfo = await ask([
    {
      question: "Database type?",
      header: "DB Type",
      options: [
        { label: "PostgreSQL", description: "Relational, ACID" },
        { label: "MySQL", description: "Relational, popular" },
        { label: "MongoDB", description: "NoSQL, document" },
        { label: "Redis", description: "Cache, key-value" }
      ]
    },
    {
      question: "Database size?",
      header: "Size",
      options: [
        { label: "<1GB", description: "Small dataset" },
        { label: "1-10GB", description: "Medium dataset" },
        { label: "10-100GB", description: "Large dataset" },
        { label: ">100GB", description: "Very large dataset" }
      ]
    },
    {
      question: "When did this start?",
      header: "Timeline",
      options: [
        { label: "Today", description: "Sudden issue" },
        { label: "This week", description: "Recent degradation" },
        { label: "Gradual", description: "Getting worse over time" },
        { label: "After deploy", description: "Post-deployment issue" }
      ]
    }
  ]);

  session.context.database = dbInfo;

  // Retourner diagnostic spécifique
  return {
    issue: specific,
    database: dbInfo["Database type?"],
    size: dbInfo["Database size?"],
    timeline: dbInfo["When did this start?"],
    solutions: generateDBSolutions(specific, dbInfo)
  };
};

// BRANCH: Error Diagnosis
const diagnoseErrors = async (session) => {
  const errorType = await ask({
    question: "What error code or type?",
    header: "Error",
    options: [
      {
        label: "4xx Client",
        description: "400, 401, 403, 404 - Client errors"
      },
      {
        label: "5xx Server",
        description: "500, 502, 503 - Server errors"
      },
      {
        label: "Timeout",
        description: "Request timeout, connection timeout"
      },
      {
        label: "Memory/Crash",
        description: "Out of memory, segfault, crash"
      }
    ]
  });

  const error = errorType["What error code or type?"];
  session.path.push({ level: 2, choice: error });

  // Deep dive based on error type
  if (error === "4xx Client") {
    return await diagnose4xxErrors(session);
  } else if (error === "5xx Server") {
    return await diagnose5xxErrors(session);
  } else if (error === "Timeout") {
    return await diagnoseTimeouts(session);
  } else {
    return await diagnoseMemoryCrash(session);
  }
};

// Solutions Application avec Retry Logic
const applySolutions = async (diagnosis, session) => {
  const solutions = diagnosis.diagnostics
    ? diagnosis.diagnostics.flatMap(d => d.solutions)
    : diagnosis.solutions;

  let resolved = false;
  let attempts = 0;
  const maxAttempts = 3;

  while (!resolved && attempts < maxAttempts) {
    attempts++;

    // Proposer solutions (max 4 à la fois)
    const solutionBatch = solutions.slice(attempts * 4 - 4, attempts * 4);

    if (solutionBatch.length === 0) {
      console.log("No more solutions to try.");
      break;
    }

    const chosen = await ask({
      question: `Attempt ${attempts}: Which solution to try?`,
      header: "Solution",
      multiSelect: false,
      options: solutionBatch.map(sol => ({
        label: sol.name,
        description: sol.description
      }))
    });

    const solution = solutionBatch.find(s =>
      s.name === chosen[`Attempt ${attempts}: Which solution to try?`]
    );

    // Afficher instructions
    console.log(`\n📋 Applying: ${solution.name}`);
    console.log(`Instructions:\n${solution.instructions}\n`);

    // Vérifier résolution
    const result = await ask({
      question: "Did this solve the issue?",
      header: "Result",
      options: [
        {
          label: "Yes, fixed!",
          description: "Issue completely resolved"
        },
        {
          label: "Improved",
          description: "Better but not fully resolved"
        },
        {
          label: "No change",
          description: "Issue persists"
        },
        {
          label: "Worse",
          description: "Made things worse"
        }
      ]
    });

    const resultValue = result["Did this solve the issue?"];
    session.attempts.push({
      solution: solution.name,
      result: resultValue,
      attempt: attempts
    });

    if (resultValue === "Yes, fixed!") {
      resolved = true;
      console.log("✅ Issue resolved successfully!");
    } else if (resultValue === "Worse") {
      // Rollback suggestion
      console.log("⚠️ Solution made things worse. Consider rolling back:");
      console.log(solution.rollback || "Undo the changes made");

      const rollback = await ask(
        "Do you want to rollback this change?",
        ["Yes, rollback", "No, continue"]
      );

      if (rollback === "Yes, rollback") {
        console.log("Rolled back. Trying alternative solution...");
      }
    } else if (resultValue === "Improved") {
      // Continuer avec solutions complémentaires
      const continueChoice = await ask(
        "Issue improved. Continue with more solutions?",
        ["Yes, continue", "Good enough", "Try different approach"]
      );

      if (continueChoice === "Good enough") {
        resolved = true;
      } else if (continueChoice === "Try different approach") {
        // Retour au diagnostic
        return await rediagnose(session);
      }
    }
  }

  if (!resolved && attempts >= maxAttempts) {
    await escalateToExpert(session);
  }
};

// Guided Diagnosis pour "Unknown"
const guidedDiagnosis = async (session) => {
  console.log("Let's identify the issue together...\n");

  const symptoms = await ask({
    question: "What symptoms are you seeing? (select all)",
    header: "Symptoms",
    multiSelect: true,
    options: [
      { label: "Slow", description: "Things take too long" },
      { label: "Broken", description: "Features not working" },
      { label: "Error messages", description: "Seeing errors" },
      { label: "Can't start", description: "Application won't run" }
    ]
  });

  // Logique pour déduire le type de problème
  const symptomList = symptoms["What symptoms are you seeing? (select all)"];

  if (symptomList.includes("Slow")) {
    return await diagnosePerformance(session);
  } else if (symptomList.includes("Error messages") || symptomList.includes("Broken")) {
    return await diagnoseErrors(session);
  } else {
    return await diagnoseConfiguration(session);
  }
};

// Helper Functions
const generateDBSolutions = (issue, context) => {
  const solutions = [];

  if (issue === "Slow Queries") {
    solutions.push({
      name: "Add Index",
      description: "Create index on frequently queried columns",
      instructions: "Run: CREATE INDEX idx_name ON table(column);",
      rollback: "DROP INDEX idx_name;"
    });

    solutions.push({
      name: "Query Optimization",
      description: "Rewrite query for better performance",
      instructions: "Use EXPLAIN ANALYZE to identify bottlenecks",
      rollback: "Revert to original query"
    });
  }

  if (issue === "Connection Pool") {
    solutions.push({
      name: "Increase Pool Size",
      description: "Raise max connections",
      instructions: "Set max_connections = 200 in config",
      rollback: "Revert to previous value"
    });
  }

  return solutions;
};

// Escalation
const escalateToExpert = async (session) => {
  console.log("\n⚠️ Unable to resolve automatically. Escalating...\n");

  const report = generateReport(session);

  console.log("📊 Diagnostic Report for Expert:");
  console.log(JSON.stringify(report, null, 2));

  const escalation = await ask({
    question: "How would you like to proceed?",
    header: "Escalate",
    options: [
      {
        label: "Export report",
        description: "Save diagnostic data to file"
      },
      {
        label: "Contact support",
        description: "Send report to tech support"
      },
      {
        label: "Community help",
        description: "Post to Stack Overflow/Discord"
      },
      {
        label: "Schedule expert",
        description: "Book senior dev session"
      }
    ]
  });

  // Handle escalation choice
  console.log(`Escalation method: ${escalation}`);
};

// Report Generation
const generateReport = (session) => {
  const duration = Date.now() - session.startTime;

  return {
    duration: `${Math.floor(duration / 1000)}s`,
    steps: session.path.length,
    attempts: session.attempts.length,
    successRate: session.attempts.filter(a =>
      a.result === "Yes, fixed!"
    ).length / session.attempts.length,
    path: session.path,
    attempts: session.attempts,
    context: session.context
  };
};

const displayReport = (session) => {
  const report = generateReport(session);

  console.log(`
╔════════════════════════════════════════════╗
║        🔧 DIAGNOSTIC REPORT               ║
╚════════════════════════════════════════════╝

📊 SESSION STATS
├─ Duration: ${report.duration}
├─ Steps taken: ${report.steps}
├─ Solutions tried: ${report.attempts}
└─ Success rate: ${(report.successRate * 100).toFixed(0)}%

📍 DIAGNOSTIC PATH
${report.path.map((p, i) =>
  `${i+1}. Level ${p.level}: ${p.choice}`
).join('\n')}

🔧 SOLUTIONS ATTEMPTED
${report.attempts.map((a, i) =>
  `${i+1}. ${a.solution} → ${a.result}`
).join('\n')}

${report.successRate === 1
  ? '✅ Issue successfully resolved!'
  : '⚠️ Issue partially resolved or escalated'}
  `);
};

// Execute
await technicalDiagnosticWizard();
```

</details>

---

## 🔍 Points d'Apprentissage

### Concepts Maîtrisés :

1. **Decision Trees** : Navigation dans des arbres de décision multi-niveaux
2. **Branching Logic** : Chemins conditionnels basés sur les réponses
3. **Retry Patterns** : Gestion des échecs avec nouvelles tentatives
4. **Session Tracking** : Suivi complet du parcours diagnostic
5. **Escalation Flow** : Gestion des cas non résolus

---

## 🚀 Défis Supplémentaires

### Challenge 1 : Machine Learning

Ajoutez un système d'apprentissage qui mémorise les solutions efficaces :

```javascript
const ml = {
  successfulSolutions: {},

  recordSuccess(problem, solution) {
    if (!this.successfulSolutions[problem]) {
      this.successfulSolutions[problem] = {};
    }
    this.successfulSolutions[problem][solution] =
      (this.successfulSolutions[problem][solution] || 0) + 1;
  },

  getSortedSolutions(problem) {
    // Retourne solutions triées par taux de succès
    return Object.entries(this.successfulSolutions[problem] || {})
      .sort((a, b) => b[1] - a[1])
      .map(([solution]) => solution);
  }
};
```

### Challenge 2 : Parallel Diagnosis

Exécutez plusieurs branches de diagnostic en parallèle :

```javascript
const parallelDiagnosis = async () => {
  const [perfDiag, errorDiag, configDiag] = await Promise.all([
    checkPerformance(),
    checkErrors(),
    checkConfiguration()
  ]);

  // Combiner les résultats
  return mergeDiagnostics(perfDiag, errorDiag, configDiag);
};
```

### Challenge 3 : Auto-Fix

Implémentez des corrections automatiques pour les problèmes courants :

```javascript
const autoFix = {
  "Missing Index": async () => {
    await exec("CREATE INDEX ...");
    return verify();
  },
  "Memory Leak": async () => {
    await restartService();
    return monitorMemory();
  }
};
```

---

## 📊 Auto-évaluation

- [ ] J'ai créé un arbre de décision multi-niveaux
- [ ] J'ai implémenté le branching conditionnel
- [ ] J'ai ajouté la logique de retry
- [ ] J'ai tracké la session complète
- [ ] J'ai géré l'escalation des échecs

**Score** : ___/5

---

## 🎯 Prochaine Étape

Prêt pour le niveau expert ? → [Decision Tree Complet](./niveau-4.md)

Dans le dernier exercice :
- Decision trees 10+ niveaux
- Validation chains complexes
- Patterns de recovery avancés
- Optimisation de performance

---

> 💡 **Expert Tip** : Les decision trees deviennent complexes rapidement.
> Documentez toujours votre arbre avec des diagrammes ASCII ou Mermaid !