---
description: Quiz sur Slash Commands
---

# ⚡ Quiz : Slash Commands

Test tes connaissances sur les slash commands avec 5 questions !

## Question 1/5 : Localisation
Où peut-on stocker des slash commands personnalisés ? (plusieurs réponses)
a) .claude/commands/
b) ~/.claude/commands/
c) Dans un plugin
d) Toutes les réponses

## Question 2/5 : Format
Quel élément est OBLIGATOIRE dans le frontmatter d'une command ?
a) description
b) model
c) allowed-tools
d) argument-hint

## Question 3/5 : Variables
Comment accéder à tous les arguments dans une command ?
a) $ARGS
b) $ARGUMENTS
c) ${arguments}
d) @arguments

## Question 4/5 : Exécution Bash
Comment exécuter une commande bash AVANT le prompt ?
a) `git status`
b) !`git status`
c) $`git status`
d) @`git status`

## Question 5/5 : Désactivation
Comment empêcher Claude d'invoquer une command spécifique ?
a) disable: true
b) enabled: false
c) disable-model-invocation: true
d) allow-claude: false

---

**Réponses** :
1. d) Toutes les réponses
2. a) description
3. b) $ARGUMENTS
4. b) !`git status`
5. c) disable-model-invocation: true

**Score** :
- 5/5 : Maître des Commands ! ⚡
- 3-4/5 : Bon niveau 👍
- 1-2/5 : Relis themes/2-commands/guide.md 📚