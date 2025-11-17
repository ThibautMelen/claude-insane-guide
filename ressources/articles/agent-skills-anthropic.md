# Equipping Agents for the Real World with Agent Skills

**Source** : [Anthropic Engineering Blog](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)
**Auteur** : Barry Zhang, Keith Lazuka, Mahesh Murag (Anthropic)
**Date** : 16 octobre 2025
**Type** : Article officiel Anthropic Engineering
**Niveau** : 🔴 Expert (Architecture avancée)

---

## 🎯 Résumé Exécutif

Article **officiel Anthropic** introduisant Agent Skills comme nouveau paradigme pour équiper les agents IA de connaissances spécialisées et capacités procédurales. Skills = dossiers organisés (instructions + scripts + ressources) découverts et chargés dynamiquement par Claude.

**Impact** : Transforme agents généralistes en agents spécialisés via composants réutilisables, scalables et portables.

---

## 📚 Concepts Clés

### 1. Anatomie d'un Skill

```
.claude/skills/pdf/
├── SKILL.md              # Frontmatter YAML + instructions
├── scripts/              # Code exécutable
│   └── extract_form.py
├── references/           # Documentation
│   └── pdf_spec.md
└── assets/               # Ressources statiques
    └── sample_form.pdf
```

**Structure minimale** :
```yaml
---
name: skill-name
description: When to use this skill
---

[Instructions détaillées]
```

**Métadonnées requises** :
- `name` : Identifiant unique
- `description` : Quand utiliser ce skill (matching description)

**Métadonnées optionnelles** :
- `allowed-tools` : Outils pré-approuvés
- `model` : Sélection modèle (haiku/sonnet/opus)

---

### 2. Progressive Disclosure (Principe Fondamental)

```
╔═══════════════════════════════════════════════════════════╗
║           PROGRESSIVE DISCLOSURE (3 NIVEAUX)              ║
╚═══════════════════════════════════════════════════════════╝

NIVEAU 1 : Métadonnées (name + description)
           ├─> Chargées au startup dans system prompt
           ├─> ~50-200 caractères
           └─> Permet à Claude de décider si skill pertinent

              ↓ (si pertinent)

NIVEAU 2 : SKILL.md complet
           ├─> Chargé via Read tool
           ├─> Instructions détaillées (500-5000 mots)
           └─> Références vers fichiers bundled

              ↓ (si besoin de plus de contexte)

NIVEAU 3+ : Fichiers bundled
           ├─> scripts/ (code exécutable)
           ├─> references/ (docs techniques)
           └─> assets/ (templates, samples)

BÉNÉFICE : Context window optimisé, charge uniquement ce qui est nécessaire
```

**Exemple officiel** : PDF Skill
- NIVEAU 1 : Metadata indique "PDF manipulation"
- NIVEAU 2 : SKILL.md avec instructions générales + références à `forms.md`
- NIVEAU 3 : `forms.md` chargé uniquement si remplissage de formulaire nécessaire

---

### 3. Context Window Dynamics

**Séquence de chargement** (visualisation officielle) :

```
┌─────────────────────────────────────────────────────────┐
│ TURN 1 (Startup)                                        │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ System Prompt                                       │ │
│ │ + Skill Metadata (tous les skills)                 │ │
│ │   - pdf: "Manipulate PDF files"                    │ │
│ │   - excel: "Work with spreadsheets"                │ │
│ │   - ...                                             │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘

                         ↓

┌─────────────────────────────────────────────────────────┐
│ TURN 2 (User message)                                   │
│ User: "Extract text from this PDF form"                │
└─────────────────────────────────────────────────────────┘

                         ↓

┌─────────────────────────────────────────────────────────┐
│ TURN 3 (Claude triggers PDF skill)                     │
│ Claude: Read(.claude/skills/pdf/SKILL.md)              │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ System Prompt + Skill Metadata                      │ │
│ │ + PDF SKILL.md content (full instructions)         │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘

                         ↓

┌─────────────────────────────────────────────────────────┐
│ TURN 4 (Claude needs form-specific info)               │
│ Claude: Read(.claude/skills/pdf/forms.md)              │
│ ┌─────────────────────────────────────────────────────┐ │
│ │ System Prompt + Metadata + SKILL.md                │ │
│ │ + forms.md (form-filling specifics)                │ │
│ └─────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

**Résultat** : Context window grandit progressivement selon besoins, pas tout d'un coup.

---

### 4. Code Execution dans Skills

**Principe** : Certaines opérations mieux adaptées au code qu'à la génération de tokens.

**Exemples** :
- ❌ Trier une liste via LLM → Coûteux en tokens, lent
- ✅ Trier via script Python → Rapide, déterministe, fiable

**Pattern officiel** :

```python
# .claude/skills/pdf/scripts/extract_form_fields.py

import sys
from pypdf import PdfReader

def extract_fields(pdf_path):
    reader = PdfReader(pdf_path)
    fields = []

    for page in reader.pages:
        if '/Annots' in page:
            for annot in page['/Annots']:
                obj = annot.get_object()
                if obj.get('/FT') == '/Tx':  # Text field
                    fields.append({
                        'name': obj.get('/T'),
                        'value': obj.get('/V', '')
                    })

    return fields

if __name__ == '__main__':
    fields = extract_fields(sys.argv[1])
    print(json.dumps(fields, indent=2))
```

**Usage dans SKILL.md** :
```markdown
## Form Field Extraction

To extract form fields from a PDF:

1. Run: `python {baseDir}/scripts/extract_form_fields.py [pdf_path]`
2. Parse JSON output
3. Process fields as needed

This script returns deterministic results without loading PDF into context.
```

**Bénéfices** :
- ✅ Déterministe (reproductible à 100%)
- ✅ Efficace (code natif vs génération tokens)
- ✅ Fiable (pas d'hallucinations)
- ✅ Context-free (PDF non chargé dans context window)

---

## 🛠️ Développement et Évaluation de Skills

### Best Practices Officielles

**1. Start with Evaluation**
```
❌ Mauvaise approche : Créer skills sans tester
✅ Bonne approche :
   1. Identifier gaps via tests sur tâches représentatives
   2. Observer où agents échouent/manquent contexte
   3. Créer skills pour combler gaps spécifiques
   4. Itérer basé sur observations
```

**2. Structure for Scale**
```
Quand SKILL.md devient ingérable :
├─> Split content en fichiers séparés
├─> Référencer via paths dans SKILL.md
└─> Contextes mutuellement exclusifs → paths séparés (réduit token usage)

Code comme documentation :
├─> Executable tools (scripts/ exécutés directement)
└─> Reference documentation (references/ lus comme context)
```

**3. Think from Claude's Perspective**
```
Monitor skill usage :
├─> Observer trajectoires inattendues
├─> Identifier sur-utilisation de certains contextes
├─> Ajuster name + description pour matching précis
└─> Itérer basé sur comportement réel
```

**4. Iterate with Claude**
```
Workflow collaboratif :
1. Travailler sur tâche avec Claude
2. Demander à Claude de capturer approches réussies dans skill
3. Si erreur, demander self-reflection sur ce qui a échoué
4. Découvrir contexte réellement nécessaire (vs anticipé)
```

---

## 🔒 Considérations de Sécurité

**⚠️ AVERTISSEMENT OFFICIEL ANTHROPIC** :

```
╔═══════════════════════════════════════════════════════════╗
║              SECURITY CONSIDERATIONS                      ║
╚═══════════════════════════════════════════════════════════╝

Skills = Nouvelles capacités (instructions + code)
→ Risque : Skills malveillants peuvent :
  ├─> Introduire vulnérabilités dans environnement
  ├─> Diriger Claude vers exfiltration données
  └─> Prendre actions non intentionnées

RECOMMANDATIONS :

1. ✅ Installer skills UNIQUEMENT de sources de confiance

2. ⚠️ Si source moins fiable :
   ├─> Audit complet avant usage
   ├─> Lire tous fichiers bundled (comprendre actions)
   ├─> Vérifier dépendances code avec attention
   ├─> Examiner ressources bundled (images, scripts)
   └─> Attention aux connexions réseau externes non fiables

3. 🔍 Points de vigilance :
   ├─> Instructions dirigeant vers sources externes non fiables
   ├─> Code avec dépendances suspectes
   ├─> Scripts demandant permissions élevées
   └─> Connexions réseau non justifiées
```

**Exemple de skill à risque** :
```yaml
---
name: data-exporter
description: Export data to external services
---

# DO NOT USE - Example of risky skill

This skill connects to external servers to upload data.

⚠️ RED FLAGS:
- Connects to hardcoded external URLs
- No authentication verification
- Uploads potentially sensitive data
- No user confirmation before actions
```

---

## 🚀 Disponibilité et Futur

### Disponibilité Actuelle

**Supporté sur** :
- ✅ Claude.ai (web interface)
- ✅ Claude Code (CLI tool)
- ✅ Claude Agent SDK (programmatic)
- ✅ Claude Developer Platform (API)

### Roadmap Future

**Court terme** (coming weeks) :
- Lifecycle complet : create, edit, discover, share, use
- Marketplace de skills (organisations + individus)
- Integration avec Model Context Protocol (MCP servers)

**Long terme** :
- Agents créent/éditent/évaluent leurs propres skills
- Codification autonome de patterns comportementaux
- Skills comme capacités réutilisables apprises par agents

---

## 🎓 Points Clés à Retenir

### Architecture

✅ **Progressive disclosure = principe fondamental**
- Niveau 1 : Metadata (startup)
- Niveau 2 : SKILL.md (on-demand)
- Niveau 3+ : Bundled files (as-needed)

✅ **Skills = dossiers organisés**
- SKILL.md avec YAML frontmatter
- scripts/ pour code exécutable
- references/ pour documentation
- assets/ pour ressources statiques

✅ **Code execution dans skills**
- Déterministe, efficace, fiable
- Pas de chargement dans context
- Opérations mieux adaptées au code

### Développement

✅ **Start with evaluation**
- Identifier gaps via tests
- Observer où agents échouent
- Créer skills ciblés

✅ **Think from Claude's perspective**
- Monitor usage patterns
- Ajuster name + description
- Itérer basé sur observations

✅ **Iterate with Claude**
- Collaboration pour capturer approches
- Self-reflection sur erreurs
- Découvrir contexte réellement nécessaire

### Sécurité

✅ **Installer uniquement sources de confiance**
✅ **Auditer skills de sources moins fiables**
✅ **Vérifier code, dépendances, connexions réseau**

---

## 🔗 Ressources Officielles

**Documentation** :
- 📄 [Skills Docs](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
- 📄 [Skills Cookbook](https://github.com/anthropics/claude-cookbooks/tree/main/skills)
- 📄 [Model Context Protocol](https://modelcontextprotocol.io/)

**Articles Connexes** :
- 📄 [Skills Deep Dive (Lee Hanchung)](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)
- 📄 [Skills Announcement (Anthropic News)](https://www.anthropic.com/news/skills)

---

## 💡 Citation Clé

> "Skills are a simple concept with a correspondingly simple format. This simplicity makes it easier for organizations, developers, and end users to build customized agents and give them new capabilities."
>
> — Barry Zhang, Keith Lazuka, Mahesh Murag (Anthropic Engineering)

---

**Tags** : `#anthropic` `#official` `#skills` `#agents` `#progressive-disclosure` `#security` `#architecture` `#expert`
