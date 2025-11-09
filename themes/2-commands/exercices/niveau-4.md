# 🔴 Niveau 4 : Commands Équipe & Organisation

> **Objectif** : Pack de commands pour équipe complète
> **Durée** : 25-30 min

## 🎯 Objectif

Créer système complet de commands partagées.

## 📋 Exercice

1. **Structure organisée**
```bash
.claude/commands/
├── README.md
├── frontend/
│   ├── create-component.md
│   ├── create-hook.md
│   └── create-page.md
├── backend/
│   ├── create-api.md
│   ├── create-migration.md
│   └── create-service.md
└── devops/
    ├── deploy.md
    ├── rollback.md
    └── logs.md
```

2. **Command avec best practices**
```markdown
---
name: deploy
description: Déploiement production avec checks
arguments:
  - name: environment
    description: dev/staging/production
    required: true
---

# Déploiement : {environment}

## Pre-checks
- [ ] Tests passent
- [ ] Build OK
- [ ] Pas de secrets
- [ ] Branch à jour

## Déploiement
1. Build production
2. Run migrations
3. Deploy application
4. Health check

## Post-deploy
1. Vérifier logs
2. Test smoke
3. Notifier équipe
4. Update documentation

Si erreur → `/rollback {environment}`
```

3. **Documentation**
```markdown
# Commands Équipe

## Frontend
- `/create-component <name>` - Nouveau composant
- `/create-page <path>` - Nouvelle page

## Backend
- `/create-api <endpoint>` - Nouvel endpoint
- `/deploy <env>` - Déploiement

## Utilisation
Voir guide complet dans docs/commands.md
```

## ✅ Validation

- [ ] 9+ commands organisées
- [ ] README.md complet
- [ ] Workflows documentés
- [ ] Tests réussis

## 🏆 Challenge

Créer pack complet pour votre tech stack (React/Node/Postgres par exemple).

---

🎉 **Bravo !** Vous maîtrisez les Commands. Passez à [MCP](../../4-mcp/guide.md) ! 🚀
