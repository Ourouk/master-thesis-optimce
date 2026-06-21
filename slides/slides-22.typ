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
    title: [Pérennisation d'un projet de recherche grâce à l'open source],
    subtitle: [Une approche intégrée associant restructuration technique, intégration continue et gouvernance collaborative],
    author: [Andrea Spelgatti],
    date: datetime.today(),
    institution: [HEPL],
  ),
)
#set heading(numbering: "1.")

#title-slide()

= Introduction
== Contexte : le projet Locomotrice
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  align: (left + top, left + top),
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[📋 Le projet]
    #v(0.3em)
    - Recherche *Win²Wal*, financée par la Wallonie
    - *Deux volets* :
      - *OptimCE* : gestion administrative (CeCoTePe)
      - *EMS* : domotique énergétique (ULiège)
    - Maturité : #alert[TRL 7] — proche production
    - Cadre : 1 développeur, contexte académique
  ],
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[🤝 Partenaires]
    #v(0.5em)
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.8em,
      align: (center + horizon, center + horizon),
      [
        #align(center)[
          #image("assets/partners/cecotepe.png", height: 1.4cm)
          #v(0.2em)
          *CeCoTePe*
        ]
      ],
      [
        #align(center)[
          #image("assets/partners/uliege.svg", height: 1.4cm)
          #v(0.2em)
          *ULiège*
        ]
      ],
    )
    #v(0.3em)
    #align(center)[
      *Émission Zéro* \
      #text(size: 0.9em, fill: text-color.lighten(40%))[association partenaire]
    ]
  ],
)

== Stack technique
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  column-gutter: 0.3em,
  row-gutter: 1em,
  align: (center + horizon, center + horizon, center + horizon, center + horizon),
  [#image("assets/tech-stack/typescript.svg", height: 1.4cm) #v(-2em) \ TypeScript],
  [#image("assets/tech-stack/angular.svg", height: 1.4cm) #v(-2em) \ Angular],
  [#image("assets/tech-stack/python.svg", height: 1.4cm) #v(-2em) \ Python],
  [#image("assets/tech-stack/rust.svg", height: 1.4cm) #v(-2em) \ Rust],
  [#image("assets/tech-stack/postgresql.svg", height: 1.4cm) #v(-2em) \ PostgreSQL],
  [#image("assets/tech-stack/keycloak.svg", height: 1.4cm) #v(-2em) \ Keycloak],
  [#image("assets/tech-stack/krakend.png", height: 1.4cm) #v(-2em) \ KrakenD],
  [#image("assets/tech-stack/nginx.svg", height: 1.4cm) #v(-2em) \ Nginx],
  [#image("assets/tech-stack/docker.svg", height: 1.4cm) #v(-2em) \ Docker],
  [#image("assets/tech-stack/natsdotio.svg", height: 1.4cm) #v(-2em) \ NATS],
  [#image("assets/tech-stack/minio.svg", height: 1.4cm) #v(-2em) \ MinIO],
  [#image("assets/tech-stack/githubactions.svg", height: 1.4cm) #v(-2em) \ GitHub Actions],
)

== Aperçu de l'application
#align(center)[#image("assets/OptimceScreenshot.png", width: 80%)]

#v(0.3em)
Interface Angular pour la gestion administrative des communautés d'énergie
— profils, compteurs, documents, représentations.

== Problématique et objectifs
#block(
  fill: primary-color.lighten(90%),
  inset: 0.5em,
  radius: 6pt,
  width: 100%,
)[
  #text(weight: "bold", fill: primary-color)[❓ Question centrale]
  #v(0.1em)
  #text(size: 0.9em)[Comment transformer un prototype de recherche fragile en solution
  open-source robuste, simple à déployer, ouverte à la contribution ?]
]

#v(0.2em)

#text(size: 0.95em, weight: "bold", fill: primary-color)[6 défis à relever]
#v(0.1em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.4em,
  row-gutter: 0.3em,
  align: (center + horizon, center + horizon, center + horizon),
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[🛡️ *Licence* \ #text(size: 0.75em)[protection juridique]]
    ]],
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[👨‍💻 *DX* \ #text(size: 0.75em)[expérience développeur]]
    ]],
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[🔄 *Reproductibilité* \ #text(size: 0.75em)[installation simplifiée]]
    ]],
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[🏗️ *Architecture* \ #text(size: 0.75em)[modulaire et claire]]
    ]],
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[📚 *Documentation* \ #text(size: 0.75em)[multi-publics]]
    ]],
  [#block(
      fill: primary-color.lighten(85%),
      inset: 0.3em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[✅ *Tests* \ #text(size: 0.75em)[qualité logicielle]]
    ]],
)

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.95em)[#text(weight: "bold")[🎯 Objectif global :] projet stable, compréhensible et réutilisable en open-source.]
]

= Méthodologie

== Suivi du projet
#grid(
  columns: (55%, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/notion01.png", width: 100%),
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[📋 Outil central]
    #v(0.3em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      *Notion*
      #v(0.1em)
      #text(size: 0.9em)[Kanban + documentation des décisions]
    ]

    #v(0.3em)

    - *Tags* : refactoring, documentation, tests
    - *Wiki* : historique des décisions architecturales
    - Transparence avec CeCoTePe et ULiège
  ],
)

== Structure initiale et difficultés
#grid(
  columns: (52%, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top),
  stack(
    dir: ttb,
    spacing: 0.4em,
    [
      #align(center)[
        #text(size: 0.85em, weight: "bold", fill: secondary-color)[THÉORIE]
        #v(0.1em)
        #image("assets/architecture_simple.png", height: 5.8cm)
      ]
    ],
    [
      #align(center)[
        #text(size: 0.85em, weight: "bold", fill: primary-color)[RÉALITÉ]
        #v(0.1em)
        #image("assets/architecture.png", height: 5.8cm)
      ]
    ],
  ),
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[📂 Constat]
    #v(0.3em)
    66 dossiers, dépendances croisées entre composants.

    #v(0.4em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.95em, weight: "bold")[⚠️ Difficultés]
      #v(0.2em)
      - *Évolutivité* : 1 feature → 4–5 composants
      - *Déploiement* : pas de CI/CD, manuel
      - *Ressources* : #alert[3 Go RAM] en dev
      - *Contribution* : code non documenté
    ]
  ],
)


== L'anti-pattern
#grid(
  columns: (45%, 1fr),
  column-gutter: 1.2em,
  align: (center + horizon, left + top),
  image("assets/distributed-monolith.png", width: 100%),
  [
    *Services physiquement séparés mais logiquement couplés.*

    #v(0.5em)

    #block(
      fill: red.lighten(80%),
      inset: 0.6em,
      radius: 4pt,
      width: 100%,
    )[
      *⚠️ Symptômes observés*
      - 5 à 7 appels REST synchrones par requête
      - Défaillance d'un composant → impact global
    ]

    #v(0.4em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.6em,
      radius: 4pt,
      width: 100%,
    )[
      *🎯 Cause racine*
      - Absence d'analyse DDD initiale
      - Évolution continue du domaine
    ]
  ],
)

== Comparaison avec d'autres patterns
#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + text-color,
  fill: (col, row) => if row == 0 { primary-color.lighten(85%) } else if row == 7 { secondary-color.lighten(75%) } else if calc.even(row) { luma(245) } else { white },
  table.header(
    [*Critère*], [*Monolithe*], [*Mono. distribué*], [*Modulaire*], [*Micro-services*],
  ),
  [Simplicité déploiement], [➕➕➕], [➖], [➕➕], [➕],
  [Indépendance équipes], [➖], [➖], [➕], [➕➕➕],
  [Scalabilité granulaire], [➖], [➕], [➕], [➕➕➕],
  [Complexité opérationnelle], [➕], [➖➖➖], [➕➕], [➖➖➖],
  [Facilité contribution], [➕➕], [➖], [➕➕], [➕],
  [Résilience], [➖], [➖➖➖], [➕], [➕➕➕],
  [*Adéquation au contexte*], [*➕➕*], [*➖➖➖*], [*#text(fill: primary-color)[➕➕➕]*], [*➖*],
)

#v(0.3em)

#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #align(center)[
    *Monolithe modulaire* : le meilleur compromis pour notre contexte — ~15 conteneurs, 1 équipe, contribution open-source.
  ]
]

= Solutions

== Projet de refactorisation
#block(
  fill: primary-color.lighten(85%),
  inset: 0.5em,
  radius: 4pt,
  width: 100%,
)[
  #align(center)[
    #text(weight: "bold")[Transition partielle :] monolithe distribué → monolithe modulaire
  ]
]

#v(0.4em)

#grid(
  columns: (auto, 1fr, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top, left + top),
  stack(
    dir: ttb,
    spacing: 0.5em,
    [#align(center)[#image("assets/micro-service.png", width: 10.5cm)]],
    [#align(center)[#image("assets/modular_monolith.png", width: 5.5cm)]],
  ),
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[🎯 Pourquoi ?]
    #v(0.3em)
    - Analyse *DDD* : bounded contexts
    - Architecture simplifiée
    - Évolutivité améliorée
    - Contribution facilitée
  ],
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[🤔 Pourquoi partielle ?]
    #v(0.3em)
    - Multi-langages (Python, TS)
    - Évolution progressive
    - Scaling horizontal ciblé
  ],
)

== Proposition architecturale
#grid(
  columns: (1.5fr, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top),
  image("assets/proposition_architecturale.png", height: auto),
  [
    #text(size: 0.95em, weight: "bold", fill: primary-color)[🔵 Edge / Frontend]
    #v(0.1em)
    Utilisateur → Ingress → KrakenD → Angular

    #v(0.3em)

    #text(size: 0.95em, weight: "bold", fill: primary-color)[🟢 Cœur métier]
    #v(0.1em)
    - *business* : CRM Service + DB + S3
    - *security* : Keycloak + DB
    - *infra* : Event Bus (NATS)

    #v(0.3em)

    #text(size: 0.95em, weight: "bold", fill: primary-color)[🟣 Event-services]
    #v(0.1em)
    Notification, Template Generator, Key Generation, Key Simulation
  ],
)


= Infrastructure et Open-Source
== Accès Code Source
#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/image.png", height: 12cm),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      #align(center)[
        #text(weight: "bold")[📜 Licence Apache 2.0]
        #v(0.2em)
        permissive + protection des brevets
      ]
    ]

    #v(0.4em)

    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.6em,
      align: (left + top, left + top),
      [
        #text(size: 0.95em, weight: "bold", fill: primary-color)[🏛️ Gouvernance]
        #v(0.2em)
        - Organisation *OptimCE*
        - Politique de contribution
        - Hiérarchie : mainteneurs, contributeurs, utilisateurs
      ],
      [
        #text(size: 0.95em, weight: "bold", fill: primary-color)[🛠️ DX]
        #v(0.2em)
        - Linting automatisé
        - DevContainers préconfigurés
        - `repository_dispatch` pour synchro
      ],
    )
  ],
)


== CI/CD et qualité automatisée
#grid(
  columns: (auto, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top),
  image("assets/cicd-pipeline.png", height: 12cm),
  [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 0.6em,
      align: (left + top, left + top),
      [
        #text(size: 1em, weight: "bold", fill: primary-color)[⚙️ Pipeline]
        #v(0.2em)
        - Tests + intégration
        - Dependabot
        - Build Docker
        - Cosign
        - Doc + notify
      ],
      [
        #text(size: 1em, weight: "bold", fill: primary-color)[🛡️ Qualité]
        #v(0.2em)
        - Unitaires + intégration
        - Healthcheck `/health`
        - CodeQL : CVE
        - Dependabot
        - Cosign : signature
      ],
    )

    #v(0.3em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      #text(size: 0.9em, weight: "bold")[→ Auto à chaque PR :] tests, scans de sécurité, build, signature d'images et documentation — tout s'exécute automatiquement.
    ]
  ],
)

== Monorepo et déploiement
#align(center)[#image("assets/docker-compose-dev-mermaid.png", width: 20cm)]

#v(0.3em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + top, left + top),
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[📦 Organisation]
    - 1 dépôt Git par composant
    - Submodules → monorepo de staging
    - `git clone --recurse-submodules`
    - Synchro via `repository_dispatch`
  ],
  [
    #text(size: 1em, weight: "bold", fill: primary-color)[🧩 Composants]
    - `crm-backend`, `crm-frontend`
    - `keycloak` + `keycloak-config`
    - `krakend` + `swagger2krakend`
    - `optimce-keycloak-theme`
  ],
)

== Compose vs Kubernetes
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  align: (left + top, left + top),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.6em,
      radius: 6pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: primary-color)[✅ Notre contexte]
      #v(0.3em)
      - \~15 conteneurs sur 1 VPS
      - Charge stable et prévisible
      - Équipe : 1 développeur
      - Pas d'auto-scaling nécessaire
    ]
  ],
  [
    #block(
      fill: red.lighten(80%),
      inset: 0.6em,
      radius: 6pt,
      width: 100%,
    )[
      #text(weight: "bold", fill: red.darken(20%))[❌ K8s surdimensionné]
      #v(0.3em)
      - Min. 3 nœuds maître + workers
      - Équipe SRE/DevOps dédiée
      - Courbe d'apprentissage : semaines
      - Mise en prod : jours
    ]
  ],
)

#v(0.5em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.7em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold")[Le choix : Docker Compose.] \
  K8s reste accessible via *Docker Compose Bridge* (scaling horizontal, migration cloud).
]

== Expérience déploiement
#block(
  fill: luma(15%),
  inset: 1em,
  radius: 4pt,
  width: 100%,
  text(font: "Fira Code", size: 0.95em, fill: white)[
    `$ git clone --recurse-submodules https://github.com/OptimCE/monorepo.git`
    #v(0.3em)
    `$ cd monorepo && ./docker-stack.sh start`
  ],
)

#v(0.4em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.6em,
  align: (left + top, left + top, left + top),
  [
    #text(size: 0.95em, weight: "bold", fill: primary-color)[📦 Déploiement]
    #v(0.2em)
    - Keycloak
    - PostgreSQL
    - MinIO
    - NATS
    - KrakenD
    - Nginx
  ],
  [
    #text(size: 0.95em, weight: "bold", fill: primary-color)[⚙️ Configuration]
    #v(0.2em)
    - SSL/TLS (Certbot)
    - Realm Keycloak
    - API Gateway
    - Frontend Angular
    - Reverse proxy
  ],
  [
    #text(size: 0.95em, weight: "bold", fill: primary-color)[✅ Résultat]
    #v(0.2em)
    - ~15 conteneurs prêts
    - 1 fichier `.env`
    - Images GHCR
    - Healthchecks actifs
    - Production-ready
  ],
)

#v(0.3em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.6em,
  radius: 4pt,
  width: 100%,
)[
  #text(weight: "bold")[→ Images pré-construites via GHCR :] pas de build local, déploiement reproductible.
]

= Contributions open-source

== Keycloak
#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.6em,
  align: (left + top, left + top),
  [
    #text(size: 0.9em, weight: "bold", fill: primary-color)[🔐 Standards]
    #v(0.1em)
    - *OAuth 2.0 + OIDC*
    - *JWT* auto-contenu
    - `kc-groupid-mapper`
  ],
  [
    #text(size: 0.9em, weight: "bold", fill: primary-color)[⚙️ Intégration]
    #v(0.1em)
    - *Keycloakify* (React → FTL)
    - Config JSON générique
    - Démarrage via `keycloak-config`
  ],
)

#v(0.2em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.4em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.85em, weight: "bold")[🤔 Pourquoi Keycloak ?]
  #v(0.1em)
  #text(size: 0.8em)[
    *vs Auth0/Okta* : OSS auto-hébergeable, pas de vendor lock-in. \
    *vs custom REST* : sécurité native (CSRF, MFA, social login). \
    *vs Authentik* : écosystème mature (plugins, doc).
  ]
]

#v(0.2em)

#block(
  fill: primary-color.lighten(85%),
  inset: 0.4em,
  radius: 4pt,
  width: 100%,
)[
  #text(size: 0.85em)[#text(weight: "bold")[🎯 Choix assumé :] thèmes Keycloak (redirection) > custom REST. \
  Sécurité native maximale au prix d'une légère redirection.]
]

== Outils d'automatisation
#grid(
  columns: (1.3fr, 1fr),
  column-gutter: 0.8em,
  align: (center + horizon, left + top),
  [
  #v(1fr)
  #image("assets/config-generation-flow.png", height: 10.5cm)
  #v(1fr)
  ],
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      *🔧 Swagger2Krakend* (Python)
      #v(0.1em)
      #text(size: 0.85em)[Config KrakenD depuis OpenAPI + règles YAML]
    ]

    #v(0.2em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      *📝 Templates envsubst*
      #v(0.1em)
      #text(size: 0.85em)[Nginx, Angular, Keycloak]
    ]

    #v(0.2em)

    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.4em,
      radius: 4pt,
      width: 100%,
    )[
      *💓 Healthcheck sidecars*
      #v(0.1em)
      #text(size: 0.85em)[`curl` minimalistes, démarrage ordonné]
    ]
  ],
)

== EcoArbiter
#grid(
  columns: (auto, 1fr),
  column-gutter: 1em,
  align: (center + horizon, left + top),
  image("assets/emsg-logic.png", height: 14cm),
  [
    #text(weight: "bold", fill: primary-color)[Algorithme Rust open-source]
    - Alternative au BEMS d'ULiège
    - Distribution équitable entre EMS locaux
    - Complexité basse → haute fréquence possible

    #v(0.4em)

    #text(weight: "bold", fill: primary-color)[3 scénarios]
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
            #text(size: 0.85em)[prorata des besoins]
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
            #text(size: 0.85em)[stockage / réseau]
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
            #text(size: 0.85em)[délestage équitable]
          ]
        ]
      ],
    )

    #v(0.3em)

    Licence *Apache 2.0* — conçu pour intégration facile.
  ],
)

= Résultats, conclusion et perspectives
== Métriques de performance
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  align: (center + horizon, center + horizon, center + horizon),
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.8em,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        #text(size: 0.9em, weight: "bold", fill: primary-color)[CONSOMMATION MÉMOIRE]
        #v(0.3em)
        #text(size: 1.8em, weight: "bold")[3 Go → 800 Mo]
        #v(0.2em)
        #text(size: 1.1em, weight: "bold", fill: primary-color)[−73%]
      ]
    ]
  ],
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.8em,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        #text(size: 0.9em, weight: "bold", fill: primary-color)[APPELS REST / REQUÊTE]
        #v(0.3em)
        #text(size: 1.8em, weight: "bold")[5–7 → 1–2]
        #v(0.2em)
        #text(size: 1.1em, weight: "bold", fill: primary-color)[÷3 à ÷4]
      ]
    ]
  ],
  [
    #block(
      fill: primary-color.lighten(85%),
      inset: 0.8em,
      radius: 6pt,
      width: 100%,
    )[
      #align(center)[
        #text(size: 0.9em, weight: "bold", fill: primary-color)[LATENCE UTILISATEUR]
        #v(0.3em)
        #text(size: 1.8em, weight: "bold")[perceptible]
        #v(0.2em)
        #text(size: 1.1em, weight: "bold", fill: primary-color)[ch ↓ significative]
      ]
    ]
  ],
)

#v(0.5em)

#block(
  fill: secondary-color.lighten(75%),
  inset: 0.6em,
  radius: 4pt,
  width: 100%,
)[
  *Impact concret* : environnement de dev local viable, stack de production
  exécutable sur un VPS standard.
]

== Leçons apprises
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  align: (left + top, left + top, left + top),
  [
    #text(size: 1.4em)[🏗️] \
    *Architecture*
    - Faire du *DDD avant* de découper en micro-services
    - Monolithe modulaire > monolithe distribué
    - Adapter la solution à l'échelle réelle
  ],
  [
    #text(size: 1.4em)[📖] \
    *Open-source*
    - Code + gouvernance + documentation
    - La DX est le facteur clé d'adoption
    - Une commande > mille README
  ],
  [
    #text(size: 1.4em)[🔄] \
    *Méthodologie*
    - Décisions documentées au fil de l'eau
    - Kanban partagé → collaboration asynchrone
    - Standards (OAuth2/OIDC) → interopérabilité
  ],
)

== Bilan et perspectives
#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  align: (left + top, left + top),
  [
    #text(size: 1.2em, weight: "bold", fill: primary-color)[✅ Ce que le refactoring a apporté]
    #v(0.3em)
    - #text(weight: "bold")[🏗️] Architecture modulaire
    - #text(weight: "bold")[🚀] Infrastructure reproductible
    - #text(weight: "bold")[⚙️] Pipeline CI/CD complet
    - #text(weight: "bold")[📦] ~15 conteneurs, 1 fichier `.env`
  ],
  [
    #text(size: 1.2em, weight: "bold", fill: primary-color)[🔭 Perspectives]
    #v(0.3em)

    #block(
      fill: primary-color.lighten(85%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *Court terme* — tests d'intégration automatisés
    ]

    #v(0.3em)

    #block(
      fill: secondary-color.lighten(75%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *Moyen terme* — Kubernetes via Compose Bridge
    ]

    #v(0.3em)

    #block(
      fill: tertiary-color.lighten(70%),
      inset: 0.5em,
      radius: 4pt,
      width: 100%,
    )[
      *Long terme* — offre SaaS, EcoArbiter industrialisé
    ]
  ],
)

#focus-slide[
  Merci de votre attention \
  #v(1.5em)
  #text(size: 0.6em)[Andrea Spelgatti] \
  #v(0.3em)
  #text(size: 0.5em)[HEPL — Master Ingénieur Industriel] \
  #v(0.3em)
  #text(size: 0.5em, fill: secondary-color)[#link("https://github.com/OptimCE")[github.com/OptimCE]]
]
