---
description: Vérifier le statut de tous les composants Supernovae Studio
allowed-tools: Bash(python:*), Bash(node:*), Bash(git:*), Read
---

# Supernovae Studio Status Check

Vérifie le statut complet de l'environnement Supernovae Studio.

## Tâches à effectuer

1. **Vérifier l'installation des dépendances**
   - Python version (requis: 3.8+)
   - Node.js version (requis: 18+)
   - Packages Python installés
   - Packages npm installés

2. **Vérifier les plugins Claude Code**
   - Plugin Local Global Info installé et activé
   - Plugin Traduction installé et activé
   - Plugin QR Code AI installé et activé

3. **Vérifier les serveurs MCP**
   - MCP Server global-info accessible
   - MCP Server qr-code-ai accessible
   - Authentification OAuth valide

4. **Vérifier l'état du repository**
   - Branche actuelle
   - Statut git (fichiers modifiés, staged, etc.)
   - Dernier commit

5. **Résumé**
   - Créer un rapport de statut clair
   - Signaler les problèmes détectés
   - Suggérer des actions de correction si nécessaire

## Format du Résultat

Présenter le résultat sous forme de tableau avec:
- Composant
- Statut (✅ OK, ⚠️ Warning, ❌ Error)
- Détails
