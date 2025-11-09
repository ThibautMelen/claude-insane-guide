# 🟡 Exercice Niveau 2 : Wizard Multi-étapes

## 📋 Objectif

Créer un wizard de configuration complet pour un projet e-commerce avec questions adaptatives.

**Temps estimé** : 20 minutes
**Difficulté** : Intermédiaire
**Prérequis** : Avoir complété le niveau 1

---

## 🎯 Mission

Construire un assistant de configuration e-commerce qui :
1. Collecte les informations de base (nom, type de produits)
2. Adapte les questions suivantes selon les réponses
3. Configure les features appropriées
4. Génère une configuration complète

---

## 📝 Instructions

### Structure Attendue

Votre wizard doit avoir cette progression :

```
1. Info de base (nom + type produits)
    ↓
2. Plateforme (adaptée au type)
    ↓
3. Features (multi-select)
    ↓
4. Paiement (si feature activée)
    ↓
5. Shipping (si produits physiques)
    ↓
6. Résumé + Config
```

### Étape 1 : Questions de Base

```javascript
const setupEcommerce = async () => {
  // Questions groupées pour efficacité
  const baseInfo = await ask([
    {
      question: "What's your store name?",
      header: "Store",
      multiSelect: false,
      options: [
        { label: "My Store", description: "Default name" },
        { label: "Brand Store", description: "Use your brand" },
        { label: "Custom", description: "Enter custom name" }
      ]
    },
    {
      question: "What type of products?",
      header: "Products",
      multiSelect: false,
      options: [
        { label: "Physical", description: "Shipped products, inventory needed" },
        { label: "Digital", description: "Downloads, licenses, no shipping" },
        { label: "Services", description: "Bookings, consultations" },
        { label: "Mixed", description: "Combination of types" }
      ]
    }
  ]);
};
```

### Étape 2 : Platform Adaptative

Adaptez les options selon le type de produits :

```javascript
// Logique conditionnelle
let platformOptions = [];

if (baseInfo["What type of products?"] === "Digital") {
  platformOptions = [
    { label: "Gumroad", description: "Best for digital products" },
    { label: "Shopify", description: "All-in-one solution" },
    { label: "Custom", description: "Build from scratch" }
  ];
} else if (baseInfo["What type of products?"] === "Physical") {
  platformOptions = [
    { label: "Shopify", description: "Complete e-commerce" },
    { label: "WooCommerce", description: "WordPress integration" },
    { label: "Custom", description: "Headless commerce" }
  ];
}

const platform = await ask({
  question: "Which platform to use?",
  header: "Platform",
  options: platformOptions
});
```

### Étape 3 : Features Multi-Select

```javascript
const features = await ask({
  question: "Which features do you need?",
  header: "Features",
  multiSelect: true, // ← Important !
  options: [
    { label: "Payments", description: "Accept online payments" },
    { label: "Inventory", description: "Stock management" },
    { label: "Analytics", description: "Sales tracking" },
    { label: "Marketing", description: "Email, SEO, ads" }
  ]
});
```

### Étape 4 : Configuration Conditionnelle

```javascript
// Si "Payments" est sélectionné
if (features["Which features do you need?"].includes("Payments")) {
  const paymentProvider = await ask({
    question: "Payment provider?",
    header: "Payments",
    options: [
      { label: "Stripe", description: "Global, developer-friendly" },
      { label: "PayPal", description: "Widely recognized" },
      { label: "Square", description: "Good for retail" }
    ]
  });
}

// Si produits physiques
if (baseInfo["What type of products?"] === "Physical") {
  const shipping = await ask({
    question: "Shipping strategy?",
    header: "Shipping",
    options: [
      { label: "Flat Rate", description: "Same price everywhere" },
      { label: "Calculated", description: "Based on location/weight" },
      { label: "Free", description: "Include in product price" }
    ]
  });
}
```

### Étape 5 : Génération Configuration

```javascript
// Générer config basée sur toutes les réponses
const generateConfig = (answers) => {
  return {
    store: {
      name: answers.storeName,
      type: answers.productType,
      platform: answers.platform
    },
    features: answers.features,
    payments: answers.paymentProvider || null,
    shipping: answers.shippingStrategy || null,
    // Recommandations automatiques
    recommendations: getRecommendations(answers)
  };
};
```

---

## ✅ Solution Complète

<details>
<summary>Cliquez pour voir la solution complète</summary>

```javascript
const setupEcommerceWizard = async () => {
  console.log("🛒 E-Commerce Setup Wizard\n");

  // ÉTAPE 1: Informations de base (questions groupées)
  const baseInfo = await ask([
    {
      question: "What's your online store name?",
      header: "Store Name",
      multiSelect: false,
      options: [
        { label: "My Store", description: "Generic starter name" },
        { label: "Brand Store", description: "Use your brand name" },
        { label: "Custom", description: "Enter a custom name" }
      ]
    },
    {
      question: "What type of products will you sell?",
      header: "Product Type",
      multiSelect: false,
      options: [
        {
          label: "Physical",
          description: "Shipped items, requires inventory & logistics"
        },
        {
          label: "Digital",
          description: "Downloads, licenses, courses, no shipping"
        },
        {
          label: "Services",
          description: "Bookings, consultations, appointments"
        },
        {
          label: "Mixed",
          description: "Combination of multiple types"
        }
      ]
    }
  ]);

  const storeName = baseInfo["What's your online store name?"];
  const productType = baseInfo["What type of products will you sell?"];

  // ÉTAPE 2: Platform (adaptée au type de produits)
  let platformOptions = [];

  switch(productType) {
    case "Digital":
      platformOptions = [
        {
          label: "Gumroad",
          description: "Optimized for creators, built-in audience"
        },
        {
          label: "Shopify",
          description: "Full e-commerce, good for scaling"
        },
        {
          label: "Podia",
          description: "Courses, memberships, digital products"
        }
      ];
      break;

    case "Physical":
      platformOptions = [
        {
          label: "Shopify",
          description: "Industry leader, complete solution"
        },
        {
          label: "WooCommerce",
          description: "WordPress plugin, very flexible"
        },
        {
          label: "BigCommerce",
          description: "Enterprise-ready, API-first"
        }
      ];
      break;

    case "Services":
      platformOptions = [
        {
          label: "Square",
          description: "Appointments + payments integrated"
        },
        {
          label: "Calendly + Stripe",
          description: "Booking focused with payments"
        },
        {
          label: "Custom",
          description: "Build your own booking system"
        }
      ];
      break;

    default: // Mixed
      platformOptions = [
        {
          label: "Shopify Plus",
          description: "Enterprise, handles everything"
        },
        {
          label: "Custom Stack",
          description: "Headless commerce approach"
        },
        {
          label: "WooCommerce",
          description: "Most flexible, needs setup"
        }
      ];
  }

  const platform = await ask({
    question: `Best platform for ${productType.toLowerCase()} products?`,
    header: "Platform",
    multiSelect: false,
    options: platformOptions
  });

  // ÉTAPE 3: Features (multi-select)
  const features = await ask({
    question: "Which features do you need? (select all that apply)",
    header: "Features",
    multiSelect: true,
    options: [
      {
        label: "Payments",
        description: "Accept credit cards, digital wallets"
      },
      {
        label: "Inventory",
        description: "Stock tracking, alerts, variants"
      },
      {
        label: "Analytics",
        description: "Sales reports, customer insights"
      },
      {
        label: "Marketing",
        description: "Email, SEO tools, social media"
      }
    ]
  });

  // ÉTAPE 4: Configuration conditionnelle basée sur les features
  let paymentProvider = null;
  let shippingStrategy = null;
  let marketingTools = null;

  // Si Payments est activé
  if (features["Which features do you need? (select all that apply)"].includes("Payments")) {
    paymentProvider = await ask({
      question: "Preferred payment processor?",
      header: "Payments",
      multiSelect: false,
      options: [
        {
          label: "Stripe",
          description: "Developer-friendly, global reach, 2.9% + 30¢"
        },
        {
          label: "PayPal",
          description: "Most recognized, buyer protection, 2.9% + 30¢"
        },
        {
          label: "Square",
          description: "Good for retail + online, 2.9% + 30¢"
        }
      ]
    });
  }

  // Si produits physiques, demander shipping
  if (productType === "Physical" || productType === "Mixed") {
    shippingStrategy = await ask({
      question: "How will you handle shipping?",
      header: "Shipping",
      multiSelect: false,
      options: [
        {
          label: "Flat Rate",
          description: "$X everywhere, simple for customers"
        },
        {
          label: "Calculated",
          description: "Real-time rates based on location/weight"
        },
        {
          label: "Free Shipping",
          description: "Include cost in product prices"
        },
        {
          label: "Local Only",
          description: "Delivery zones or pickup only"
        }
      ]
    });
  }

  // Si Marketing est activé
  if (features["Which features do you need? (select all that apply)"].includes("Marketing")) {
    marketingTools = await ask({
      question: "Primary marketing channels?",
      header: "Marketing",
      multiSelect: true,
      options: [
        {
          label: "Email",
          description: "Newsletters, abandoned carts"
        },
        {
          label: "Social",
          description: "Instagram, Facebook, TikTok"
        },
        {
          label: "SEO",
          description: "Organic search optimization"
        },
        {
          label: "Ads",
          description: "Google Ads, Facebook Ads"
        }
      ]
    });
  }

  // ÉTAPE 5: Générer configuration finale
  const config = {
    store: {
      name: storeName,
      type: productType,
      platform: platform["Best platform for " + productType.toLowerCase() + " products?"]
    },
    features: features["Which features do you need? (select all that apply)"],
    payments: paymentProvider ? paymentProvider["Preferred payment processor?"] : null,
    shipping: shippingStrategy ? shippingStrategy["How will you handle shipping?"] : null,
    marketing: marketingTools ? marketingTools["Primary marketing channels?"] : null,

    // Estimations automatiques
    estimatedCosts: calculateCosts(platform, features, paymentProvider),
    timeToLaunch: estimateTimeline(productType, platform),

    // Recommandations
    recommendations: generateRecommendations(productType, platform, features)
  };

  // Afficher résumé
  displaySummary(config);

  return config;
};

// Fonctions helper
const calculateCosts = (platform, features, payment) => {
  let monthly = 0;
  let transaction = "2.9% + 30¢";

  // Platform costs (exemples)
  if (platform.includes("Shopify")) monthly += 29;
  if (platform.includes("WooCommerce")) monthly += 15; // hosting

  // Feature costs
  if (features.includes("Analytics")) monthly += 10;
  if (features.includes("Marketing")) monthly += 20;

  return {
    monthly: `$${monthly}/month`,
    transaction: transaction,
    yearly: `$${monthly * 12}/year`
  };
};

const estimateTimeline = (type, platform) => {
  if (type === "Digital" && platform.includes("Gumroad")) {
    return "1-2 days";
  } else if (platform.includes("Shopify")) {
    return "3-5 days";
  } else if (platform.includes("Custom")) {
    return "2-4 weeks";
  }
  return "1 week";
};

const generateRecommendations = (type, platform, features) => {
  const recs = [];

  if (type === "Physical" && !features.includes("Inventory")) {
    recs.push("⚠️ Consider adding inventory management for physical products");
  }

  if (features.includes("Marketing") && !features.includes("Analytics")) {
    recs.push("💡 Add analytics to measure marketing effectiveness");
  }

  if (platform.includes("Custom")) {
    recs.push("🔧 Consider hiring a developer for custom platform");
  }

  return recs;
};

const displaySummary = (config) => {
  console.log(`
╔════════════════════════════════════════════╗
║       🛒 E-COMMERCE CONFIGURATION          ║
╚════════════════════════════════════════════╝

📦 STORE DETAILS
├─ Name: ${config.store.name}
├─ Type: ${config.store.type}
└─ Platform: ${config.store.platform}

✨ FEATURES
${config.features.map(f => `├─ ✓ ${f}`).join('\n')}

💳 PAYMENTS
└─ ${config.payments || 'Not configured'}

📮 SHIPPING
└─ ${config.shipping || 'Not applicable'}

📊 MARKETING
${config.marketing ? config.marketing.map(m => `├─ ${m}`).join('\n') : '└─ Not configured'}

💰 ESTIMATED COSTS
├─ Monthly: ${config.estimatedCosts.monthly}
├─ Transaction: ${config.estimatedCosts.transaction}
└─ Yearly: ${config.estimatedCosts.yearly}

⏱️ TIME TO LAUNCH: ${config.timeToLaunch}

📝 RECOMMENDATIONS
${config.recommendations.map(r => r).join('\n')}

═══════════════════════════════════════════
  `);
};

// Exécuter le wizard
await setupEcommerceWizard();
```

</details>

---

## 🔍 Points d'Apprentissage

### Concepts Maîtrisés :

1. **Questions Groupées** : Utiliser un array pour poser jusqu'à 4 questions simultanément
2. **Logique Conditionnelle** : Adapter les questions selon les réponses précédentes
3. **Multi-Select** : Permettre plusieurs sélections avec `multiSelect: true`
4. **Context Preservation** : Utiliser les réponses pour personnaliser les questions suivantes
5. **Configuration Generation** : Créer une config complète basée sur les inputs

---

## 🚀 Défis Supplémentaires

### Challenge 1 : Validation d'Entrée

Ajoutez une validation pour le nom du store :

```javascript
if (storeName === "Custom") {
  let validName = false;
  while (!validName) {
    const customName = await ask("Enter custom name:", ["Type here..."]);
    if (customName.length > 3 && !customName.includes(" ")) {
      validName = true;
    }
  }
}
```

### Challenge 2 : Progression Tracking

Affichez la progression du wizard :

```javascript
console.log(`Step 1 of 5: Basic Information`);
// questions...
console.log(`Step 2 of 5: Platform Selection`);
// questions...
```

### Challenge 3 : Save & Resume

Implémentez une sauvegarde de progression :

```javascript
const saveProgress = (step, answers) => {
  // Sauvegarder dans un fichier JSON
  fs.writeFileSync('.wizard-progress.json', JSON.stringify({
    step,
    answers,
    timestamp: Date.now()
  }));
};

const resumeWizard = () => {
  // Charger et reprendre où l'utilisateur s'était arrêté
};
```

---

## 📊 Auto-évaluation

- [ ] J'ai créé un wizard de 5+ étapes
- [ ] J'ai utilisé des questions groupées (array)
- [ ] J'ai implémenté la logique conditionnelle
- [ ] J'ai utilisé multi-select correctement
- [ ] J'ai généré une configuration finale

**Score** : ___/5

---

## 🎯 Prochaine Étape

Prêt pour le niveau 3 ? → [Branching Conditionnel](./niveau-3.md)

Dans le prochain exercice :
- Decision trees complexes
- Branching multi-niveaux
- Validation avancée
- Patterns de retry

---

> 💡 **Pro Tip** : Grouper les questions (max 4) améliore l'UX en réduisant
> le nombre d'interactions. Utilisez cette technique pour les questions liées !