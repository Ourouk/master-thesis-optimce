#import "template/template.typ": *

#show: project.with(
  main-title: "Pérennisation d'un projet de recherche grâce à l'open source",
  sub-title: "Une approche intégrée associant restructuration technique, intégration continue et gouvernance collaborative",
  fullTitlePage: true,
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ingénieur Industriel",
      specialty: "Génie Électrique et Informatique",
    ),
  ),
  bibliography-file: "../ref.bib",
  annex: include "annex.typ",
  binding: false,
)
#set text(lang: "fr")
= Remerciements

Je tiens à remercier Éric Paque, mon promoteur au sein du CeCoTePe, pour son encadrement, sa confiance et ses conseils avisés tout au long de ce travail.

Je remercie également les membres de l'équipe BEMS de l'Université de Liège pour leur collaboration et leurs retours constructifs lors des réunions de coordination hebdomadaires.

J'exprime ma gratitude envers l'ensemble des partenaires du projet Locomotrice, le CeCoTePe, l'Université de Liège et Émission Zéro, pour leur engagement dans cette recherche visant à faciliter la transition énergétique participative.

Je tiens aussi à saluer les membres de la communauté open-source pour leur travail acharné et leur contribution à l'écosystème logiciel, qui m'ont inspiré dans la structuration et la gouvernance de ce projet.

Mes remerciements s'adressent également à l'équipe éducative de l'ISIL, qui m'a soutenu tout au long de mon cursus académique.

J'adresse une mention particulière à Guillain Ernotte pour m'avoir fourni le template Typst#footnote([Typst est un langage de composition de documents concurrent de TeX/LaTeX]) utilisé pour la rédaction de ce mémoire, ce qui en a grandement facilité la mise en forme et l'organisation.

Enfin, je remercie chaleureusement ma famille et mes amis pour leur présence et leur soutien inconditionnel au cours de ce parcours exigeant.

#pagebreak()

#set text(lang: "eng")
= Abstract

This Master's Thesis presents the transition of the OptimCE subproject—developed within the framework of the Locomotrice research project—toward an open-source model. The goal is to restructure the project to make it accessible, maintainable, and adaptable for a diverse community, including researchers, businesses, and energy communities.

== Problem Statement

The challenges addressed include:
- *Code Quality*: Improving readability, modularity, and developer experience.
- *Reproducibility*: Simplifying the infrastructure to ensure smooth installation.
- *Simplification*: Reducing the project's complexity, which is currently excessive for its scale.
- *Documentation*: Creating clear resources tailored to different audiences.
- *Testing*: Implementing unit and integration tests to ensure stability.
- *Communication*: Developing a promotion strategy to maximize adoption.
- *Governance*: Establishing collaborative processes for effective development.

== Methodology

The approach combines:
- *Architectural Audit*: Identifying anti-patterns (e.g., Distributed Monolith).
- *Refactoring*: Merging redundant components (e.g., Backend Database and Backend).
- *DevOps*: Integrating CI/CD#footnote[Continuous Integration / Continuous Deployment — pratiques d'intégration et de déploiement continus du code.] and automation.
- *Tooling*: Developing solutions for deployment and collaboration.
- *Benchmarking*: Studying best practices from established open-source projects.
- *Communication Tools*: Using available tools to facilitate collaboration.

== Results

The refactoring resulted in a 73% reduction in memory consumption (3 GB to 800 MB), a significant decrease in synchronous REST#footnote[Representational State Transfer — style d'architecture logicielle basé sur des appels HTTP sans état.] calls between micro-services#footnote[Architecture décomposant une application en services indépendants communiquant via le réseau.] (leading to reduced system latency), and the implementation of a complete CI/CD pipeline with automated security scanning, dependency updates, and signed Docker images. The project is now structured as a modular architecture with independent Git repositories, a staging monorepo, and a one-command deployment system.

== Conclusion

By the end of this work, the OptimCE project is transformed into a stable, modular, and easily reusable solution, characterized by reduced technical complexity. This restructuring promotes its adoption by the open-source community while ensuring its longevity and laying the foundations for collaborative and adaptable governance.

#pagebreak()

#set text(lang: "fr")
= Résumé

Ce mémoire de master présente la transition du sous-projet OptimCE, développé dans le cadre du projet de recherche Locomotrice, vers un modèle open-source. L'objectif est de restructurer le projet pour le rendre accessible, maintenable et adaptable pour une communauté diversifiée, incluant des chercheurs, des entreprises et des communautés énergétiques.

== Problématique

Les défis abordés comprennent :
- *Qualité du code* : Améliorer la lisibilité, la modularité et l'expérience développeur.
- *Reproductibilité* : Simplifier l'infrastructure pour assurer une installation fluide.
- *Simplification* : Réduire la complexité du projet, actuellement excessive pour son échelle.
- *Documentation* : Créer des ressources claires adaptées à différents publics.
- *Tests* : Mettre en place des tests unitaires et d'intégration pour garantir la stabilité.
- *Communication* : Développer une stratégie de promotion pour maximiser l'adoption.
- *Gouvernance* : Établir des processus collaboratifs pour un développement efficace.

== Méthodologie

L'approche combine :
- *Audit architectural* : Identification des anti-patterns (ex. : Monolithe Distribué).
- *Refactoring* : Fusion des composants redondants (ex. : Backend Database et Backend).
- *DevOps* : Intégration de CI/CD et automatisation.
- *Outillage* : Développement de solutions pour le déploiement et la collaboration.
- *Benchmarking* : Étude des meilleures pratiques de projets open-source établis.
- *Outils de communication* : Utilisation d'outils disponibles pour faciliter la collaboration.

== Résultats

Le refactoring a permis une réduction de 73 % de la consommation mémoire (de 3 Go à 800 Mo), une diminution significative des appels REST synchrones entre micro-services (diminuant par conséquent la latence du système), et la mise en place d'un pipeline CI/CD complet avec analyse de sécurité automatisée, mises à jour de dépendances et signature d'images Docker. Le projet est désormais structuré en architecture modulaire avec des dépôts Git indépendants, un monorepo de staging et un système de déploiement en une commande.

== Conclusion

À l'issue de ce travail, le projet OptimCE a été transformé en une solution stable, modulaire et facilement réutilisable, caractérisée par une complexité technique réduite. Cette restructuration favorise son adoption par la communauté open-source tout en assurant sa pérennité et en posant les bases d'une gouvernance collaborative et adaptable.

#pagebreak()

#set text(lang: "fr")
= Lexique

#table(
  columns: (auto, 1fr),
  inset: 3pt,
  stroke: none,
  [*Abréviation*], [Signification],
  [*2PC*], [Two-Phase Commit : protocole de validation en deux phases pour les transactions distribuées],
  [*ACID*], [Atomicité, Cohérence, Isolation, Durabilité],
  [*BEMS*], [Building Energy Management System],
  [*CeCoTePe*], [Centre de Coopération Technique et Pédagogique],
  [*CI/CD*], [Continuous Integration / Continuous Deployment],
  [*CRM*], [Customer Relationship Management],
  [*CVE*], [Common Vulnerabilities and Exposures],
  [*DDD*], [Domain-Driven Design],
  [*DTO*], [Data Transfer Object],
  [*DX*], [Developer Experience (Expérience Développeur)],
  [*EMS*], [Energy Management System],
  [*HEPL*], [Haute École de la Province de Liège],
  [*IaC*], [Infrastructure as Code],
  [*ISIL*], [Institut Supérieur Industriel de Liège],
  [*JWT*], [JSON Web Token],
  [*k3s*], [Distribution Kubernetes légère],
  [*NATS*], [Broker de messages open-source],
  [*OAuth 2.0*], [Open Authorization 2.0],
  [*OIDC*], [OpenID Connect],
  [*ORM*], [Object-Relational Mapping],
  [*OTLP*], [OpenTelemetry Protocol],
  [*PPS*], [Produit, Procédé ou Service],
  [*REST*], [Representational State Transfer],
  [*RGPD*], [Règlement Général sur la Protection des Données],
  [*S3*], [Simple Storage Service],
  [*SaaS*], [Software as a Service],
  [*SDK*], [Software Development Kit],
  [*SRE*], [Site Reliability Engineering],
  [*TRL*], [Technology Readiness Level],
  [*TTL*], [Time To Live],
  [*VPS*], [Virtual Private Server],
)

#pagebreak()
= Introduction

Ce mémoire s'inscrit dans le cadre de la mise en open-source du projet *OptimCE*, un composant clé du projet de recherche *Locomotrice*. Le projet Locomotrice est financé par l'appel à projets Win²Wal#footnote([Le programme Win²WAL finance, au sein des universités, hautes écoles et centres de recherche agréés, des projets de recherche industrielle qui permettront l'émergence d'un produit, d'un procédé ou d'un service (PPS).#cite(<Spw_2026_wallonie>)]) et inclut le CeCoTePe#footnote[Centre de Coopération Technique et Pédagogique, ASBL encadrant des formations professionnelles et de la recherche.], l'équipe BEMS de l'Université de Liège et Émission Zéro en tant que partenaire industriel. Son objectif est de faciliter la transition énergétique participative en développant une plateforme open-source pour les communautés d'énergie #cite(<locomotrice>). Le projet se divise en deux volets : OptimCE, plateforme administrative de gestion de membres et d'informations pour les communautés d'énergie, réalisé par le CeCoTePe, et EMS (Energy Management System), sous-projet domotique de contrôle de la consommation électrique, géré par l'ULiège.

L'objectif principal d'OptimCE est de fournir une plateforme administrative de gestion de membres et d'informations spécifiques à la gestion d'une communauté d'énergie. L'entreprise repreneuse a comme seules exigences techniques l'utilisation de *Node.js* et de *Kubernetes*, sans exprimer de préférence particulière quant au système de gestion de bases de données. Ces décisions architecturales seront détaillées ultérieurement dans ce document.

Le projet *OptimCE* atteint un niveau de maturité technologique (TRL#footnote[Technology Readiness Level : niveau de maturité technologique (1-9) indiquant la proximité d'un déploiement en production. Le niveau 7 signifie un système déjà testé et à faible risque.]) de 7 #cite(<Horizon_Europe_2026_gouv>). Ce niveau indique que le projet est proche d'un état opérationnel, prêt à être déployé en production. Initialement, ce développement était prévu pour être réalisé par un seul développeur dans le cadre interne de la Haute École de la Province de Liège (HEPL).

Ce travail a été réalisé au sein des locaux de l'ISIL (Institut Supérieur Industriel de Liège) sur une période de 8 mois, d'octobre à mai, sous l'encadrement d'Éric Paque. Des réunions hebdomadaires de coordination avec l'Université de Liège ont également été organisées pour assurer la synchronisation entre les volets OptimCE et EMS du projet.

== Contexte du projet Locomotrice

Le projet Locomotrice, initialement développé dans un cadre de recherche, doit être rendu open-source afin d'être accessible à la communauté d'utilisateurs ainsi qu'aux entreprises susceptibles de le reprendre. Cette transition hors du contexte académique pose plusieurs défis majeurs.

== Problématique

=== Problématique générale

Comment transformer un prototype de recherche complexe et fragile en une solution robuste, simple à déployer et ouverte à la contribution collective ?

=== Problématiques spécifiques

- *Licences* : Comment choisir une licence open-source compatible avec les usages envisagés (usage communautaire, usage commercial, contributions externes) et sécuriser juridiquement la publication du code ?

- *Attractivité et Expérience Développeur (DX)* : La réussite d'un projet open-source repose fondamentalement sur sa capacité à attirer et à fidéliser des contributeurs. Face à un code initialement conçu par un développeur/chercheur solo, aux pratiques ou au formatage parfois hétérogènes, comment instaurer une base de travail lisible, cohérente et rassurante ? L'enjeu est d'optimiser l'expérience développeur pour éliminer les barrières à l'entrée et toute friction technique qui risqueraient de décourager la bonne volonté de la communauté.

- *Reproductibilité et portabilité du projet* : Comment réduire la complexité actuelle du projet pour garantir une installation facile ?

  Dans le prolongement de cette accessibilité, l'infrastructure de développement doit être repensée de façon plus simple et accessible. Une grande partie des contributeurs commence par en être de simples utilisateurs. Il est donc fondamental de leur offrir une reproductibilité complète et immédiate : s'ils peuvent exécuter, tester et modifier le projet localement sans se heurter à une configuration laborieuse, ils seront d'autant plus enclins à basculer du rôle d'utilisateur à celui de contributeur actif.

- *Architecture et compréhension du code* : Comment structurer l'architecture du code pour la rendre compréhensible par des développeurs externes ? Quelle infrastructure minimale de développement et de production est nécessaire pour garantir une reproductibilité complète ?

- *Documentation* : Comment fournir une documentation claire, complète (installation, API, architecture, exemples), et adaptée à différents publics (développeurs, chercheurs, entreprises) ?

- *Testing et qualité logicielle* : Comment mettre en place une stratégie de tests (unitaires, d'intégration) permettant d'améliorer la qualité, détecter les régressions, renforcer la confiance dans le projet et réduire la charge de maintenance ?

== Objectifs

Notre travail se concentre sur :

- L'amélioration de l'architecture et de la structure du code, afin de rendre le projet plus clair et modulaire.
- La lisibilité et la qualité du code, via des bonnes pratiques et des outils de vérification.
- La mise en place d'une infrastructure reproductible, facilitant l'installation, le développement et l'exécution du projet.
- La réduction de la complexité générale, pour simplifier l'adoption et la contribution par la communauté.

L'objectif global est de rendre le projet stable, compréhensible et facilement réutilisable en open-source.

= État de l'art

Cette section présente le cadre théorique et les références qui ont guidé nos choix architecturaux et organisationnels.

== Évolution du code et dette technique

=== Lois de l'évolution logicielle

Dès 1980, Lehman a formulé un ensemble de lois décrivant l'évolution inéluctable des systèmes logiciels #cite(<Lehman_1980>). Parmi celles-ci, deux éclairent directement la problématique de ce mémoire : la loi d'*augmentation de la complexité* (loi 2), qui stipule que la complexité d'un système croît inévitablement au fil des modifications sauf si un travail explicite est mené pour la réduire, et la loi de *dégradation de la qualité* (loi 6), qui prévient que la qualité perçue du système décline sauf à maintenir une adaptation rigoureuse aux changements de l'environnement. Ces lois fournissent un cadre théorique pour comprendre pourquoi un projet de recherche, soumis à des évolutions fréquentes et exploratoires, tend naturellement vers une complexité croissante.

=== Métaphore de la dette technique

Ward Cunningham a popularisé la métaphore de la dette technique #cite(<Cunningham_1992>) pour décrire les conséquences des compromis techniques à court terme. Tout comme une dette financière, elle se compose d'un *principal* (le coût initial d'une solution sous-optimale choisie délibérément) et d'*intérêts* (le surcoût de maintenance accumulé à chaque modification ultérieure). Sans remboursement régulier par du refactoring, les intérêts composés finissent par paralyser l'évolution du projet.

Dans un contexte académique, cette dette est particulièrement insidieuse : les contraintes de délais, l'évolution rapide des besoins et la priorité donnée à la validation de concepts plutôt qu'à la perfection structurelle sont autant de facteurs légitimes qui l'alimentent. Pourtant, les projets de recherche doivent aussi garantir leur réutilisabilité et leur maintenabilité, surtout lorsqu'ils visent une transition vers l'open-source.

=== Dérive architecturale

La dérive architecturale est une forme spécifique de dette technique où l'architecture initiale devient progressivement inadaptée face à l'évolution des besoins. Dans notre projet, elle s'est manifestée par la transition d'une architecture micro-services théoriquement claire vers un *monolithe distribué*, un anti-pattern combinant les inconvénients du monolithe (couplage fort) et des micro-services (complexité opérationnelle), comme détaillé dans la section @ddd.

Ces concepts, lois de Lehman, dette technique et dérive architecturale, constituent le prisme théorique à travers lequel nous analyserons l'état initial du projet OptimCE et les choix de refactoring opérés.

== Architectures logicielles : du monolithe aux micro-services

L'architecture logicielle d'un système influence directement sa maintenabilité, sa scalabilité et la productivité des équipes qui le développent. Trois paradigmes principaux coexistent dans l'industrie :

=== Architecture monolithique

L'architecture monolithique regroupe l'ensemble des fonctionnalités dans une seule unité déployable. Elle présente l'avantage de la simplicité : un seul code source, un seul déploiement, des tests simplifiés et un débogage direct. Cependant, elle souffre de limitations à mesure que le projet croît : couplage fort entre les modules, difficulté à scaler individuellement les composants, et risque de dérive vers une architecture non structurée.

#figure(
  image("assets/monolith-architecture.png", width: 60%),
  caption: [Architecture monolithique, source : Thomas Morin #cite(<Morintd_2026_dev>)],
)

=== Architecture micro-services

L'architecture micro-services décompose le système en services indépendants, communiquant via des appels réseau (généralement REST ou messaging). Chaque service possède sa propre base de données, son cycle de vie et peut être développé dans un langage différent. Cette approche offre une scalabilité granulaire, une résilience accrue et une indépendance des équipes, ce qui la rend particulièrement adaptée aux projets impliquant de grandes équipes de développeurs.

#figure(
  image("assets/article-microservices.png", width: 60%),
  caption: [Architecture micro-services, source : Thomas Morin #cite(<Morintd_2026_dev>)],
)

Cependant, elle introduit une complexité opérationnelle significative : gestion des communications réseau, cohérence distribuée, déploiement orchestré et observabilité. Comme le souligne Microsoft dans son Azure Architecture Center, les micro-services ne devraient être envisagés que lorsque la complexité du système justifie cette approche #cite(<Claytonsiemens77_2026_microsoft>).



=== Approche hybride : les micro-services bien faits

Face au dilemme monolithe vs micro-services, une troisième voie existe : regrouper les services trop étroitement liés dans un monolithe modulaire, tout en isolant les composants véritablement indépendants. Cette approche, également formalisée par Microsoft #cite(<MicrosoftDDD_2026>), recommande une analyse de domaine rigoureuse avant de définir des frontières entre services.

Un bon candidat au statut de micro-service indépendant présente les caractéristiques suivantes :

  - Des besoins de scaling différents du reste de l'architecture (ex. : génération de documents, traitement de tâches lourdes)
  - Une technologie ou un langage spécifique justifiant une isolation
  - Une faible dépendance aux données des autres services

À l'inverse, un module intensivement dépendant des données d'autres services, qui scale de manière identique et n'effectue pas de tâches asynchrones lourdes, a tout intérêt à être intégré au monolithe.

=== Domain-Driven Design (DDD) <ddd>

Pour mener ce travail d'analyse, le Domain-Driven Design propose une méthode se basant sur la structure du domaine métier plutôt que sur des considérations purement techniques. Les concepts de *bounded contexts* et d'*ubiquitous language* permettent d'identifier les zones de cohérence sémantique où un service peut opérer de manière autonome.

Le principe fondamental du DDD est que chaque bounded context possède sa propre représentation des entités partagées. Prenons l'exemple d'un client :
- Pour un service de livraison, c'est une adresse et un prix payé
- Pour la gestion de compte, c'est un identifiant et un mot de passe
- Pour le service client, c'est un numéro de téléphone

Chaque contexte ne conserve que les données qui lui sont pertinentes, évitant ainsi le couplage fort. Si deux services parlent d'un objet de la même manière, le DDD suggère qu'il n'y a pas de raison valable de les séparer.

Dans le contexte de notre projet, l'absence d'une analyse DDD initiale a conduit à une définition imprécise des entités partagées entre services, générant un couplage fort et des appels synchrones excessifs. Le refactoring a consisté à identifier les bounded contexts naturels et à regrouper ceux qui partageaient la même sémantique.

== Bonnes pratiques open-source

La transition d'un projet académique vers un modèle open-source nécessite une structuration dépassant la simple publication du code source.

=== Gouvernance et licence

Le choix de la licence détermine les droits et obligations des utilisateurs et contributeurs. Les licences permissives (MIT, Apache 2.0) favorisent l'adoption commerciale, tandis que les licences copyleft (GPL, AGPL) garantissent que les dérivés restent open-source. La licence Apache 2.0 offre un équilibre avec sa clause de protection des brevets, ce qui en fait un choix courant pour les projets institutionnels #cite(<OpenSourceGuide_2026>).

La gouvernance définit les rôles (mainteneurs, contributeurs, utilisateurs), les processus de décision et les mécanismes de contribution. Le guide du gouvernement français sur l'open-source #cite(<pocos-dinsic-stable:online>) recommande une documentation claire des processus de contribution, un code de conduite et une politique de release explicite.

Cette démarche exige également une communication transparente quant aux objectifs du projet, aux priorités de développement et aux critères d'acceptation des contributions. 

Elle se traduit par la publication d'une feuille de route (*roadmap*), un suivi rigoureux des tickets (*issues*) et la mise en place de canaux d'échanges dédiés avec la communauté (forums, listes de diffusion, messagerie instantanée). Si ces pratiques peuvent sembler inhabituelles dans le cadre d'un projet de recherche traditionnel, elles s'avèrent indispensables à la pérennité et à l'adoption d'un projet open-source. En effet, au sein d'une communauté décentralisée, l'absence d'interactions informelles (les célèbres « discussions à la machine à café ») impose de formaliser et de documenter systématiquement les décisions et les orientations techniques, afin que l'ensemble des contributeurs puisse s'y référer sans ambiguïté.

=== Qualité logicielle en open-source

Les projets open-source matures intègrent systématiquement :
- Des pipelines CI/CD pour valider chaque contribution
- Des analyseurs statiques (CodeQL, SonarQube) pour détecter les vulnérabilités
- Des gestionnaires de dépendances automatisés (Dependabot, Renovate)
- Une documentation accessible et à jour

== DevOps et intégration continue

Le DevOps vise à réduire le cycle de développement en automatisant les étapes entre l'écriture du code et son déploiement en production #cite(<RedHatDevOps_2026>). Les pratiques clés incluent :

=== Intégration Continue (CI)

L'intégration continue consiste à merger fréquemment les modifications de code dans une branche principale, chaque merge étant validé par des builds et des tests automatisés. Cela permet de détecter les erreurs rapidement et de réduire les conflits d'intégration.

=== Déploiement Continu (CD)

Le déploiement continu automatise la mise en production des modifications validées, réduisant le temps entre le développement et la disponibilité pour les utilisateurs finaux.

=== Infrastructure as Code

L'infrastructure as code (IaC) permet de définir et versionner l'infrastructure via des fichiers de configuration, garantissant la reproductibilité des environnements et facilitant le déploiement. Docker Compose et Kubernetes sont des exemples d'outils implémentant cette approche.

= Méthodologie et solutions proposées

== Suivi du projet
Un suivi rigoureux du projet est essentiel pour garantir la transparence, la coordination et la documentation des décisions tout au long du développement. Un projet open-source, en particulier, nécessite une communication claire et une documentation accessible pour permettre à la communauté de comprendre les choix techniques et de contribuer efficacement.
=== Notion
Le suivi du projet a été effectué via *Notion*, utilisé comme gestionnaire de tâches (Kanban) et comme support de documentation des décisions architecturales. Une partie significative de ce mémoire a été rédigée en se basant sur les recherches préalables aux différentes implémentations, documentées au fil du travail.

#figure(
  image("assets/Notion01.png"),
  caption: [Kanban de suivi de l'avancement et de la dette technique],
)

L'adoption d'un tableau Kanban a offert une visualisation claire des tâches à accomplir, facilitant le suivi de l'avancement et l'identification rapide des goulots d'étranglement. Partagé avec l'ensemble des partenaires, cet outil est un très bon vecteur de transparence, centralisant l'information et fluidifiant la collaboration asynchrone.

L'utilisation d'étiquettes (*tags*) a permis de catégoriser finement les tâches (ex. : *refactoring*, documentation, tests) et d'en prioriser le traitement en fonction de leur impact sur la qualité globale du projet. De plus, cette approche visuelle offre plusieurs avantages inhérents à la méthode Kanban : elle permet de limiter la quantité de travail en cours (*Work In Progress*), d'éviter la surcharge cognitive des développeurs et d'améliorer la prédictibilité des livraisons.

Cette approche structurée s'est avérée particulièrement bénéfique pour la gestion de la dette technique. Elle a permis de recenser les composants à optimiser et de planifier leur refonte de manière méthodique. Plus qu'un simple outil de gestion, ce tableau est devenu une base documentaire à part entière. Il a préservé l'historique de l'évolution du projet, la trace des décisions architecturales et leurs justifications, nourrissant ainsi les échanges lors des réunions de coordination avec l'Université de Liège.

#figure(
  image("assets/Notion02.png", height: 7.5cm),
  caption: [Documentation des décisions architecturales],
)

L'outil Notion a été mis à profit pour consigner les choix techniques, les analyses architecturales et les justifications inhérentes à chaque étape de refactoring. Ainsi, toute décision majeure a fait l'objet d'une page dédiée, systématiquement liée à la tâche correspondante dans le tableau Kanban.

Ce processus documentaire s'est révélé indispensable, non seulement pour rationaliser le processus décisionnel tout au long du développement, mais également pour fournir la matière première essentielle à la rédaction de ce mémoire.

=== Alternatives libres et pérennité

Il convient toutefois d'émettre quelques réserves quant à l'utilisation de Notion dans le cadre d'un projet open-source, particulièrement concernant la pérennité de la documentation. Notion étant une *plateforme propriétaire*, il existe un risque inhérent de perte de données ou de restriction d'accès à l'avenir. Il est donc indispensable de définir une stratégie de sauvegarde régulière, par exemple en exportant les pages aux formats Markdown ou PDF, pour en garantir la disponibilité à long terme. Une alternative plus en adéquation avec la philosophie du projet consisterait à migrer vers des solutions open-source éprouvées, telles qu'un wiki auto-hébergé couplé à une instance Kanban libre de droits.

=== Jira et Confluence

Bien que Jira et Confluence soient des standards de l'industrie pour la gestion de projet et la documentation, leur adoption a été écartée ici. Ces plateformes, quoique très complètes, s'avèrent souvent complexes et surdimensionnées pour les besoins d'une équipe restreinte évoluant dans un cadre de recherche. Leur courbe d'apprentissage abrupte risque de constituer une barrière à l'entrée pour les contributeurs externes. À l'inverse, Notion offre une interface plus accessible et une souplesse parfaitement adaptée à notre contexte. Par ailleurs, l'expérience préalable du développeur principal avec cet outil en a grandement facilité l'intégration immédiate dans le flux de travail quotidien.

=== Bilan sur le système de suivi

Le choix de Notion s'est finalement justifié par sa simplicité, sa flexibilité et sa capacité à centraliser de manière homogène le pilotage des tâches et la documentation technique. Néanmoins, pour rester en parfaite cohérence avec les principes de l'open source à long terme, ce compromis devra sans doute céder sa place à une infrastructure libre.

En définitive, l'utilisation en continu d'un écosystème de suivi moderne a constitué un atout majeur. Elle a fluidifié la coordination et autorisé une traçabilité beaucoup plus granulaire que les méthodes classiques de reporting employées dans la recherche académique. En effet, l'exercice de la note d'avancement, souvent rédigée semestriellement par stricte obligation pour les validateurs financiers, s'avère chronophage, de nature narrative et pauvre en transmission technique pour d'autres développeurs. À l'inverse, la documentation « au fil de l'eau » mise en place a généré un patrimoine informationnel immédiat et pérenne, directement valorisable, surtout dans le cadre d'un projet open-source.

== Revue du code et analyse de l'architecture

L'analyse initiale du code source a révélé que l'architecture micro-services, bien qu'adaptée aux grandes équipes et aux déploiements cloud natifs, pose plusieurs défis majeurs dans le cadre d'un projet open-source.

Bien que conçue pour offrir la résilience, la scalabilité et un déploiement indépendant des composants, cette architecture introduit une complexité opérationnelle accrue, notamment en matière de tests, de compréhension globale du système et de maintenance.

Chaque micro-service, bien que faiblement couplé et déployable individuellement, nécessite une gestion fine des interconnexions, des protocoles de communication et des mécanismes de tolérance aux pannes, ce qui peut rendre le projet difficile à appréhender pour de nouveaux contributeurs ou pour une petite équipe de développeurs.

Elle nécessite donc une infrastructure et une culture de développement orientées vers les grandes équipes et/ou les entreprises. Un autre problème est que nous n'avions aucune certitude quant au déploiement du produit en tant que SaaS#footnote[Software as a Service — modèle de distribution de logiciel où l'application est hébergée par un fournisseur.] ; il pourrait très bien suivre une architecture auto-hébergée.
=== Illustration du problème
Lors de la division initiale, théoriquement, le code paraissait assez simple à suivre avec des frontières claires entre les composants.
#figure(
  image("assets/architecture_simple.png"),
  caption: [Architecture initialement prévue],
)
Or cette division relève d'un domaine de recherche à part entière : le *DDD*, tel que détaillé dans la section sur les architectures logicielles au @ddd. Son objectif est d'étudier l'interaction et la définition des objets au sein de l'ensemble du code source d'un produit.

L'intérêt du micro-service apparaît principalement lorsque les services manipulent les mêmes objets de façon totalement différente et ne les définissent même pas de la même manière, permettant ainsi une communication asynchrone où les données sont partiellement copiées et adaptées via un bus de communication.

En pratique, cette démarche d'analyse s'avère complexe. Dans le cadre de ce projet, l'évolution continue du domaine au fil du développement et une vision initiale incomplète de son ensemble ont mené à une définition imprécise des entités, entraînant ainsi une augmentation graduelle de la complexité technique.
== Proposition de modifications
Face à la complexité du projet, et dans l'objectif d'améliorer la lisibilité et l'expérience développeur, nous avons entrepris un important refactoring.

=== Anti-pattern : le monolithe distribué
Le monolithe distribué est un anti-pattern où les services sont physiquement séparés mais logiquement fortement couplés, combinant les inconvénients des deux approches : complexité opérationnelle des micro-services sans les bénéfices de l'indépendance. Cet anti-pattern apparaît fréquemment lorsqu'une architecture micro-services est adoptée sans une analyse rigoureuse des frontières du domaine métier.

#figure(
  image("assets/distributed-monolith.png", width: 60%),
  caption: [Le monolithe distribué, source : Thomas Morin #cite(<Morintd_2026_dev>)],
)

Dans notre projet initial, l'utilisation intensive d'appels synchrones REST entre services créait exactement ce scénario : chaque service dépendait fortement des autres pour fonctionner, formant un réseau de dépendances où la défaillance d'un composant pouvait impacter l'ensemble du système.
Le projet était tombé dans cet anti-pattern.

Combinant les désavantages du monolithe et des microservices. #cite(<Morintd_2026_dev>). Des parties du projet étaient trop proches au niveau du domaine d'analyse et nécessitaient techniquement trop d'appels synchrones.

Ces appels synchrones rendaient les micro-services très interdépendants et nécessitaient la modification de nombreuses parties de code dans différents composants pour chaque fonctionnalité.

Ce n'est d'ailleurs pas une erreur de conception initiale, mais plutôt une conséquence naturelle d'une évolution continue du projet sans une vision globale claire du domaine métier. En effet, à mesure que de nouvelles fonctionnalités étaient ajoutées et que le domaine s'affinait, les frontières entre les services devenaient floues, entraînant une augmentation progressive de la complexité technique. L'erreur n'est donc pas une mauvaise décision initiale, mais plutôt l'absence d'une vision d'ensemble au début du projet, ce qui a conduit à une dérive vers un monolithe distribué.

En plus d'une certaine pression du repreneur souhaitant l'utilisation de Kubernetes, qui est très adapté aux micro-services, mais pas nécessairement à notre projet, nous avons été confrontés à un dilemme : soit conserver l'architecture micro-services et accepter la complexité accrue, soit regrouper les services trop interdépendants pour réduire cette complexité.

#figure(
  image("assets/architecture.png"),
  caption: [Augmentation de la complexité],
)
Une des idées était donc de rassembler les fonctionnalités redondantes dans des services plus importants afin de réduire cette complexité, tout en anticipant la capacité future du produit à supporter une charge croissante.


=== Analyse comparative des architectures

Avant de procéder au refactoring, nous avons évalué ces architectures :

#table(
  columns: (auto, auto, auto, auto, auto),
  [*Critère*], [*Monolithe*], [*Mono. distribué*], [*Modulaire*], [*Micro-services*],
  [Simplicité de déploiement], [+++], [\-\-], [++], [+],
  [Indépendance des équipes], [\-\-], [\-\-], [+], [+++],
  [Scalabilité granulaire], [\-\-], [+], [+], [+++],
  [Complexité opérationnelle], [+], [\-\-\-], [++], [\-\-\-],
  [Facilité de contribution], [++], [\-\-], [++], [+],
  [Résilience], [\-\-], [\-\-\-], [+], [+++],
  [Adéquation au contexte], [++], [\-\-\-], [+++], [\-\-],
)
_Tableau comparatif des architectures évaluées pour le projet OptimCE._

Le monolithe distribué (notre architecture de départ par dérive) présentait les pires scores en combinant les inconvénients des autres approches. Le monolithe pur a été rejeté car il aurait empêché l'utilisation de Python pour les composants mathématiques et limité la scalabilité future. Les micro-services complets ont été écartés en raison de la complexité opérationnelle excessive pour une équipe réduite. L'architecture modulaire, un monolithe modulaire couplé à des micro-services pour les composants nécessitant une indépendance technique, a été retenue comme compromis optimal.

=== Suppression des backend-db

Initialement, une série de services avait pour rôle de transcrire les appels vers les bases de données en API REST. Bien que cette abstraction pût se justifier pour assurer une stricte séparation, elle apportait une couche de complexité supplémentaire qui n'était plus nécessaire dans notre contexte : chaque micro-service peut en effet accéder directement à sa propre base de données via une bibliothèque ORM#footnote[Object-Relational Mapping — technique de correspondance entre les objets d'un langage de programmation et les tables d'une base de données relationnelle.]. Nous avons donc préféré les fusionner avec les services qui les utilisaient, ce qui a permis d'alléger l'architecture en réduisant le nombre de conteneurs à déployer et à maintenir.

=== Fusion de composants
Nous avons également procédé à une fusion de micro-services en raison d'appels synchrones trop fréquents et de leur impact négatif sur les performances :
- Opérations de partage
- Communauté
- Membres

Ces fonctionnalités ont été regroupées vers un service unifié : le CRM (Customer Relationship Management).

Le nom de CRM a été choisi car c'est un nom assez commun dans les programmes SaaS, et il reflète bien la nature de ce service central qui gère les interactions avec les utilisateurs, les communautés et les opérations de partage. De plus, ce nom est suffisamment générique pour ne pas limiter l'évolution future du projet, tout en étant facilement compréhensible pour les développeurs et les utilisateurs finaux.

=== Fusion des frontends
Les frontends, initialement séparés pour chaque micro-service, ont été fusionnés en une seule interface utilisateur. Cette décision a été motivée par le fait que les différentes fonctionnalités (gestion de communauté, gestion des membres, opérations de partage) sont étroitement liées du point de vue de l'utilisateur final. Les regrouper dans une interface unifiée améliore la cohérence de l'expérience utilisateur et simplifie la maintenance du code frontend, ce qui nous permet de partager les éléments d'interface communs (ex. : barre de navigation, styles) sans devoir les dupliquer ou les synchroniser entre plusieurs projets.
=== Remplacement de certains composants par des services tiers
Certains composants, tels que l'API Gateway, le service d'identité ou le stockage d'objets, ont été remplacés par des solutions tierces éprouvées (KrakenD, Keycloak, MinIO). Cette décision a été prise pour réduire la charge de maintenance, bénéficier de fonctionnalités avancées (ex. : sécurité, scalabilité) et accélérer le développement en s'appuyant sur des outils spécialisés.

En effet, certains outils avaient été développés en interne pour répondre à des besoins spécifiques, mais leur maintenance et leur évolution représentaient une charge importante. En adoptant des solutions tierces, nous avons pu nous concentrer sur les fonctionnalités métier du projet tout en bénéficiant de la robustesse et de la communauté de support associée à ces outils.

Nous avons donc adapté notre architecture pour intégrer ces services tiers, en veillant à ce que les interfaces de communication soient clairement définies et que les données soient correctement synchronisées entre les différents composants du système.
=== Justification du maintien de certains micro-services
On pourrait se demander pourquoi ne pas fusionner l'ensemble dans l'application centrale.

L'architecture micro-services présente cependant certains avantages non négligeables dans des scénarios rencontrés au cours du projet :

- *Code source dans plusieurs langages* : certains composants existants du projet ont été réalisés en Python, notamment grâce à des bibliothèques mathématiques reconnues et plus largement testées que celles disponibles en TypeScript.

- *Fonctionnement asynchrone nécessaire* : certaines tâches peuvent s'avérer particulièrement demandeuses en calculs, chronophages, ou ne nécessiter aucune interaction directe avec le CRM. Dans ces cas de figure, il reste préférable de les isoler au sein de micro-services dédiés, garantissant ainsi une gestion optimisée des ressources et une scalabilité indépendante. Elles pourraient, par exemple, être relayées vers des instances dans le cloud ou exécutées sous forme de fonctions serverless (comme des AWS Lambda). Cette approche permettrait de réduire significativement les coûts d'infrastructure, dans la mesure où les ressources ne seraient allouées qu'au moment précis de l'exécution de ces tâches. Un tel modèle s'avère particulièrement pertinent dans le contexte d'une architecture hybride, combinant un hébergement sur site (on-premise) et des services cloud.

- *Composants micro-services restants* :
  - *Notifications* : Utilisation de SDK aisé sans être limité par un langage spécifique, et qui peut être facilement externalisé vers des services cloud (ex. : AWS SNS, Twilio).
  - *Simulation/Génération de clés* : Tâches potentiellement lourdes nécessitant une gestion indépendante des ressources, et pouvant bénéficier de langages spécialisés pour les calculs mathématiques.
  - *Template* : Gestion de modèles de documents ou d'e-mails, qui peut nécessiter une logique spécifique et bénéficier d'une isolation pour faciliter les évolutions futures.
  Ces composants restent donc indépendants du CRM et peuvent être développés dans les langages les plus adaptés à leur fonctionnement. Dans la majorité des cas, ces modules pourraient être implémentés sous forme de fonctions lambda si nous opérions dans le cloud.
=== Schéma après modification

==== Composant central : CRM-backend :
- Regroupe les fonctionnalités de gestion de communauté, de membres et d'opérations de partage.
- Permet une gestion orientée objet des données, avec des entités clairement définies (ex. : Community, User, CommunityUser).
- Réduit les appels synchrones entre les composants, améliorant ainsi les performances et la maintenabilité.
==== CRM-frontend :
- Interface utilisateur pour la gestion des communautés, des membres et des opérations de partage.
==== Remplacement de composants par des bibliothèques ou services tiers :
- *KrakenD* : API Gateway, utilisé pour exposer les différentes API de manière unifiée et sécurisée.
- *Keycloak* : service d'identité et de gestion des utilisateurs, utilisé pour l'authentification et l'autorisation.
- *MinIO* : service de stockage d'objets, utilisé pour stocker les fichiers liés aux communautés (ex. : logos).
- *Broker de messages* (NATS#footnote[Broker de messages open-source avec support JetStream pour la persistance et la relecture des messages. Alternative légère à RabbitMQ, privilégiée pour sa simplicité de déploiement et son intégration cloud-native.]) : utilisé pour la communication asynchrone entre les composants, notamment pour les tâches de génération de clés d'allocation.
==== Composants micro-services :
- *Notifications* : gère les notifications asynchrones (ex. : e-mails, alertes).
- *Simulation/Génération de clés* : responsable des tâches de simulation et de génération de clés, qui peuvent être plus lourdes ou nécessiter des langages spécifiques.
- *Template* : gère les modèles de documents ou d'e-mails, nécessitant une logique spécifique.



#figure(
  image("assets/proposition_architecturale.png"),
  caption: [Proposition de refactoring présente dans la documentation partagée],
)

== Refactoring architectural
=== Implémentation de la couche d'accès aux données
Afin de conserver une architecture solide et modulaire, nous avons adopté la structure suivante :
==== Mapping objet-relationnel
Une librairie ORM permet de :
- Définir des entités (comme Community) qui reflètent les tables de la base de données.
- Établir des relations entre les entités (ex. : une communauté peut avoir plusieurs utilisateurs, et chaque utilisateur peut appartenir à plusieurs communautés).
- Gérer les champs spécifiques (identifiants uniques, URLs, descriptions, etc.) et leurs contraintes (unicité, nullabilité, etc.).

Extrait de code disponible en @annex:community-entity
==== Services
Un ensemble de services est responsable des tâches suivantes :
- Récupérer les données depuis la base de données en fonction des requêtes (ex. : lister toutes les communautés publiques).
- Traiter les données avant de les retourner (ex. : générer des URLs temporaires pour les logos des communautés).
- Gérer les erreurs (ex. : journaliser les échecs de génération d'URL pour les logos).
- Paginer les résultats.
Exemple de service disponible en @annex:getAllPublicCommunities
=== DTO
Les objets de transfert de données (DTO) structurent les informations retournées au client. Voir un exemple en @annex:public-community-dto
==== Architecture complète
Cette approche permet une séparation claire des différentes couches, ce qui est essentiel pour le principe de séparation des responsabilités #cite(<Separati80:online>).

Nous retrouvons ainsi une arborescence de fichiers organisée de la manière suivante pour chaque module (voir @annex:file-architecture) :
- Couche API (Présentation)
  - *community.controller.ts* : gère les requêtes et réponses HTTP et délègue le traitement aux services.
  - *community.dtos.ts* : définit les DTO (Data Transfer Objects) pour la validation des requêtes et des réponses.
  - *community.routes.ts* : associe les URLs aux méthodes du contrôleur (Express.js).
  - *community.swagger.ts* : ajoute la documentation Swagger/OpenAPI pour les points d'accès.

- Couche Domaine (Logique métier)
  - *community.models.ts* : définit les modèles métier (ex. : `Community`, `CommunityUser`).
  - *i-community.repository.ts* : interface pour les opérations de base de données (ex. : `findAll`, `save`).
  - *i-community.services.ts* : interface pour la logique métier (ex. : `getAllPublicCommunities`).

- Couche Infrastructure (Implémentation)
  - *community.repository.ts* : implémente `ICommunityRepository` avec TypeORM.
  - *community.service.ts* : implémente `ICommunityService` avec la logique métier et les appels au dépôt (repository).

- Couche Partagée (Utilitaires)
  - *community.error.ts* : définit les erreurs personnalisées (ex. : `CommunityNotFoundError`).
  - *to_dto.ts* : convertit les modèles métier vers les DTO pour les réponses API.
  - *to_model.ts* : convertit les DTO vers les modèles métier pour la logique métier.
=== Fusion de services

La seconde partie de la refonte a concerné la fusion des composants users, community et opérations de partage dans le composant CRM. L'objectif a été de remplacer les nombreux appels REST entre ces composants par une gestion orientée objets de ces informations.

Cette fusion a nécessité une réorganisation significative du code :
- *Harmonisation des modèles de données* : les entités `User`, `Community` et `CommunityUser` ont été unifiées dans un seul contexte de domaine, avec des relations Many-to-Many gérées par l'ORM.
- Les schémas de base de données des trois composants ont été consolidés en une seule base PostgreSQL.
- *Refactorisation des contrôleurs API* : les endpoints REST des trois services ont été regroupés dans des contrôleurs unifiés, avec une gestion cohérente des erreurs et de la pagination.

=== Conclusion
Ce changement a permis une réduction significative du nombre d'appels synchrones REST entre les micro-services. La diminution de la complexité est notable et nous a permis d'itérer plus rapidement.

Ces modifications ont principalement été implémentées par Éric Paques. J'ai eu l'occasion de participer à la revue de code et à la validation des choix techniques, ainsi qu'à l'utilisation de ce nouveau modèle dans l'ajout de certaines fonctionnalités.
== Mise en open-source
=== Réorganisation du code en sous-dépôts
L'ancienne organisation des fichiers dans le code source était fonctionnelle mais complexe, avec de nombreux sous-dossiers. L'inconvénient principal était qu'un seul dépôt Git gérait l'entièreté du code source, ce qui augmentait fortement le nombre de fichiers à suivre.

En conséquence, même des opérations basiques comme les commits et les fetch devenaient progressivement plus lentes. La structure complète de l'ancien projet est disponible en @annex:old-directory-structure
Nous avons donc décidé de séparer chaque composant dans son propre dépôt Git. Cette approche présente plusieurs avantages majeurs pour un projet open-source :

- *Modularité et indépendance* : Chaque composant peut être développé, testé et déployé indépendamment, permettant aux contributeurs de se concentrer sur un seul module sans impacter les autres.
- *Gestion des versions granulaire* : Chaque dépôt possède son propre historique de versionnage, facilitant le suivi des modifications et les publications de versions individuelles.
- *Réutilisabilité* : Les composants peuvent être réutilisés dans d'autres projets sans dépendre de l'ensemble du monorepo.
- *Permissions et accès* : Il est possible de gérer finement les droits d'accès par dépôt, renforçant la sécurité et la gouvernance du projet.
- *Réduction de la complexité* : Un dépôt de petite taille est plus facile à comprendre, à cloner et à maintenir pour les nouveaux contributeurs.

=== Création d'une organisation
Nous avons créé une organisation GitHub dédiée au projet, permettant de centraliser la gestion des dépôts, des équipes et des permissions. Cette organisation facilite la collaboration entre les différents contributeurs et offre une meilleure visibilité pour le projet.

Sous le nom OptimCE (#link("https://github.com/OptimCE")), nous avons en effet rassemblé tous les dépôts liés au projet. Cette organisation nous permet de centraliser la gestion des secrets et des pipelines CI/CD, ainsi que de créer des équipes de contributeurs avec des rôles spécifiques (mainteneurs, contributeurs, etc.).
=== Choix de licence
Le choix de la licence est une étape cruciale pour tout projet open-source, car elle définit les droits et les obligations des utilisateurs et des contributeurs. Après une analyse approfondie des différentes options, nous avons opté pour la licence Apache 2.0.

Cette licence offre un bon équilibre entre la permissivité et la protection juridique, permettant une utilisation commerciale tout en protégeant les contributeurs contre les litiges liés aux brevets. De plus, elle est largement reconnue et utilisée dans la communauté open-source, ce qui facilite l'adoption et la contribution au projet.

Pour les outils développés par d'autres communautés et intégrés dans notre projet, nous avons veillé à ce qu'ils soient compatibles avec la licence Apache 2.0, afin d'assurer une cohérence juridique et de faciliter la réutilisation du code.
=== Création d'une politique de contribution
Le projet dispose désormais d'une politique de contribution concise. Les contributeurs peuvent proposer des modifications via des pull requests, qui sont ensuite examinées par les mainteneurs du projet. Nous encourageons les contributions de tous types, qu'il s'agisse de corrections de bugs, d'ajout de fonctionnalités ou d'améliorations de la documentation.
==== Hiérarchie des contributeurs
- *Mainteneurs* : responsables de la gestion globale du projet, de la validation des contributions et de la prise de décisions stratégiques.
- *Contributeurs internes* : personnes travaillant directement sur le projet au sein de l'organisation, avec des droits d'accès étendus pour faciliter le développement.
- *Contributeurs externes* : membres de la communauté qui proposent des contributions via des pull requests, avec des droits d'accès limités pour garantir la sécurité du projet.
- *Utilisateurs* : personnes qui utilisent le projet. Ils peuvent signaler des bugs ou suggérer des améliorations via les issues, mais n'ont pas de droits d'accès au code.
==== Linting et formatage
Pour garantir la qualité du code et faciliter les contributions, nous avons précisé que le code doit être formaté et linté selon les règles définies dans le README.md.
- Nous avons intégré des outils de linting et de formatage dans les pipelines CI/CD pour automatiser ce processus et assurer une cohérence dans le code soumis par les contributeurs.
- Nous avons également fourni des configurations de linting et de formatage dans les dépôts, ainsi que des scripts npm pour faciliter leur utilisation en local avant de soumettre une pull request.
- Nous encourageons l'utilisation de hooks Git (ex. : lint-staged) pour exécuter automatiquement les vérifications de linting et de formatage avant chaque commit, afin de réduire les erreurs et d'améliorer la qualité du code dès le début du processus de contribution.

Nous utilisons donc les linters/formatters suivants selon les différentes technologies utilisées :
- *TypeScript* : ESLint et Prettier
- *SQL* : SQLFluff
- *Python* : ruff
Des configurations encore plus spécifiques peuvent être définies selon les besoins de chaque composant.

Nous fournissons également un fichier agents.md pour aider les contributeurs à utiliser des agents d'IA (ex. : GitHub Copilot) pour compléter leurs relectures de code, en fournissant des conseils sur les meilleures pratiques et en suggérant des améliorations potentielles. Celui-ci contient les recommandations de linting et de formatage.

=== Environnements de développement unifiés (DevContainers)

Afin d'abaisser la barrière à l'entrée pour les nouveaux contributeurs et de garantir une reproductibilité parfaite des environnements de développement, nous avons intégré des configurations DevContainers au sein des différents dépôts de composants.

Un DevContainer (Development Container) permet de définir un environnement de développement complet (outils, extensions de l'IDE, versions spécifiques des langages comme Node.js ou Python, et dépendances système) directement sous forme de code, comme illustré dans l'@annex:devcontainer-config. Ainsi, un contributeur souhaitant travailler sur un composant spécifique peut lancer un environnement préconfiguré et isolé via Docker, sans avoir à installer manuellement les prérequis sur sa machine hôte. Notons également que le montage de volumes spécifiques permet d'assurer le bon fonctionnement des outils de contrôle de version (tels que Git) au sein d'un espace de travail modulaire, l'utilisation de sous-modules ajoutant en effet une certaine complexité opérationnelle à cet égard.

Cette standardisation élimine le classique syndrome du « ça marche sur ma machine » et assure que tous les développeurs, qu'ils utilisent Windows, macOS ou Linux, bénéficient exactement du même outillage, incluant d'office les configurations de linting et de formatage ainsi que les plugins recommandés mentionnés précédemment.

De plus, les DevContainers sont mis à jour automatiquement via les pipelines CI/CD, garantissant ainsi la synchronisation continue des environnements de développement avec les évolutions du projet et l'introduction de nouvelles dépendances.

Bien que cette fonctionnalité demeure optionnelle pour les contributeurs, son utilisation est vivement conseillée. Elle s'avère particulièrement précieuse pour les nouveaux arrivants ou les développeurs moins familiers avec la configuration manuelle d'environnements.
=== CI/CD
Chaque dépôt est configuré avec des pipelines CI/CD sur GitHub Actions, ce qui permet d'automatiser les processus de tests, de construction (build) et de déploiement. Ces pipelines sont conçus pour garantir la qualité continue du code et faciliter la contribution.

==== Principes de fonctionnement des pipelines
Un workflow GitHub Actions est défini au sein d'un fichier YAML placé dans le répertoire `.github/workflows/` de chaque dépôt. Ces flux d'automatisation sont déclenchés par des événements spécifiques (par exemple, un `push` ou une `pull request`) et se décomposent en une série d'étapes (*jobs*) exécutées de manière séquentielle ou parallèle sur des *runners*.

Un *runner* est une machine virtuelle ou un conteneur chargé d'exécuter les étapes du workflow. GitHub propose des environnements hébergés dans le cloud (Ubuntu, Windows, macOS). Les étapes peuvent inclure l'appel à des actions prédéfinies (par exemple, `actions/setup-node` pour configurer l'environnement Node.js) ou l'exécution de scripts personnalisés. L'ensemble des résultats est ensuite restitué dans l'interface de GitHub, assorti de journaux d'exécution détaillés (*logs*) indispensables au débogage en cas d'échec.

Par ailleurs, certaines fonctionnalités avancées possèdent leurs propres fichiers de configuration directement situés à la racine du répertoire `.github/`. C'est le cas des outils d'analyse de sécurité (tels que CodeQL) ou de gestion automatisée des dépendances (comme Dependabot), qui sont nativement interprétés par GitHub pour enclencher les processus de vérification correspondants.
==== Exemple de pipeline CI/CD
On peut voir ci-dessous un exemple de l'arborescence des fichiers d'un dépôt (voir @annex:cicd-file-tree), avec les différents workflows CI/CD configurés pour les tests, la publication Docker, la notification de mise à jour du monorepo et la mise à jour de la documentation.
Nous allons revenir sur chacun de ces workflows dans les sections suivantes.

#figure(
  image("assets/cicd-pipeline-mermaid.png", width: 100%),
  caption: [Vue d'ensemble des pipelines CI/CD GitHub Actions du projet OptimCE @annex:cicd-pipeline],
)

==== Test
Le workflow *test.yml* est déclenché à chaque pull request et push sur la branche principale. Il installe Node.js 22, les dépendances via `npm ci`, et exécute l'ensemble des tests unitaires et d'intégration (`npm run test-all`). Le contenu complet est disponible en @annex:test-workflow

==== Sécurité
Plusieurs mécanismes assurent la sécurité du projet :

- *CodeQL* : Le workflow *codeql.yml* scanne le code à la recherche de vulnérabilités connues et de mauvaises pratiques à chaque contribution. Les résultats sont disponibles dans l'onglet « Security » du dépôt, avec un niveau de sévérité et des recommandations de correction.
#figure(
  image("assets/security_reporting.png"),
  caption: [Exemple de rapport de sécurité],
)
#figure(
  image("assets/security_workflow_permissions.png"),
  caption: [Permissions et workflow de sécurité],
)

- *Dependabot* : Le fichier *dependabot.yml* configure la surveillance automatique des dépendances (npm, Docker, GitHub Actions, DevContainers). Des pull requests sont créées automatiquement pour les mises à jour de sécurité, avec une vérification hebdomadaire. La configuration complète est disponible en @annex:dependabot-config
#figure(
  image("assets/dependabot.png"),
  caption: [Exemple de Pull Request générée par Dependabot],
)

==== Docker build and publish
Le workflow *docker-publish.yml* construit et publie les images Docker sur GitHub Container Registry à chaque push sur la branche principale. Il utilise Docker Buildx pour la construction multi-plateforme et Cosign pour la signature des images (détails de signature dans la section Résultats). La publication n'est effective que pour les pushes directs (non pull requests), mais les tests de construction sont exécutés pour toutes les contributions. Le contenu complet est disponible en @annex:docker-build-publish

==== Update documentation
Le workflow *update-documentation.yml* génère et déploie la documentation OpenAPI sur GitHub Pages à chaque push sur la branche principale (en excluant les modifications du dossier `docs/` pour éviter les boucles). La génération utilise les commandes npm Swagger (voir @annex:swagger-npm-commands) produisant les formats YAML, Markdown et HTML. Le contenu du workflow est disponible en @annex:update-docs-workflow
== Développement d'un monorepo de staging
Pouvoir travailler sur chaque composant de manière indépendante constitue un avantage majeur pour la modularité et la maintenabilité du projet. Cela peut toutefois introduire des défis en termes de synchronisation et de coordination entre les différents composants. C'est pourquoi nous avons développé un monorepo de staging, qui sert de point central pour intégrer et tester les différentes parties du projet avant de les publier dans leurs dépôts respectifs.
=== Git submodules
Nous avons utilisé la fonctionnalité de Git submodules#footnote[Fonctionnalité Git permettant d'inclure d'autres dépôts comme sous-répertoires, chacun conservant son historique et ses branches propres. Utile pour les monorepos.] pour intégrer les différents dépôts de composants dans le monorepo de staging. Chaque composant est ajouté en tant que sous-module, ce qui permet de maintenir une séparation claire entre les différents projets tout en facilitant la synchronisation et l'intégration. La configuration des submodules est disponible en @annex:gitmodules-config
Dans la syntaxe du fichier de configuration, on peut constater l'un des avantages de l'organisation GitHub : la possibilité d'utiliser des chemins relatifs pour les URL des submodules, ce qui facilite la gestion et la synchronisation des différents composants du projet.

Cela permet aussi de télécharger l'ensemble du projet avec une seule commande `git clone --recurse-submodules`, ce qui est particulièrement utile pour les nouveaux contributeurs qui souhaitent se lancer dans le développement sans avoir à cloner chaque dépôt individuellement.

Les différents IDE permettent aussi de gérer les versions de submodules de manière relativement simple, avec des interfaces graphiques pour synchroniser les submodules, vérifier les changements, etc.

Nous avons principalement utilisé Visual Studio Code pour gérer les submodules.
#figure(
  image("assets/vscode_submodules.png", height: 8cm),
  caption: [Gestion des submodules dans Visual Studio Code],
)
Cette capture d'écran présente l'interface de Visual Studio Code pour la gestion des submodules. Elle permet de visualiser les changements dans chaque submodule, de les synchroniser avec leurs dépôts respectifs, et de gérer les différentes branches et commits pour chaque composant du projet.

La possibilité d'isoler et de tester chaque branche de manière indépendante pour les divers composants s'avère particulièrement utile lors du développement et des tests, car elle permet de travailler sur des fonctionnalités spécifiques sans impacter les autres sous-projets.

=== Synchronisation automatique submodule vers monorepo
Afin de faciliter la synchronisation entre les dépôts de composants et le monorepo de staging, nous avons mis en place un workflow GitHub Actions se déclenchant à chaque push sur les branches principales des dépôts de composants. Ce workflow utilise des scripts pour mettre à jour automatiquement les submodules dans le monorepo de staging, garantissant ainsi que celui-ci intègre toujours les dernières modifications apportées aux différents composants.

Il est composé de deux éléments principaux :
- Un workflow dans chaque dépôt de composant, déclenché à chaque push sur la branche principale, qui envoie un événement de type `repository_dispatch`#footnote[Événement GitHub permettant de déclencher un workflow dans un autre dépôt via l'API, avec des données personnalisées. Utile pour la synchronisation entre dépôts.] au dépôt du monorepo. Voir le workflow en @annex:notify-monorepo-workflow
Ce workflow est déclenché par les pushes vers la branche `main` de chaque dépôt de composant. Il utilise la commande `curl` pour envoyer une requête POST à l'API GitHub, déclenchant ainsi un événement de type `repository_dispatch` dans le dépôt du monorepo. Le payload de l'événement contient des informations sur le dépôt qui a été mis à jour, ce qui permet au monorepo d'identifier le submodule à synchroniser. Voir le workflow de mise à jour en @annex:update-submodules-workflow
Ce workflow est déclenché par l'événement `repository_dispatch` envoyé par les workflows des dépôts de composants. Il met à jour le submodule correspondant au dépôt qui a été modifié, puis commit et push les changements dans la branche principale du monorepo. Si aucun changement n'est détecté (par exemple, si le submodule est déjà à jour), le workflow s'arrête sans faire de commit.

Le token MONOREPO_TOKEN est généré sur demande par les mainteneurs du projet, et est stocké en tant que secret dans les paramètres de l'organisation, ce qui garantit sa sécurité tout en permettant une utilisation facile dans les workflows GitHub Actions.
==== Docker Compose de développement
Pour faciliter le développement et les tests d'intégration, nous utilisons un fichier docker-compose dans le monorepo de staging qui permet de lancer l'ensemble de l'infrastructure du projet en local. Ce docker-compose intègre tous les composants du projet, ainsi que les services nécessaires pour leur fonctionnement.

Voici les principaux services définis dans le fichier docker-compose.dev.yml (voir @annex:docker-compose-dev), regroupés par catégorie :

- *Bases de données* : `crm-database` (PostgreSQL du CRM), `keycloak-db` (PostgreSQL dédiée à Keycloak), `allocation-key-db` (PostgreSQL pour la génération de clés).
- *Services métier* : `crm-backend` (application principale), `allocation-key-generation` (service Python/FastAPI pour les clés de répartition), `allocation-key-generation-worker` (worker asynchrone via NATS JetStream).
- *Authentification* : `keycloak` (serveur d'identité, expose l'interface d'administration sur `8082:8080`), `keycloak-config` (génération de configuration du realm).
- *Stockage et messagerie* : `minio` (stockage compatible S3, ports `8091:9000` et `8092:9001`), `minio-init` (initialisation du bucket), `nats` (broker de messages avec JetStream, ports `8094:4222` et `8095:8222`).
- *API Gateway et proxy* : `krakend` (passerelle API), `krakend-config` (génération de configuration depuis OpenAPI), `reverse-proxy` (Nginx, point d'entrée navigateur).
- *Frontend* : `crm-frontend` (interface utilisateur Angular), `crm-frontend-config` (génération de configuration).
- *Observabilité* : `jaeger` (traçage distribué), `swagger-doc-gen` et `generation-doc-gen` (génération de documentation OpenAPI).
- *Configuration* : `nginx-config` (adaptation du reverse proxy HTTP/HTTPS).

#figure(
  image("assets/docker-compose-dev-mermaid.png"),
  caption: [Diagramme : docker-compose de développement @annex:docker-compose-dev-architecture],
)


Dans `docker-compose`, l'intégration repose surtout sur trois mécanismes : les profils (`dev` et `init`) pour séparer les services permanents des services d'initialisation, les dépendances `depends_on` pour ordonner le démarrage, et les réseaux Docker pour isoler les communications internes entre le backend, le proxy et les services exposés.

Le mapping des ports permet de rendre accessible chaque service à l'extérieur du réseau Docker, ce qui est essentiel pour le développement. Les développeurs ont aussi accès à une liste des ports utilisés par chaque service dans la documentation du projet, afin de faciliter les tests et le débogage en local.

Il est à noter que dans ce docker-compose, il y a beaucoup de *services de configuration*. Nous reviendrons sur ceux-ci plus tard dans la section dédiée à l'automatisation du déploiement, mais ils sont déjà utilisés dans le docker-compose de développement pour préparer les fichiers de configuration nécessaires au bon fonctionnement de l'infrastructure en local.

==== Test de staging
Le monorepo de staging est utilisé pour intégrer et tester les différentes parties du projet avant de les publier dans leurs dépôts respectifs. En raison de leur temps d'exécution potentiellement très long, nous n'avons pas intégré de pipelines de tests d'intégration automatisés directement sur GitHub.

Néanmoins, nous avons conçu un script nommé `docker-stack.sh` permettant de déployer l'intégralité des composants du projet en environnement local via un fichier Docker Compose. Le docker-compose intégrant des health checks pour chaque service, nous pouvons facilement vérifier que tous les composants fonctionnent correctement ensemble avant de publier les changements dans les dépôts respectifs.

Ce script permet également de réaliser des tests manuels d'intégration, ce qui est particulièrement utile pour les nouvelles fonctionnalités ou les changements majeurs pouvant avoir des impacts importants sur l'ensemble du projet.

Un test complet de staging avec injection de données mockées peut en effet prendre plusieurs dizaines de minutes, car il reconstruit chaque image Docker, puis lance l'ensemble de l'infrastructure.

L'utilisation des submodules prend tout son sens dans ce contexte, car elle nous permet de tester les différentes branches de chaque composant indépendamment, sans avoir à cloner chaque dépôt individuellement ou à gérer manuellement les différentes versions des composants et à les construire en une seule commande.

Le code source du script est disponible dans le dépôt du monorepo, et est conçu pour être facilement modifiable en fonction des besoins spécifiques de chaque composant ou de l'infrastructure utilisée pour les tests. #cite(<monorepo72:online>)
==== Automatisation du déploiement

L'automatisation du déploiement est une étape cruciale pour garantir la rapidité et la fiabilité des mises à jour du projet. Nous avons développé une série de services dédiés à la génération automatique des fichiers de configuration, qui s'intègrent directement dans le docker-compose de développement et de production :

- *swagger-doc-gen* : ce service génère la documentation OpenAPI à partir du backend CRM. Les fichiers produits sont utilisés par le service suivant.
- *krakend-config* : ce service génère la configuration de l'API Gateway KrakenD à partir des spécifications OpenAPI produites par le service précédent. Cela permet de maintenir la configuration de l'API Gateway à jour avec les dernières modifications du backend, sans nécessiter d'intervention manuelle.
- *Configuration par templates* : plusieurs services sont dédiés à la génération de fichiers de configuration à partir de modèles et de variables d'environnement :
  - *keycloak-config* : produit le fichier de configuration du realm Keycloak (ceci est un fichier de configuration contenant les paramètres de configuration de l'instance).
  - *nginx-config* : adapte le reverse proxy selon que l'environnement utilise HTTP ou HTTPS.
  - *crm-frontend-config* : prépare les paramètres consommés par l'application web avant son lancement.

Chacun de ces services prend en entrée un template de configuration et les variables d'environnement nécessaires, et produit un fichier de configuration prêt à être utilisé par le service correspondant.
== Développement d'une version Production
Comme vu dans la section précédente, nous avons développé un script de déploiement qui permet de lancer l'ensemble de l'infrastructure du projet en local à l'aide d'un docker compose, ainsi qu'une série de scripts de configuration qui génèrent automatiquement les fichiers de configuration nécessaires.

Différence entre la version de développement et la version de production :
- Retrait des montages de ports pour les services qui ne sont pas censés être exposés à l'extérieur du réseau Docker, afin de renforcer la sécurité et d'éviter les accès non autorisés.
- Utilisation d'images Docker pré-construites et publiées sur un registre d'images, plutôt que de construire les images localement à partir du code source.
- Ajout de la persistance des données pour les services qui en ont besoin, afin de garantir que les données ne sont pas perdues lors du redémarrage des conteneurs.
- Politique de communication plus restrictive entre les services, en limitant les connexions aux seuls services nécessaires pour chaque composant, afin de réduire la surface d'attaque et d'améliorer la sécurité de l'infrastructure.
- Ajout de mécanismes de backup des bases de données, pour garantir la résilience et la récupération en cas de défaillance.
- Activation du mode production pour Keycloak (`start` au lieu de `start-dev`) avec health checks et métriques activés.
- Ajout d'un service de migration de base de données (`optimce-migrator`) pour gérer les évolutions du schéma CRM en production.
- Intégration de Certbot pour la gestion automatique des certificats SSL/TLS.
- Téléchargement automatique des plugins Keycloak (kc-groupid-mapper) et du thème OptimCE lors de l'initialisation.
=== Registre d'images de conteneurs

Nous avons choisi d'utiliser GitHub Container Registry pour héberger les images Docker de notre projet. Cette solution offre une intégration transparente avec GitHub Actions, ce qui facilite la construction et la publication des images à partir de nos pipelines CI/CD.

La lecture du registre est publique pour permettre à quiconque de déployer le projet sans configuration d'authentification supplémentaire, tandis que l'écriture est strictement restreinte aux workflows CI/CD authentifiés.

Cela permet un déploiement plus rapide car nous contrôlons entièrement le processus de build et de publication, et nous pouvons facilement mettre à jour les images en fonction des changements dans le code source.

De plus, GitHub Container Registry offre des fonctionnalités de sécurité avancées, telles que la signature d'images avec Cosign, ce qui renforce la confiance dans les images utilisées pour le déploiement.

Cette modification était par ailleurs nécessaire pour les déploiements Kubernetes.
=== Docker Compose

La version de production est elle aussi faite en docker-compose (voir @annex:docker-compose-prod).

Un aspect notable de cette configuration est que l'ensemble du déploiement se pilote via un unique fichier `.env`. En complétant une dizaine de champs (identifiants, URLs, ports, secrets), l'utilisateur obtient une infrastructure entièrement fonctionnelle : du reverse proxy à la télémétrie, en passant par l'authentification Keycloak, le stockage MinIO et l'API Gateway KrakenD. Cette simplicité de configuration réduit considérablement la barrière à l'entrée pour les utilisateurs finaux souhaitant auto-héberger le projet.

Cependant, nous pouvons aisément faire des traductions du docker compose vers d'autres orchestrateurs de conteneurs, notamment :
- Docker Swarm#footnote[Orchestrateur de conteneurs natif Docker. Plus simple que Kubernetes mais moins flexible. Gère scaling, failover et load-balancing.] : 
Docker Swarm est très proche de docker compose, et la plupart des fonctionnalités utilisées dans notre docker-compose sont compatibles avec Docker Swarm. Cela nous permet de déployer notre infrastructure sur un cluster Docker Swarm sans nécessiter de modifications majeures, en utilisant simplement le même fichier docker-compose avec quelques ajustements mineurs pour les spécificités de Swarm (ex. : utilisation de secrets, configuration des services en mode swarm, etc.).
- Kubernetes :
En utilisant l'outil fourni par docker : *Docker Compose Bridge* #cite(<Usethede7:online>), qui permet de convertir un fichier docker-compose en une configuration compatible avec d'autres orchestrateurs de conteneurs. Cela nous offre une grande flexibilité pour déployer notre infrastructure sur différentes plateformes, en fonction des besoins spécifiques de chaque environnement (développement, staging, production).

La version de production introduit plusieurs services absents du développement :
- *optimce-migrator* : service de migration de base de données exécuté une seule fois pour appliquer les évolutions du schéma CRM. Il utilise un outil de migration Python (alembic) pour garantir la cohérence entre les versions du code et de la base de données.
- *keycloak-healthcheck* : sidecar dédié à la vérification de l'état de Keycloak via son endpoint `/health/ready`. Ce service permet de retarder le démarrage du backend CRM jusqu'à ce que Keycloak soit pleinement opérationnel.
- *certbot* : service de gestion automatique des certificats SSL/TLS via le protocole ACME de Let's Encrypt. Il utilise la méthode webroot pour valider le domaine sans interrompre le service.
- *keycloak-group-id-mapper* et *keycloak-optimce-theme* : services d'initialisation qui téléchargent respectivement le plugin de mapping de groupes Keycloak et le thème visuel OptimCE, garantissant que les artefacts sont disponibles avant le démarrage de Keycloak.
- *crm-database-backup* et *keycloak-db-backup* : services de backup exécutés sur demande (profil `backup`) qui exportent les bases de données via `pg_dump` dans un répertoire persistant.
=== Déploiement réel

La version actuellement déployée est basée sur Docker Compose et hébergée sur un VPS#footnote[Virtual Private Server — serveur virtuel isolé au sein d'un serveur physique partagé.] chez Hostinger. Nous avons retenu cette solution pour trois raisons principales :
- *La souveraineté des données* : l'hébergement en Europe garantit le respect du RGPD.
- Le coût réduit, adapté au budget d'un projet de recherche.
- La simplicité de l'interface de gestion, qui reflète le niveau de compétence technique attendu d'un utilisateur final auto-hébergeant le projet. Cette similarité nous permet d'évaluer de manière réaliste les défis de déploiement rencontrés par les utilisateurs finaux.
==== Pourquoi ne pas faire un déploiement sur cluster Kubernetes ?

Nous estimons que les communautés d'énergies renouvelables sont par nature décentralisées, et que les utilisateurs finaux ne sont pas nécessairement intéressés par des technologies d'orchestration complexes, mais plutôt par des solutions simples et accessibles répondant à leurs besoins spécifiques.

Le tableau ci-dessous compare les besoins réels du projet OptimCE avec ce que Kubernetes offre :

#table(
  columns: (auto, auto, auto),
  inset: 0.5em,
  stroke: none,
  [*Critère*], [*Kubernetes*], [*Docker Compose*],
  [Échelle cible], [Centaines/milliers de nœuds], [1 serveur unique],
  [Nombre de conteneurs], [Des centaines à milliers], [~15 conteneurs],
  [Équipe ops requise], [Équipe dédiée (SRE/DevOps)], [Aucune (auto-hébergé)],
  [Auto-scaling], [Nécessite une charge variable], [Charge stable et prévisible],
  [Haute disponibilité], [Multi-nœuds, tolérance aux pannes], [Single-node, backups manuels],
  [Coût infrastructure], [Minimum 3 nœuds maître + workers], [1 VPS suffit],
  [Courbe d'apprentissage], [Semaines à mois], [Heures à jours],
  [Temps de mise en prod], [Jours (cluster + config)], [Minutes (docker compose up)],
  [Adéquation au contexte], [Surdimensionné], [Adapté],
)
_Tableau comparatif : Kubernetes vs Docker Compose à l'échelle d'OptimCE._

Kubernetes est conçu pour résoudre des problèmes que nous n'avons pas : le scaling horizontal massif, la résilience multi-nœuds et le déploiement continu à haute fréquence. Pour un projet de ~15 conteneurs déployé sur un serveur unique avec une équipe réduite, Kubernetes introduirait une complexité disproportionnée par rapport aux bénéfices obtenus.

Afin de vérifier cette hypothèse, nous avons mené des expérimentations avec trois distributions Kubernetes légères :
- *k3s*#footnote[Distribution Kubernetes légère (< 100 Mo) conçue pour l'IoT, le edge computing et les environnements à ressources limitées.] : bien que plus léger que Kubernetes standard, k3s nécessite tout de même un serveur avec au moins 2 Go de RAM dédiés au plan de contrôle, ce qui représente une part significative des ressources de notre VPS. De plus, la gestion des manifests et des Helm charts ajoute une couche de complexité non justifiée pour notre nombre de services.
- *Minikube*#footnote[Outil permettant d'exécuter un cluster Kubernetes à nœud unique en local, principalement destiné au développement et aux tests.] : conçu pour le développement local, Minikube n'est pas adapté à un déploiement de production. Son modèle de gestion (VM ou conteneur unique) et son absence de mécanismes de persistance robustes en font un outil de test plutôt qu'une solution de production viable.
- *Kind*#footnote[Outil permettant d'exécuter des clusters Kubernetes dans des conteneurs Docker, principalement utilisé pour les tests CI/CD et le développement.] : similaire à Minikube, Kind est orienté développement et CI/CD. Bien qu'il permette de créer rapidement des clusters éphémères, il n'offre pas les garanties de stabilité et de persistance nécessaires pour un déploiement de production.

Ces expérimentations ont confirmé que même les distributions Kubernetes les plus légères introduisent une surcharge opérationnelle (gestion des manifests, des ConfigMaps, des Secrets, des Ingress, des PersistentVolumeClaims) disproportionnée par rapport aux besoins réels du projet.

Nous avons cependant conservé la compatibilité avec un orchestrateur plus avancé. Si la demande émerge, par exemple pour une offre SaaS, la migration vers Kubernetes est prévue via l'outil Docker Compose Bridge.
=== Conclusions
Cette partie de la transition a été principalement faite par mes soins, avec une collaboration étroite avec Eric. Donc un vrai travail d'équipe, avec des échanges réguliers pour valider les choix d'architecture, les configurations de CI/CD, et les stratégies de déploiement.
== Contributions connexes

En plus du travail principal sur l'architecture et l'infrastructure d'OptimCE, plusieurs tâches et contributions connexes ont été accomplies de manière autonome :
=== Analyse de l'intégration de Keycloak et gestion de l'authentification

L'authentification et l'autorisation du projet reposent sur Keycloak, un serveur open-source d'identité et d'accès. Son intégration a nécessité des décisions architecturales autour des standards OAuth 2.0 et OpenID Connect (OIDC).

==== OAuth 2.0 et OpenID Connect

OAuth 2.0 est un standard d'autorisation qui définit les mécanismes de partage d'informations et d'interaction entre services. Il ne gère pas directement l'authentification, mais permet à une application d'obtenir un accès limité à un compte utilisateur auprès d'un service.

OIDC complète OAuth 2.0 en ajoutant une couche d'authentification standardisée. Il impose l'ajout d'un troisième jeton, l'`id_token`, contenant les informations d'identité de l'utilisateur. L'avantage principal d'OIDC est l'interopérabilité : grâce à la standardisation des claims#footnote[Revendications standardisées dans le payload du JWT], il est possible de changer de fournisseur d'identité sans modifier l'application cliente.

==== Mécanismes de vérification des jetons

Notre architecture supporte deux approches pour la vérification des jetons d'accès :

- *Jetons auto-contenus (JWT)*#footnote[JSON Web Token — format de jeton d'accès compact et auto-contenu, utilisé pour l'authentification.] : Le jeton contient toutes les informations nécessaires (scopes, permissions, identité). Il est signé par le serveur d'autorisation et peut être vérifié localement par les microservices grâce à la clé publique, sans appel réseau supplémentaire. Seul le refresh token nécessite une vérification auprès du serveur OAuth pour contrôler d'éventuelles révocations.
- *Jetons opaques* : Le jeton ne contient aucune information lisible. Le backend doit interroger le serveur d'autorisation via une route d'introspection pour vérifier sa validité à chaque requête.

L'approche JWT auto-contenu a été privilégiée pour sa performance, car elle évite un appel réseau synchrone à chaque requête authentifiée.

==== Claims personnalisés et gestion des groupes

Le projet nécessite la transmission d'un identifiant de communauté (`group_id`) via le JWT, ce qui dépasse le scope standard d'OIDC. Plusieurs approches ont été évaluées :

- *Claims personnalisés dans le JWT* : Ajouter directement le `group_id` dans le payload du jeton via un mapper Keycloak. Cette approche est simple à maintenir et supportée nativement par la majorité des clients OIDC. Cependant, elle produit des jetons plus volumineux, ce qui peut poser problème si un utilisateur appartient à un grand nombre de groupes (risque de dépassement des limites d'en-têtes HTTP).
- *Middleware de groupes* : Ajouter un intermédiaire qui enrichit les requêtes authentifiées avec les informations de groupes. Cette approche n'apportait pas de bénéfice significatif dans notre architecture.
- *Gestion backend* : Chaque microservice gère indépendamment les permissions communautaires. Cette solution ajouterait de la complexité à chaque service sans réel avantage.

L'approche des claims personnalisés via un plugin Keycloak (`kc-groupid-mapper`), téléchargé automatiquement lors de l'initialisation du conteneur, a finalement été retenue.

==== Flux d'authentification

Le flux d'authentification avec Keycloak suit le protocole OIDC standard :

#table(
  columns: (auto, auto, auto),
  inset: 0.5em,
  stroke: none,
  [*Étape*], [*Action*], [*Responsabilité*],
  [1. Déclenchement], [L'utilisateur clique sur "Connexion"], [Application cliente (OIDC Client)],
  [2. Redirection], [L'application redirige vers le portail Keycloak], [Keycloak (Portail)],
  [3. Vérification], [L'utilisateur saisit ses identifiants], [Keycloak (IdP)],
  [4. Réponse], [Keycloak renvoie un code ou un token], [Keycloak (Protocole OIDC)],
  [5. Accès], [L'application lit le JWT et autorise l'accès], [Application cliente],
)
_Flux d'authentification OIDC avec Keycloak._

==== Approche d'intégration : Thèmes personnalisés vs Interface custom

Deux approches principales ont été considérées pour l'intégration de Keycloak :

#table(
  columns: (auto, auto, auto),
  inset: 0.5em,
  stroke: none,
  [*Critère*], [*Thèmes Keycloak (Redirection)*], [*Interface custom (REST/ROPC)*],
  [Sécurité], [Maximale. Keycloak gère les cookies de session et CSRF.], [Moyenne. Gestion manuelle des tokens et de la sécurité.],
  [Expérience utilisateur], [Légère redirection visible.], [Intégration transparente.],
  [Complexité], [Apprentissage du templating `.ftl` de Keycloak.], [Développement boilerplate d'appels API.],
  [Connexions sociales], [Native (Google, Apple, etc.).], [Complexe sans redirections.],
)
_Comparaison des approches d'intégration Keycloak._

L'approche par thèmes personnalisés a été retenue, offrant le meilleur équilibre entre sécurité, maintenabilité et expérience utilisateur. Toutes les fonctionnalités de l'interface sont disponibles via l'API REST de Keycloak, mais l'approche par redirection reste plus robuste pour la gestion des sessions et la sécurité.
==== Unification de thèmes Frontend et Keycloak
Les thèmes Keycloak ont été unifiés avec celui du frontend afin d'offrir une identité visuelle cohérente à l'ensemble du projet. L'outil Keycloakify a été utilisé pour réaliser ce travail.

Car de base Keycloak utilise le moteur de templating FreeMarker, qui est relativement basique et nécessite de réécrire l'ensemble des pages d'authentification (login, registration, account management, etc.) pour appliquer une personnalisation visuelle. Keycloakify permet de générer automatiquement les templates FreeMarker à partir d'un projet React, ce qui facilite grandement la maintenance du thème personnalisé. Et ce rapproche plus des pratiques du reste du projet, qui est lui aussi en React (Angular pour le frontend, mais la logique de composants et de styles est similaire).
==== Intégration de la configuration de Keycloak dans le docker-compose
Une configuration de développement de Keycloak, comprenant un realm, des clients, des rôles et des utilisateurs de test, a été exportée dans un fichier JSON. 

Suite à un nettoyage approfondi visant à retirer les données sensibles et les paramètres propres à l'environnement de développement, ce fichier a été conçu pour être générique. Il est ainsi facilement adaptable aux besoins spécifiques de chaque environnement (développement, staging, production).

Ce fichier est ensuite utilisé par le service `keycloak-config` pour initialiser Keycloak à chaque démarrage de l'infrastructure.

Cette approche permet de fournir une configuration prête à l'emploi dès le lancement de l'infrastructure. Elle s'avère particulièrement pertinente pour les nouveaux contributeurs ou les utilisateurs finaux, qui peuvent ainsi déployer le projet sans avoir à configurer Keycloak manuellement.
=== Outils pipeline docker

Certains services ont nécessité le développement de petits outils pour préparer leurs fichiers, ou l'utilisation de sidecars.

- *Swagger2Krakend* : outil développé pour automatiser la génération des configurations de l'API Gateway KrakenD à partir de spécifications OpenAPI. Intégré au monorepo, ce projet open-source est utilisé dans les pipelines de développement et de production pour maintenir ces configurations à jour. Développé en Python, il permet de spécifier, via un fichier de configuration YAML, les différentes règles à appliquer aux spécifications des API définies au format OpenAPI. Un exemple de ces règles est disponible en @annex:swagger-to-krakend-config. Par exemple, il est possible de sécuriser une API en imposant la vérification du JWT pour toutes les connexions entrantes sur un endpoint donné, ou encore d'appliquer du rate-limiting. Si cet outil a été initialement conçu dans un souci de gain de temps, il a grandement facilité l'évolution et la sécurisation rapide de l'infrastructure.

- *Génération de fichiers de configuration à partir de templates* : Kubernetes dispose d'une solution native pour ce problème (ConfigMap), mais celle-ci n'existe pas dans l'écosystème Docker. Des fichiers templates ont par conséquent été créés pour chaque configuration à modifier automatiquement. L'utilitaire Unix `envsubst` (fourni par le paquet `gettext`) a été utilisé pour remplacer les variables d'environnement par leurs valeurs actuelles et produire le fichier de configuration final. Ce fichier est ensuite monté dans le conteneur correspondant. Une image OCI minimale contenant cet utilitaire a de plus été assemblée (voir @annex:envsubstub-dockerfile).
#figure(
  image("assets/config-generation-flow-mermaid.png", height: 8cm),
  caption: [Exemple de template de configuration avec `envsubst` @annex:general-config-generation-logic],
)
- *Vérification des healthchecks* : Docker Compose propose une fonctionnalité de healthcheck, mais elle repose sur l'exécution de scripts à l'intérieur du conteneur cible. Des sidecars dédiés ont été mis en place pour vérifier l'état des services en utilisant un conteneur minimal ne contenant que `curl`.
=== Ajout de fonctionnalités

Plusieurs fonctionnalités et corrections de bugs ont également été implémentées de façon autonome :
- Ajout de routes de healthcheck pour les services qui n'en disposaient pas, notamment le backend CRM.
- Création de l'annuaire de communautés d'énergie, incluant la modification de l'interface Angular et l'ajout de la logique backend pour gérer les accès à la base de données.


=== Projet EMS Global

Une participation active aux décisions d'architecture du projet EMS Global a eu lieu, englobant notamment les choix technologiques, la logique d'authentification et d'autorisation, ainsi que l'intégration avec le reste du projet.

=== EcoArbiter

L'outil EcoArbiter a été entièrement développé pour servir d'alternative au projet de redistribution énergétique en temps réel proposé par les étudiants en fin d'études de l'ULiège. Il s'agit d'un projet écrit en Rust qui implémente une logique de distribution équitable de l'énergie entre différents EMS locaux, dans l'objectif de maximiser l'autoconsommation collective.

Ce projet a été développé car l'algorithme initial présentait plusieurs limitations : une latence élevée, l'absence de prise en compte des notions de parité entre utilisateurs, et un code source non public (extrait disponible dans le mémoire sur la plateforme Mathéo). EcoArbiter est publié en open-source sous licence Apache 2.0 et conçu pour être facilement intégrable au reste du projet.

==== Algorithme de distribution

L'algorithme est conçu pour privilégier une latence faible plutôt qu'une réponse systématiquement exacte, ce qui est essentiel pour une logique de distribution mise à jour à haute fréquence. La complexité de la fonction `recalculate_allowances` est en O(n log n) dans le pire des cas, dominée par le tri des indices déficitaires. Cette complexité permet de traiter des centaines d'entités en quelques millisecondes.

#figure(
  image("assets/emsg-logic.png", height: 15cm),
  caption: [Workflow de l'algorithme de distribution d'EcoArbiter],
)

L'algorithme distingue trois scénarios :
- *Déficit* (scénario 1) : la production totale est inférieure à la consommation. Aucune allowance n'est distribuée.
- *Excédent* (scénario 2) : la production excède la consommation totale, y compris la consommation élastique. Chaque consommateur reçoit sa consommation élastique maximale.
- *Insuffisant* (scénario 3) : la production couvre partiellement la consommation élastique. L'algorithme répartit équitablement le surplus via une approche itérative garantissant une distribution mathématiquement correcte.

==== Algorithme de Simulation simpliste
Un algorithme de simulation a été développé pour tester la logique d'EcoArbiter dans des scénarios réalistes. Il génère des profils de consommation et de production aléatoires pour un ensemble d'entités, puis applique l'algorithme de distribution à chaque intervalle de temps. Le tout avec une visualisation des données via une interface graphique simple pour observer les résultats.

= Résultats et analyse

== Métriques de performance

=== Consommation mémoire

La métrique la plus tangible de l'amélioration est la réduction de la consommation mémoire à vide. L'architecture initiale, avec ses nombreux micro-services redondants et ses services backend-db intermédiaires, nécessitait environ 3 Go de RAM pour un environnement de développement complet. Après refactoring, cette consommation est descendue à environ 800 Mo, soit une réduction de 73 %.

Cette diminution s'explique principalement par :
- La suppression des services backend-db (économie d'un conteneur PostgreSQL et d'un processus Node.js par service fusionné)
- La réduction du nombre de processus Node.js en exécution simultanée
- L'élimination des appels REST synchrones internes, réduisant la surcharge réseau et la mémoire tampon

=== Réduction des appels synchrones

L'architecture initiale nécessitait en moyenne 5 à 7 appels REST synchrones pour traiter une requête utilisateur complète (par exemple, créer un membre dans une communauté). Après refactoring, ce nombre est réduit à 1 à 2 appels, car les données sont désormais gérées au sein d'un même service via des appels de méthode directs.

Cette réduction a un impact direct sur :
- La latence perçue par l'utilisateur (moins de sauts réseau)
- La résilience (moins de points de défaillance potentiels)
- La complexité du débogage (traçage simplifié)

== Qualité logicielle

=== Stratégie de tests

La stratégie de tests mise en place couvre plusieurs niveaux de validation :

- *Tests unitaires* : Chaque module du CRM-backend dispose de tests unitaires validant la logique métier isolément. Les services, repositories et convertisseurs DTO sont testés individuellement avec des mocks pour les dépendances externes (base de données, stockage S3).
- *Tests d'intégration* : Les tests d'intégration valident le bon fonctionnement des interactions entre les couches (controller → service → repository → base de données). Ils nécessitent une base de données PostgreSQL de test éphémère.
- *Tests de healthcheck* : Chaque service expose une route `/health` vérifiée par des sidecars dans l'environnement Docker Compose, garantissant que les services sont opérationnels avant de les exposer.

Les tests sont exécutés automatiquement à chaque pull request via le workflow `test.yml`. Bien que la couverture de tests n'ait pas été mesurée de manière systématique sur l'ensemble du projet (via un outil comme Istanbul/nyc), les modules critiques (gestion des communautés, authentification) disposent d'une couverture suffisante pour détecter les régressions majeures.

=== Vulnérabilités détectées et corrigées

L'intégration de CodeQL et de Dependabot a permis d'identifier et de corriger plusieurs vulnérabilités :
- CodeQL a détecté des injections SQL potentielles et des problèmes de validation d'entrées dans le code initial
- Dependabot a généré des pull requests pour mettre à jour des dépendances présentant des failles de sécurité connues (CVE), notamment dans la chaîne de dépendances JavaScript

Ces corrections, validées automatiquement par les tests CI avant intégration, ont renforcé significativement la sécurité du projet.

=== Signature des images

La signature des images Docker avec Cosign garantit l'intégrité et la provenance des artefacts déployés. Chaque image publiée est signée avec une clé sans serveur (keyless) via Sigstore, permettant à quiconque de vérifier que l'image provient bien du pipeline CI/CD officiel et n'a pas été modifiée après publication.

== Expérience développeur

Dès le mois de décembre, le projet avait atteint un niveau de fonctionnalité satisfaisant. Cependant, la complexité de l'architecture initiale rendait l'ajout de nouvelles fonctionnalités, voire même la réalisation de simples modifications, particulièrement laborieux. Chaque changement nécessitait d'intervenir dans de multiples composants fortement couplés, augmentant le risque de régressions et le temps de développement.

Après le refactoring architectural et la mise en place des outils d'automatisation, la situation s'est nettement améliorée. Notre promoteur a constaté une amélioration significative de la vélocité de développement pour les prochains mois. La réduction de la complexité, la séparation claire des responsabilités et les pipelines CI/CD permettent désormais d'itérer rapidement et en toute confiance.

Le déploiement et la mise à jour en une commande ont tenu leur promesse. L'infrastructure basée sur Docker Compose, couplée aux scripts d'automatisation développés, permet désormais de déployer l'ensemble du projet ou d'appliquer des mises à jour avec une simplicité déconcertante par rapport à la situation initiale. Cette fiabilité opérationnelle est un atout majeur pour l'adoption du projet par des utilisateurs finaux qui n'ont pas nécessairement une expertise DevOps avancée.

== Sécurité

=== Analyse de la surface d'attaque

L'architecture du projet expose plusieurs points d'entrée potentiels qui ont été sécurisés :

- *API Gateway (KrakenD)* : Point d'entrée unique pour toutes les requêtes externes. La configuration générée par Swagger2Krakend applique automatiquement la validation JWT sur les endpoints protégés et le rate-limiting pour prévenir les abus.
- *Keycloak* : Service d'authentification exposé uniquement via l'API Gateway. Les mots de passe sont hashés avec bcrypt et les sessions sont gérées via des tokens JWT à durée limitée.
- *Base de données PostgreSQL* : Non exposée directement, accessible uniquement depuis le réseau Docker interne par le CRM-backend.
- *MinIO (stockage S3)* : Accessible uniquement depuis le réseau Docker interne. Les URLs presignées permettent un accès temporaire aux fichiers sans exposition directe du service.
- *Broker de messages (NATS)* : Isolé dans le réseau Docker interne, utilisé uniquement pour la communication asynchrone entre services.

=== Sécurité des conteneurs

Plusieurs mesures de sécurité ont été appliquées au niveau des conteneurs :
- *Signature des images* : Chaque image Docker publiée est signée avec Cosign via Sigstore (détails dans la section Résultats).
- *Registre accessible publiquement en lecture* : Les images sont hébergées sur GitHub Container Registry. La lecture est publique pour faciliter le déploiement, mais l'écriture est strictement restreinte aux workflows CI/CD authentifiés.
- *Mises à jour des dépendances* : Dependabot surveille les dépendances npm, Docker, GitHub Actions et DevContainers, créant automatiquement des pull requests pour les mises à jour de sécurité.
- *Analyse statique* : CodeQL scanne le code à chaque contribution pour détecter les vulnérabilités connues (injections SQL, XSS, etc.).

=== Segmentation réseau

La politique de communication entre services a été renforcée dans la version de production. Alors que l'environnement de développement utilise deux réseaux (`backend` et `reverse-proxy`), la production en déploie cinq pour une isolation plus fine :
- *api-gateway* : réseau partagé entre KrakenD, le backend CRM et le reverse-proxy.
- *crm* : réseau isolé pour le backend CRM, sa base de données et le migrateur.
- *keycloak* : réseau dédié à Keycloak, sa base de données et le healthcheck sidecar.
- *minio* : réseau isolé pour le stockage S3.
- *opentelemetry* : réseau dédié à la télémétrie (OTLP).

Les services internes (bases de données, MinIO, broker NATS) ne sont pas exposés à l'extérieur de leurs réseaux respectifs. Seul le reverse-proxy Nginx est accessible depuis l'extérieur (ports 80/443).

=== Backup et résilience

Des mécanismes de backup des bases de données ont été ajoutés pour garantir la résilience et la récupération en cas de défaillance. La persistance des données est assurée via des volumes Docker nommés, protégés contre la perte lors du redémarrage des conteneurs.

= Discussion critique

== Limites du travail

=== Absence de benchmarks de performance

La principale limite de ce travail est l'absence de benchmarks de performance formels. La version initiale du projet ne disposait pas d'instrumentation de télémétrie, et nous n'avons pas mis en place de suite de benchmarks avant/après le refactoring. Les améliorations de performance (réduction de la RAM, latence perçue) sont donc qualitatives plutôt que quantitatives. Une recommandation pour les développements futurs serait d'intégrer un outil de benchmarking (ex. : k6, Apache JMeter) dans les pipelines CI/CD.

=== Tests d'intégration non automatisés en CI

Les tests d'intégration complets ne sont pas exécutés automatiquement dans les pipelines CI/CD en raison de leur temps d'exécution (plusieurs dizaines de minutes pour reconstruire toutes les images Docker et lancer l'infrastructure). Ils sont effectués manuellement via le script `docker-stack.sh` avant les releases majeures. Cette approche présente un risque : une régression d'intégration pourrait passer inaperçue si elle n'est pas détectée lors d'un test manuel. Une solution serait d'extraire les tests d'intégration critiques dans un pipeline séparé exécuté nightly.

=== Gouvernance open-source encore théorique

La gouvernance du projet (licence, politique de contribution, rôles) a été définie mais n'a pas encore été testée en conditions réelles avec des contributeurs externes. L'organisation GitHub OptimCE est structurée, mais aucun contributeur externe n'a encore soumis de pull request. La véritable validation de cette gouvernance viendra de son utilisation effective par la communauté.

=== Déploiement Kubernetes non implémenté

Bien que l'architecture soit conçue pour être compatible avec Kubernetes (via Docker Compose Bridge), la migration effective n'a pas été réalisée. Le déploiement actuel repose sur Docker Compose chez un hébergeur VPS. Si la demande pour une offre SaaS émerge, cette migration deviendra nécessaire et impliquera un travail supplémentaire significatif (mais réalisable aisément).

== Arbitres et compromis

=== Monolithe modulaire vs micro-services complets

Le choix de l'architecture modulaire (monolithe CRM + micro-services pour les composants spécifiques) est un compromis. Nous avons perdu certains avantages des micro-services purs :
- L'indépendance de déploiement des composants fusionnés (users, community, partage)
- La possibilité de scaler individuellement chaque fonctionnalité
- L'isolation technologique complète

Cependant, ce compromis est justifié par le contexte : une équipe réduite, un besoin de simplicité pour les contributeurs externes, et une charge utilisateur ne justifiant pas une scalabilité granulaire.

De plus, une architecture micro-services pure introduit des problématiques complexes de consistance des données. Dans un système distribué, garantir la cohérence entre les bases de données locales de chaque service nécessite la mise en place de mécanismes avancés :
- *Propagation d'état pilotée par événements* : Chaque donnée doit avoir un unique service détenteur de la vérité (source of truth). Les autres services maintiennent des modèles de lecture localement, acceptant une consistance éventuelle.
- *Pattern Transactional Outbox* : Toute modification dans la base de données du service source doit générer un événement de manière atomique, garantissant qu'aucun changement ne soit perdu.
- *Idempotence* : Les consommateurs d'événements doivent ignorer les doublons par conception, car la livraison au moins une fois (at-least-once) est la norme dans les systèmes asynchrones.
- *Compensation plutôt que transactions distribuées* : En cas d'erreur, il faut implémenter des événements de compensation pour annuler les opérations précédentes, car les transactions ACID#footnote[Atomicité, Cohérence, Isolation, Durabilité — propriétés garantissant la fiabilité des transactions en base de données.] distribuées (2PC#footnote[Two-Phase Commit — protocole de validation en deux phases pour les transactions distribuées.]) ne sont pas viables à grande échelle.
- *Watchdogs de consistance* : Des mécanismes de vérification périodique sont nécessaires pour détecter et corriger les divergences entre les données répliquées.
- *Contrats et schémas d'événements* : La structure des événements doit être strictement définie et versionnée pour éviter les incompréhensions entre services.

Cette complexité s'étend également au bootstrap des nouveaux micro-services, qui doivent synchroniser leur état initial avec les sources de vérité existantes. Plusieurs approches existent : appels API en masse (bulk), restauration depuis un snapshot SQL, ou replay du journal d'événements (nécessitant un broker comme Kafka avec rétention longue).

Pour un projet comme OptimCE, où les relations entre utilisateurs, communautés et opérations de partage sont intrinsèquement liées et fréquemment consultées ensemble, cette surcharge opérationnelle n'était pas justifiée. Le monolithe modulaire offre une consistance instantanée native via les transactions ACID de PostgreSQL, tout en conservant une séparation logique claire des responsabilités.

=== Git submodules vs monorepo natif

Nous avons choisi les Git submodules plutôt qu'un monorepo natif (avec outils comme Nx ou Turborepo) pour des raisons de simplicité et de familiarité. Cette approche présente des inconvénients :
- La gestion des submodules peut être source de confusion pour les contributeurs novices
- Les dépendances entre submodules ne sont pas résolues automatiquement
- Les outils CI/CD doivent être configurés séparément pour chaque dépôt

Un monorepo natif aurait offert une meilleure cohérence mais aurait nécessité une courbe d'apprentissage plus importante.

=== Docker Compose vs orchestrateur complet

Le choix de Docker Compose pour le déploiement de production est un compromis entre simplicité et fonctionnalités. Docker Compose ne gère pas nativement :
- Le scaling automatique
- La résurrection automatique de conteneurs défaillants (au-delà du restart policy basique)
- Le load balancing entre instances

Cependant, pour le contexte cible (communautés d'énergie auto-hébergeant le projet), ces fonctionnalités ne sont pas nécessaires et auraient ajouté une complexité injustifiée.

=== Gestion des secrets : HashiCorp Vault

La gestion sécurisée des secrets (identifiants de base de données, clés API, certificats) est un aspect critique de toute architecture distribuée. Nous avons étudié l'intégration de HashiCorp Vault, une solution leader dans ce domaine, mais avons finalement décidé de la rejeter pour le déploiement actuel.

Notre recherche sur Vault a identifié plusieurs modèles d'intégration prometteurs :
- *Authentification Kubernetes* : Utilisation des Service Accounts pour authentifier les pods de manière native, permettant une rotation automatique des secrets.
- *AppRole pour Docker Swarm* : Workflow basé sur le stockage des `secretID` dans les secrets Docker, adapté aux environnements non-Kubernetes.
- *Accès "Just-in-Time"* : Génération de credentials à durée de vie limitée (TTL#footnote[Time To Live — durée de vie maximale d'une donnée avant son expiration.]) avec révocation instantanée en cas de suspicion de compromission, réduisant considérablement la fenêtre d'attaque.

Les modèles de livraison identifiés incluent :
- *Zero-Touch (Agent Injector)* : Injection d'un sidecar qui expose les secrets comme des fichiers locaux, gérant automatiquement l'authentification et la rotation.
- *Platform-Native (CSI Driver)* : Montage des secrets comme volumes Kubernetes, plus léger que l'approche sidecar.
- *App-First (SDK)* : Intégration directe de l'API Vault dans le code applicatif, gardant les secrets en mémoire vive uniquement.

Cependant, cette approche a été rejetée pour plusieurs raisons :
- *Complexité disproportionnée* : L'ajout d'un serveur Vault, sa configuration initiale et la gestion des politiques d'accès introduisent une surcharge opérationnelle significative pour un déploiement sur un VPS unique.
- *Dépendance à l'orchestrateur* : Les modèles les plus élégants (sidecar injector, CSI driver) sont intrinsèquement liés à Kubernetes et ne sont pas directement transposables à Docker Compose sans outils tiers complexes.
- *Surcharge applicative* : Le modèle SDK nécessiterait de modifier chaque microservice pour gérer l'authentification Vault, la rotation des tokens et les fallbacks en cas d'indisponibilité.
- *Sécurité suffisante* : Pour le contexte actuel, l'utilisation des secrets Docker Compose combinée à des variables d'environnement injectées au runtime offre un niveau de sécurité acceptable sans la complexité de Vault.

Cette décision pourrait être réévaluée si le projet évolue vers une offre SaaS multi-locataires ou si les exigences de conformité imposent une rotation automatique des credentials.

== Propositions d'évolution architecturale

Bien que le refactoring actuel ait considérablement simplifié l'architecture, plusieurs évolutions ont été identifiées pour améliorer la maintenabilité et les performances à long terme.

=== Consolidation des bases de données en une instance PostgreSQL unique

À l'heure actuelle, chaque micro-service dispose de sa propre base de données PostgreSQL, ce qui engendre une complexité opérationnelle non négligeable (gestion de multiples instances, synchronisation, surconsommation de ressources). Une évolution pertinente consisterait à consolider l'ensemble de ces bases au sein d'une instance PostgreSQL unique, en exploitant des schémas distincts pour chaque service. Cette stratégie permettrait de réduire drastiquement la charge de maintenance tout en préservant l'isolation logique requise entre les composants. Enfin, si une montée en charge s'avérait nécessaire à l'avenir, une nouvelle migration vers une architecture multi-instances demeurerait parfaitement envisageable.

=== Amélioration de la gestion des identités

Actuellement, Keycloak et le CRM-backend se synchronisent lors de la création et de la modification des utilisateurs. Toutefois, ce processus synchrone est susceptible d'entraîner des problèmes de cohérence en cas de forte charge ou de défaillance temporaire de Keycloak. Une évolution pertinente consisterait à adopter une architecture orientée événements pour la synchronisation des identités. En exploitant le broker NATS, les changements d'état des utilisateurs pourraient être propagés de manière asynchrone. Cette approche garantirait une résilience accrue du système tout en assurant une consistance éventuelle (eventual consistency) parfaitement adaptée aux exigences du projet.

=== Intégration de nouveaux micro-services

L'ajout de nouvelles fonctionnalités doit suivre une logique de micro-services indépendants lorsqu'ils présentent des besoins techniques spécifiques ou un cycle de vie différent :

- *Génération de clés et simulation* : Conservés comme micro-services séparés pour des raisons techniques (langages différents, besoins asynchrones).
- *Gestion documentaire* : Les documents sont liés aux utilisateurs mais indépendants du CRM. Le stockage de fichiers devrait reposer sur une solution open-source dédiée, avec une mise en file d'attente des requêtes pour le stockage à long terme.
- *Génération de templates* : Divisé en deux composants : un collecteur d'actions (ex. : ajout d'un utilisateur à une communauté) stockant les snapshots dans une base NoSQL, et un générateur produisant les documents finaux. Ce service devrait rester indépendant pour éviter d'alourdir le CRM.
- *Notifications* : Conservé séparément car asynchrone par nature (SMTP, SMS, WebSocket). Il ne dépend que des données utilisateurs et peut tolérer des interruptions sans impacter le reste du système.

=== Gestion de la consistance des données

Le principal avantage d'une architecture monolithique réside dans la cohérence immédiate des données, au prix d'une mise à l'échelle (scaling) plus complexe. Dans notre contexte, si un fournisseur unique (wallon ou belge) vient à desservir plusieurs communautés avec un grand nombre d'utilisateurs concurrents, le modèle distribué reste pertinent malgré la complexité accrue liée à la gestion de cette cohérence. L'approche asynchrone par événements et la tolérance à la cohérence à terme (eventual consistency) offrent un compromis adéquat entre performances et résilience.

L'adoption d'une modularité stricte au sein du monolithe, reposant sur des couches de service bien définies, permet de limiter considérablement les risques de régressions et d'en faciliter la maintenance. En cas de besoin d'une scalabilité plus fine à l'avenir, une migration complète vers une architecture orientée micro-services pourrait être amorcée, en s'appuyant sur les patterns de gestion évoqués précédemment. De plus, cette modularité interne simplifierait grandement une telle transition. Toutefois, les besoins actuels du projet ne prévoient et ne justifient pas ce type d'évolution dans un futur proche.


=== Processus de mise à jour automatisé

Un mécanisme de mise à jour automatisé a été planifié pour faciliter la maintenance des instances déployées. Ce système reposerait sur plusieurs principes :

- *Versionnage sémantique* (`x.y.z`) : les versions majeures signalent des changements potentiellement incompatibles, les mineures des évolutions impactant la base de données, et les patchs des corrections mineures. Les versions `-rc` (release candidate) seraient réservées aux tests développeurs.
- *Mode maintenance* : lors d'une mise à jour, l'application basculerait en lecture seule ou afficherait une page de maintenance.
- *Sauvegarde pré-migration* : un dump automatique de la base de données serait généré avant toute migration, stocké sur un bucket S3 tiers pour permettre un rollback rapide.
- *Mécanisme d'updater* : la containerisation des composants permettrait un auto-pull des nouvelles images et un auto-restart des services (déjà implémenté). Des scripts internes pourraient être ajoutés pour détecter les changements de version, appliquer les migrations, vérifier le bon fonctionnement post-migration et effectuer un rollback automatique en cas d'échec.

== Perspectives d'amélioration

Plusieurs axes d'amélioration ont été identifiés pour les développements futurs :
- Intégration d'un système de télémétrie (Prometheus et Grafana) afin de mesurer les performances de manière objective.
- Automatisation complète des tests d'intégration au sein d'un pipeline CI/CD nocturne (nightly build).
- Enrichissement de la documentation utilisateur (guides d'installation, tutoriels), une démarche d'ores et déjà bien amorcée depuis la fin de la période de stage.
- Étude d'une migration vers Kubernetes, dans l'éventualité où la demande pour une offre SaaS viendrait à émerger.

== Retour d'expérience

Ce travail a confirmé une conviction forte : il n’existe pas de silver bullet en ingénierie. Il n’y a que des bonnes réponses, adaptées à leur contexte. Voici les enseignements clés tirés de l’expérience OptimCE, qui illustrent cette réalité :

- *Domain-Driven Design* : n'est pas optionnel dès qu'on dépasse deux services. L'absence d'une analyse DDD initiale a conduit à un monolithe distribué. Quelques jours de modélisation du domaine en amont auraient évité des semaines de refactoring.

- *Kubernetes* : n'est pas la réponse à tout. Pour ~15 conteneurs sur un VPS unique, Docker Compose offre un meilleur rapport simplicité-efficacité. La tentation d'adopter Kubernetes « parce que c'est le standard » doit être pondérée par les besoins réels du projet.

- *Documenter la dette technique* : est plus important que de la rembourser. Dans un projet de recherche, la dette est inévitable. Un tableau Kanban de suivi, couplé à une documentation des décisions architecturales, s'est avéré plus utile qu'un refactoring systématique et prématuré.

- *Documentation, gestionnaire de projet et DevContainers* : éliminent réellement le syndrome du « ça marche sur ma machine ». L'investissement dans leur configuration a été largement rentabilisé par la réduction des problèmes d'environnement et du temps d'onboarding des nouveaux contributeurs.

- *CI/CD* : le ciment des équipes en communication asymétrique
Dans un contexte où les contributeurs ne communiquent pas en temps réel (fuseaux horaires décalés, équipes distribuées, ou contributions asynchrones), le CI/CD devient un pilier de la maintenabilité. En effet, cela impose une discipline collective. L'impact n'est donc pas que technique mais un outil de collaboration au même titre qu'un tableau Kanban ou les documents partagés.


Ces leçons, bien que spécifiques au contexte d'OptimCE, illustrent des défis récurrents dans la transition de prototypes de recherche vers des projets open-source viables.

= Conclusion

Ce mémoire a présenté la transition du projet OptimCE, composant clé du projet de recherche Locomotrice, vers une solution open-source pérenne et collaborative. Le travail réalisé s'est articulé autour de plusieurs axes majeurs.

Sur le plan technique, nous avons procédé à une restructuration profonde de l'architecture du projet. L'analyse initiale a révélé un anti-pattern de monolithe distribué, caractérisé par une complexité opérationnelle excessive et des appels synchrones nombreux entre micro-services. La fusion des composants redondants (utilisateurs, communauté, opérations de partage) en un service CRM unifié, combinée à la suppression des services backend-db intermédiaires, a permis de réduire significativement cette complexité. Les résultats sont tangibles : la consommation mémoire est passée de 3 Go à 800 Mo à vide, et la maintenabilité du code s'en trouve considérablement améliorée.

L'organisation du code source a également été repensée. La séparation en dépôts Git indépendants au sein d'une organisation GitHub dédiée offre une modularité et une réutilisabilité accrues, tout en facilitant la contribution externe. Chaque dépôt dispose désormais de pipelines CI/CD automatisés incluant tests unitaires, analyse de sécurité via CodeQL, mises à jour automatiques des dépendances avec Dependabot, et publication d'images Docker signées avec Cosign.

Le développement d'un monorepo de staging, basé sur les sous-modules Git, a permis de résoudre le défi de synchronisation entre les composants indépendants. Couplé à un docker-compose de développement complet, il offre un environnement de test et d'intégration reproductible, accessible en une seule commande. L'automatisation du déploiement, via des scripts de génération de configuration et l'outil Swagger2Krakend développé pour l'occasion, garantit une infrastructure cohérente et à jour entre les environnements de développement et de production.

La gouvernance du projet a été structurée autour d'une licence Apache 2.0, d'une politique de contribution claire définissant les rôles (mainteneurs, contributeurs internes et externes, utilisateurs), et d'outils de qualité logicielle (linting, formatage, hooks Git). Ces éléments sont essentiels pour encourager et faciliter les contributions externes.

Sur le plan communautaire, les fondations ont été posées pour accueillir et fidéliser les contributeurs. La documentation adaptée à différents publics (développeurs, chercheurs, entreprises), les canaux de communication structurés (issues GitHub, forums) et les processus de revue de code transparents créent un environnement propice à la collaboration. L'organisation GitHub OptimCE centralise l'ensemble de ces éléments et offre une vitrine claire pour le projet. La réussite de cette transition open-source dépendra désormais de la capacité à fédérer une communauté active autour du projet, en maintenant un équilibre entre l'accessibilité pour les nouveaux venus et la rigueur technique nécessaire à la qualité du code.

Notre participation s'est étendue au-delà du périmètre initial d'OptimCE, notamment avec le développement d'EcoArbiter, un algorithme de redistribution énergétique en temps réel écrit en Rust, conçu comme une alternative performante et équitable au projet proposé par l'ULiège dans le cadre du sous-projet EMS Global.

Les objectifs fixés en début de stage ont été atteints : le projet OptimCE est désormais stable, modulaire, documenté et prêt à être adopté par une communauté open-source. En résumé, nous avons transformé un prototype de recherche complexe et fragile en une solution robuste, simple à déployer et ouverte à la contribution collective : les trois piliers indispensables à sa pérennité.

Les perspectives futures incluent l'élargissement de la communauté de contributeurs, l'évolution vers un déploiement Kubernetes si la demande le justifie (notamment pour une offre SaaS), et l'intégration continue des retours des utilisateurs finaux pour guider les développements futurs. La transition vers l'open-source n'est pas un aboutissement, mais le début d'un processus d'amélioration continue qui devra être entretenu par la communauté.

= Déclaration d'utilisation de l'IA

Conformément aux consignes institutionnelles, je déclare avoir utilisé des outils d'intelligence artificielle (principalement les modèles Gemini et MiniMax) de manière limitée pour :
- La reformulation et la correction orthographique et grammaticale de certaines sections.
- La recherche préparatoire de références bibliographiques et de bonnes pratiques techniques.
- La vérification de syntaxe Typst et la mise en forme du document.

La problématique, la méthodologie, l'analyse architecturale, les résultats et les conclusions de ce mémoire sont entièrement le fruit de mon travail personnel et de ma réflexion ainsi que de recherches documentaires classiques.
