#import "@preview/touying:0.5.3": *
#import "@preview/curryst:0.3.0" as curryst: rule

#import "theme.typ": *

#show: university-theme.with(
  config-colors(
    primary: primary-color,
    secondary: secondary-color,
    tertiary: tertiary-color,
    neutral-darkest: text-color,
  ),
  config-info(
    title: [OptimCE — Slides de réserve],
    subtitle: [Slides backup pour les questions],
    author: [Andrea Spelgatti],
    date: datetime.today(),
    institution: [HEPL],
  ),
)
#set heading(numbering: "1.")

#title-slide()

= Réserve : Keycloak

== Keycloakify et thèmes FreeMarker
#v(0.3em)
#grid(
  columns: (50%, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  stack(
    dir: ttb,
    spacing: 0.3em,
    image("assets/article-microservices.png", width: 100%),
  ),
  [
    *Keycloakify*
    - Outil React → templates FreeMarker (`.ftl`)
    - Identité visuelle unifiée entre l'app et Keycloak
    - Compilation TypeScript/React, déploiement transparent

    *Plugin `kc-groupid-mapper`*
    - Ajout d'un mapper personnalisé dans Keycloak
    - Injecte le `group_id` de l'utilisateur dans le JWT
    - Évite un appel API supplémentaire côté backend

    *Configuration JSON générique*
    - Import/export des realms en JSON
    - Nettoyage automatique des données sensibles
    - Démarrage via service `keycloak-config` (Docker)

    *Avantages* : identité visuelle cohérente, sécurité native Keycloak,
    connexions sociales gratuites (Google, Apple, etc.)
  ],
)

= Réserve : EcoArbiter

== EcoArbiter : algorithme de distribution
#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  image("assets/emsg-logic.png", height: 14cm),
  [
    *Algorithme Rust open-source*
    - Alternative au projet ULiège BEMS
    - Distribution *équitable* entre EMS locaux
    - Complexité *O(n log n)* — haute fréquence

    *Trois scénarios*
    - *Déficit* : production < consommation
      → répartition au prorata des besoins
    - *Excédent* : production > consommation
      → redistribution vers le réseau ou stockage
    - *Insuffisant* : production < demande totale
      → délestage equitable

    *Intégration*
    - Licence Apache 2.0
    - Binaire standalone ou microservice REST
    - Conçu pour branchement direct sur OptimCE
  ],
)

= Réserve : Choix techniques

== Choix d'intégration Keycloak — détail
#v(0.3em)
#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + text-color,
  [*Critère*], [*Thèmes Keycloak (Redirection)*], [*Interface custom (REST/ROPC)*],
  [Sécurité], [Maximale — Keycloak gère cookies et CSRF], [Moyenne — gestion manuelle des tokens],
  [Expérience utilisateur], [Légère redirection visible], [Intégration transparente],
  [Complexité], [Apprentissage du templating `.ftl`], [Développement boilerplate d'appels API],
  [Connexions sociales], [Native (Google, Apple, etc.)], [Complexe sans redirections],
  [Maintenance], [Mises à jour Keycloak centralisées], [Code custom à maintenir],
  [Personnalisation visuelle], [Limitée au templating FreeMarker], [Totale (React/Angular)],
  [Coût initial], [Modéré (Keycloakify + config)], [Élevé (auth flow complet)],
)

*Décision* : thèmes Keycloak via Keycloakify.
Sécurité native > UX transparente. Le templating FreeMarker est un investissement initial
marginal comparé au développement d'un flux d'authentification complet.

= Réserve : Limitations

== Limitations détaillées
*Tests et CI*
- Tests d'intégration non automatisés dans la CI du monorepo
- Temps d'exécution actuel : dizaines de minutes
- Solution envisagée : pré-build des images de test en CI, exécution en parallèle

*Benchmarks*
- Pas de benchmarks formels avant/après refactoring
- Métriques RAM/appels issues d'observations manuelles
- Roadmap : intégration de k6 ou Gatling pour benchmarks reproductibles

*Gouvernance*
- Politique de contribution définie mais non testée en conditions réelles
- Pas encore de processus de revue formel multi-mainteneurs
- Roadmap : tester la gouvernance avec les premiers contributeurs externes

*Kubernetes*
- Tests réalisés : k3s, Minikube, Kind
- Conclusion : surdimensionné pour 15 conteneurs et 1 VPS
- Alternative retenue : Docker Compose Bridge (compatibilité ascendante K8s)

= Réserve : Roadmap

== Roadmap opérationnel
*Court terme (3–6 mois)*
- Automatiser les tests d'intégration dans la CI du monorepo
- Tableau de bord de métriques (couverture de code, santé des services)
- Documenter l'API publique avec OpenAPI + Swagger UI
- Finaliser le guide de contribution multi-publics (dev, ops, chercheurs)

*Moyen terme (6–12 mois)*
- Déploiement Kubernetes via Docker Compose Bridge
- Formalisation de la gouvernance communautaire (CODEOWNERS, RFCs)
- Internationalisation (i18n) de l'interface utilisateur
- Connecteurs tiers : Home Assistant, Grafana, Prometheus

*Long terme (12+ mois)*
- Scaling horizontal multi-VPS (load balancing, replication)
- Marketplace de connecteurs énergétiques
- Industrialisation EcoArbiter (production → déploiement)
- Étude d'impact environnemental (métrique carbone des déploiements)

= Réserve : Déploiement

== Docker Compose : dev vs prod
#v(0.3em)
#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + text-color,
  [*Aspect*], [*Développement*], [*Production*],
  [Images], [Build local depuis le code source], [Images pré-construites depuis GitHub Container Registry],
  [Ports], [Tous les ports exposés pour débogage], [Uniquement les ports nécessaires],
  [Données], [Volumes éphémères], [Volumes persistants + backups PG],
  [SSL], [HTTP seulement], [HTTPS avec Certbot + Let's Encrypt],
  [Keycloak], [Mode `start-dev`], [Mode `start` avec health checks],
  [Migrations DB], [Reset à chaque démarrage], [Service `optimce-migrator` (Alembic)],
)

== Kubernetes vs Docker Compose
#v(0.3em)
#table(
  columns: (auto, auto, auto),
  inset: 5pt,
  stroke: 0.5pt + text-color,
  [*Critère*], [*Kubernetes*], [*Docker Compose*],
  [Échelle cible], [Centaines/milliers de nœuds], [1 serveur unique],
  [Nombre de conteneurs], [Centaines à milliers], [~15 conteneurs],
  [Équipe ops requise], [Équipe dédiée (SRE/DevOps)], [Aucune (auto-hébergé)],
  [Auto-scaling], [Nécessite une charge variable], [Charge stable et prévisible],
  [Haute disponibilité], [Multi-nœuds, tolérance pannes], [Single-node, backups manuels],
  [Coût infrastructure], [Minimum 3 nœuds maître + workers], [1 VPS suffit],
  [Courbe apprentissage], [Semaines à mois], [Heures à jours],
  [Temps mise en production], [Jours (cluster + config)], [Minutes (`docker compose up`)],
  [Adéquation au projet], [Surdimensionné], [#alert[Adapté]],
)

= Réserve : Open-Source

== Licence, organisation et contribution
#grid(
  columns: (38%, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + horizon),
  image("assets/image.png", width: 100%),
  stack(
    dir: ttb,
    spacing: 0.3em,
    [
      - Licence *Apache 2.0* : permissive + protection des brevets
      - Organisation GitHub *OptimCE*
      - Politique de contribution documentée
      - Hiérarchie : mainteneurs, contributeurs, utilisateurs
      - Linting et formatage automatisés (ESLint, Prettier, ruff, SQLFluff)
    ],
    align(
      center,
      [
        #v(3mm)
        #link("https://github.com/optimce/monorepo")[#text(fill: blue)[github.com/optimce/monorepo]]
      ],
    ),
    align(
      center,
      image("assets/github.svg", width: 30%),
    ),
  ),
)

== Expérience Développeur
- *DevContainers* : environnement de développement préconfiguré et isolé via Docker
  → Plus de « ça marche sur ma machine »
- `./docker-stack.sh start` : toute la stack en une commande
- Git submodules : chaque composant reste un dépôt indépendant
- Tests d'intégration rapides en local
- Linting et formatage intégrés aux pipelines CI/CD

== Essayez vous-même
#v(1.5cm)
#align(center)[
  #text(size: 1.5em, weight: "bold")[1 commande = 1 infrastructure complète]

  #v(1em)

  #text(size: 1.1em, font: "Fira Code")[git clone --recurse-submodules \ ]
  #text(size: 1.1em, font: "Fira Code")[  https://github.com/OptimCE/monorepo.git]

  #v(0.5em)
  #text(size: 1.1em, font: "Fira Code")[cd monorepo]

  #v(0.5em)
  #text(size: 1.1em, font: "Fira Code")[./docker-stack.sh start]

  #v(1.5em)

  #link("https://github.com/OptimCE/monorepo")[#text(fill: blue, size: 1.2em)[github.com/OptimCE/monorepo]]
]

= Réserve : Qualité

== Qualité logicielle et sécurité
#v(0.3em)
#grid(
  columns: (48%, 1fr),
  column-gutter: 0.5em,
  align: (center + horizon, left + horizon),
  image("assets/security_reporting.png"),
  [
    *Stratégie de tests*
    - Unitaires : logique métier isolée (mocks)
    - Intégration : controller → service → DB
    - Healthcheck : `/health` sur chaque service

    *Sécurité automatisée*
    - *CodeQL* : détection d'injections SQL
    - *Dependabot* : mises à jour automatiques (CVE)
    - *Cosign* : signature keyless (Sigstore)

    → Exécution automatique à chaque Pull Request
  ],
)

#focus-slide[
  Fin des slides de réserve \
  #v(1.5em)
  #text(size: 0.5em, fill: secondary-color)[#link("https://github.com/OptimCE")[github.com/OptimCE]]
]
