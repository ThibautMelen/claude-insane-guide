# La Status Line ULTIME pour Claude Code - Tracking Contexte & Usage en Temps Réel

![Miniature vidéo](https://img.youtube.com/vi/CgxOnY-RIlo/maxresdefault.jpg)

## Informations Vidéo

- **Titre**: La Status Line ULTIME pour Claude Code
- **Auteur**: Melvynx
- **Durée**: 11 minutes
- **Date**: Novembre 2025
- **Lien**: [https://youtu.be/CgxOnY-RIlo](https://youtu.be/CgxOnY-RIlo)

## Tags

`#statusline` `#claude-code` `#custom-script` `#context-tracking` `#usage-monitoring` `#typescript` `#git-integration` `#api-token` `#productivity` `#developer-tools`

---

## Résumé Exécutif

Melvynx présente sa status line personnalisée pour Claude Code, développée après plusieurs jours de travail minutieux. Cette status line affiche en temps réel les informations Git, le contexte utilisé (tokens et pourcentage), le coût de la session, et le pourcentage d'usage quotidien. Le tout est réalisé via un projet TypeScript custom qui reverse-engineer les APIs de Claude et récupère automatiquement les credentials stockés localement.

**Conclusion principale**: Une status line intelligente transforme radicalement l'expérience développeur en donnant une visibilité temps réel sur l'utilisation du contexte et les limites, permettant d'optimiser son workflow et éviter l'auto-compact surprise.

---

## Timecodes

- `00:00` - Présentation de la status line ultime
- `00:17` - Démonstration des features Git et contexte
- `00:41` - Explication du tracking de session et tokens
- `01:21` - Précision des données et auto-compact à 99%
- `01:51` - Tracking du budget journalier et reset time
- `02:29` - Architecture du projet et configuration
- `03:09` - Code source : récupération du contexte
- `04:54` - Récupération des credentials et API token
- `06:46` - Installation et personnalisation
- `09:22` - Adaptation pour Windows et debugging
- `10:40` - Invitation à rejoindre la communauté

---

## Concepts Clés

### 1. Architecture Multi-Couches de la Status Line

**Définition**: Une status line structurée en 3 niveaux d'information : Git (base), Session (contexte/tokens), Usage (limites quotidiennes).

```
╔══════════════════════════════════════════════════════╗
║                 STATUS LINE ARCHITECTURE             ║
╠══════════════════════════════════════════════════════╣
║  LIGNE 1: Git Info                                   ║
║  ┌─────────────────────────────────────────────┐    ║
║  │ 📦 Branch │ +Files │ -Files │ Staging       │    ║
║  └─────────────────────────────────────────────┘    ║
║                         ▼                            ║
║  LIGNE 2: Session & Context                          ║
║  ┌─────────────────────────────────────────────┐    ║
║  │ 💰 $0.XX │ 🧠 163K tokens │ 81% used        │    ║
║  └─────────────────────────────────────────────┘    ║
║                         ▼                            ║
║  LIGNE 3: Usage Limits                               ║
║  ┌─────────────────────────────────────────────┐    ║
║  │ 📊 43% daily │ Reset in 2h06m │ ████░░░░    │    ║
║  └─────────────────────────────────────────────┘    ║
╚══════════════════════════════════════════════════════╝
```

**Avantages**:
- ✅ Visibilité instantanée sur l'état du projet
- ✅ Prévention de l'auto-compact surprise (alerte à 99%)
- ✅ Optimisation du budget quotidien
- ✅ Tracking précis des coûts par session

**Limitations**:
- ❌ Nécessite adaptation pour Windows (credential storage)
- ❌ Dépend du reverse-engineering des APIs internes

**Cas d'usage**:
- Sessions longues de développement intensif
- Projets avec beaucoup de contexte (>100K tokens)
- Optimisation des coûts Claude Pro
- Éviter les interruptions par auto-compact

---

### 2. Reverse Engineering des APIs Claude

```
┌─────────────────────┐
│  TRANSCRIPT PATH    │
│   /Library/Cache/   │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐     ┌──────────────────────┐
│  Parse JSON Files   │────>│  Extract Token Info  │
│  • Messages         │     │  • Input tokens      │
│  • Metadata         │     │  • Cache tokens      │
└─────────────────────┘     └──────────┬───────────┘
                                       │
                    ┌──────────────────▼──────────────┐
                    │      Calculate Context %        │
                    │   (Current / Max) * 100         │
                    └──────────────────────────────────┘
```

L'accès aux transcripts locaux permet d'extraire précisément les tokens utilisés sans passer par une API externe. Le système analyse les fichiers JSON de cache pour calculer l'utilisation réelle du contexte.

---

### 3. Récupération Automatique des Credentials

```
╔═══════════════════════════════════════════════╗
║         CREDENTIAL RETRIEVAL FLOW            ║
╠═══════════════════════════════════════════════╣
║                                               ║
║  macOS Keychain                               ║
║  ┌─────────────────────────────────────┐     ║
║  │ security find-generic-password      │     ║
║  │ -s "claude-code-credential"         │     ║
║  └──────────────┬──────────────────────┘     ║
║                 │                             ║
║                 ▼                             ║
║  ┌─────────────────────────────────────┐     ║
║  │     Extract API Token               │     ║
║  │     Format: sk-ant-api03-xxxxx      │     ║
║  └──────────────┬──────────────────────┘     ║
║                 │                             ║
║                 ▼                             ║
║  ┌─────────────────────────────────────┐     ║
║  │   Fetch Usage from Claude API       │     ║
║  │   POST /api/auth/usage              │     ║
║  └─────────────────────────────────────┘     ║
║                                               ║
╚═══════════════════════════════════════════════╝
```

Le système utilise les commandes natives du système d'exploitation pour récupérer de manière sécurisée le token API stocké localement, permettant ensuite d'interroger l'API Claude pour obtenir les limites d'usage.

---

## Citations Marquantes

> "Quand tu arrives à 99%, l'auto-compact s'effectue automatiquement et c'est une information cruciale quand tu codes pour réussir à avancer"

> "Moi je sais que quand j'arrive à la fin de ma session et qu'il me reste 30 minutes, je commence à bombarder les messages"

> "J'ai passé des jours sur cette status line à faire tout au pixel près"

---

## Points d'Action

### ✅ Immédiat

1. **Installer la Status Line via le Setup Script**
   - Cloner le repo de Melvynx
   - Exécuter la commande d'installation unique
   - Choisir les features à activer

2. **Configurer selon ses préférences**
   - Ajuster les couleurs (progressive, green, custom)
   - Définir la taille de la progress bar
   - Activer/désactiver l'affichage du modèle

### 🔄 Court Terme

3. **Adapter pour Windows si nécessaire**
   - Utiliser Claude Code pour trouver l'emplacement des credentials Windows
   - Modifier la fonction `getCredentials()` en conséquence

### 💪 Long Terme

4. **Contribuer au projet**
   - Proposer des améliorations via pull requests
   - Ajouter le support multi-plateforme
   - Créer des thèmes personnalisés

---

## Ressources Mentionnées

### 🔗 Outils

- **Setup Claude Code en 10 secondes** : [Lien dans la description de la vidéo]
  - Installation complète avec commandes, agents, permissions et status line

### 📚 Documentation

- **Projet Status Line** : Repository GitHub de Melvynx
  - Code source TypeScript complet
  - Configuration personnalisable
  - Documentation d'installation

---

## Schéma Récapitulatif

```
         ╔════════════════════════════════════╗
         ║     STATUS LINE DATA FLOW          ║
         ╚════════════════════════════════════╝
                          │
         ┌────────────────┼────────────────┐
         │                │                │
         ▼                ▼                ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  Git Data   │  │Context Data │  │ Usage Data  │
│  • Branch   │  │ • Tokens    │  │ • Daily %   │
│  • Files    │  │ • Cache     │  │ • Reset     │
│  • Staging  │  │ • Percent   │  │ • Progress  │
└──────┬──────┘  └──────┬──────┘  └──────┬──────┘
       │                │                │
       └────────────────┼────────────────┘
                        │
                        ▼
            ┌───────────────────┐
            │   Format & Display │
            │   • Colors        │
            │   • Progress Bar  │
            │   • Separators    │
            └───────────────────┘
                        │
                        ▼
                ╔═══════════════╗
                ║ Terminal View ║
                ╚═══════════════╝
```

---

## Notes Personnelles

### 🤔 Questions à Explorer

- Comment adapter le système pour d'autres IDEs (VS Code, Neovim) ?
- Possibilité d'ajouter des webhooks pour alertes contexte ?
- Intégration avec des dashboards de monitoring externes ?

### 💡 Idées d'Amélioration

- Ajouter un historique graphique de l'utilisation sur 7 jours
- Créer des profils de configuration par type de projet
- Système d'alertes sonores avant l'auto-compact
- Export des métriques pour analyse post-session

### 🔗 À Combiner Avec

- Guide des Sub-Agents de Melvynx pour workflow optimal
- Techniques d'optimisation du contexte Claude Code
- Stratégies de gestion du budget Pro

---

## Conclusion

**Message clé** : Une status line bien configurée est l'outil indispensable pour maîtriser Claude Code - elle transforme une expérience aveugle en pilotage précis avec dashboard temps réel.

**Action immédiate** : Installer la status line via le script d'installation et personnaliser selon son workflow (couleurs, taille progress bar, infos affichées).

---

**🎓 Niveau de difficulté** : 🟡 Intermédiaire (installation simple, customisation avancée)
**⏱️ Temps de mise en pratique** : 15-30 minutes (installation + configuration)
**💪 Impact** : 🔥 Très élevé - Amélioration drastique de la productivité