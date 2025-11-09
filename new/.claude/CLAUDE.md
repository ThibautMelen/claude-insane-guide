# Supernovae Studio - Claude Code Configuration

Bienvenue dans le projet Supernovae Studio ! Ce projet utilise Claude Code avec une marketplace personnalisée pour gérer 174 locales, des traductions contextuelles et la génération de QR codes avec IA.

## 🎯 Objectif du Projet

Fournir une suite complète d'outils pour :
- **Gestion de 174 locales** avec informations détaillées (langue, région, format, culture)
- **Traduction contextuelle** utilisant les données de locales pour une précision maximale
- **Génération de QR codes** avec intelligence artificielle et analyse

## 📦 Plugins Disponibles

### 1. Local Global Info
- Accès à la base de données des 174 locales
- CRUD complet sur les données de locales
- Recherche et filtrage avancés
- **MCP Server :** `global-info`

### 2. Plugin Traduction
- Traduction contextuelle multi-locale
- Utilise les données de Global Info pour précision
- Peut récupérer contexte des QR codes
- **MCP Client :** Utilise `global-info` et `qr-code-ai`

### 3. QR Code AI
- Génération intelligente de QR codes
- Analyse et optimisation AI
- Stockage des métadonnées
- **MCP Server :** `qr-code-ai`

## 🔧 Commandes Bash Courantes

```bash
# Vérifier l'installation des dépendances
python --version  # Python 3.8+
node --version    # Node.js 18+

# Installer les dépendances Python
pip install -r requirements.txt

# Installer les dépendances Node
npm install

# Lancer les tests
python -m pytest tests/
npm test

# Lancer le serveur de dev
npm run dev
```

## 📁 Fichiers et Répertoires Importants

### Configuration Claude Code
- `.claude/settings.json` - Configuration du projet
- `.claude/CLAUDE.md` - Ce fichier
- `.claude/commands/` - Slash commands personnalisés
- `.claude/agents/` - Subagents spécialisés

### Marketplace et Plugins
- `supernovae-marketplace/` - Marketplace Supernovae Studio
- `supernovae-marketplace/local-global-info/` - Plugin gestion locales
- `supernovae-marketplace/plugin-traduction/` - Plugin traduction
- `supernovae-marketplace/qr-code-ai/` - Plugin QR codes

### Documentation
- `CLAUDE_CODE_NEWS.md` - Dernières news et features Claude Code
- `SUPERNOVAE_ARCHITECTURE.md` - Architecture détaillée avec schémas ASCII
- `README.md` - Guide d'installation et utilisation

## 🎨 Style de Code

### Python
- **Indentation :** 4 espaces
- **Max line length :** 100 caractères
- **Docstrings :** Style Google
- **Type hints :** Obligatoires pour fonctions publiques
- **Formatter :** Black
- **Linter :** Pylint + Flake8

```python
def get_locale_info(locale_code: str) -> dict[str, any]:
    """
    Récupère les informations d'une locale.

    Args:
        locale_code: Code de la locale (ex: 'fr-FR')

    Returns:
        Dictionnaire contenant les informations de la locale
    """
    pass
```

### JavaScript/TypeScript
- **Indentation :** 2 espaces
- **Quotes :** Simple quotes pour strings
- **Semicolons :** Toujours
- **Module system :** ES modules (import/export)
- **Formatter :** Prettier
- **Linter :** ESLint

```javascript
export function translateText(text, sourceLocale, targetLocale) {
  // Implementation
}
```

### Markdown
- **Headers :** Utiliser ATX style (`# Header`)
- **Lists :** `-` pour unordered, `1.` pour ordered
- **Code blocks :** Toujours spécifier le langage
- **Line length :** Soft wrap à 80 caractères

## 🧪 Tests

### Avant de Committer
**IMPORTANT :** Toujours lancer les tests avant de committer !

```bash
# Tests Python
python -m pytest tests/ -v

# Tests JavaScript
npm test

# Linter
black . --check
pylint src/
npm run lint
```

### Écriture de Tests
- Un fichier de test par module : `test_module.py` ou `module.test.js`
- Nommer les tests clairement : `test_should_return_locale_data_when_code_exists`
- Utiliser des fixtures pour les données de test
- Mocker les appels API externes

## 🔄 Workflow Git

### Branches
- `main` - Branche principale, toujours stable
- `develop` - Développement en cours
- `feature/nom-feature` - Nouvelles fonctionnalités
- `fix/nom-fix` - Corrections de bugs

### Commits
- Messages en français
- Format : `[type] Description concise`
- Types : `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Exemples :
```
[feat] Ajouter support pour locale ar-SA
[fix] Corriger validation des codes QR
[docs] Mettre à jour architecture ASCII
```

### Pull Requests
- Toujours créer une PR pour merger vers `main` ou `develop`
- Inclure description des changements
- Lier les issues concernées
- Demander review à au moins une personne

## 🔌 Utilisation des MCP Servers

### Global Info Server

```bash
# Lister toutes les locales
/mcp__global_info__list_locales

# Obtenir une locale spécifique
/mcp__global_info__get_locale fr-FR

# Mettre à jour une locale
/mcp__global_info__update_locale fr-FR '{"currency": "EUR"}'

# Rechercher dans les locales
/mcp__global_info__search_locales "Europe"
```

### QR Code AI Server

```bash
# Générer un QR code
/mcp__qr_code_ai__generate_qr "https://supernovae.studio"

# Récupérer les données d'un QR code
/mcp__qr_code_ai__get_qr_data qr_abc123

# Analyser un QR code depuis une image
/mcp__qr_code_ai__analyze_qr /path/to/qr-image.png
```

## 🎯 Workflows Recommandés

### Ajouter une Nouvelle Locale

1. Utiliser la commande `/add-locale` ou appeler directement l'API
2. Valider les données avec `validate-locale.py`
3. Tester la récupération avec `/get-locale`
4. Committer les changements

### Traduire du Contenu

1. Identifier la locale source et cible
2. Utiliser `/translate [text] [source] [target]`
3. Le plugin récupère automatiquement le contexte via MCP Global Info
4. Valider la traduction avec un locuteur natif si disponible

### Générer un QR Code

1. Préparer les données à encoder
2. Utiliser `/generate-qr [data] [options]`
3. Le plugin optimise avec AI
4. Récupérer l'ID et l'image générée

## ⚠️ Points d'Attention

### Sécurité
- **JAMAIS** committer de secrets, API keys, ou credentials
- Toujours utiliser des variables d'environnement
- Les credentials MCP sont dans `${GLOBAL_INFO_CLIENT_ID}` etc.
- Fichiers `.env` sont dans `.gitignore`

### Performance
- Utiliser le caching pour données fréquemment accédées
- Batch les appels API quand possible
- Progressive disclosure : ne charger que le contexte nécessaire

### Base de Données
- Toujours valider les données avant insertion
- Utiliser des transactions pour opérations multiples
- Logger toutes les modifications pour audit

## 🐛 Debugging

### Claude Code
```bash
# Mode debug
claude --debug

# Voir le contexte actuel
/context

# Vérifier l'usage des tokens
/cost

# Lister les tâches background
/bashes
```

### MCP Servers
```bash
# Debug MCP
claude --mcp-debug

# Lister les serveurs MCP
/mcp

# Vérifier l'authentification
/mcp auth global-info
```

### Logs
- Logs Claude : `.claude/session-log.txt`
- Logs éditions : `.claude/edit-log.txt`
- Logs application : `logs/app.log`

## 📚 Ressources

### Documentation
- Architecture détaillée : @SUPERNOVAE_ARCHITECTURE.md
- News Claude Code : @CLAUDE_CODE_NEWS.md
- Guide d'installation : @README.md

### Liens Utiles
- Docs Claude Code : https://code.claude.com/docs
- MCP Protocol : https://modelcontextprotocol.io
- Anthropic Academy : https://anthropic.skilljar.com

### Support
- Email : dev@supernovae.studio
- Documentation interne : voir fichiers du projet

## 💡 Conseils d'Utilisation avec Claude

### Soyez Spécifiques
Au lieu de "ajoute une locale", préférez :
> "Ajoute la locale ja-JP avec les informations suivantes : langue japonais, région Japon, devise JPY (¥), format de date YYYY/MM/DD, écriture verticale possible, style formel avec keigo"

### Utilisez les Images
- Drag & drop des mocks de design
- Screenshots des erreurs
- Diagrammes pour architecture

### Course Correction
- Demandez un plan avant le coding
- Appuyez sur Escape pour interrompre
- Double Escape pour revenir en arrière
- Utilisez `/rewind` si nécessaire

### Gestion du Contexte
- Utilisez `/clear` fréquemment entre tâches
- Mentionnez les fichiers avec tab-completion
- Référencez avec `@filename.ext`

### Utilisation des Subagents
- Les subagents ont leur propre contexte isolé
- Parfait pour tâches parallèles
- Voir `.claude/agents/` pour exemples

## 🎓 Best Practices

1. **Toujours commencer par lire la documentation** - @SUPERNOVAE_ARCHITECTURE.md
2. **Tester avant de committer** - Lancer tests unitaires et linters
3. **Documenter les changements** - Mettre à jour README et comments
4. **Utiliser les slash commands** - Plus rapide que d'écrire à chaque fois
5. **Exploiter les Skills** - Les plugins ont des Skills qui se chargent automatiquement
6. **Progressive Disclosure** - Ne charger que le contexte nécessaire
7. **Valider les données** - Toujours valider avant insertion en DB
8. **Logger les opérations** - Pour debug et audit

## 🔄 Mises à Jour

Ce fichier est régulièrement mis à jour. Dernière modification : 2025-01-06

Pour ajouter rapidement des informations à ce fichier, utilisez la touche `#` au début de votre prompt.

---

**Version :** 1.0.0
**Projet :** Supernovae Studio
**Claude Code :** Configuré et opérationnel
