# Les PLUGINS sur Claude Code : ça devient incontrôlable !!

![Miniature vidéo](https://img.youtube.com/vi/hvfNIi8jqPg/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: Les PLUGINS sur Claude Code : ça devient incontrôlable !!
- **Auteur**: Melvynx • Apprendre à coder
- **Durée**: 16 minutes
- **Date**: 10 octobre 2025
- **Lien**: [https://www.youtube.com/watch?v=hvfNIi8jqPg](https://www.youtube.com/watch?v=hvfNIi8jqPg)

## Tags

`#plugins` `#marketplace` `#slash-commands` `#agents` `#mcp-servers` `#hooks` `#workflow` `#configuration` `#partage-equipe` `#open-source`

---

## Résumé Exécutif

Claude Code franchit une étape majeure avec l'introduction des **Plugins** et des **Marketplaces**, transformant l'outil en un véritable "OS pour coder". Les plugins permettent de packager et partager facilement des configurations complètes (commandes, agents, MCP servers, hooks) entre développeurs et équipes. Melvynx explore en détail le fonctionnement des plugins, comment les installer depuis des marketplaces tierces, et surtout comment créer sa propre marketplace personnalisée. La démonstration pratique montre la création du plugin AIBlueprint avec sa marketplace dédiée.

**Conclusion principale**: Les plugins répondent à un vrai besoin de partage de configuration, mais attention à ne pas polluer son environnement en installant trop de plugins non maîtrisés - privilégier la compréhension et l'adaptation manuelle.

---

## Timecodes

- **00:00** - Intro et objectifs de la vidéo
- **01:30** - Présentation des plugins et cas d'usage
- **03:00** - Naviguer et installer avec `/plugin`
- **04:30** - Démo : installer SecurityPro
- **06:00** - Utiliser les commandes et agents
- **07:30** - Ajouter et gérer les Marketplaces
- **09:00** - Structure locale : où s'installent les plugins
- **10:30** - Créer une marketplace et plugin
- **12:00** - Installer et tester un plugin local
- **13:30** - Récap étapes et conseils pratiques
- **15:00** - Avis personnel et conclusion

---

## Concepts Clés

### 1. 🔌 Plugins Claude Code

**Définition**: Les plugins sont des **collections packagées** de configurations Claude Code qui regroupent des slash commands, sub-agents, MCP servers et hooks. Ils permettent de partager et distribuer facilement un setup complet entre développeurs.

```
╔════════════════════════════════════════════════════════════╗
║                    🔌 PLUGIN CLAUDE CODE                   ║
╚════════════════════════════════════════════════════════════╝
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
    ┌────────┐         ┌────────┐         ┌────────┐
    │   📋   │         │  🤖   │         │  🔧   │
    │Commands│         │ Agents │         │  MCP   │
    └────────┘         └────────┘         └────────┘
        │                   │                   │
        └───────────────────┼───────────────────┘
                            ▼
                        ┌────────┐
                        │  🪝   │
                        │ Hooks  │
                        └────────┘
```

**Avantages**:
- ✅ **Partage facile** : Distribuer un setup complet en une commande
- ✅ **Standards d'équipe** : Enforcer des conventions dans les projets
- ✅ **Activation/désactivation** : Toggle on/off sans désinstaller
- ✅ **Écosystème communautaire** : Réutiliser des configs éprouvées

**Limitations**:
- ❌ **Pollution de contexte** : Risque d'avoir trop de commandes/agents
- ❌ **Manque de contrôle** : Configs qu'on ne maîtrise pas toujours
- ❌ **Verbosité** : Structure de marketplace un peu complexe
- ❌ **Dépendance** : Mises à jour non contrôlées des plugins tiers

**Cas d'usage**:
- 🏢 **Équipes** : Partager la config standardisée d'une entreprise
- 🎓 **Open Source** : Proposer des outils aux contributeurs
- 🔧 **Workflows personnels** : Distribuer sa config optimale (comme AIBlueprint)
- ⚡ **Setup rapide** : Connecter rapidement des MCP servers complexes

---

### 2. 🏪 Marketplaces

**Définition**: Les marketplaces sont des **registres de plugins** hébergés sur GitHub qui permettent de centraliser et distribuer plusieurs plugins. N'importe qui peut créer sa marketplace en suivant une structure simple.

```
🏪 MARKETPLACE FLOW
═══════════════════════════════════════════════════════════

1️⃣ CRÉATION
   📁 mon-repo/
   ┗━━ 📄 .claude/plugins/marketplace.json
       {
         "name": "Ma Marketplace",
         "plugins": [...]
       }

2️⃣ PUBLICATION
   GitHub: user/mon-repo
            ▼
   Commit + Push marketplace.json

3️⃣ AJOUT PAR UTILISATEUR
   /plugin marketplace add user/mon-repo
            ▼
   ┌───────────────────────────────────┐
   │  Marketplace téléchargée localement │
   └───────────────────────────────────┘

4️⃣ INSTALLATION PLUGIN
   /plugin → Browse → Select plugin
            ▼
   Plugin installé dans ~/.claude/plugins/
```

**Structure marketplace.json** :
```json
{
  "name": "I Blueprint",
  "owner": "Melvynx",
  "description": "blueprints.dev courses configuration",
  "plugins": [
    {
      "name": "AIBP base",
      "source": "./claude-code-config",
      "description": "Base config for blueprints.dev",
      "version": "1.0.0",
      "author": "Melvynx"
    }
  ]
}
```

**Marketplaces testées dans la vidéo** :
- 🔹 **claude-code-templates** : Workflows standards (Git, Supabase, Next.js, Security Pro)
- 🔹 **cloud-code-workflow** (Weston) : Collection de plugins communautaires
- 🔹 **AI Blueprint** (Melvynx) : Config personnalisée pour ses cours

---

### 3. ⚙️ Installation et Gestion

**Définition**: Claude Code fournit une interface CLI complète via `/plugin` pour gérer l'écosystème des plugins et marketplaces.

```
📋 COMMANDES /PLUGIN
═══════════════════════════════════════════════════════════

┌─────────────────────────────────────────────────────────┐
│  /plugin                                                │
│  ┣━━ 🔍 Browse and install plugin                       │
│  ┣━━ ⚙️  Manage and uninstall plugin                    │
│  ┣━━ ➕ Add marketplace                                 │
│  ┗━━ 🏪 Manage marketplaces                             │
└─────────────────────────────────────────────────────────┘

🔄 CYCLE DE VIE D'UN PLUGIN
═══════════════════════════════════════════════════════════

Install              Enable              Use               Disable
  ▼                   ▼                  ▼                  ▼
┌────┐  space   ┌────────┐   call   ┌───────┐   space   ┌────────┐
│ 📦 │─────────>│   ✅   │─────────>│  🚀   │─────────>│   ⏸️   │
└────┘          └────────┘          └───────┘          └────────┘
 Idle            Active              Running            Paused
```

**Où sont stockés les plugins ?** :
```
~/.claude/plugins/
┣━━ 📁 marketplace-1/
┃   ┣━━ 📄 marketplace.json
┃   ┗━━ 📁 plugin-a/
┃       ┣━━ 📁 commands/
┃       ┣━━ 📁 agents/
┃       ┗━━ 📄 hooks.json
┣━━ 📁 marketplace-2/
┗━━ 📄 enabled-plugins.json
```

**Actions disponibles** :
- ⌨️ **Enter** : Installer / Voir détails
- **Space** : Toggle Enable/Disable
- **Delete** : Marquer pour désinstallation
- **U** : Marquer pour update

---

## Citations Marquantes

> "Claude Code devient une vraie OS pour coder entre guillemets avec des commandes, des agents et maintenant des plugins voire même des marketplace."

> "Je sais comment ça finit, je vous connais les gars. On arrive, on finit par installer 25 plugins, on les utilise une fois tous les 2 ans et on se retrouve avec un contexte pollué."

> "À force d'ajouter des plugins, on vient de rajouter ici des custom agents avec des tokens qui sont potentiellement pas ce qu'on veut."

> "C'est ce que je vous invite à faire quand vous utilisez mes commandes : vous dire est-ce que j'ai besoin de cette commande ? Comment je la modifie ? Que c'est plugin, je sais pas si c'est adapté à mon code."

> "J'aurais préféré avoir une commande 'plugin add URL' et bam. Un peu comme ChatGPT UI. Un registry.json, tu mets l'URL et ça download tout."

---

## Points d'Action

### ✅ Immédiat (< 1h)

1. **Tester la commande `/plugin`**
   - Lancer `/plugin` dans Claude Code
   - Explorer l'interface Browse/Manage/Add
   - Vérifier si des plugins sont déjà installés

2. **Ajouter une marketplace de test**
   - Commande : `/plugin marketplace add cloud-code-templates/claude-code-templates`
   - Explorer les plugins disponibles
   - Ne pas installer pour le moment (juste observer)

3. **Auditer ses besoins réels**
   - Lister les commandes/agents qu'on utilise vraiment
   - Identifier ce qui pourrait être packagé en plugin
   - Éviter la tentation d'installer sans réfléchir

### 🔄 Court Terme (1 jour - 1 semaine)

4. **Installer et tester 1-2 plugins pertinents**
   - Choisir des plugins alignés avec son workflow actuel
   - Les activer, tester, puis désactiver si non utiles
   - Documenter ce qui fonctionne bien

5. **Analyser le code des plugins installés**
   - Explorer `~/.claude/plugins/`
   - Lire les commandes et agents pour comprendre leur fonctionnement
   - Copier/adapter ce qui est pertinent plutôt que tout garder

6. **Créer un plugin personnel pour son équipe**
   - Structure : `commands/`, `agents/`, `hooks.json`
   - Packager ses 3-5 meilleures commandes/agents
   - Créer un `marketplace.json` local

### 💪 Long Terme (> 1 semaine)

7. **Publier sa propre marketplace**
   - Créer un repo GitHub public
   - Ajouter `.claude/plugins/marketplace.json`
   - Partager avec la communauté

8. **Mettre en place un standard d'équipe**
   - Définir les plugins obligatoires pour les projets
   - Créer une marketplace d'entreprise privée
   - Former les devs à l'utilisation

9. **Contribuer à l'écosystème**
   - Proposer des améliorations de plugins existants
   - Créer des plugins open-source de qualité
   - Partager ses retours d'expérience

---

## Ressources Mentionnées

### 🔗 Outils

- **AIBlueprint CLI** : [https://mlv.sh/cc-cli](https://mlv.sh/cc-cli)
  - Config personnalisée de Melvynx pour Claude Code
  - Installation : `plugin marketplace add melvynx/aiblueprint`

- **Claude Code Templates** : Marketplace officielle avec plugins standards
  - Plugins : Git Workflow, Supabase, Next.js, Security Pro
  - Installation : `/plugin marketplace add cloud-code-templates/claude-code-templates`

- **Weston's Marketplace** : [Weston Hobson Commands](https://github.com/wshobson)
  - Collection communautaire de plugins
  - Installation : `/plugin marketplace add wshobson/commands`

### 📚 Documentation

- **Plugin Documentation** : Docs officielles Claude Code (mentionné dans la vidéo)
- **Cursor IDE** : Utilisé dans la démo pour visualiser la structure
- **GitHub** : Hébergement des marketplaces et plugins

### 🎓 Cours Melvynx

- JavaScript gratuit : [https://mlv.sh/js](https://mlv.sh/js)
- React gratuit : [https://mlv.sh/react](https://mlv.sh/react)
- Next.js gratuit : [https://mlv.sh/nextjs](https://mlv.sh/nextjs)
- Masterclass SaaS : [https://mlv.sh/nowts-masterclass](https://mlv.sh/nowts-masterclass)

---

## Schéma Récapitulatif

```
🔄 ÉCOSYSTÈME PLUGINS CLAUDE CODE
═══════════════════════════════════════════════════════════════════════

                    🌐 COMMUNAUTÉ
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
    🏪 Market 1     🏪 Market 2     🏪 Market 3
    (Official)     (Community)     (Personal)
        │                │                │
        └────────────────┼────────────────┘
                         ▼
              /plugin marketplace add
                         │
                         ▼
              ┌──────────────────────┐
              │   ~/.claude/plugins   │
              │                       │
              │  📦 Plugin A          │
              │  📦 Plugin B          │
              │  📦 Plugin C          │
              └──────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
    📋 Commands     🤖 Agents       🔧 MCP Servers
        │                │                │
        └────────────────┼────────────────┘
                         ▼
                   ⚠️ ATTENTION ⚠️

        ❌ POLLUTION DE CONTEXTE POSSIBLE

        ┌─────────────────────────────────┐
        │ Trop de plugins = Contexte lourd│
        │ → Ralentissement                │
        │ → Commandes inutilisées         │
        │ → Agents non maîtrisés          │
        └─────────────────────────────────┘

                         │
                         ▼
              ✅ SOLUTION : MINIMALISME

        🎯 N'installer QUE le nécessaire
        🔍 Auditer et comprendre chaque plugin
        🧹 Désactiver ce qui n'est pas utilisé
        ✂️  Copier/adapter plutôt que tout garder
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- **Sécurité** : Comment vérifier qu'un plugin tiers ne contient pas de code malveillant ?
- **Versioning** : Comment gérer les mises à jour de plugins et la compatibilité ?
- **Performance** : Quel est l'impact réel sur les tokens d'avoir 5, 10, 20 plugins activés ?
- **Isolation** : Peut-on avoir des plugins actifs uniquement sur certains projets ?
- **Registry centralisé** : Pourquoi pas un NPM-like officiel pour les plugins Claude ?

### 💡 Idées d'Amélioration

- **Plugin scopes** : Activer des plugins uniquement pour certains projets (comme npm workspaces)
- **URL directe** : `plugin add https://mon-site.com/plugin.json` sans passer par marketplace
- **Plugin CI/CD** : Plugins dédiés aux pipelines (tests, build, deploy)
- **Analytics** : Dashboard montrant les plugins les plus utilisés/populaires
- **Validation** : Système de review/certification des plugins communautaires

### 🔗 À Combiner Avec

- 📄 **[Skills vs MCP vs Sub-Agents](skills-vs-mcp-vs-subagents.md)** : Comprendre où se positionnent les plugins dans l'architecture
- 📄 **[Sub-Agents Usage](subagents-usage-melvynx.md)** : Les agents peuvent être packagés dans des plugins
- 📄 **[800h Claude Code - Edmund Yong](800h-claude-code-edmund-yong.md)** : Best practices pour organiser sa config
- 📄 **Memory Guide** : Les plugins peuvent-ils contenir des fichiers CLAUDE.md ?

---

## Conclusion

**Message clé** : Les plugins Claude Code sont un **game changer pour le partage de configurations**, mais il faut les utiliser avec discernement. Privilégier la compréhension et l'adaptation manuelle plutôt que l'installation aveugle de dizaines de plugins. Le vrai power user maîtrise ce qu'il utilise.

**Action immédiate** : Lancer `/plugin`, explorer une marketplace, installer UN SEUL plugin pertinent, le tester à fond, puis décider s'il reste ou non.

---

**🎓 Niveau de difficulté** : 🟡 Niveau 2 - Utilisation (nécessite de comprendre commands/agents/MCP)
**⏱️ Temps de mise en pratique** : 20-30 minutes (installation + test)
**💪 Impact** : 🔥 Élevé pour les équipes, Moyen pour usage solo
