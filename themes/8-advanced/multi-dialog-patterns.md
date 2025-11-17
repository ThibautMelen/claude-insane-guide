# 🎯 Patterns Avancés Multi-Dialog avec AskUserQuestion

> **Durée estimée** : 90 minutes
> **Niveau** : 🔴 Expert
> **Prérequis** : Maîtrise du thème 10 (Interactive UI)

## 📚 Introduction

Les patterns multi-dialog permettent de créer des workflows conversationnels complexes avec Claude Code, allant bien au-delà des simples questions-réponses. Ces patterns sont essentiels pour :
- 🏗️ **Migrations complexes** d'infrastructure
- 🎯 **Wizards d'onboarding** personnalisés
- 🔄 **Workflows décisionnels** multi-étapes
- 🧩 **Configuration avancée** de projets

## 🎨 Pattern 1 : Sequential Chaining

### Concept
Enchaîner plusieurs dialogues où chaque réponse détermine la question suivante.

```
╔════════════════════════════════════════════╗
║        Sequential Dialog Flow              ║
╚════════════════════════════════════════════╝

    [Question 1]
         ↓
    (Réponse A) → [Question 2A]
         ↓              ↓
    (Réponse B) → [Question 2B]
         ↓              ↓
    [Question 3] ← ← ← ←
         ↓
    [Action Finale]
```

### Implémentation

```typescript
// Pattern Sequential Chaining
async function sequentialMigration() {
  // Étape 1: Type de migration
  const migrationType = await askUserQuestion({
    questions: [{
      question: "Quel type de migration souhaitez-vous effectuer ?",
      header: "Migration",
      options: [
        { label: "Base de données", description: "Migrer schema et données" },
        { label: "Application", description: "Migrer code et dépendances" },
        { label: "Infrastructure", description: "Migrer serveurs et services" },
        { label: "Complète", description: "Migration end-to-end" }
      ],
      multiSelect: false
    }]
  });

  // Étape 2: Questions spécifiques selon le type
  if (migrationType.Migration === "Base de données") {
    const dbDetails = await askUserQuestion({
      questions: [{
        question: "Quelle base de données source utilisez-vous ?",
        header: "Source DB",
        options: [
          { label: "PostgreSQL", description: "Version 12+" },
          { label: "MySQL", description: "Version 5.7+" },
          { label: "MongoDB", description: "Version 4+" },
          { label: "SQLite", description: "Version 3+" }
        ],
        multiSelect: false
      }]
    });

    // Étape 3: Configuration spécifique
    const migrationConfig = await askUserQuestion({
      questions: [
        {
          question: "Quelle stratégie de migration préférez-vous ?",
          header: "Stratégie",
          options: [
            { label: "Blue-Green", description: "Zéro downtime, coût élevé" },
            { label: "Rolling", description: "Downtime minimal, complexité moyenne" },
            { label: "Big Bang", description: "Rapide mais avec downtime" }
          ],
          multiSelect: false
        },
        {
          question: "Quelles options activer ?",
          header: "Options",
          options: [
            { label: "Backup auto", description: "Créer backup avant migration" },
            { label: "Validation", description: "Valider intégrité après migration" },
            { label: "Rollback", description: "Préparer rollback automatique" },
            { label: "Monitoring", description: "Activer monitoring temps réel" }
          ],
          multiSelect: true
        }
      ]
    });
  }

  // Suite du workflow...
}
```

### Cas d'usage réel
- **Migration cloud** : AWS → GCP avec 15+ décisions
- **Setup CI/CD** : Configuration pipeline selon stack
- **Onboarding développeur** : Personnalisation environnement

---

## 🎨 Pattern 2 : Conditional Branching

### Concept
Créer des arbres décisionnels où les branches dépendent de conditions complexes.

```
╔════════════════════════════════════════════╗
║        Conditional Branching Tree          ║
╚════════════════════════════════════════════╝

           [Initial Check]
                 |
         ┌───────┴───────┐
         ↓               ↓
    [Condition A]   [Condition B]
         |               |
    ┌────┴────┐     ┌────┴────┐
    ↓         ↓     ↓         ↓
  [A1]      [A2]  [B1]      [B2]
    |         |     |         |
    └────┬────┘     └────┬────┘
         ↓               ↓
    [Merge A]       [Merge B]
         |               |
         └───────┬───────┘
                 ↓
           [Final Action]
```

### Implémentation

```typescript
// Pattern Conditional Branching
async function conditionalSetup() {
  // Analyse contexte initial
  const context = await analyzeProjectContext();

  // Branches conditionnelles selon contexte
  let questions = [];

  if (context.hasBackend) {
    questions.push({
      question: "Quelle technologie backend utiliser ?",
      header: "Backend",
      options: [
        { label: "Node.js", description: "JavaScript/TypeScript" },
        { label: "Python", description: "Django/FastAPI" },
        { label: "Go", description: "Performance optimale" },
        { label: "Java", description: "Enterprise ready" }
      ],
      multiSelect: false
    });
  }

  if (context.needsDatabase) {
    questions.push({
      question: "Quel type de base de données ?",
      header: "Database",
      options: [
        { label: "Relationnelle", description: "PostgreSQL/MySQL" },
        { label: "NoSQL", description: "MongoDB/DynamoDB" },
        { label: "Cache", description: "Redis/Memcached" },
        { label: "Graph", description: "Neo4j/Amazon Neptune" }
      ],
      multiSelect: true  // Peut avoir plusieurs types
    });
  }

  if (context.requiresAuth) {
    questions.push({
      question: "Quelle méthode d'authentification ?",
      header: "Auth",
      options: [
        { label: "OAuth2", description: "Standard industry" },
        { label: "JWT", description: "Stateless tokens" },
        { label: "Session", description: "Server-side sessions" },
        { label: "SAML", description: "Enterprise SSO" }
      ],
      multiSelect: false
    });
  }

  // Collecte conditionnelle
  if (questions.length > 0) {
    const answers = await askUserQuestion({ questions });

    // Actions basées sur les réponses combinées
    if (answers.Backend === "Node.js" && answers.Database?.includes("Relationnelle")) {
      // Configuration spécifique Node + SQL
      await setupTypeORM();
    } else if (answers.Backend === "Python" && answers.Auth === "OAuth2") {
      // Configuration Python + OAuth
      await setupDjangoOAuth();
    }
  }
}
```

### Use Cases Avancés
- **Architecture microservices** : Décisions par service
- **Setup monorepo** : Configuration par package
- **Deployment multi-cloud** : Stratégies hybrides

---

## 🎨 Pattern 3 : Parallel Execution

### Concept
Collecter plusieurs informations indépendantes simultanément.

```
╔════════════════════════════════════════════╗
║         Parallel Information Gathering      ║
╚════════════════════════════════════════════╝

          [Start]
             |
    ┌────────┼────────┬────────┐
    ↓        ↓        ↓        ↓
  [Q1]     [Q2]     [Q3]     [Q4]
    ↓        ↓        ↓        ↓
  (A1)     (A2)     (A3)     (A4)
    |        |        |        |
    └────────┼────────┴────────┘
             ↓
        [Aggregate]
             ↓
        [Process]
```

### Implémentation

```typescript
// Pattern Parallel Execution
async function parallelConfiguration() {
  // Collecte parallèle de toutes les préférences
  const config = await askUserQuestion({
    questions: [
      {
        question: "Quel framework frontend préférez-vous ?",
        header: "Frontend",
        options: [
          { label: "React", description: "Composants réactifs" },
          { label: "Vue", description: "Progressive framework" },
          { label: "Angular", description: "Full-featured" },
          { label: "Svelte", description: "Compiler-based" }
        ],
        multiSelect: false
      },
      {
        question: "Quels outils de développement activer ?",
        header: "Dev Tools",
        options: [
          { label: "ESLint", description: "Linting code" },
          { label: "Prettier", description: "Formatage auto" },
          { label: "Husky", description: "Git hooks" },
          { label: "Jest", description: "Testing" }
        ],
        multiSelect: true
      },
      {
        question: "Quelle stratégie de style CSS ?",
        header: "Styling",
        options: [
          { label: "CSS Modules", description: "Scoped CSS" },
          { label: "Tailwind", description: "Utility-first" },
          { label: "Styled Components", description: "CSS-in-JS" },
          { label: "Sass", description: "Preprocessor" }
        ],
        multiSelect: false
      },
      {
        question: "Quel gestionnaire de package ?",
        header: "Package",
        options: [
          { label: "npm", description: "Default Node.js" },
          { label: "yarn", description: "Fast & reliable" },
          { label: "pnpm", description: "Disk efficient" },
          { label: "bun", description: "Ultra fast" }
        ],
        multiSelect: false
      }
    ]
  });

  // Traitement parallèle des configurations
  await Promise.all([
    setupFramework(config.Frontend),
    installDevTools(config["Dev Tools"]),
    configureStyles(config.Styling),
    initPackageManager(config.Package)
  ]);
}
```

### Applications Production
- **Setup projet complet** : 10+ décisions simultanées
- **Configuration d'équipe** : Préférences multiples
- **Migration batch** : Options par composant

---

## 🎨 Pattern 4 : Validation Chains

### Concept
Valider progressivement les choix avec possibilité de correction.

```
╔════════════════════════════════════════════╗
║          Validation Chain Pattern          ║
╚════════════════════════════════════════════╝

    [Input] → [Validate] → [Confirm/Retry]
                   ↓              ↑
              [Valid]            |
                   ↓              |
              [Process] ← ← ← ← ←
                   ↓
            [Next Input]
```

### Implémentation

```typescript
// Pattern Validation Chains
async function validationWorkflow() {
  let isValid = false;
  let retryCount = 0;
  const MAX_RETRIES = 3;

  while (!isValid && retryCount < MAX_RETRIES) {
    // Collecte informations
    const dbConfig = await askUserQuestion({
      questions: [{
        question: "Configuration base de données ?",
        header: "DB Config",
        options: [
          { label: "Host local", description: "localhost:5432" },
          { label: "Host distant", description: "Serveur externe" },
          { label: "Docker", description: "Container local" },
          { label: "Cloud", description: "Service managé" }
        ],
        multiSelect: false
      }]
    });

    // Validation
    const validationResult = await validateDatabaseConfig(dbConfig);

    if (!validationResult.success) {
      // Demande de correction avec contexte d'erreur
      const correction = await askUserQuestion({
        questions: [{
          question: `Erreur: ${validationResult.error}. Comment corriger ?`,
          header: "Correction",
          options: [
            { label: "Réessayer", description: "Nouvelle configuration" },
            { label: "Ignorer", description: "Utiliser config par défaut" },
            { label: "Manuel", description: "Configuration manuelle" },
            { label: "Aide", description: "Voir documentation" }
          ],
          multiSelect: false
        }]
      });

      if (correction.Correction === "Ignorer") {
        await useDefaultConfig();
        isValid = true;
      } else if (correction.Correction === "Manuel") {
        await manualConfiguration();
        isValid = true;
      } else {
        retryCount++;
      }
    } else {
      isValid = true;
    }
  }

  if (!isValid) {
    throw new Error("Configuration invalide après plusieurs tentatives");
  }
}
```

---

## 🎨 Pattern 5 : State Management

### Concept
Maintenir un état cohérent à travers plusieurs dialogues.

```
╔════════════════════════════════════════════╗
║         State Management Pattern           ║
╚════════════════════════════════════════════╝

    ┌─────────────┐
    │   State     │
    │ ┌─────────┐ │
    │ │ user    │ │
    │ │ project │ │←──── [Dialog 1]
    │ │ config  │ │←──── [Dialog 2]
    │ │ history │ │←──── [Dialog 3]
    │ └─────────┘ │
    └─────────────┘
           ↓
      [Final Action]
```

### Implémentation

```typescript
// Pattern State Management
class DialogState {
  private state: Map<string, any> = new Map();
  private history: Array<{timestamp: Date, action: string, data: any}> = [];

  async collectWithState() {
    // Phase 1: Informations utilisateur
    const userInfo = await askUserQuestion({
      questions: [{
        question: "Quel est votre rôle dans le projet ?",
        header: "Rôle",
        options: [
          { label: "Tech Lead", description: "Architecture & décisions" },
          { label: "Developer", description: "Implémentation" },
          { label: "DevOps", description: "Infrastructure & CI/CD" },
          { label: "Product", description: "Requirements & specs" }
        ],
        multiSelect: false
      }]
    });

    this.state.set('userRole', userInfo.Rôle);
    this.history.push({
      timestamp: new Date(),
      action: 'roleSelection',
      data: userInfo
    });

    // Phase 2: Questions adaptées au rôle
    let projectQuestions = [];

    if (this.state.get('userRole') === 'Tech Lead') {
      projectQuestions = [
        {
          question: "Quelle architecture préconisez-vous ?",
          header: "Architecture",
          options: [
            { label: "Monolithe", description: "Simple et rapide" },
            { label: "Microservices", description: "Scalable et flexible" },
            { label: "Serverless", description: "Pay-per-use" },
            { label: "Hybride", description: "Mix des approches" }
          ],
          multiSelect: false
        }
      ];
    } else if (this.state.get('userRole') === 'Developer') {
      projectQuestions = [
        {
          question: "Quels langages maîtrisez-vous ?",
          header: "Langages",
          options: [
            { label: "JavaScript", description: "Frontend/Backend" },
            { label: "Python", description: "Data/Backend" },
            { label: "Go", description: "Performance" },
            { label: "Rust", description: "Systems" }
          ],
          multiSelect: true
        }
      ];
    }

    const projectInfo = await askUserQuestion({ questions: projectQuestions });

    // Sauvegarde état cumulatif
    this.state.set('projectConfig', {
      ...this.state.get('projectConfig'),
      ...projectInfo
    });

    // Phase 3: Validation finale avec tout le contexte
    const summary = this.generateSummary();
    const confirmation = await askUserQuestion({
      questions: [{
        question: `Configuration finale:\n${summary}\n\nConfirmer ?`,
        header: "Validation",
        options: [
          { label: "Confirmer", description: "Appliquer configuration" },
          { label: "Modifier", description: "Changer certains choix" },
          { label: "Recommencer", description: "Tout reprendre" },
          { label: "Annuler", description: "Ne rien faire" }
        ],
        multiSelect: false
      }]
    });

    return this.processConfirmation(confirmation);
  }

  private generateSummary(): string {
    // Génère résumé basé sur l'état complet
    return Array.from(this.state.entries())
      .map(([key, value]) => `${key}: ${JSON.stringify(value)}`)
      .join('\n');
  }

  private processConfirmation(confirmation: any) {
    // Traite la confirmation avec rollback possible
    if (confirmation.Validation === "Modifier") {
      // Permet modification sélective
      return this.selectiveModification();
    }
    // etc...
  }
}
```

---

## 💼 Cas Réels en Production

### 1. Migration Infrastructure Complète (Enterprise)

```typescript
// Exemple réel: Migration AWS vers GCP pour application critique
async function enterpriseMigration() {
  const migrationPlan = new MigrationWizard();

  // 15+ étapes de décision
  await migrationPlan
    .assessCurrentInfrastructure()
    .selectTargetArchitecture()
    .mapServices()
    .defineSecurityPolicies()
    .planDataMigration()
    .configureNetworking()
    .setupMonitoring()
    .defineRollbackStrategy()
    .scheduleExecution()
    .confirmWithStakeholders();
}
```

### 2. Setup Monorepo Complexe

```typescript
// Configuration monorepo avec 20+ packages
async function monorepoSetup() {
  // Décisions pour chaque package
  const packages = await discoverPackages();

  for (const pkg of packages) {
    const config = await askUserQuestion({
      questions: [
        {
          question: `Configuration pour ${pkg.name} ?`,
          header: "Package",
          options: generateOptionsForPackageType(pkg.type),
          multiSelect: true
        }
      ]
    });

    await configurePackage(pkg, config);
  }
}
```

### 3. Wizard Onboarding Développeur

```typescript
// Personnalisation complète environnement dev
async function developerOnboarding() {
  const wizard = new OnboardingWizard();

  await wizard
    .collectPersonalPreferences()
    .setupIDE()
    .configureGitSettings()
    .installRequiredTools()
    .cloneRepositories()
    .setupLocalEnvironment()
    .runValidationTests()
    .provideDocumentation();
}
```

---

## ⚠️ Anti-patterns à Éviter

### ❌ 1. Dialog Overload
```typescript
// MAUVAIS: Trop de questions d'un coup
const tooMany = await askUserQuestion({
  questions: [/* 10+ questions */]
});

// ✅ BON: Grouper par contexte
const phase1 = await askUserQuestion({
  questions: [/* 2-4 questions liées */]
});
```

### ❌ 2. Missing Context
```typescript
// MAUVAIS: Questions sans contexte
"Choisir option ?"

// ✅ BON: Contexte clair
"Suite à l'échec de connexion MySQL, quelle alternative ?"
```

### ❌ 3. No Escape Route
```typescript
// MAUVAIS: Pas de sortie
while (true) {
  const answer = await askUserQuestion(/*...*/);
  // Pas de break condition
}

// ✅ BON: Toujours une sortie
while (attempts < MAX && !done) {
  // Avec options "Annuler" ou "Ignorer"
}
```

### ❌ 4. State Loss
```typescript
// MAUVAIS: Perte d'état entre dialogues
const a = await dialog1();
// État perdu
const b = await dialog2(); // Ne sait rien de 'a'

// ✅ BON: État maintenu
state.set('previousChoice', a);
const b = await dialog2(state);
```

---

## ✏️ Exercice Expert : Infrastructure Wizard Complet

### 🎯 Objectif
Créer un wizard complet de déploiement d'infrastructure utilisant tous les patterns.

### 📋 Requirements
- Minimum 10 décisions interconnectées
- Validation à chaque étape critique
- Gestion d'état persistant
- Rollback possible
- Export configuration finale

### 📝 Instructions Step-by-Step

#### Étape 1: Structure de base
```typescript
class InfrastructureWizard {
  private state: WizardState;
  private validator: ConfigValidator;
  private history: DecisionHistory;

  async run() {
    // Votre implémentation
  }
}
```

#### Étape 2: Implémenter Sequential Chaining
- Collecte type d'infrastructure
- Questions adaptées au type
- Validation progressive

#### Étape 3: Ajouter Conditional Branching
- Détection automatique du contexte
- Branches selon les capacités détectées
- Merge des configurations

#### Étape 4: Intégrer Parallel Execution
- Collecte simultanée des préférences
- Optimisation du temps de configuration
- Agrégation des résultats

#### Étape 5: Validation Chain complète
- Validation à chaque étape critique
- Retry avec contexte d'erreur
- Options de correction

#### Étape 6: State Management avancé
- Persistance entre sessions
- Historique des décisions
- Rollback à n'importe quel point

### ✅ Validation
- [ ] 10+ décisions interconnectées implémentées
- [ ] Tous les patterns utilisés au moins une fois
- [ ] Gestion d'erreur robuste
- [ ] État persistant fonctionnel
- [ ] Export configuration JSON/YAML
- [ ] Documentation des choix
- [ ] Tests unitaires des patterns

### 🎓 Ce que vous maîtrisez maintenant
- Orchestration de dialogues complexes
- Gestion d'état avancée
- Patterns de validation
- Workflows conditionnels
- Architecture de wizards production-ready

---

## 🚀 Aller Plus Loin

### Ressources Avancées
- 📄 [Documentation officielle AskUserQuestion](https://code.claude.com/docs/en/interactive-ui)
- 📹 [Video: Advanced Dialog Patterns](https://youtube.com/watch?v=...)
- 🔗 [Repository exemples production](https://github.com/...)

### Prochains Patterns à Explorer
- **Recursive Dialogs** : Dialogues auto-référencés
- **Dynamic Forms** : Génération dynamique de questions
- **ML-Driven Dialogs** : Adaptation par apprentissage
- **Distributed State** : État partagé multi-agents

### Contribution
Partagez vos patterns avancés avec la communauté !

---

## 🎓 Points Clés à Retenir

```
╔════════════════════════════════════════════╗
║         PATTERNS MULTI-DIALOG MASTERY      ║
╚════════════════════════════════════════════╝

✅ Sequential Chaining
   → Workflows linéaires adaptables

✅ Conditional Branching
   → Arbres décisionnels complexes

✅ Parallel Execution
   → Collecte optimisée d'informations

✅ Validation Chains
   → Robustesse et error handling

✅ State Management
   → Cohérence cross-dialog

⭐ BEST PRACTICES
   • Contexte clair toujours
   • Escape routes obligatoires
   • État persistant préférable
   • Validation à chaque étape
   • Documentation des décisions

⚡ PERFORMANCE
   • Grouper questions liées
   • Paralléliser si possible
   • Cache des validations
   • Minimiser round-trips
```

---

**Prochaine étape** → [Advanced Workflows](./advanced-workflows.md)