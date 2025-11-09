# 🟢 Exercice Niveau 1 : Dialog Simple

## 📋 Objectif

Créer votre premier dialogue interactif avec `AskUserQuestion` pour configurer un projet basique.

**Temps estimé** : 15 minutes
**Difficulté** : Débutant
**Prérequis** : Avoir lu le guide principal

---

## 🎯 Mission

Créez un assistant qui aide à initialiser un nouveau projet web en posant 3 questions simples :

1. Le nom du projet
2. Le framework à utiliser
3. Si TypeScript doit être activé

---

## 📝 Instructions

### Étape 1 : Structure de base

Commencez par créer la structure de votre fonction :

```javascript
const setupProject = async () => {
  // Votre code ici
};
```

### Étape 2 : Première question (Nom)

Demandez le nom du projet avec 3 suggestions :

```javascript
const projectName = await ask(
  "What's your project name?",
  ["my-app", "web-project", "awesome-site"]
);
```

### Étape 3 : Deuxième question (Framework)

Demandez le framework avec des descriptions :

```javascript
const framework = await ask({
  question: "Which framework?",
  header: "Framework",
  multiSelect: false,
  options: [
    {
      label: "Next.js",
      description: "Full-stack React framework"
    },
    {
      label: "Vue",
      description: "Progressive JavaScript framework"
    },
    {
      label: "Vanilla",
      description: "No framework, pure JavaScript"
    }
  ]
});
```

### Étape 4 : Troisième question (TypeScript)

Simple question Oui/Non :

```javascript
const useTypeScript = await ask(
  "Enable TypeScript?",
  ["Yes", "No"]
);
```

### Étape 5 : Afficher le résumé

```javascript
console.log(`
Project Configuration:
- Name: ${projectName}
- Framework: ${framework}
- TypeScript: ${useTypeScript}
`);
```

---

## ✅ Solution Complète

<details>
<summary>Cliquez pour voir la solution</summary>

```javascript
const setupProject = async () => {
  // Question 1 : Nom du projet
  const projectName = await ask(
    "What's your project name?",
    ["my-app", "web-project", "awesome-site"]
  );

  // Question 2 : Framework
  const framework = await ask({
    question: "Which framework would you like to use?",
    header: "Framework",
    multiSelect: false,
    options: [
      {
        label: "Next.js",
        description: "Full-stack React framework with SSR/SSG"
      },
      {
        label: "Vue",
        description: "Progressive JavaScript framework"
      },
      {
        label: "Vanilla",
        description: "No framework, pure JavaScript"
      }
    ]
  });

  // Question 3 : TypeScript
  const useTypeScript = await ask(
    "Enable TypeScript for better type safety?",
    ["Yes", "No"]
  );

  // Résumé
  console.log(`
  ✅ Project Configuration Summary:
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  📁 Name: ${projectName}
  🚀 Framework: ${framework}
  📝 TypeScript: ${useTypeScript === "Yes" ? "✓ Enabled" : "✗ Disabled"}
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  `);

  // Bonus : Générer la commande d'installation
  let installCmd = "npm create ";

  if (framework === "Next.js") {
    installCmd += `next-app@latest ${projectName}`;
    if (useTypeScript === "Yes") {
      installCmd += " --typescript";
    }
  } else if (framework === "Vue") {
    installCmd += `vue@latest ${projectName}`;
  } else {
    installCmd = `mkdir ${projectName} && cd ${projectName} && npm init -y`;
  }

  console.log(`To create your project, run:\n${installCmd}`);
};

// Exécuter
await setupProject();
```

</details>

---

## 🔍 Points d'Apprentissage

### Ce que vous avez appris :

1. **Syntaxe de base** : Deux façons d'utiliser `ask()`
   - Simple : `ask("Question?", ["Opt1", "Opt2"])`
   - Détaillée : `ask({ question, header, options, ... })`

2. **Options avec descriptions** : Donner du contexte aide l'utilisateur

3. **Réponses comme strings** : Les réponses sont toujours des strings

4. **Header court** : Maximum 12 caractères pour le label

---

## 🚀 Bonus : Aller Plus Loin

### Challenge 1 : Ajouter une 4ème question

Ajoutez une question pour choisir le gestionnaire de packages :

```javascript
const packageManager = await ask(
  "Package manager?",
  ["npm", "yarn", "pnpm", "bun"]
);
```

### Challenge 2 : Validation

Vérifiez que le nom du projet est valide (pas d'espaces, caractères spéciaux) :

```javascript
const projectName = await ask(...);

if (projectName.includes(" ")) {
  console.log("⚠️ Project names cannot contain spaces!");
  // Redemander ou transformer
}
```

### Challenge 3 : Questions groupées

Essayez de poser les 3 questions en une seule fois :

```javascript
const config = await ask([
  { question: "Project name?", header: "Name", ... },
  { question: "Framework?", header: "Framework", ... },
  { question: "TypeScript?", header: "TypeScript", ... }
]);

console.log(config["Project name?"]);
console.log(config["Framework?"]);
console.log(config["TypeScript?"]);
```

---

## 📊 Auto-évaluation

- [ ] J'ai créé un dialogue avec 3 questions
- [ ] J'ai utilisé les deux syntaxes (simple et détaillée)
- [ ] J'ai ajouté des descriptions aux options
- [ ] J'ai affiché un résumé des choix
- [ ] J'ai testé avec différentes réponses

**Score** : ___/5

---

## 🎯 Prochaine Étape

Prêt pour le niveau 2 ? → [Wizard Multi-étapes](./niveau-2.md)

Dans le prochain exercice, vous apprendrez à :
- Créer des wizards de 5+ étapes
- Utiliser les réponses pour adapter les questions suivantes
- Implémenter la logique conditionnelle
- Grouper les questions pour optimiser l'UX

---

> 💡 **Astuce** : L'option "Other" est automatiquement ajoutée par Claude Code.
> Testez-la pour voir comment elle fonctionne !