# 🔴 Exercice Niveau 4 : Decision Tree Expert

## 📋 Objectif

Créer un système de configuration d'infrastructure cloud complet avec decision tree 10+ niveaux, validation chains et optimisation automatique.

**Temps estimé** : 30-45 minutes
**Difficulté** : Expert
**Prérequis** : Maîtrise complète des niveaux 1-3

---

## 🎯 Mission Finale

Construire un **Cloud Infrastructure Wizard** qui :
1. Configure une infrastructure complète (AWS/GCP/Azure)
2. Gère 15+ décisions interconnectées
3. Valide la cohérence des choix
4. Optimise coûts et performances
5. Génère Terraform/Pulumi code

---

## 🏗️ Architecture du Decision Tree

```
                        [Cloud Platform]
                              │
                ┌─────────────┼─────────────┐
                │             │             │
              [AWS]         [GCP]        [Azure]
                │             │             │
            [Region]      [Region]      [Region]
                │             │             │
          [Environment]  [Environment]  [Environment]
                │             │             │
         ┌──────┴──────┐     ...           ...
         │             │
    [Compute]      [Storage]
         │             │
    ┌────┼────┐   ┌───┼───┐
    │    │    │   │   │   │
  [EC2][ECS][Lambda][S3][EBS][EFS]
    │    │    │   │   │   │
  [Size][Config][Scaling][Policies]
    │    │    │   │   │   │
[Network][Security][Monitoring]
    │    │    │   │   │   │
[Validation][Optimization][Cost]
    │    │    │   │   │   │
[Generate IaC Code & Deploy]
```

---

## 📝 Implementation Guide

### Phase 1 : Setup & Context Collection

```javascript
const cloudInfrastructureWizard = async () => {
  console.log("☁️ Cloud Infrastructure Configuration Wizard\n");

  // System de tracking avancé
  const wizard = new InfrastructureWizard();

  // Collect context (4 questions max)
  const context = await ask([
    {
      question: "What's the project name?",
      header: "Project",
      options: [
        { label: "New Project", description: "Start fresh" },
        { label: "Existing", description: "Migrate existing" },
        { label: "Custom", description: "Enter name" }
      ]
    },
    {
      question: "What type of application?",
      header: "App Type",
      options: [
        { label: "Web App", description: "Public facing website/app" },
        { label: "API Service", description: "Backend services, microservices" },
        { label: "Data Pipeline", description: "ETL, analytics, ML" },
        { label: "Enterprise", description: "Internal tools, B2B" }
      ]
    },
    {
      question: "Expected traffic?",
      header: "Traffic",
      options: [
        { label: "Low", description: "<1k users/day" },
        { label: "Medium", description: "1k-100k users/day" },
        { label: "High", description: "100k-1M users/day" },
        { label: "Massive", description: ">1M users/day" }
      ]
    },
    {
      question: "Budget range per month?",
      header: "Budget",
      options: [
        { label: "$0-100", description: "Hobby/POC" },
        { label: "$100-1k", description: "Startup" },
        { label: "$1k-10k", description: "Growth" },
        { label: "$10k+", description: "Enterprise" }
      ]
    }
  ]);

  wizard.setContext(context);

  // Continue to platform selection
  await selectCloudPlatform(wizard);
};
```

### Phase 2 : Platform & Region Selection

```javascript
const selectCloudPlatform = async (wizard) => {
  // Intelligent platform recommendation based on context
  const recommendations = wizard.getRecommendations();

  const platform = await ask({
    question: "Which cloud platform?",
    header: "Platform",
    options: recommendations.platforms.map(p => ({
      label: p.name,
      description: `${p.reason} | Est: $${p.estimatedCost}/mo`
    }))
  });

  wizard.setPlatform(platform);

  // Region selection with latency info
  const regions = await wizard.getOptimalRegions();

  const selectedRegions = await ask({
    question: "Select regions (multi-region recommended for HA)",
    header: "Regions",
    multiSelect: true,
    options: regions.slice(0, 4).map(r => ({
      label: r.code,
      description: `${r.name} | Latency: ${r.latency}ms | Cost: ${r.costMultiplier}x`
    }))
  });

  wizard.setRegions(selectedRegions);

  // Continue to compute configuration
  await configureCompute(wizard);
};
```

### Phase 3 : Compute Layer (Deep Branching)

```javascript
const configureCompute = async (wizard) => {
  const computeStrategy = await ask({
    question: "Compute strategy for your workload?",
    header: "Compute",
    options: wizard.getComputeOptions() // Dynamic based on app type
  });

  // Branch based on compute choice
  switch(computeStrategy) {
    case "Serverless":
      await configureServerless(wizard);
      break;
    case "Containers":
      await configureContainers(wizard);
      break;
    case "VMs":
      await configureVMs(wizard);
      break;
    case "Hybrid":
      await configureHybrid(wizard);
      break;
  }

  // Continue to storage
  await configureStorage(wizard);
};

const configureServerless = async (wizard) => {
  // Deep dive into serverless config
  const serverlessConfig = await ask([
    {
      question: "Primary compute service?",
      header: "Service",
      options: [
        { label: "Lambda/Functions", description: "Event-driven, auto-scale" },
        { label: "App Runner", description: "Container-based serverless" },
        { label: "Fargate", description: "Serverless containers" }
      ]
    },
    {
      question: "Memory allocation?",
      header: "Memory",
      options: wizard.getMemoryOptions() // Based on app type
    },
    {
      question: "Concurrency limits?",
      header: "Concurrent",
      options: [
        { label: "Default", description: "Platform defaults" },
        { label: "Limited", description: "Control costs" },
        { label: "Unlimited", description: "Max performance" }
      ]
    }
  ]);

  wizard.setComputeConfig(serverlessConfig);

  // Validate configuration
  const issues = wizard.validateCompute();
  if (issues.length > 0) {
    await resolveConfigIssues(wizard, issues);
  }
};
```

### Phase 4 : Validation Chains

```javascript
class InfrastructureWizard {
  constructor() {
    this.config = {};
    this.validationRules = new ValidationEngine();
    this.costOptimizer = new CostOptimizer();
  }

  validateCompute() {
    const issues = [];

    // Check memory vs expected load
    if (this.config.traffic === "High" && this.config.memory < 1024) {
      issues.push({
        severity: "warning",
        message: "Low memory for high traffic",
        suggestion: "Increase to 2048MB minimum"
      });
    }

    // Check region availability
    if (!this.isServiceAvailable(this.config.compute, this.config.regions)) {
      issues.push({
        severity: "error",
        message: "Service not available in selected regions",
        suggestion: "Change regions or service"
      });
    }

    // Cost validation
    const estimatedCost = this.costOptimizer.estimate(this.config);
    if (estimatedCost > this.config.budget * 1.2) {
      issues.push({
        severity: "warning",
        message: `Estimated cost ($${estimatedCost}) exceeds budget`,
        suggestion: "Optimize configuration"
      });
    }

    return issues;
  }

  async resolveIssues(issues) {
    for (const issue of issues) {
      if (issue.severity === "error") {
        const resolution = await ask({
          question: `Error: ${issue.message}. How to resolve?`,
          header: "Fix Error",
          options: this.getResolutionOptions(issue)
        });

        await this.applyResolution(resolution, issue);
      }
    }
  }
}
```

### Phase 5 : Advanced Patterns

```javascript
// Pattern 1: Circular Validation
const circularValidation = async (wizard) => {
  let valid = false;
  let iterations = 0;
  const maxIterations = 5;

  while (!valid && iterations < maxIterations) {
    iterations++;

    // Get current config
    const config = wizard.getConfig();

    // Validate all aspects
    const validation = await wizard.validateAll();

    if (validation.isValid) {
      valid = true;
    } else {
      // Show issues and get fixes
      const fixes = await ask({
        question: `Found ${validation.issues.length} issues. How to proceed?`,
        header: "Validation",
        multiSelect: true,
        options: validation.issues.map(i => ({
          label: i.fix,
          description: i.description
        }))
      });

      // Apply fixes
      await wizard.applyFixes(fixes);
    }
  }

  if (!valid) {
    console.log("⚠️ Could not achieve valid configuration");
    await manualIntervention(wizard);
  }
};

// Pattern 2: Cost Optimization Loop
const optimizeCosts = async (wizard) => {
  const currentCost = wizard.estimateCost();
  const targetCost = wizard.config.budget;

  if (currentCost > targetCost) {
    const optimizations = wizard.getCostOptimizations();

    const selected = await ask({
      question: `Current: $${currentCost}/mo. Target: $${targetCost}/mo. Apply optimizations?`,
      header: "Optimize",
      multiSelect: true,
      options: optimizations.map(opt => ({
        label: opt.name,
        description: `Save ~$${opt.savings}/mo | Impact: ${opt.impact}`
      }))
    });

    await wizard.applyOptimizations(selected);

    // Re-validate after optimization
    await circularValidation(wizard);
  }
};

// Pattern 3: Progressive Enhancement
const progressiveEnhancement = async (wizard) => {
  // Start with minimal config
  let config = wizard.getMinimalConfig();

  // Progressively add features
  const enhancements = [
    "High Availability",
    "Auto-scaling",
    "CDN",
    "Monitoring",
    "Backup",
    "Security Hardening"
  ];

  for (const enhancement of enhancements) {
    const costImpact = wizard.calculateEnhancementCost(enhancement);

    if (config.currentCost + costImpact <= config.budget) {
      const add = await ask(
        `Add ${enhancement}? (+$${costImpact}/mo)`,
        ["Yes", "No", "Ask me later"]
      );

      if (add === "Yes") {
        config = await wizard.addEnhancement(enhancement);
      }
    }
  }

  return config;
};
```

### Phase 6 : Code Generation

```javascript
const generateInfrastructureCode = async (wizard) => {
  const config = wizard.getFinalConfig();

  const codeFormat = await ask({
    question: "Which Infrastructure as Code format?",
    header: "IaC",
    options: [
      { label: "Terraform", description: "HCL, widely adopted" },
      { label: "Pulumi", description: "TypeScript/Python/Go" },
      { label: "CloudFormation", description: "AWS native" },
      { label: "ARM/Bicep", description: "Azure native" }
    ]
  });

  // Generate code
  const code = wizard.generateCode(codeFormat, config);

  // Review and confirm
  console.log("\n📝 Generated Infrastructure Code:\n");
  console.log(code.preview);

  const action = await ask({
    question: "Review complete. Next step?",
    header: "Deploy",
    options: [
      { label: "Save locally", description: "Save to files" },
      { label: "Create PR", description: "Push to Git" },
      { label: "Deploy now", description: "Apply immediately" },
      { label: "Export config", description: "JSON/YAML export" }
    ]
  });

  await executeDeploymentAction(action, code, wizard);
};
```

---

## ✅ Solution Complète (Extraits)

<details>
<summary>Structure complète du Wizard (500+ lignes)</summary>

```javascript
// Main Wizard Class
class CloudInfrastructureWizard {
  constructor() {
    this.state = {
      context: {},
      platform: null,
      regions: [],
      compute: {},
      storage: {},
      network: {},
      security: {},
      monitoring: {},
      costs: { estimated: 0, optimized: 0 }
    };

    this.validators = {
      compute: new ComputeValidator(),
      storage: new StorageValidator(),
      network: new NetworkValidator(),
      security: new SecurityValidator(),
      cost: new CostValidator()
    };

    this.optimizer = new InfrastructureOptimizer();
    this.codeGenerator = new IaCGenerator();
  }

  async run() {
    try {
      // Phase 1: Context
      await this.collectContext();

      // Phase 2: Platform
      await this.selectPlatform();

      // Phase 3: Regions
      await this.selectRegions();

      // Phase 4: Compute
      await this.configureCompute();

      // Phase 5: Storage
      await this.configureStorage();

      // Phase 6: Network
      await this.configureNetwork();

      // Phase 7: Security
      await this.configureSecurity();

      // Phase 8: Monitoring
      await this.configureMonitoring();

      // Phase 9: Validation
      await this.validateConfiguration();

      // Phase 10: Optimization
      await this.optimizeConfiguration();

      // Phase 11: Review
      await this.reviewConfiguration();

      // Phase 12: Generate Code
      await this.generateCode();

      // Phase 13: Deploy
      await this.deploy();

    } catch (error) {
      await this.handleError(error);
    }
  }

  // ... 500+ lines of implementation
}

// Validation Engine
class ValidationEngine {
  constructor() {
    this.rules = [
      // Compute rules
      {
        name: "compute-memory-traffic",
        check: (config) => {
          if (config.traffic === "High" && config.compute.memory < 2048) {
            return {
              valid: false,
              message: "Insufficient memory for high traffic",
              severity: "error",
              fix: "Increase memory to 2048MB+"
            };
          }
          return { valid: true };
        }
      },
      // Network rules
      {
        name: "network-multi-region",
        check: (config) => {
          if (config.regions.length > 1 && !config.network.loadBalancer) {
            return {
              valid: false,
              message: "Multi-region requires load balancer",
              severity: "error",
              fix: "Add global load balancer"
            };
          }
          return { valid: true };
        }
      },
      // ... 50+ validation rules
    ];
  }

  async validateAll(config) {
    const results = [];
    for (const rule of this.rules) {
      const result = await rule.check(config);
      if (!result.valid) {
        results.push(result);
      }
    }
    return results;
  }
}

// Cost Optimizer
class CostOptimizer {
  constructor() {
    this.strategies = [
      {
        name: "Spot Instances",
        applicable: (config) => config.compute.type === "EC2",
        savings: (config) => config.compute.cost * 0.7,
        impact: "Instances may be terminated"
      },
      {
        name: "Reserved Capacity",
        applicable: (config) => config.commitment >= 12,
        savings: (config) => config.totalCost * 0.3,
        impact: "1-3 year commitment"
      },
      // ... optimization strategies
    ];
  }

  async optimize(config, budget) {
    const applicable = this.strategies
      .filter(s => s.applicable(config))
      .sort((a, b) => b.savings(config) - a.savings(config));

    const selected = [];
    let currentCost = this.calculateCost(config);

    for (const strategy of applicable) {
      if (currentCost > budget) {
        selected.push(strategy);
        currentCost -= strategy.savings(config);
      }
    }

    return selected;
  }
}

// Infrastructure as Code Generator
class IaCGenerator {
  generateTerraform(config) {
    return `
# Generated by Cloud Infrastructure Wizard
# Project: ${config.context.projectName}
# Date: ${new Date().toISOString()}

terraform {
  required_providers {
    ${this.getProvider(config.platform)} = {
      source  = "${this.getProviderSource(config.platform)}"
      version = "~> 4.0"
    }
  }
}

# Provider Configuration
provider "${this.getProvider(config.platform)}" {
  ${this.getProviderConfig(config)}
}

# Compute Resources
${this.generateComputeResources(config.compute)}

# Storage Resources
${this.generateStorageResources(config.storage)}

# Network Resources
${this.generateNetworkResources(config.network)}

# Security Resources
${this.generateSecurityResources(config.security)}

# Monitoring
${this.generateMonitoringResources(config.monitoring)}

# Outputs
output "infrastructure_summary" {
  value = {
    platform     = "${config.platform}"
    regions      = ${JSON.stringify(config.regions)}
    estimated_cost = "$${config.costs.optimized}/month"
    endpoints    = module.network.endpoints
  }
}
    `;
  }

  generatePulumi(config) {
    // Pulumi TypeScript generation
  }

  generateCloudFormation(config) {
    // CloudFormation JSON/YAML generation
  }
}

// Execute the Wizard
const runInfrastructureWizard = async () => {
  const wizard = new CloudInfrastructureWizard();
  await wizard.run();
};

await runInfrastructureWizard();
```

</details>

---

## 🔍 Points d'Apprentissage

### Concepts Expert Maîtrisés :

1. **Decision Trees 10+ niveaux** : Navigation complexe multi-branches
2. **Validation Chains** : Validation circulaire avec correction automatique
3. **Cost Optimization** : Boucles d'optimisation avec contraintes budget
4. **Progressive Enhancement** : Construction incrémentale de config
5. **Code Generation** : Génération IaC depuis configuration
6. **State Management** : Gestion d'état complexe avec rollback
7. **Error Recovery** : Patterns de récupération avancés

---

## 🚀 Ultra Challenges

### Challenge 1 : AI-Powered Suggestions

```javascript
class AIAdvisor {
  async suggestOptimal(context, history) {
    // Analyse patterns from similar projects
    const similar = await this.findSimilarProjects(context);

    // Machine learning recommendations
    const ml = await this.mlPredict(context, similar);

    // Return ranked suggestions
    return this.rankSuggestions(ml.predictions);
  }
}
```

### Challenge 2 : Multi-Cloud Strategy

```javascript
const multiCloudWizard = async () => {
  // Distribute across multiple providers
  const distribution = await ask({
    question: "Multi-cloud distribution strategy?",
    options: [
      { label: "Active-Active", description: "All clouds active" },
      { label: "Active-Passive", description: "Failover setup" },
      { label: "Hybrid", description: "On-prem + cloud" },
      { label: "Specialized", description: "Different clouds for different services" }
    ]
  });

  // Configure each cloud
  const clouds = ["AWS", "GCP", "Azure"];
  for (const cloud of clouds) {
    await configureCloud(cloud, distribution);
  }
};
```

### Challenge 3 : Disaster Recovery Planning

```javascript
const disasterRecoveryPlan = async (wizard) => {
  const dr = await ask([
    {
      question: "RPO (Recovery Point Objective)?",
      header: "RPO",
      options: [
        { label: "Zero", description: "No data loss (expensive)" },
        { label: "< 1 hour", description: "Minimal data loss" },
        { label: "< 24 hours", description: "Daily backups" }
      ]
    },
    {
      question: "RTO (Recovery Time Objective)?",
      header: "RTO",
      options: [
        { label: "< 1 min", description: "Hot standby (expensive)" },
        { label: "< 1 hour", description: "Warm standby" },
        { label: "< 24 hours", description: "Cold standby" }
      ]
    }
  ]);

  // Generate DR configuration
  return wizard.generateDRPlan(dr);
};
```

---

## 📊 Auto-évaluation Expert

- [ ] J'ai créé un decision tree avec 10+ niveaux
- [ ] J'ai implémenté validation chains avec auto-correction
- [ ] J'ai ajouté cost optimization loops
- [ ] J'ai géré l'état complexe avec rollback
- [ ] J'ai généré du code IaC fonctionnel
- [ ] J'ai optimisé les performances (< 15 questions total)
- [ ] J'ai géré tous les edge cases

**Score Expert** : ___/7

---

## 🏆 Certification

Si vous avez complété cet exercice avec succès :

```
╔════════════════════════════════════════════╗
║                                            ║
║        🏆 ASKUSERQUESTION EXPERT 🏆        ║
║                                            ║
║     Vous maîtrisez les patterns les       ║
║     plus avancés d'interaction UI         ║
║                                            ║
║    Challenges complétés:                  ║
║    ✅ Decision Trees Complexes            ║
║    ✅ Validation Chains                   ║
║    ✅ Optimization Loops                  ║
║    ✅ State Management                    ║
║    ✅ Code Generation                     ║
║                                            ║
║         Niveau: EXPERT CERTIFIED          ║
║                                            ║
╚════════════════════════════════════════════╝
```

---

## 🎯 Pour Aller Plus Loin

### Projets Réels Suggérés

1. **Database Migration Wizard** : Assistant complet pour migrations DB
2. **CI/CD Pipeline Builder** : Configuration GitHub Actions/GitLab CI
3. **Security Audit Tool** : Scan et recommandations sécurité
4. **Performance Optimizer** : Analyse et optimisation auto
5. **Multi-Tenant SaaS Setup** : Configuration complète SaaS

### Ressources Avancées

- [Advanced Patterns Multi-Dialog](../../../advanced/multi-dialog-patterns.md)
- [Production Case Study](../../../showcase/supernovae-studio/)
- [Community Patterns](https://github.com/anthropics/claude-code/discussions)

---

> 🎯 **Ultimate Challenge** : Créez votre propre wizard de 20+ étapes pour
> un cas d'usage réel de votre choix. Partagez-le avec la communauté !

> 💎 **Master Tip** : Les meilleurs wizards anticipent les erreurs,
> optimisent automatiquement, et génèrent du code production-ready.