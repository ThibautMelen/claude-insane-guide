# 🔧 Guide de Troubleshooting Claude Code

> Résolution rapide des problèmes courants avec Claude Code

## 📋 Table des Matières

1. [Problèmes d'Installation](#-problèmes-dinstallation)
2. [Problèmes de Configuration](#-problèmes-de-configuration)
3. [Memory & Settings](#-memory--settings)
4. [Commands & Slash Commands](#-commands--slash-commands)
5. [MCP Servers](#-mcp-servers)
6. [Agents & Sub-agents](#-agents--sub-agents)
7. [Performance](#-performance)
8. [Erreurs Courantes](#-erreurs-courantes)
9. [Outils de Diagnostic](#-outils-de-diagnostic)
10. [Support & Ressources](#-support--ressources)

---

## 🔴 Problèmes d'Installation

### Claude command not found

**Symptômes** :
```bash
$ claude
zsh: command not found: claude
```

**Solutions** :
```bash
# Solution 1: Réinstaller
curl -fsSL https://claude.ai/install.sh | bash

# Solution 2: Vérifier PATH
echo $PATH | grep -o claude
export PATH="$PATH:$HOME/.local/bin"

# Solution 3: Installation manuelle
npm install -g @anthropic-ai/claude-code

# Solution 4: Homebrew (Mac)
brew tap anthropics/claude
brew install claude-code
```

### Permission denied

**Symptômes** :
```bash
$ claude
bash: /usr/local/bin/claude: Permission denied
```

**Solutions** :
```bash
# Fix permissions
chmod +x /usr/local/bin/claude
sudo chown $USER:$USER /usr/local/bin/claude

# Alternative: Installation utilisateur
npm install --prefix ~/.local @anthropic-ai/claude-code
```

---

## ⚙️ Problèmes de Configuration

### API Key invalide

**Symptômes** :
```
Error: Invalid API key provided
```

**Solutions** :
```bash
# Vérifier la clé
echo $ANTHROPIC_API_KEY

# Re-configurer
claude login

# Alternative: Export manuel
export ANTHROPIC_API_KEY="sk-ant-..."

# Vérifier config
cat ~/.config/claude-code/config.json
```

### Modèle non disponible

**Symptômes** :
```
Error: Model claude-3-opus not available
```

**Solutions** :
```bash
# Utiliser modèle disponible
claude --model claude-3-5-sonnet

# Vérifier modèles disponibles
claude --list-models

# Fallback sur défaut
unset CLAUDE_MODEL
```

---

## 🧠 Memory & Settings

### Memory ne se charge pas

**Symptômes** :
- Instructions dans CLAUDE.md ignorées
- Préférences non appliquées

**Solutions** :

#### 1. Vérifier l'emplacement
```bash
# Global memory
ls -la ~/.claude/CLAUDE.md

# Project memory
ls -la .claude/CLAUDE.md

# Priorité: Local > Global
```

#### 2. Vérifier syntaxe Markdown
```markdown
<!-- BON ✅ -->
# Titre correct

## Section valide
- Point 1
- Point 2

<!-- MAUVAIS ❌ -->
#Titre collé
## Section sans espace
```

#### 3. Restart session
```bash
# Quitter Claude
exit

# Relancer
claude

# Vérifier chargement
/context
```

### Settings.json non lu

**Symptômes** :
- Configuration ignorée
- Paramètres par défaut utilisés

**Solutions** :
```bash
# Vérifier JSON valide
python -m json.tool .claude/settings.json

# Exemple correct
cat > .claude/settings.json << 'EOF'
{
  "model": "claude-3-5-sonnet",
  "maxTokens": 4096,
  "temperature": 0.7
}
EOF

# Permissions
chmod 644 .claude/settings.json
```

---

## 💬 Commands & Slash Commands

### Command not found

**Symptômes** :
```
/mycommand
Error: Command not found
```

**Solutions** :

#### 1. Vérifier existence
```bash
ls .claude/commands/
cat .claude/commands/mycommand.md
```

#### 2. Vérifier format
```markdown
---
description: Description obligatoire
---

Contenu de la commande
```

#### 3. Redémarrer Claude
```bash
# Les commands sont chargées au démarrage
exit
claude
```

### Command ne s'exécute pas

**Solutions** :
```bash
# Debug mode
claude --debug

# Vérifier permissions
ls -la .claude/commands/*.md

# Test simple
cat > .claude/commands/test.md << 'EOF'
---
description: Test command
---

Echo "Test successful"
EOF

# Tester
/test
```

---

## 🔌 MCP Servers

### MCP server connection failed

**Symptômes** :
```
Error: Failed to connect to MCP server
```

**Solutions** :

#### 1. Vérifier configuration
```bash
# Config location
cat ~/.config/claude-code/mcp-config.json

# Format correct
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"]
    }
  }
}
```

#### 2. Tester connexion
```bash
# Test direct
npx -y @modelcontextprotocol/server-filesystem

# Vérifier npm
npm --version
node --version

# Installer globalement
npm install -g @modelcontextprotocol/server-filesystem
```

#### 3. Logs MCP
```bash
# Activer debug
export MCP_DEBUG=1
claude

# Voir logs
tail -f ~/.claude/logs/mcp.log
```

### MCP tools not available

**Solutions** :
```bash
# Vérifier tools disponibles
/mcp list

# Restart avec config
claude --mcp-config ./mcp-config.json

# Vérifier dans Claude
> List available MCP tools
```

---

## 🤖 Agents & Sub-agents

### Agent ne se lance pas

**Symptômes** :
```
> Use code-reviewer agent
Error: Agent not found
```

**Solutions** :

#### 1. Structure correcte
```bash
# Créer structure
mkdir -p .claude/agents

# Fichier agent
cat > .claude/agents/code-reviewer.md << 'EOF'
---
name: code-reviewer
description: Reviews code
tools: Read, Grep, Glob
---

Agent instructions here
EOF
```

#### 2. YAML valide
```yaml
# Vérifier syntaxe
# - Les --- sur ligne séparée
# - Pas de tabs
# - Guillemets si caractères spéciaux

---
name: my-agent
description: "Agent: does something"
tools: Read, Write
---
```

#### 3. Invocation correcte
```bash
# Bon ✅
> Use the code-reviewer agent to review main.js

# Mauvais ❌
> code-reviewer main.js
```

### Agents parallèles lents

**Solutions** :
```bash
# Limiter nombre agents
claude --max-agents 4

# Optimiser modèles
# Haiku pour tâches simples
# Sonnet pour standard
# Opus seulement si nécessaire

# Configuration
{
  "parallelAgents": {
    "maxConcurrent": 4,
    "timeout": 30000
  }
}
```

---

## ⚡ Performance

### Claude très lent

**Causes & Solutions** :

#### 1. Context window trop large
```bash
# Réduire contexte
claude --max-context 100000

# Nettoyer historique
/clear

# Ignorer fichiers
echo "node_modules/" >> .claudeignore
echo "dist/" >> .claudeignore
```

#### 2. Modèle trop lourd
```bash
# Utiliser Haiku pour tâches simples
claude --model claude-3-haiku

# Sonnet par défaut
export CLAUDE_MODEL=claude-3-5-sonnet
```

#### 3. Rate limiting
```bash
# Vérifier limite
claude --show-limits

# Espacer requêtes
sleep 2 && claude -p "..."

# Utiliser cache
claude --enable-cache
```

### Mémoire insuffisante

**Solutions** :
```bash
# Augmenter heap Node.js
export NODE_OPTIONS="--max-old-space-size=8192"

# Clear cache Claude
rm -rf ~/.claude/cache/*

# Limiter output
claude --max-output 10000
```

---

## ❌ Erreurs Courantes

### Error: Context length exceeded

**Solution** :
```bash
# Réduire input
claude --max-files 10

# Utiliser .claudeignore
echo "*.log" >> .claudeignore
echo "*.min.js" >> .claudeignore

# Clear contexte
/clear
```

### Error: Timeout

**Solution** :
```bash
# Augmenter timeout
claude --timeout 60000

# Diviser tâche
# Au lieu de: "Refactor entire codebase"
# Faire: "Refactor src/components"
```

### Error: Git repository not found

**Solution** :
```bash
# Initialiser Git
git init

# Ou désactiver Git features
claude --no-git

# Config
{
  "git": {
    "enabled": false
  }
}
```

---

## 🔍 Outils de Diagnostic

### Debug Mode

```bash
# Lancer en debug
claude --debug

# Verbose logging
claude --verbose

# Trace complet
claude --trace
```

### Vérification Système

```bash
# Script diagnostic complet
cat > diagnose-claude.sh << 'EOF'
#!/bin/bash

echo "=== Claude Code Diagnostic ==="
echo ""

echo "1. Version:"
claude --version

echo -e "\n2. Configuration:"
ls -la ~/.config/claude-code/

echo -e "\n3. Memory files:"
ls -la ~/.claude/CLAUDE.md 2>/dev/null
ls -la .claude/CLAUDE.md 2>/dev/null

echo -e "\n4. Commands:"
ls -la .claude/commands/ 2>/dev/null

echo -e "\n5. MCP Servers:"
cat ~/.config/claude-code/mcp-config.json 2>/dev/null | head -20

echo -e "\n6. Environment:"
env | grep -i claude

echo -e "\n7. Node/NPM:"
node --version
npm --version

echo -e "\n8. Disk space:"
df -h ~ | head -2

echo -e "\n9. Process:"
ps aux | grep claude

echo -e "\n=== End Diagnostic ==="
EOF

chmod +x diagnose-claude.sh
./diagnose-claude.sh
```

### Logs

```bash
# Locations logs
~/.claude/logs/
~/.config/claude-code/logs/
/tmp/claude-*.log

# Tail logs temps réel
tail -f ~/.claude/logs/claude.log

# Grep erreurs
grep -i error ~/.claude/logs/*.log
```

### Test Minimal

```bash
# Test basique
echo "test" | claude -p "Echo this"

# Si marche → problème projet spécifique
# Si marche pas → problème installation/config
```

---

## 💬 Support & Ressources

### Obtenir de l'Aide

1. **Documentation Officielle**
   - 📄 [Docs Claude Code](https://code.claude.com/docs)
   - 📄 [Troubleshooting Guide](https://code.claude.com/docs/en/troubleshooting)

2. **Communauté**
   - 💬 [Discord Claude Code](https://discord.gg/claude-code)
   - 💬 [GitHub Discussions](https://github.com/anthropics/claude-code/discussions)

3. **Issues GitHub**
   - 🐛 [Report Bug](https://github.com/anthropics/claude-code/issues)
   - 💡 [Feature Request](https://github.com/anthropics/claude-code/issues/new?template=feature_request.md)

4. **Support Anthropic**
   - 📧 support@anthropic.com (compte Pro/Enterprise)
   - 🎫 [Support Portal](https://support.anthropic.com)

### Commandes Utiles

```bash
# Version et info
claude --version
claude --info

# Status
claude status

# Config
claude config show
claude config reset

# Update
claude update

# Uninstall/Reinstall
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code@latest
```

### Template Issue GitHub

```markdown
## Description
[Décrire le problème]

## Steps to Reproduce
1. Step 1
2. Step 2
3. Error occurs

## Expected Behavior
[Ce qui devrait se passer]

## Actual Behavior
[Ce qui se passe vraiment]

## Environment
- OS: [Mac/Linux/Windows]
- Claude Version: [claude --version]
- Node Version: [node --version]

## Logs
```
[Coller logs pertinents]
```

## Additional Context
[Autre information utile]
```

---

## 🎯 Quick Fixes Cheatsheet

```bash
# Fix 90% des problèmes
exit                    # Quitter Claude
rm -rf ~/.claude/cache  # Clear cache
claude update          # Update version
claude --debug         # Relancer en debug

# Reset complet
rm -rf ~/.claude
rm -rf ~/.config/claude-code
curl -fsSL https://claude.ai/install.sh | bash
```

---

**Note** : Si aucune solution ne fonctionne, consultez le [Discord](https://discord.gg/claude-code) ou ouvrez une [issue GitHub](https://github.com/anthropics/claude-code/issues) avec les logs complets.