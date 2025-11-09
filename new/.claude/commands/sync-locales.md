---
description: Synchroniser les locales locales avec la base de données cloud
allowed-tools: Bash(python:*), Read, Write
argument-hint: [direction: pull|push] [filter: optional]
---

# Sync Locales

Synchronise les données de locales entre le cache local et la base de données cloud.

## Arguments

- `$1` : Direction de synchronisation
  - `pull` : Télécharger depuis cloud vers local
  - `push` : Envoyer depuis local vers cloud
- `$2` : Filtre optionnel (ex: "Europe", "fr-*", "en-US,en-GB")

## Workflow

### Si direction = pull

1. Se connecter au MCP Server global-info
2. Récupérer les locales selon le filtre (ou toutes si pas de filtre)
3. Créer/mettre à jour le cache local dans `cache/locales/`
4. Générer un rapport de synchronisation

### Si direction = push

1. Lire les fichiers de locales dans `cache/locales/`
2. Valider chaque locale avec le script `validate-locale.py`
3. Envoyer les locales valides vers le cloud via MCP
4. Logger les erreurs de validation
5. Générer un rapport de synchronisation

## Précautions

- **TOUJOURS** valider les données avant un push
- **NE JAMAIS** écraser des données cloud sans backup
- **VÉRIFIER** que le filtre est correct pour éviter modifications accidentelles
- **LOGGER** toutes les opérations pour audit

## Rapport de Synchronisation

Créer un rapport avec:
- Nombre de locales synchronisées
- Nombre d'erreurs
- Liste des locales modifiées
- Timestamp de l'opération
- Sauvegarder dans `logs/sync-locales-YYYY-MM-DD-HH-MM-SS.log`
