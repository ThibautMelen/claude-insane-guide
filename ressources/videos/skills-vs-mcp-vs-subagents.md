# Claude Code: Skills vs MCP vs Sub Agents

![Miniature vidéo](https://img.youtube.com/vi/ZroGqu7GyXM/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: Claude Code Skills vs MCP vs Sub Agents: What Works for Solo Devs?
- **Auteur**: Solo Swift Crafter
- **Durée**: 9 minutes
- **Date**: 27 octobre 2025
- **Lien**: [https://youtu.be/ZroGqu7GyXM](https://youtu.be/ZroGqu7GyXM)

## Tags

`#skills` `#mcp` `#subagents` `#workflow` `#solo-dev` `#oss-model` `#fine-tuning` `#notion` `#context-window`

---

## Résumé Exécutif

Cette vidéo compare **trois approches** pour optimiser son workflow avec Claude Code : **Skills**, **MCP (Model Context Protocol)**, et **Subagents**. L'auteur partage son expérience de développeur iOS solo et explique comment il a fini par créer son propre modèle OSS fine-tuné pour garder le contrôle sur son workflow.

**Conclusion principale**: Chaque approche a ses forces spécifiques - le choix dépend du type de tâche.

---

## Concepts Clés

### 1. Skills

**Définition**: Modules automatiques qui permettent à l'agent de faire "la bonne chose" sans commande explicite.

**Avantages**:
- ✅ Modulaires et faciles à mettre à jour
- ✅ Efficaces en termes de context window
- ✅ Parfaits pour workflows répétables
- ✅ L'agent "sait quoi faire" automatiquement

**Cas d'usage**:
- Appliquer des règles de style de code
- Exécuter des vérifications automatiques
- Nettoyer les erreurs SwiftLint
- Extraire des données de manière standardisée

**Limitations**:
- ❌ Pas d'intégrations externes
- ❌ Limité aux comportements prédéfinis

---

### 2. MCP (Model Context Protocol)

**Définition**: Pont entre votre code et le monde extérieur (APIs, bases de données, etc.).

**Avantages**:
- ✅ Accès aux données externes
- ✅ Intégrations (Notion, backend, etc.)
- ✅ Automatisation de tâches récurrentes

**Inconvénients**:
- ⚠️ **Consomme beaucoup de context window**
- ⚠️ Peut ralentir l'agent si trop de serveurs
- ⚠️ "Why is my agent so slow today?"

**Cas d'usage**:
- Récupérer des docs depuis un backend
- Pinger une base Notion pour des idées d'app
- Automatiser les syncs de données

**Conseil**: Utiliser avec parcimonie pour ne pas exploser le context.

---

### 3. Subagents

**Définition**: Agents parallèles qui traitent des tâches isolées avec leur propre context window.

**Avantages**:
- ✅ **Context propre** - ne pollue pas la session principale
- ✅ Parallélisation du travail
- ✅ Parfait pour tâches lourdes (refactoring, tests)
- ✅ "Clone yourself for a night"

**Limitations**:
- ❌ **Pas de persistence de contexte**
- ❌ L'historique ne se transfère pas

**Cas d'usage**:
- Batch fixing de tests
- Refactoring isolé
- Code reviews en parallèle
- Découper de grosses features

**Citation**: "If you ever wished you could clone yourself for a night and ship three features at once, this is the closest you'll get."

---

## Approche de l'Auteur: Fine-tuned OSS Model

### Pourquoi créer son propre modèle?

L'auteur a rencontré des problèmes avec les outils existants:
- Changements de pricing (Cursor)
- Context window qui reset
- Edge cases bloquants
- Dépendance aux outils externes

### Solution: Swift Brain (Notion Training Set)

**Système**:
1. Notion team space structuré: **Swift Brain**
2. Contenu:
   - Meilleurs snippets Swift
   - Design patterns
   - UI quirks
   - Code reviews passées

3. Entraîner un modèle OSS (ex: Mistral) sur ces données
4. Le modèle "connaît son style"

**Avantages**:
- ✅ Contrôle total sur le modèle
- ✅ Pas de surprises pricing
- ✅ Le modèle respecte vos règles ("use struct unless you absolutely need a class")
- ✅ Plus stable et fun

**Citation**: "I've got a sidekick who's learned my weird indie dev rituals."

---

## Quand Utiliser Quoi?

### Skills
- Comportement automatique
- Tâches répétitives standardisées
- Appliquer du style/conventions
- Petits helpers réutilisables

### MCP
- Intégrations externes
- Fetching de docs/analytics
- Automatiser les syncs Notion
- **Attention**: Utiliser avec parcimonie

### Subagents
- Tâches parallèles lourdes
- Refactoring isolés
- Batch operations
- Quand le context switching devient un problème

### Fine-tuned OSS
- Workflow vraiment personnel
- Indépendance des outils externes
- Contrôle total sur le comportement
- Long-terme et itération

---

## Crafter OS - Le Système de l'Auteur

L'auteur a créé **Crafter OS** via [crafterslab.dev](https://crafterslab.dev):

### Composants

1. **Playbook** (Notion)
   - Command center
   - Planification d'apps
   - Documentation live

2. **Swift Brain** (Notion)
   - Bibliothèque Swift/SwiftUI curée
   - Training set pour fine-tuning
   - Deep dive resources

3. **OpsLab** (Notion)
   - Systèmes d'agents
   - Workflows et automations
   - Setups Notion

4. **Discord**
   - Communauté
   - Accountability
   - Partage d'expériences

---

## Citations Marquantes

> "Skills are the new hotness. If you just want your agent to quietly do the right thing without having to remember some arcane command."

> "MCP can blow up your context window fast. Every server you spin up gets loaded."

> "Sub agents are honestly a lifesaver for keeping your context clean."

> "Why not just train my own [model]?"

> "Solo doesn't have to mean alone."

---

## Points d'Action

### Pour Débuter
1. ✅ Tester Skills pour automatiser les tâches répétitives
2. ✅ Expérimenter avec Subagents pour tâches parallèles
3. ✅ Utiliser MCP uniquement quand nécessaire (intégrations)

### Pour Aller Plus Loin
1. 🔄 Créer un système de notes structuré (type Notion)
2. 🔄 Documenter vos patterns de code
3. 🔄 Considérer fine-tuning d'un OSS model pour votre style

---

## Ressources Mentionnées

- **Crafter Lab**: [crafterslab.dev](https://crafterslab.dev)
- **Swift Brain**: Training set Notion
- **OSS Models**: Mistral (mentionné)
- **Notion**: Pour organisation et training sets

---

## Notes Personnelles

<!-- Ajoutez vos réflexions ici -->

**Questions à explorer**:
- Comment structurer un bon training set?
- Quel OSS model choisir pour débuter?
- Comment mesurer l'efficacité de chaque approche?

**À tester**:
- Créer mon premier Skill simple
- Lancer un Subagent pour une tâche isolée
- Explorer les MCP servers disponibles
