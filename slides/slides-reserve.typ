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

= Keycloak (détail)

== Keycloakify et thèmes FreeMarker
#grid(
  columns: (45%, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/article-microservices.png", width: 100%),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🎨 Keycloakify*
      #v(0.1em)
      - React → templates FreeMarker (`.ftl`)
      - Identité visuelle unifiée app ↔ Keycloak
      - Compilation TypeScript transparente
    ]

    #v(0.2em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🔐 JWT auto-contenus*
      #v(0.1em)
      - Vérification locale par clé publique
      - *Pas d'appel réseau* par requête
      - Seul le refresh token → introspection
    ]

    #v(0.2em)

    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *👥 3 approches évaluées (groupes)*
      #v(0.1em)
      - ✅ Claims dans JWT (retenu)
      - ❌ Middleware dédié (écarté)
      - ❌ Gestion backend (écarté)
    ]

    #v(0.2em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *📦 Configuration JSON générique*
      #v(0.1em)
      - Import/export des realms
      - Nettoyage automatique des secrets
      - Démarrage via `keycloak-config`
    ]
  ],
)

#v(0.2em)

#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold")[✅ Avantages :] identité visuelle cohérente, sécurité native Keycloak, connexions sociales gratuites (Google, Apple, etc.)
]

= EcoArbiter (détail)

== EcoArbiter : algorithme de distribution
#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/emsg-logic.png", height: 12cm),
  [
    #text(weight: "bold", fill: primary-color)[⚡ Algorithme Rust open-source]
    #v(0.2em)
    - Alternative au projet ULiège BEMS
    - Distribution équitable entre EMS locaux
    - Complexité `O(n log n)` → haute fréquence
    - Tri des indices déficitaires dominant

    #v(0.2em)

    #text(weight: "bold", fill: primary-color)[📊 Trois scénarios]
    #grid(
      columns: (1fr, 1fr, 1fr),
      column-gutter: 0.4em,
      align: (center + top, center + top, center + top),
      [
        #block(
          fill: primary-color.lighten(85%),
          inset: 0.4em,
          radius: 4pt,
          width: 100%,
        )[
          #align(center)[
            *Déficit* \
            #text(size: 0.8em)[production < conso : prorata]
          ]
        ]
      ],
      [
        #block(
          fill: secondary-color.lighten(75%),
          inset: 0.4em,
          radius: 4pt,
          width: 100%,
        )[
          #align(center)[
            *Excédent* \
            #text(size: 0.8em)[production > conso : réseau / stockage]
          ]
        ]
      ],
      [
        #block(
          fill: tertiary-color.lighten(70%),
          inset: 0.4em,
          radius: 4pt,
          width: 100%,
        )[
          #align(center)[
            *Insuffisant* \
            #text(size: 0.8em)[demande > prod : délestage]
          ]
        ]
      ],
    )

    #v(0.2em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.9em, weight: "bold")[🔌 Intégration :] Licence Apache 2.0, binaire standalone ou microservice REST, branchement direct sur OptimCE.
    ]

    #v(0.2em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.9em, weight: "bold")[🧪 Validation :] algorithme de simulation avec profils de consommation/production aléatoires et visualisation graphique des résultats.
    ]
  ],
)

= Choix techniques

== Choix d'intégration Keycloak — détail
#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + text-color,
  fill: (col, row) => if row == 0 { primary-color.lighten(85%) } else if calc.even(row) { luma(245) } else { white },
  table.header(
    [*Critère*], [*Thèmes Keycloak (Redirection)*], [*Interface custom (REST/ROPC)*],
  ),
  [Sécurité], [Maximale — Keycloak gère cookies et CSRF], [Moyenne — gestion manuelle des tokens],
  [Expérience utilisateur], [Légère redirection visible], [Intégration transparente],
  [Complexité], [Apprentissage du templating `.ftl`], [Développement boilerplate d'appels API],
  [Connexions sociales], [Native (Google, Apple, etc.)], [Complexe sans redirections],
  [Maintenance], [Mises à jour Keycloak centralisées], [Code custom à maintenir],
  [Personnalisation visuelle], [Limitée au templating FreeMarker], [Totale (React/Angular)],
  [Coût initial], [Modéré (Keycloakify + config)], [Élevé (auth flow complet)],
)

#v(0.2em)

#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold")[🎯 Décision :] thèmes Keycloak via Keycloakify. \
  *Meilleur équilibre* entre sécurité, maintenabilité et expérience utilisateur. \
  Toutes les fonctionnalités sont aussi disponibles via l'API REST, mais la redirection reste plus robuste pour la gestion des sessions et la sécurité.
]

== Arbitres et compromis
#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.8em,
  row-gutter: 0.3em,
  align: (left + top, left + top),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🏗️ Monolithe modulaire vs µ-services*
      #v(0.2em)
      - *Perdu* : scalabilité individuelle
      - *Patterns évités* : Transactional Outbox, idempotence, compensation, watchdogs
      - *Retenu* : consistance native PostgreSQL, adapté au contexte
    ]
  ],
  [
    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *📦 Git submodules vs monorepo natif*
      #v(0.2em)
      - *Choisi* : submodules (simplicité, familiarité)
      - *Sacrifié* : Nx/Turborepo, résolution auto des deps
      - *Limite* : CI/CD séparés par dépôt, confusion pour novices
    ]
  ],
  [
    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🐳 Docker Compose vs orchestrateur*
      #v(0.2em)
      - *Pas de* : scaling auto, résurrection native, load balancing
      - *Suffisant* : charge stable, 1 VPS, équipe réduite
      - *Évolution* : Docker Compose Bridge → K8s si besoin SaaS
    ]
  ],
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🔐 HashiCorp Vault (étudié, rejeté)*
      #v(0.2em)
      - 3 modèles identifiés : Agent Injector, CSI Driver, SDK
      - *Rejeté* : complexité disproportionnée pour 1 VPS
      - *Alternative* : secrets Docker Compose + `.env` acceptables
    ]
  ],
)

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.9em, weight: "bold")[💡 Décision-clé :] chaque compromis est *justifié par le contexte* (équipe réduite, charge stable, 1 VPS) et *réévaluable* si le projet évolue vers une offre SaaS multi-locataires.
]

= Limitations

== Limitations détaillées
#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.8em,
  row-gutter: 0.3em,
  align: (left + top, left + top),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🧪 Tests et CI*
      #v(0.2em)
      - Tests d'intégration non automatisés
      - Temps d'exécution : dizaines de minutes
      - *Solution* : pré-build images test, exécution parallèle
    ]
  ],
    [
      #block(
        fill: secondary-color.lighten(75%),
        inset: 0.5em,
        radius: 4pt,
        width: 100%,
      )[
        *📊 Benchmarks*
        #v(0.2em)
        - Pas de benchmarks formels avant/après
        - Métriques RAM/appels : observations manuelles
        - *Roadmap* : k6 ou Apache JMeter
      ]
    ],
    [
      #block(
        fill: tertiary-color.lighten(70%),
        inset: 0.5em,
        radius: 4pt,
        width: 100%,
      )[
        *👥 Gouvernance*
        #v(0.2em)
        - Politique définie mais non testée
        - Pas de revue formelle multi-mainteneurs
        - *Roadmap* : tester avec 1ers contributeurs
      ]
    ],
    [
      #block(
        fill: primary-color.lighten(85%),
        inset: 0.5em,
        radius: 4pt,
        width: 100%,
      )[
        *☸️ Kubernetes*
        #v(0.2em)
        - *k3s* : 2 Go RAM min pour control plane
        - *Minikube* : dev local, pas production
        - *Kind* : CI/CD, pas stable
      ]
    ],
)

= Roadmap

== Roadmap opérationnel
#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold", fill: primary-color)[⏱️ Court terme (3–6 mois)]
  #v(0.2em)
  - Automatiser les tests d'intégration dans la CI du monorepo
  - Tableau de bord de métriques (couverture, santé des services)
  - Documenter l'API publique avec OpenAPI + Swagger UI
  - Finaliser le guide de contribution multi-publics
]

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold", fill: primary-color)[📅 Moyen terme (6–12 mois)]
  #v(0.2em)
  - Déploiement Kubernetes via Docker Compose Bridge
  - Formalisation de la gouvernance (CODEOWNERS, RFCs)
  - Internationalisation (i18n) de l'interface
  - *Processus de mise à jour automatisé* :
    - Versionnage sémantique (`x.y.z`, `-rc` pour tests)
    - Mode maintenance (lecture seule)
    - Backup pré-migration (dump PG → S3)
    - Auto-pull, auto-restart, *auto-rollback* si échec
]

#v(0.2em)

#block(
  fill: tertiary-color.lighten(70%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold", fill: primary-color)[🚀 Long terme (12+ mois)]
  #v(0.2em)
  - Consolidation DB (1 PostgreSQL, schémas distincts)
  - Synchronisation Keycloak/CRM orientée événements via NATS
  - Télémétrie Prometheus + Grafana
  - Scaling horizontal multi-VPS (load balancing, replication)
  - Industrialisation EcoArbiter
]

= Déploiement (détail)

== Docker Compose : dev vs prod
#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + text-color,
  fill: (col, row) => if row == 0 { primary-color.lighten(85%) } else if calc.even(row) { luma(245) } else { white },
  table.header(
    [*Aspect*], [*Développement*], [*Production*],
  ),
  [Images], [Build local depuis le code source], [Images pré-construites depuis GHCR],
  [Ports], [Tous les ports exposés pour débogage], [Uniquement les ports nécessaires],
  [Données], [Volumes éphémères], [Volumes persistants + backups PG],
  [SSL], [HTTP seulement], [HTTPS avec Certbot + Let's Encrypt],
  [Keycloak], [Mode `start-dev`], [Mode `start` avec health checks],
  [Migrations DB], [Reset à chaque démarrage], [Service `optimce-migrator` (Alembic)],
)

#v(0.2em)

#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.9em, weight: "bold")[🐳 Déploiement actuel :] VPS Hostinger (souveraineté données Europe, RGPD, coût adapté à un projet de recherche). \
  *Docker Swarm* supporté sans modifications majeures (compatibilité ascendante).
]

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.9em, weight: "bold")[🔐 HashiCorp Vault étudié mais rejeté :] \
  3 modèles d'intégration identifiés (Agent Injector, CSI Driver, SDK) — tous trop complexes pour 1 VPS. \
  *Secrets Docker Compose + `.env`* jugés suffisants. Réévaluation possible si offre SaaS multi-locataires.
]

== Kubernetes vs Docker Compose
#table(
  columns: (auto, auto, auto),
  inset: 5pt,
  stroke: 0.5pt + text-color,
  fill: (col, row) => if row == 0 { primary-color.lighten(85%) } else if row == 8 { secondary-color.lighten(75%) } else if calc.even(row) { luma(245) } else { white },
  table.header(
    [*Critère*], [*Kubernetes*], [*Docker Compose*],
  ),
  [Échelle cible], [Centaines/milliers de nœuds], [1 serveur unique],
  [Nombre de conteneurs], [Centaines à milliers], [~15 conteneurs],
  [Équipe ops requise], [Équipe dédiée (SRE/DevOps)], [Aucune (auto-hébergé)],
  [Auto-scaling], [Nécessite une charge variable], [Charge stable et prévisible],
  [Haute disponibilité], [Multi-nœuds, tolérance pannes], [Single-node, backups manuels],
  [Coût infrastructure], [Minimum 3 nœuds maître + workers], [1 VPS suffit],
  [Courbe apprentissage], [Semaines à mois], [Heures à jours],
  [Temps mise en production], [Jours (cluster + config)], [Minutes (`docker compose up`)],
  [*Adéquation au projet*], [*Surdimensionné*], [*#text(fill: primary-color)[Adapté]*],
)

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.9em, weight: "bold")[🧪 Distributions K8s testées :] \
  *k3s* : 2 Go RAM min pour control plane (trop lourd). \
  *Minikube* : dev local, pas de persistance robuste. \
  *Kind* : orienté CI/CD, pas stable en production. \
  → Toutes écartées. *Docker Compose Bridge* retenu (compatibilité K8s si besoin futur).
]

= Open-Source (détail)

== Licence, organisation et contribution
#grid(
  columns: (38%, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/image.png", width: 100%),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[
        #text(weight: "bold")[📜 Licence Apache 2.0]
        #v(0.1em)
        #text(size: 0.9em)[permissive + protection brevets, \
        choix rapide poussé pour publication publique]
      ]
    ]

    #v(0.2em)

    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.6em,
      align: (left + top, left + top),
      [
        #text(size: 0.9em, weight: "bold", fill: primary-color)[🏛️ Hiérarchie (4 niveaux)]
        #v(0.1em)
        - *Mainteneurs* (globaux, stratégiques)
        - *Contributeurs internes* (accès étendu)
        - *Contributeurs externes* (PR uniquement)
        - *Utilisateurs* (issues uniquement)
      ],
      [
        #text(size: 0.9em, weight: "bold", fill: primary-color)[🛠️ Linting automatisé]
        #v(0.1em)
        - ESLint + Prettier (TypeScript)
        - ruff (Python)
        - SQLFluff (SQL)
        - Hooks Git (lint-staged)
      ],
    )

    #v(0.2em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.85em, weight: "bold")[🔗 Organisation :] #link("https://github.com/OptimCE")[github.com/OptimCE] — initiative personnelle pour centraliser dépôts, secrets et pipelines CI/CD.
    ]
  ],
)

== Expérience Développeur
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.8em,
  align: (left + top, left + top, left + top),
    [
      #block(
        fill: primary-color.lighten(85%),
        inset: 0.5em,
        radius: 4pt,
        width: 100%,
      )[
        *📦 DevContainers*
        #v(0.2em)
        - Environnement préconfiguré et isolé
        - Sync auto via CI/CD (nouvelles deps)
        - Multiplateforme : Windows, macOS, Linux
        - Plus de « ça marche sur ma machine »
      ]
    ],
  [
    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🚀 Déploiement*
      #v(0.2em)
      - `./docker-stack.sh start` : toute la stack
      - Git submodules : 1 dépôt par composant
      - Tests d'intégration rapides en local
    ]
  ],
  [
    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🛠️ Qualité*
      #v(0.2em)
      - Linting automatisé (ESLint, ruff, etc.)
      - Formatage (Prettier, SQLFluff)
      - Intégré aux pipelines CI/CD
    ]
  ],
)

== Essayez vous-même
#align(center)[
  #text(size: 1.3em, weight: "bold", fill: primary-color)[1 commande = 1 infrastructure complète]
]

#v(0.3em)

#block(
  fill: luma(15%),
  inset: 1em,
  radius: 4pt,
  width: 100%,
  text(font: "Fira Code", size: 1.1em, fill: white)[
    `$ git clone --recurse-submodules https://github.com/OptimCE/monorepo.git`
    #v(0.3em)
    `$ cd monorepo && ./docker-stack.sh start`
  ],
)

#v(0.3em)

#align(center)[
  #link("https://github.com/OptimCE/monorepo")[#text(fill: primary-color, size: 1.1em, weight: "bold")[github.com/OptimCE/monorepo]] \
  #text(size: 0.85em)[— un seul fichier `.env` d'une dizaine de champs]
]

= Qualité et sécurité (détail)

== Qualité logicielle et sécurité
#grid(
  columns: (45%, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top),
  image("assets/security_reporting.png", width: 100%),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🧪 Stratégie de tests*
      #v(0.2em)
      - *Unitaires* : logique métier isolée (mocks)
      - *Intégration* : controller → service → DB
      - *Healthcheck* : `/health` sur chaque service
      - *Vulnérabilités* : SQL injection (CodeQL), CVE deps JS (Dependabot)
    ]

    #v(0.2em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *🛡️ Sécurité automatisée*
      #v(0.2em)
      - *CodeQL* : détection d'injections SQL
      - *Dependabot* : mises à jour CVE automatiques
      - *Cosign* : signature keyless (Sigstore)
    ]

    #v(0.2em)

    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.9em, weight: "bold")[🔒 Segmentation réseau :] 2 réseaux en dev → *5 en production*. PostgreSQL, MinIO, NATS jamais exposés (réseau Docker interne uniquement).
    ]

    #v(0.2em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.9em)[→ Exécution automatique à chaque *Pull Request*]
    ]
  ],
)

#focus-slide[
  Fin des slides de réserve \
  #v(0.5em)
  #text(size: 0.5em, fill: secondary-color)[#link("https://github.com/OptimCE")[github.com/OptimCE]]
]
