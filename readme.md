# TFE — Andrea Spelgatti

**Titre :** Pérennisation d'un projet de recherche grâce à l'open source  
**Sous-titre :** Une approche intégrée associant restructuration technique, intégration continue et gouvernance collaborative

Ce dépôt est une sauvegarde de mon Travail de Fin d'Études (Master Ingénieur Industriel, Génie Électrique et Informatique) réalisé au CeCoTePe.

## Structure

- `main.typ` — document principal
- `template/` — template Typst
- `assets/` — ressources
- `ref.bib` — bibliographie
- `annex.typ` — annexes
- `slides/` — présentation de soutenance (Typst + Touying)
  - `slides-22.typ` — **présentation principale** cible 20 min (~22 diapos)
  - `slides-reserve.typ` — slides de réserve pour les questions du jury (PDF séparé)
  - `theme.typ` — thème HEPL (couleurs, mise en page)

## Variantes de la présentation (soutenance 20 min)

| Fichier | Diapos | Usage |
|---------|--------|-------|
| `slides/slides-22.typ` | 21 | **Principal.** Version cible 20 min. |
| `slides/slides-reserve.typ` | 11 | PDF séparé, à projeter à la demande selon les questions. |

### Structure de `slides-22.typ`

6 sections, 21 sub-slides, 29 pages PDF :

1. **Introduction** — Contexte, Stack technique, Aperçu, Problématique
2. **Méthodologie** — Suivi (Notion), Structure initiale, Anti-pattern, Comparaison
3. **Solutions** — Refactorisation, Proposition architecturale
4. **Infrastructure et Open-Source** — Accès Code Source, CI/CD, Monorepo, Compose vs K8s, Déploiement
5. **Contributions open-source** — Keycloak, Outils d'automatisation, EcoArbiter
6. **Résultats, conclusion et perspectives** — Métriques, Leçons, Bilan

### Slides de réserve (`slides-reserve.typ`)

À n'utiliser que si le jury pose des questions spécifiques :

1. **Keycloak** : Keycloakify et thèmes FreeMarker
2. **EcoArbiter** : algorithme Rust et scénarios
3. **Choix d'intégration Keycloak** (tableau détaillé)
4. **Limitations détaillées** (tests, benchmarks, gouvernance, K8s)
5. **Roadmap opérationnel** (court / moyen / long terme)
6. **Docker Compose** : dev vs prod (tableau)
7. **Kubernetes vs Docker Compose** (tableau)
8. **Licence, organisation et contribution** (version détaillée)
9. **Expérience Développeur** (DevContainers, DX)
10. **Essayez vous-même** (slide de démo interactive)
11. **Qualité logicielle et sécurité** (tests + CodeQL + Cosign)

## Compilation

### Mémoire

```bash
typst compile main.typ TFE.pdf
```

### Présentations de soutenance

```bash
# Version principale (20 min)
typst compile slides/slides-22.typ slides-22.pdf

# Slides de réserve (PDF séparé)
typst compile slides/slides-reserve.typ slides-reserve.pdf
```
