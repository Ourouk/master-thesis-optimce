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
  thanks: (
    (
      first-name: "Eric",
      last-name: "Paques",
      role: "Promoteur, CeCoTePe",
    )
  ),
  bibliography-file: "../ref.bib",
  annex: include "annex.typ",
  binding: false,
)

= Remerciements

Nous tenons à remercier Eric Paques, notre promoteur au sein du CeCoTePe, pour son encadrement, sa confiance et ses conseils avisés tout au long de ce travail.

Nous remercions également les membres de l'équipe BEMS de l'Université de Liège pour leur collaboration et leurs retours constructifs lors des réunions de coordination hebdomadaires.

Enfin, nous exprimons notre gratitude envers l'ensemble des partenaires du projet Locomotrice — le CeCoTePe, l'Université de Liège et Émission Zéro — pour leur engagement dans cette recherche visant à faciliter la transition énergétique participative.

#pagebreak()

#set text(lang: "eng")
= Abstract

This Master's Thesis presents the transition of the OptimCE subproject—developed within the framework of the Locomotrice research project—toward an open-source model. The goal is to restructure the project to make it accessible, maintainable, and adaptable for a diverse community, including researchers, businesses, and energy communities.

== Problem Statement

The challenges addressed include:
- Code Quality: Improving readability, modularity, and developer experience.
- Reproducibility: Simplifying the infrastructure to ensure smooth installation.
- Simplification: Reducing the project's complexity, which is currently excessive for its scale.
- Documentation: Creating clear resources tailored to different audiences.
- Testing: Implementing unit and integration tests to ensure stability.
- Communication: Developing a promotion strategy to maximize adoption.
- Governance: Establishing collaborative processes for effective development.

== Methodology

The approach combines:
- Architectural Audit: Identifying anti-patterns (e.g., Distributed Monolith).
- Refactoring: Merging redundant components (e.g., Backend Database and Backend).
- DevOps: Integrating CI/CD and automation.
- Tooling: Developing solutions for deployment and collaboration.
- Benchmarking: Studying best practices from established open-source projects.
- Communication Tools: Using available tools to facilitate collaboration.

== Results

The refactoring resulted in a 73% reduction in memory consumption (3 GB to 800 MB), a significant decrease in synchronous REST calls between micro-services, and the implementation of a complete CI/CD pipeline with automated security scanning (CodeQL), dependency updates (Dependabot), and signed Docker images (Cosign). The project is now structured as a modular architecture with independent Git repositories, a staging monorepo, and a one-command deployment system.

== Conclusion

By the end of this work, the OptimCE project is transformed into a stable, modular, and easily reusable solution, characterized by reduced technical complexity. This restructuring promotes its adoption by the open-source community while ensuring its longevity and laying the foundations for collaborative and adaptable governance.

#pagebreak()

#set text(lang: "fr")
= Résumé

Ce mémoire de master présente la transition du sous-projet OptimCE — développé dans le cadre du projet de recherche Locomotrice — vers un modèle open source. L'objectif est de restructurer le projet pour le rendre accessible, maintenable et adaptable pour une communauté diversifiée, incluant des chercheurs, des entreprises et des communautés énergétiques.

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
- *Benchmarking* : Étude des meilleures pratiques de projets open source établis.
- *Outils de communication* : Utilisation d'outils disponibles pour faciliter la collaboration.

== Résultats

Le refactoring a permis une réduction de 73 % de la consommation mémoire (de 3 Go à 800 Mo), une diminution significative des appels REST synchrones entre micro-services, et la mise en place d'un pipeline CI/CD complet avec analyse de sécurité automatisée (CodeQL), mises à jour de dépendances (Dependabot) et signature d'images Docker (Cosign). Le projet est désormais structuré en architecture modulaire avec des dépôts Git indépendants, un monorepo de staging et un système de déploiement en une commande.

== Conclusion

À l'issue de ce travail, le projet OptimCE a été transformé en une solution stable, modulaire et facilement réutilisable, caractérisée par une complexité technique réduite. Cette restructuration favorise son adoption par la communauté open source tout en assurant sa pérennité et en posant les bases d'une gouvernance collaborative et adaptable.

#pagebreak()

#set text(lang: "fr")
= Introduction

Ce mémoire s'inscrit dans le cadre de la mise en open source#footnote[Modèle de développement où le code source est rendu public sous une licence (ex. : Apache 2.0, MIT) permettant sa consultation, modification et redistribution.] du projet *OptimCE*, un composant clé du projet de recherche *Locomotrice*. Le projet Locomotrice est financé par l'appel à projets Win2Wal et inclut le CeCoTePe#footnote[Centre de Coopération Technique et Pédagogique, ASBL encadrant formations professionnelles et recherche.], l'équipe BEMS de l'Université de Liège et Émission Zéro en tant que partenaire industriel. Son objectif est de faciliter la transition énergétique participative en développant une plateforme open source pour les communautés d'énergie #cite(<locomotrice>). Le projet se divise en deux volets : OptimCE — plateforme administrative de gestion de membres et d'informations pour les communautés d'énergie, réalisé par le CeCoTePe — et EMS (Energy Management System) — sous-projet domotique de contrôle de la consommation électrique, géré par l'ULiège.

L'objectif principal d'OptimCE est de fournir une plateforme administrative de gestion de membres et d'informations spécifiques à la gestion d'une communauté d'énergie. L'entreprise repreneuse a comme seules exigences techniques l'utilisation de *Node.js* et de *Kubernetes*, sans exprimer de préférence particulière quant au système de gestion de bases de données. Ces décisions architecturales seront détaillées ultérieurement dans ce document.

Le projet *OptimCE* atteint un niveau de maturité technologique (TRL#footnote[Technology Readiness Level : niveau de maturité technologique (1-9) indiquant la proximité d'un déploiement en production. Le niveau 7 signifie un système déjà testé et à faible risque.]) de 7 #cite(<Horizon_Europe_2026_gouv>). Ce niveau indique que le projet est proche d'un état opérationnel, prêt à être déployé en production. Initialement, ce développement était prévu pour être réalisé par un seul développeur dans le cadre interne de la Haute École de la Province de Liège (HEPL).

Ce travail a été réalisé au sein des locaux de l'ISIL (Institut Supérieur Industriel de Liège) sur une période de 8 mois, d'octobre à mai, sous l'encadrement d'Eric Paques. Des réunions hebdomadaires de coordination avec l'Université de Liège ont également été organisées pour assurer la synchronisation entre les volets OptimCE et EMS du projet.

== Contexte du projet Locomotrice

Le projet Locomotrice, initialement développé dans un cadre de recherche, doit être rendu open source afin d'être accessible à la communauté d'utilisateurs ainsi qu'aux entreprises susceptibles de le reprendre. Cette transition hors du contexte académique pose plusieurs défis majeurs.

== Problématique

=== Problématique générale

Comment transformer un prototype de recherche complexe et fragile en une solution robuste, simple à déployer et ouverte à la contribution collective ?

=== Problématiques spécifiques

- *Licences* : Comment choisir une licence open-source compatible avec les usages envisagés (usage communautaire, usage commercial, contributions externes) et sécuriser juridiquement la publication du code ?

- *Lisibilité et qualité du code / Developer Experience* : Comment rendre un code développé initialement par une équipe de recherche, souvent hétérogène et non formaté, plus lisible, cohérent et maintenable ? Comment améliorer l'expérience développeur pour encourager les contributions externes ?

En effet, en open source, la bonne volonté des contributeurs est un facteur clé de succès. Il est donc essentiel de réduire les barrières à la contribution.

- *Reproductibilité et portabilité du projet* : Comment réduire la complexité actuelle du projet pour permettre une installation simple ?

Toujours dans l'optique de réduire les barrières à l'adoption, il est essentiel de simplifier l'infrastructure nécessaire pour faire fonctionner le projet, tout en garantissant une reproductibilité complète. Les utilisateurs peuvent en effet devenir contributeurs, et il est important de leur faciliter la tâche pour qu'ils puissent tester et modifier le projet sans rencontrer de problèmes d'installation ou de configuration.

- *Architecture et compréhension du code* : Comment structurer l'architecture du code pour la rendre compréhensible par des développeurs externes ? Quelle infrastructure minimale de développement et de production est nécessaire pour garantir une reproductibilité complète ?

- *Documentation* : Comment fournir une documentation claire, complète (installation, API, architecture, exemples), et adaptée à différents publics (développeurs, chercheurs, entreprises) ?

- *Testing et qualité logicielle* : Comment mettre en place une stratégie de tests (unitaires, intégration) permettant d'améliorer la qualité, détecter les régressions, renforcer la confiance dans le projet et réduire la charge de maintenance ?

== Objectifs

Notre travail se concentre sur :

- L'amélioration de l'architecture et de la structure du code, afin de rendre le projet plus clair et modulaire.
- La lisibilité et la qualité du code, via des bonnes pratiques et des outils de vérification.
- La mise en place d'une infrastructure reproductible, facilitant l'installation, le développement et l'exécution du projet.
- La réduction de la complexité générale, pour simplifier l'adoption et la contribution par la communauté.

L'objectif global est de rendre le projet stable, compréhensible et facilement réutilisable en open-source.

= État de l'art

Cette section présente le cadre théorique et les références qui ont guidé nos choix architecturaux et organisationnels.

== Architectures logicielles : du monolithe aux micro-services

L'architecture logicielle d'un système influence directement sa maintenabilité, sa scalabilité et la productivité des équipes qui le développent. Trois paradigmes principaux coexistent dans l'industrie :

=== Architecture monolithique

L'architecture monolithique regroupe l'ensemble des fonctionnalités dans une seule unité déployable. Elle présente l'avantage de la simplicité : un seul code source, un seul déploiement, des tests simplifiés et un débogage direct. Cependant, elle souffre de limitations à mesure que le projet croît : couplage fort entre les modules, difficulté à scaler individuellement les composants, et risque de dérive vers une architecture non structurée #cite(<Morintd_2026_dev>).

=== Architecture micro-services

L'architecture micro-services décompose le système en services indépendants, communiquant via des appels réseau (généralement REST ou messaging). Chaque service possède sa propre base de données, son cycle de vie et peut être développé dans un langage différent. Cette approche offre une scalabilité granulaire, une résilience accrue et une indépendance des équipes #cite(<Claytonsiemens77_2026_microsoft>).

Cependant, elle introduit une complexité opérationnelle significative : gestion des communications réseau, cohérence distribuée, déploiement orchestré et observabilité. Comme le souligne Microsoft dans son Azure Architecture Center, les micro-services ne devraient être envisagés que lorsque la complexité du système justifie cette approche #cite(<Claytonsiemens77_2026_microsoft>).

=== Anti-pattern : le monolithe distribué

Le monolithe distribué est un anti-pattern où les services sont physiquement séparés mais logiquement fortement couplés, combinant les inconvénients des deux approches : complexité opérationnelle des micro-services sans les bénéfices de l'indépendance #cite(<Morintd_2026_dev>). Cet anti-pattern apparaît fréquemment lorsqu'une architecture micro-services est adoptée sans une analyse rigoureuse des frontières du domaine métier.

Dans notre projet initial, l'utilisation intensive d'appels synchrones REST entre services créait exactement ce scénario : chaque service dépendait fortement des autres pour fonctionner, formant un réseau de dépendances où la défaillance d'un composant pouvait impacter l'ensemble du système.

=== Approche hybride : les micro-services bien faits

Face au dilemme monolithe vs micro-services, une troisième voie existe : regrouper les services trop étroitement liés dans un monolithe modulaire, tout en isolant les composants véritablement indépendants. Cette approche est documentée par Microsoft dans son Azure Architecture Center #cite(<MicrosoftDDD_2026>), qui recommande une analyse de domaine rigoureuse avant de définir les frontières entre services.

Un bon candidat au statut de micro-service indépendant présente les caractéristiques suivantes :
- Des besoins de scaling différents du reste de l'architecture (ex. : génération de documents, traitement de tâches lourdes)
- Une technologie ou un langage spécifique justifiant une isolation
- Une faible dépendance aux données des autres services

À l'inverse, un module intensivement dépendant des données d'autres services, qui scale de manière identique et n'effectue pas de tâches asynchrones lourdes, a tout intérêt à être intégré au monolithe.

=== Domain Driven Design (DDD)

Le Domain Driven Design, tel que documenté par Microsoft dans son Azure Architecture Center #cite(<MicrosoftDDD_2026>), propose une méthode pour définir les frontières entre services en se basant sur la structure du domaine métier plutôt que sur des considérations techniques. Les concepts de *bounded contexts* et d'*ubiquitous language* permettent d'identifier les zones de cohérence sémantique où un service peut opérer de manière autonome.

Le principe fondamental du DDD est que chaque *bounded context* possède sa propre représentation des entités partagées. Prenons l'exemple d'un client :
- Pour un service de livraison, c'est une adresse et un prix payé
- Pour la gestion de compte, c'est un identifiant et un mot de passe
- Pour le service client, c'est un numéro de téléphone

Chaque contexte ne conserve que les données qui lui sont pertinentes, évitant ainsi le couplage fort. Si deux services parlent d'un objet de la même manière, le DDD suggère qu'il n'y a pas de raison valable de les séparer.

Dans le contexte de notre projet, l'absence d'une analyse DDD initiale a conduit à une définition imprécise des entités partagées entre services, générant un couplage fort et des appels synchrones excessifs. Le refactoring a consisté à identifier les *bounded contexts* naturels et à regrouper ceux qui partageaient la même sémantique.

== Bonnes pratiques open-source

La transition d'un projet académique vers un modèle open-source nécessite une structuration dépassant la simple publication du code source.

=== Gouvernance et licence

Le choix de la licence détermine les droits et obligations des utilisateurs et contributeurs. Les licences permissives (MIT, Apache 2.0) favorisent l'adoption commerciale, tandis que les licences copyleft (GPL, AGPL) garantissent que les dérivés restent open-source. La licence Apache 2.0 offre un équilibre avec sa clause de protection des brevets, ce qui en fait un choix courant pour les projets institutionnels #cite(<OpenSourceGuide_2026>).

La gouvernance définit les rôles (mainteneurs, contributeurs, utilisateurs), les processus de décision et les mécanismes de contribution. Le guide du gouvernement français sur l'open-source #cite(<pocos-dinsic-stable:online>) recommande une documentation claire des processus de contribution, un code de conduite et une politique de release explicite.

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

Le suivi du projet a été effectué via *Notion*, utilisé comme gestionnaire de tâches (Kanban) et comme support de documentation des décisions architecturales. Une partie significative de ce mémoire a été rédigée en se basant sur les recherches préalables aux différentes implémentations, documentées au fil de l'eau.

#figure(
  image("assets/Notion01.png"),
  caption: [Kanban de suivi de l'avancement et de la dette technique],
)

#figure(
  image("assets/Notion02.png", height: 7.5cm),
  caption: [Documentation des décisions architecturales],
)

== Revue du code et analyse de l'architecture

L'analyse initiale du code source a révélé que l'architecture micro-services, bien qu'adaptée aux grandes équipes et aux déploiements cloud natifs, pose plusieurs défis majeurs dans le cadre d'un projet open source.

Bien que conçue pour offrir la résilience, la scalabilité et un déploiement indépendant des composants, cette architecture introduit une complexité opérationnelle accrue, notamment en matière de tests, de compréhension globale du système et de maintenance.

Chaque micro-service, bien que faiblement couplé et déployable individuellement, nécessite une gestion fine des interconnexions, des protocoles de communication et des mécanismes de tolérance aux pannes, ce qui peut rendre le projet difficile à appréhender pour de nouveaux contributeurs ou pour une petite équipe de développeurs.

Elle nécessite donc une infrastructure et une culture de développement orientées vers les grandes équipes et/ou les entreprises. Un autre problème est que nous n'avions aucune certitude quant au déploiement du produit en tant que SaaS ; il pourrait très bien suivre une architecture auto-hébergée.
=== Illustration du problème
Lors de la division initiale, théoriquement, le code paraissait assez simple à suivre avec des frontières claires entre les composants.
#figure(
  image("assets/architecture_simple.png"),
  caption: [Architecture initialement prévue],
)
Or cette division relève d'un domaine de recherche à part entière : le *Domain Driven Design*#footnote[Méthode de conception où l'architecture suit la structure du domaine métier plutôt que la technologie. Aide à définir les frontières entre microservices.] (DDD) #cite(<2026_microsoft>), tel que détaillé dans la section sur les architectures logicielles. Son objectif est d'étudier l'interaction et la définition des objets au sein de l'ensemble du code source d'un produit.

L'intérêt du micro-service apparaît principalement lorsque les services manipulent les mêmes objets de façon totalement différente et ne les définissent même pas de la même manière, permettant ainsi une communication asynchrone où les données sont partiellement copiées et adaptées via un bus de communication.
#figure(
  image("assets/micro-service.png"),
  caption: [Une vraie implémentation micro-services],
)
En pratique, cette démarche d'analyse s'avère complexe. Dans le cadre de ce projet, l'évolution continue du domaine au fil du développement et une vision initiale incomplète de son ensemble ont mené à une définition imprécise des entités, entraînant ainsi une augmentation graduelle de la complexité technique.
== Proposition de modifications
Face à la complexité du projet, et dans l'objectif d'améliorer la lisibilité et l'expérience développeur, nous avons entrepris un important refactoring.

Le projet était tombé dans un anti-pattern : le *monolithe distribué*#footnote[Anti-pattern où les microservices, bien séparés, restent fortement couplés (appels synchrones fréquents, doublons de code). Combine les désavantages du monolithe et des microservices.] #cite(<Morintd_2026_dev>). Des parties du projet étaient trop proches au niveau du domaine d'analyse et nécessitaient techniquement trop d'appels synchrones.

Ces appels synchrones rendaient les micro-services très interdépendants et nécessitaient la modification de nombreuses parties de code dans différents composants pour chaque fonctionnalité.
#figure(
  image("assets/architecture.png"),
  caption: [Augmentation de la complexité],
)
L'idée était donc de rassembler les fonctionnalités redondantes dans des services plus importants afin de réduire cette complexité, tout en anticipant la capacité future du produit à supporter une charge croissante.

=== Analyse comparative des architectures

Avant de procéder au refactoring, nous avons évalué trois approches alternatives :

#table(
  columns: (auto, auto, auto, auto),
  inset: 0.5em,
  stroke: none,
  [*Critère*], [*Monolithe*], [*Modulaire*], [*Micro-services*],
  [Simplicité de déploiement], [+++], [++], [+],
  [Indépendance des équipes], [--], [+], [+++],
  [Scalabilité granulaire], [--], [+], [+++],
  [Complexité opérationnelle], [+], [++], [---],
  [Facilité de contribution], [++], [++], [+],
  [Résilience], [--], [+], [+++],
  [Adéquation au contexte], [++], [+++], [--],
)
_Tableau comparatif des architectures évaluées pour le projet OptimCE._

Le monolithe pur a été rejeté car il aurait empêché l'utilisation de Python pour les composants mathématiques et limité la scalabilité future. Les micro-services complets ont été écartés en raison de la complexité opérationnelle excessive pour une équipe réduite. L'architecture modulaire — un monolithe modulaire couplé à des micro-services pour les composants nécessitant une indépendance technique — a été retenue comme compromis optimal.

=== Suppression des backend-db

Une série de services avait pour rôle de convertir les appels vers les bases de données en API REST. Ces services intermédiaires ajoutaient une couche de complexité inutile, car chaque micro-service pouvait accéder directement à sa propre base de données via une librairie ORM. Nous avons donc décidé de les fusionner avec les services qui les utilisaient, éliminant ainsi des processus et des conteneurs redondants.
=== Fusion de composants
Nous avons également procédé à une fusion de micro-services en raison d'appels synchrones trop fréquents et de leur impact négatif sur les performances :
- Opérations de partage
- Communauté
- Membres

Ces fonctionnalités ont été regroupées vers un service unifié : le CRM (Customer Relationship Management).

=== Justification du maintien de certains micro-services
On pourrait se demander pourquoi ne pas fusionner l'ensemble dans l'application centrale.

L'architecture micro-services présente cependant certains avantages non négligeables dans des scénarios rencontrés au cours du projet :
==== Code source dans plusieurs langages
Certains composants existants du projet ont été réalisés en Python, notamment grâce à des bibliothèques mathématiques reconnues et plus largement testées que celles disponibles en TypeScript.

==== Fonctionnement asynchrone nécessaire
Certaines tâches peuvent s'avérer plus lourdes ou ne nécessiter aucune interaction directe avec le CRM.

==== Liste des composants micro-services restants
- Notifications
- Simulation/Génération de clés
- Template
Ces composants restent donc indépendants du CRM et peuvent être développés dans les langages les plus adaptés à leur fonctionnement.

Dans la majorité des cas, ces modules pourraient être implémentés sous forme de fonctions lambda si nous opérions dans le cloud.
=== Schéma après modification
#figure(
  image("assets/proposition_architecturale.png"),
  caption: [Proposition de refactoring présente dans la documentation partagée],
)
Composant central : CRM-backend :
- Regroupe les fonctionnalités de gestion de communauté, de membres et d'opérations de partage.
- Permet une gestion orientée objet des données, avec des entités clairement définies (ex. : Community, User, CommunityUser).
- Réduit les appels synchrones entre les composants, améliorant ainsi les performances et la maintenabilité.
CRM-frontend :
- Interface utilisateur pour la gestion des communautés, des membres et des opérations de partage.
*Composants micro-services* :
- *Notifications* : gère les notifications asynchrones (ex. : e-mails, alertes).
- *Simulation/Génération de clés* : responsable des tâches de simulation et de génération de clés, qui peuvent être plus lourdes ou nécessiter des langages spécifiques.
- *Template* : gère les modèles de documents ou d'e-mails, nécessitant une logique spécifique.
Composants tiers :
- *KrakenD* : API Gateway, utilisé pour exposer les différentes API de manière unifiée et sécurisée.
- *Keycloak* : service d'identité et de gestion des utilisateurs, utilisé pour l'authentification et l'autorisation.
- *MinIO* : service de stockage d'objets, utilisé pour stocker les fichiers liés aux communautés (ex. : logos).
- *Broker de messages* (NATS#footnote[Broker de messages open-source avec support JetStream pour la persistance et la relecture des messages. Alternative légère à RabbitMQ, privilégiée pour sa simplicité de déploiement et son intégration cloud-native.]) : utilisé pour la communication asynchrone entre les composants, notamment pour les tâches de génération de clés d'allocation.
== Refactoring architectural
=== Implémentation de la couche d'accès aux données
Afin de conserver une architecture solide et modulaire, nous avons adopté la structure suivante :
==== Mapping objet-relationnel
Une librairie ORM#footnote[Object-Relational Mapping : traduit automatiquement les lignes de base de données en objets de code (ex. Community ↔ table community). Simplifie les requêtes SQL.] permet de :
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
==== Conclusion
Ce changement a permis une réduction significative du nombre d'appels synchrones REST entre les micro-services. La diminution de la complexité est notable et nous a permis d'itérer plus rapidement.
=== Fusion de services

La seconde partie de la refonte a concerné la fusion des composants users, community et opération de partage dans le composant CRM (Customer Relationship Management). L'objectif a été de remplacer les nombreux appels REST entre ces composants par une gestion orientée objets de ces informations.

Cette fusion a nécessité une réorganisation significative du code :
- Harmonisation des modèles de données : les entités `User`, `Community` et `CommunityUser` ont été unifiées dans un seul contexte de domaine, avec des relations Many-to-Many gérées par l'ORM.
- Migration des données : les schémas de base de données des trois composants ont été consolidés en une seule base PostgreSQL, avec des scripts de migration pour préserver les données existantes.
- Refactorisation des contrôleurs API : les endpoints REST des trois services ont été regroupés dans des contrôleurs unifiés, avec une gestion cohérente des erreurs et de la pagination.
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

Sous le nom OptimCE, nous avons en effet rassemblé tous les dépôts liés au projet. Cette organisation nous permet de centraliser la gestion des secrets et des pipelines CI/CD, ainsi que de créer des équipes de contributeurs avec des rôles spécifiques (mainteneurs, contributeurs, etc.).
=== Choix de licence
Le choix de la licence est une étape cruciale pour tout projet open-source, car elle définit les droits et les obligations des utilisateurs et des contributeurs. Après une analyse approfondie des différentes options, nous avons opté pour la licence Apache 2.0.

Cette licence offre un bon équilibre entre la permissivité et la protection juridique, permettant une utilisation commerciale tout en protégeant les contributeurs contre les litiges liés aux brevets. De plus, elle est largement reconnue et utilisée dans la communauté open-source, ce qui facilite l'adoption et la contribution au projet.

Pour les outils développés par d'autres communautés et intégrés dans notre projet, nous avons veillé à ce qu'ils soient compatibles avec la licence Apache 2.0, afin d'assurer une cohérence juridique et de faciliter la réutilisation du code.
=== Création d'une politique de contribution
Le projet dispose désormais d'une politique de contribution concise. Les contributeurs peuvent proposer des modifications via des pull requests, qui sont ensuite examinées par les mainteneurs du projet. Nous encourageons les contributions de tous types, qu'il s'agisse de corrections de bugs, d'ajout de fonctionnalités ou d'améliorations de la documentation.
==== Hiérarchie des contributeurs
- Mainteneurs : responsables de la gestion globale du projet, de la validation des contributions et de la prise de décisions stratégiques.
- Contributeurs internes : personnes travaillant directement sur le projet au sein de l'organisation, avec des droits d'accès étendus pour faciliter le développement.
- Contributeurs externes : membres de la communauté qui proposent des contributions via des pull requests, avec des droits d'accès limités pour garantir la sécurité du projet.
- Utilisateurs : personnes qui utilisent le projet. Ils peuvent signaler des bugs ou suggérer des améliorations via les issues, mais n'ont pas de droits d'accès au code.
==== Linting et formatage
Pour garantir la qualité du code et faciliter les contributions, nous avons précisé que le code doit être formaté et linté selon les règles définies dans le README.md.
- Nous avons intégré des outils de linting et de formatage dans les pipelines CI/CD pour automatiser ce processus et assurer une cohérence dans le code soumis par les contributeurs.
- Nous avons également fourni des configurations de linting et de formatage dans les dépôts, ainsi que des scripts npm pour faciliter leur utilisation en local avant de soumettre une pull request.
- Nous encourageons l'utilisation de hooks Git (ex. : lint-staged) pour exécuter automatiquement les vérifications de linting et de formatage avant chaque commit, afin de réduire les erreurs et d'améliorer la qualité du code dès le début du processus de contribution.

Nous utilisons donc les linters/formatters suivants selon les différentes technologies utilisées :
- TypeScript : ESLint et Prettier
- SQL : SQLFluff
- Python : ruff
Des configurations encore plus spécifiques peuvent être définies selon les besoins de chaque composant.

Nous fournissons également un fichier agents.md pour aider les contributeurs à utiliser des agents d'IA (ex. : GitHub Copilot) pour compléter leurs relectures de code, en fournissant des conseils sur les meilleures pratiques et en suggérant des améliorations potentielles. Celui-ci contient les recommandations de linting et de formatage.

=== CI/CD
Chaque dépôt est configuré avec des pipelines CI/CD sur GitHub Actions#footnote[Service GitHub permettant d'exécuter automatiquement des workflows (tests, builds, déploiements) à chaque commit ou pull request.], permettant d'automatiser les tests, les builds et les déploiements. Ces pipelines sont conçus pour garantir la qualité du code et faciliter le processus de contribution.
==== Exemple de pipeline CI/CD
On peut voir ci-dessous un exemple de l'arborescence des fichiers d'un dépôt (voir @annex:cicd-file-tree), avec les différents workflows CI/CD configurés pour les tests, la publication Docker, la notification de mise à jour du monorepo et la mise à jour de la documentation.
Nous allons revenir sur chacun de ces workflows dans les sections suivantes.
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

- *Dependabot* : Le fichier *dependabot.yml* configure la surveillance automatique des dépendances (npm, Docker, GitHub Actions, devcontainers). Des pull requests sont créées automatiquement pour les mises à jour de sécurité, avec une vérification hebdomadaire. La configuration complète est disponible en @annex:dependabot-config
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
Pour faciliter le développement et les tests d'intégration, nous utilisons un fichier docker-compose#footnote[Outil Docker simplifiant le démarrage de plusieurs conteneurs interconnectés à partir d'un fichier YAML. Pratique pour le développement et les déploiements simples.] dans le monorepo de staging qui permet de lancer l'ensemble de l'infrastructure du projet en local. Ce docker-compose intègre tous les composants du projet, ainsi que les services nécessaires pour leur fonctionnement.

Voici les principaux services définis dans le fichier docker-compose.dev.yml (voir @annex:docker-compose-dev), regroupés par catégorie :

- *Bases de données* : `crm-database` (PostgreSQL du CRM), `keycloak-db` (PostgreSQL dédiée à Keycloak#footnote[Serveur open-source d'authentification et d'autorisation (SSO). Gère utilisateurs, rôles, sessions et fournit des protocoles standard (OAuth 2, OIDC).]), `allocation-key-db` (PostgreSQL pour la génération de clés).
- *Services métier* : `crm-backend` (application principale), `allocation-key-generation` (service Python/FastAPI pour les clés de répartition), `allocation-key-generation-worker` (worker asynchrone via NATS JetStream).
- *Authentification* : `keycloak` (serveur d'identité, expose l'interface d'administration sur `8082:8080`), `keycloak-config` (génération de configuration du realm).
- *Stockage et messagerie* : `minio` (stockage compatible S3, ports `8091:9000` et `8092:9001`), `minio-init` (initialisation du bucket), `nats` (broker de messages#footnote[Broker de messages open-source avec support JetStream pour la persistance et la relecture des messages. Alternative légère à RabbitMQ, privilégiée pour sa simplicité de déploiement et son intégration cloud-native.] avec JetStream, ports `8094:4222` et `8095:8222`).
- *API Gateway et proxy* : `krakend` (passerelle API), `krakend-config` (génération de configuration depuis OpenAPI), `reverse-proxy` (Nginx, point d'entrée navigateur).
- *Frontend* : `crm-frontend` (interface utilisateur Angular), `crm-frontend-config` (génération de configuration).
- *Observabilité* : `jaeger` (traçage distribué#footnote[Outil (Jaeger) qui enregistre le chemin des requêtes à travers tous les microservices, permettant de mesurer latences et d'identifier goulots d'étranglement.]), `swagger-doc-gen` et `generation-doc-gen` (génération de documentation OpenAPI).
- *Configuration* : `nginx-config` (adaptation du reverse proxy HTTP/HTTPS).

#figure(
  image("assets/docker-compose-dev.png"),
  caption: [Diagramme — docker-compose de développement],
)

Dans `docker-compose`, l'intégration repose surtout sur trois mécanismes : les profils (`dev` et `init`) pour séparer les services permanents des services d'initialisation, les dépendances `depends_on` pour ordonner le démarrage, et les réseaux Docker pour isoler les communications internes entre le backend, le proxy et les services exposés.

Le mapping des ports permet de rendre accessible chaque service à l'extérieur du réseau Docker, ce qui est essentiel pour le développement. Les développeurs ont aussi accès à une liste des ports utilisés par chaque service dans la documentation du projet, afin de faciliter les tests et le débogage en local.

Il est à noter que dans ce docker-compose, il y a beaucoup de *services de configuration*. Nous reviendrons sur ceux-ci plus tard dans la section dédiée à l'automatisation du déploiement, mais ils sont déjà utilisés dans le docker-compose de développement pour préparer les fichiers de configuration nécessaires au bon fonctionnement de l'infrastructure en local.

==== Test de staging
Le monorepo de staging est utilisé pour intégrer et tester les différentes parties du projet avant de les publier dans leurs dépôts respectifs. En raison de leur temps d'exécution potentiellement très long, nous n'avons pas intégré de pipelines de tests d'intégration automatisés directement sur GitHub.

Néanmoins, nous avons conçu un script nommé `docker-stack.sh` permettant de déployer l'intégralité des composants du projet en environnement local via un fichier Docker Compose. Le docker-compose intégrant des health checks pour chaque service, nous pouvons facilement vérifier que tous les composants fonctionnent correctement ensemble avant de publier les changements dans les dépôts respectifs.

Ce script permet également de réaliser des tests manuels d'intégration, ce qui est particulièrement utile pour les nouvelles fonctionnalités ou les changements majeurs pouvant avoir des impacts importants sur l'ensemble du projet.

Un test complet de staging avec injection de données mockées peut en effet prendre plusieurs dizaines de minutes, car il reconstruit chaque image Docker, puis lance l'ensemble de l'infrastructure.

L'utilisation des submodules prend tout son sens dans ce contexte, car elle nous permet de tester les différentes branches de chaque composant indépendamment, sans avoir à cloner chaque dépôt individuellement ou à gérer manuellement les différentes versions des composants et à les construire manuellement en une commande.

Le code source du script est disponible dans le dépôt du monorepo, et est conçu pour être facilement modifiable en fonction des besoins spécifiques de chaque composant ou de l'infrastructure utilisée pour les tests.#cite(<monorepo72:online>)
==== Automatisation du déploiement

L'automatisation du déploiement est une étape cruciale pour garantir la rapidité et la fiabilité des mises à jour du projet. Nous avons développé une série de services dédiés à la génération automatique des fichiers de configuration, qui s'intègrent directement dans le docker-compose de développement et de production :

- *swagger-doc-gen* : ce service génère la documentation OpenAPI à partir du backend CRM. Les fichiers produits sont utilisés par le service suivant.
- *krakend-config* : ce service génère la configuration de l'API gateway Krakend à partir des spécifications OpenAPI produites par le service précédent. Cela permet de maintenir la configuration de l'API gateway à jour avec les dernières modifications du backend, sans nécessiter d'intervention manuelle.
- *Configuration par templates* : plusieurs services sont dédiés à la génération de fichiers de configuration à partir de modèles et de variables d'environnement :
  - *keycloak-config* : produit le fichier de configuration du realm Keycloak.
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

Un aspect notable de cette configuration est que l'ensemble du déploiement se pilote via un unique fichier `.env`. En complétant une dizaine de champs (identifiants, URLs, ports, secrets), l'utilisateur obtient une infrastructure entièrement fonctionnelle : du reverse proxy à la télémétrie, en passant par l'authentification Keycloak, le stockage MinIO et l'API gateway Krakend. Cette simplicité de configuration réduit considérablement la barrière à l'entrée pour les utilisateurs finaux souhaitant auto-héberger le projet.

Cependant, nous pouvons aisément faire des traductions du docker compose vers d'autres orchestrateurs de conteneurs, notamment :
- Docker Swarm#footnote[Orchestrateur de conteneurs natif Docker. Plus simple que Kubernetes mais moins flexible. Gère scaling, failover et load-balancing.] : 
Docker Swarm est très proche de docker compose, et la plupart des fonctionnalités utilisées dans notre docker-compose sont compatibles avec Docker Swarm. Cela nous permet de déployer notre infrastructure sur un cluster Docker Swarm sans nécessiter de modifications majeures, en utilisant simplement le même fichier docker-compose avec quelques ajustements mineurs pour les spécificités de Swarm (ex. : utilisation de secrets, configuration des services en mode swarm, etc.).
- Kubernetes#footnote[Orchestrateur de conteneurs open-source (CNCF). Gère déploiement, scaling automatique, et résurrection des pods. Standard de l'industrie pour production cloud.] :
En utilisant l'outil fourni par docker : *Docker Compose Bridge* #cite(<Usethede7:online>), qui permet de convertir un fichier docker-compose en une configuration compatible avec d'autres orchestrateurs de conteneurs. Cela nous offre une grande flexibilité pour déployer notre infrastructure sur différentes plateformes, en fonction des besoins spécifiques de chaque environnement (développement, staging, production).

La version de production introduit plusieurs services absents du développement :
- *optimce-migrator* : service de migration de base de données exécuté une seule fois pour appliquer les évolutions du schéma CRM. Il utilise un outil de migration Python (alembic) pour garantir la cohérence entre les versions du code et de la base de données.
- *keycloak-healthcheck* : sidecar dédié à la vérification de l'état de Keycloak via son endpoint `/health/ready`. Ce service permet de retarder le démarrage du backend CRM jusqu'à ce que Keycloak soit pleinement opérationnel.
- *certbot* : service de gestion automatique des certificats SSL/TLS via le protocole ACME de Let's Encrypt. Il utilise la méthode webroot pour valider le domaine sans interrompre le service.
- *keycloak-group-id-mapper* et *keycloak-optimce-theme* : services d'initialisation qui téléchargent respectivement le plugin de mapping de groupes Keycloak et le thème visuel OptimCE, garantissant que les artefacts sont disponibles avant le démarrage de Keycloak.
- *crm-database-backup* et *keycloak-db-backup* : services de backup exécutés sur demande (profil `backup`) qui exportent les bases de données via `pg_dump` dans un répertoire persistant.
=== Déploiement réel

La version actuellement déployée est basée sur Docker Compose et hébergée sur un VPS#footnote[Serveur privé virtuel (équivalent EC2 d'Amazon)] chez Hostinger#footnote[Hébergeur low-cost européen]. Nous avons retenu cette solution pour trois raisons principales :
- La souveraineté des données : l'hébergement en Europe garantit le respect du RGPD.
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

Nous avons cependant conservé la compatibilité avec un orchestrateur plus avancé. Si la demande émerge, par exemple pour une offre SaaS#footnote[Software as a service : modèle de monétisation où une application est hébergée par un fournisseur et accessible via un abonnement], la migration vers Kubernetes est prévue via l'outil Docker Compose Bridge.

== Contributions connexes

En plus du travail principal sur l'architecture et l'infrastructure d'OptimCE, nous avons participé à plusieurs contributions connexes :
=== Intégration de Keycloak et gestion de l'authentification

L'authentification et l'autorisation du projet reposent sur Keycloak, un serveur open-source d'identité et d'accès. Son intégration a nécessité des décisions architecturales autour des standards OAuth 2.0 et OpenID Connect (OIDC).

==== OAuth 2.0 et OpenID Connect

OAuth 2.0 est un standard d'autorisation qui définit les mécanismes de partage d'informations et d'interaction entre services. Il ne gère pas directement l'authentification, mais permet à une application d'obtenir un accès limité à un compte utilisateur auprès d'un service.

OpenID Connect (OIDC) complète OAuth 2.0 en ajoutant une couche d'authentification standardisée. Il impose l'ajout d'un troisième jeton, l'`id_token`, contenant les informations d'identité de l'utilisateur. L'avantage principal d'OIDC est l'interopérabilité : grâce à la standardisation des claims#footnote[Revendications standardisées dans le payload du JWT], il est possible de changer de fournisseur d'identité sans modifier l'application cliente.

==== Mécanismes de vérification des jetons

Notre architecture supporte deux approches pour la vérification des jetons d'accès :

- *Jetons auto-contenus (JWT)* : Le jeton contient toutes les informations nécessaires (scopes, permissions, identité). Il est signé par le serveur d'autorisation et peut être vérifié localement par les microservices grâce à la clé publique, sans appel réseau supplémentaire. Seul le refresh token nécessite une vérification auprès du serveur OAuth pour contrôler d'éventuelles révocations.
- *Jetons opaques* : Le jeton ne contient aucune information lisible. Le backend doit interroger le serveur d'autorisation via une route d'introspection pour vérifier sa validité à chaque requête.

Nous avons retenu l'approche JWT auto-contenu pour sa performance, car elle évite un appel réseau synchrone à chaque requête authentifiée.

==== Claims personnalisés et gestion des groupes

Le projet nécessite la transmission d'un identifiant de communauté (`group_id`) via le JWT, ce qui dépasse le scope standard d'OIDC. Plusieurs approches ont été évaluées :

- *Claims personnalisés dans le JWT* : Ajouter directement le `group_id` dans le payload du jeton via un mapper Keycloak. Cette approche est simple à maintenir et supportée nativement par la majorité des clients OIDC. Cependant, elle produit des jetons plus volumineux, ce qui peut poser problème si un utilisateur appartient à un grand nombre de groupes (risque de dépassement des limites d'en-têtes HTTP).
- *Middleware de groupes* : Ajouter un intermédiaire qui enrichit les requêtes authentifiées avec les informations de groupes. Cette approche n'apportait pas de bénéfice significatif dans notre architecture.
- *Gestion backend* : Chaque microservice gère indépendamment les permissions communautaires. Cette solution ajouterait de la complexité à chaque service sans réel avantage.

Nous avons retenu l'approche des claims personnalisés via un plugin Keycloak (`kc-groupid-mapper`), téléchargé automatiquement lors de l'initialisation du conteneur.

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

Nous avons retenu l'approche par thèmes personnalisés, qui offre le meilleur équilibre entre sécurité, maintenabilité et expérience utilisateur. Toutes les fonctionnalités de l'interface sont disponibles via l'API REST de Keycloak, mais l'approche par redirection reste plus robuste pour la gestion des sessions et la sécurité.

=== Swagger2Krakend
Swagger2Krakend est un outil que nous avons développé pour automatiser la génération des configurations de l'API gateway Krakend à partir de spécifications OpenAPI.

Il s'agit d'un projet open-source repris dans le monorepo et qui est utilisé dans les pipelines de développement et de production pour maintenir le tout à jour.

Cet outil est développé en Python et permet de spécifier via un fichier de configuration YAML les différentes règles à appliquer sur les spécifications de différentes API définies dans le format OpenAPI.

Par exemple, il est possible de sécuriser la connexion d'une API en spécifiant qu'elle doit vérifier le JWT#footnote[JSON Web Token: Format de jeton d'authentification sécurisé et signé utilisé pour valider l'identité d'un utilisateur/service] pour toutes les connexions entrantes sur un endpoint donné, ou d'appliquer du rate-limiting#footnote[Mécanisme de contrôle du nombre de requêtes autorisées sur une période donnée]. Ce petit outil a été conçu initialement dans un souci de gain de temps, mais il nous a également permis de faire évoluer l'infrastructure et de la sécuriser rapidement.

Son amélioration et son intégration dans les pipelines est une étape essentielle de nos processus de développement et de déploiement.
=== Outils pipeline docker

Certains services ont nécessité le développement de petits outils pour préparer leurs fichiers, ou l'utilisation de sidecars#footnote[Conteneur auxiliaire d'un autre conteneur qui partage des ressources avec le conteneur principal. Dans des objectifs de monitoring, configuration, etc.].

- *Génération de fichiers de configuration à partir de templates* : Kubernetes dispose d'une solution native pour ce problème (ConfigMap), mais celle-ci n'existe pas dans l'écosystème Docker. Nous avons donc créé des fichiers templates pour chaque configuration à modifier automatiquement, puis utilisé l'utilitaire Unix `envsubst` (fourni par le paquet `gettext`) pour remplacer les variables d'environnement par leurs valeurs actuelles et produire le fichier de configuration final. Ce fichier est ensuite monté dans le conteneur correspondant. Nous avons créé une image OCI#footnote[Format de conteneur standardisé] minimale contenant cet utilitaire (voir @annex:envsubstub-dockerfile).
- *Vérification des healthchecks* : Docker Compose propose une fonctionnalité de healthcheck, mais elle repose sur l'exécution de scripts à l'intérieur du conteneur cible. Nous avons donc créé des sidecars dédiés qui vérifient l'état des services en utilisant un conteneur minimal ne contenant que `curl`.
=== Ajout de fonctionnalités

Nous avons également contribué au développement de fonctionnalités et à la correction de bugs :
- Ajout de routes de healthcheck pour les services qui n'en disposaient pas, notamment le backend CRM.
- Création de l'annuaire de communautés d'énergie, incluant la modification de l'interface Angular et l'ajout de la logique backend pour gérer les accès à la base de données.

=== Unification de thèmes

Nous avons unifié les thèmes Keycloak avec celui du frontend afin d'offrir une identité visuelle cohérente à l'ensemble du projet.
=== Projet EMS Global

Nous avons participé aux décisions d'architecture du projet EMS Global, notamment les choix technologiques, la logique d'authentification et d'autorisation et son intégration avec le reste du projet.

==== EcoArbiter

Nous avons développé EcoArbiter, une alternative au projet de redistribution énergétique en temps réel proposé par les étudiants en fin d'études de l'ULiège. Il s'agit d'un projet écrit en Rust qui implémente une logique de distribution équitable de l'énergie entre différents EMS locaux, dans l'objectif de maximiser l'autoconsommation collective.

Ce projet a été développé car l'algorithme initial présentait plusieurs limitations : une latence élevée, l'absence de prise en compte des notions de parité entre utilisateurs, et un code source non public. EcoArbiter est publié en open-source sous licence Apache 2.0 et conçu pour être facilement intégrable au reste du projet.

===== Algorithme de distribution

L'algorithme est conçu pour privilégier une latence faible plutôt qu'une réponse systématiquement exacte, ce qui est essentiel pour une logique de distribution mise à jour à haute fréquence. La complexité de la fonction `recalculate_allowances` est en O(n log n) dans le pire des cas, dominée par le tri des indices déficitaires. Cette complexité permet de traiter des centaines d'entités en quelques millisecondes.

#figure(
  image("assets/emsg-logic.png", height: 15cm),
  caption: [Workflow de l'algorithme de distribution d'EcoArbiter],
)

L'algorithme distingue trois scénarios :
- *Déficit* (scénario 1) : la production totale est inférieure à la consommation. Aucune allowance n'est distribuée.
- *Excédent* (scénario 2) : la production excède la consommation totale, y compris la consommation élastique. Chaque consommateur reçoit sa consommation élastique maximale.
- *Insuffisant* (scénario 3) : la production couvre partiellement la consommation élastique. L'algorithme répartit équitablement le surplus via une approche itérative garantissant une distribution mathématiquement correcte.
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

Ces corrections, validées automatiquement par les tests CI avant intégration, ont renforcé significativement la surface d'attaque du projet.

=== Signature des images

La signature des images Docker avec Cosign garantit l'intégrité et la provenance des artefacts déployés. Chaque image publiée est signée avec une clé sans serveur (keyless) via Sigstore, permettant à quiconque de vérifier que l'image provient bien du pipeline CI/CD officiel et n'a pas été modifiée après publication.

== Expérience développeur

Dès le mois de décembre, le projet avait atteint un niveau de fonctionnalité satisfaisant. Cependant, la complexité de l'architecture initiale rendait l'ajout de nouvelles fonctionnalités, voire même la réalisation de simples modifications, particulièrement laborieuse. Chaque changement nécessitait d'intervenir dans de multiples composants fortement couplés, augmentant le risque de régressions et le temps de développement.

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
- *Mises à jour des dépendances* : Dependabot surveille les dépendances npm, Docker, GitHub Actions et devcontainers, créant automatiquement des pull requests pour les mises à jour de sécurité.
- *Analyse statique* : CodeQL scanne le code à chaque contribution pour détecter les vulnérabilités connues (injections SQL, XSS, etc.).

=== Segmentation réseau

La politique de communication entre services a été renforcée dans la version de production. Alors que l'environnement de développement utilise deux réseaux (`backend` et `reverse-proxy`), la production en déploie cinq pour une isolation plus fine :
- *api-gateway* : réseau partagé entre Krakend, le backend CRM et le reverse-proxy.
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

Bien que l'architecture soit conçue pour être compatible avec Kubernetes (via Docker Compose Bridge), la migration effective n'a pas été réalisée. Le déploiement actuel repose sur Docker Compose chez un hébergeur VPS. Si la demande pour une offre SaaS émerge, cette migration deviendra nécessaire et impliquera un travail supplémentaire significatif.

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
- *Compensation plutôt que transactions distribuées* : En cas d'erreur, il faut implémenter des événements de compensation pour annuler les opérations précédentes, car les transactions ACID distribuées (2PC) ne sont pas viables à grande échelle.
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
- *Accès "Just-in-Time"* : Génération de credentials à durée de vie limitée (TTL) avec révocation instantanée en cas de suspicion de compromission, réduisant considérablement la fenêtre d'attaque.

Les modèles de livraison identifiés incluent :
- *Zero-Touch (Agent Injector)* : Injection d'un sidecar qui expose les secrets comme des fichiers locaux, gérant automatiquement l'authentification et la rotation.
- *Platform-Native (CSI Driver)* : Montage des secrets comme volumes Kubernetes, plus léger que l'approche sidecar.
- *App-First (SDK)* : Intégration directe de l'API Vault dans le code applicatif, gardant les secrets en mémoire vive uniquement.

Cependant, cette approche a été rejetée pour plusieurs raisons :
- *Complexité disproportionnée* : L'ajout d'un serveur Vault, sa configuration initiale et la gestion des politiques d'accès introduisent une surcharge opérationnelle significative pour un déploiement sur VPS unique.
- *Dépendance à l'orchestrateur* : Les modèles les plus élégants (sidecar injector, CSI driver) sont intrinsèquement liés à Kubernetes et ne sont pas directement transposables à Docker Compose sans outils tiers complexes.
- *Surcharge applicative* : Le modèle SDK nécessiterait de modifier chaque microservice pour gérer l'authentification Vault, la rotation des tokens et les fallbacks en cas d'indisponibilité.
- *Sécurité suffisante* : Pour le contexte actuel, l'utilisation des secrets Docker Compose combinée à des variables d'environnement injectées au runtime offre un niveau de sécurité acceptable sans la complexité de Vault.

Cette décision pourrait être réévaluée si le projet évolue vers une offre SaaS multi-locataires ou si les exigences de conformité imposent une rotation automatique des credentials.

== Propositions d'évolution architecturale

Bien que le refactoring actuel ait considérablement simplifié l'architecture, plusieurs évolutions ont été identifiées pour améliorer la maintenabilité et les performances à long terme.

=== Consolidation du service CRM

Le refactoring actuel a déjà fusionné les composants users, community et partage au sein du CRM. Une étape supplémentaire consisterait à intégrer la base de données PostgreSQL directement dans le conteneur backend, éliminant ainsi le conteneur `crm-database` dédié. Cette consolidation réduirait les appels synchrones internes et simplifierait le déploiement en supprimant un service intermédiaire.

Par ailleurs, la gestion des membres, des communautés et certaines opérations de gestion des clés pourraient être entièrement centralisées dans le CRM, tandis que la génération de clés de répartition, la simulation et le service d'identité (Keycloak) resteraient des services distincts.

=== Séparation stricte de l'identité et des autorisations

Bien que les entités utilisateurs aient été fusionnées dans le CRM, le service d'identité (Keycloak) doit rester strictement isolé. Cette séparation garantit que l'authentification reste opérationnelle même en cas de panne du CRM. Les autorisations sont communiquées aux services métier via les claims du JWT. Les synchronisations entre les données d'identité Keycloak et les informations membres du CRM (ex. : mise à jour d'email) sont gérées de manière asynchrone via un pipeline d'événements, évitant ainsi les couplages forts.

=== Intégration de nouveaux micro-services

L'ajout de nouvelles fonctionnalités doit suivre une logique de micro-services indépendants lorsqu'ils présentent des besoins techniques spécifiques ou un cycle de vie différent :

- *Génération de clés et simulation* : Conservés comme micro-services séparés pour des raisons techniques (langages différents, besoins asynchrones).
- *Gestion documentaire* : Les documents sont liés aux utilisateurs mais indépendants du CRM. Le stockage de fichiers devrait reposer sur une solution open-source dédiée, avec une mise en file d'attente des requêtes pour le stockage long terme.
- *Génération de templates* : Divisé en deux composants : un collecteur d'actions (ex. : ajout d'un utilisateur à une communauté) stockant les snapshots dans une base NoSQL, et un générateur produisant les documents finaux. Ce service devrait rester indépendant pour éviter d'alourdir le CRM.
- *Notifications* : Conservé séparément car asynchrone par nature (SMTP, SMS, WebSocket). Il ne dépend que des données utilisateurs et peut tolérer des interruptions sans impacter le reste du système.

=== Gestion de la consistance des données

Le principal avantage d'une architecture monolithique est la consistance instantanée des données, au prix d'un scaling complexe. Dans notre contexte, si un unique fournisseur (wallon ou belge) dessert plusieurs communautés avec un grand nombre d'utilisateurs concurrents, le modèle distribué reste pertinent malgré la complexité accrue de gestion de la consistance. L'approche asynchrone par événements et la tolérance à la consistance éventuelle (eventual consistency) offrent un compromis acceptable entre performance et résilience.

== Perspectives d'amélioration

Plusieurs axes d'amélioration ont été identifiés pour les développements futurs :
- Intégration d'un système de télémétrie (Prometheus + Grafana) pour mesurer les performances de manière objective
- Automatisation des tests d'intégration dans un pipeline CI/CD nightly
- Mise en place d'un environnement de démo public pour faciliter l'adoption
- Développement de la documentation utilisateur (guides d'installation, tutoriels)
- Exploration d'une migration Kubernetes si la demande pour une offre SaaS émerge

=== Processus de mise à jour automatisé

Un mécanisme de mise à jour automatisé a été planifié pour faciliter la maintenance des instances déployées. Ce système reposerait sur plusieurs principes :

- *Versionnage sémantique* (`x.y.z`) : les versions majeures signalent des changements potentiellement incompatibles, les mineures des évolutions impactant la base de données, et les patchs des corrections mineures. Les versions `-rc` (release candidate) seraient réservées aux tests développeurs.
- *Mode maintenance* : lors d'une mise à jour, l'application basculerait en lecture seule ou afficherait une page de maintenance.
- *Sauvegarde pré-migration* : un dump automatique de la base de données serait généré avant toute migration, stocké sur un bucket S3 tiers pour permettre un rollback rapide.
- *Mécanisme d'updater* : la containerisation des composants permettrait un auto-pull des nouvelles images et un auto-restart des services (déjà implémenté). Des scripts internes pourraient être ajoutés pour détecter les changements de version, appliquer les migrations, vérifier le bon fonctionnement post-migration et effectuer un rollback automatique en cas d'échec.

= Conclusion

Ce mémoire a présenté la transition du projet OptimCE, composant clé du projet de recherche Locomotrice, vers un modèle open-source pérenne et collaboratif. Le travail réalisé s'est articulé autour de plusieurs axes majeurs.

Sur le plan technique, nous avons procédé à une restructuration profonde de l'architecture du projet. L'analyse initiale a révélé un anti-pattern de monolithe distribué, caractérisé par une complexité opérationnelle excessive et des appels synchrones nombreux entre micro-services. La fusion des composants redondants (utilisateurs, communauté, opérations de partage) en un service CRM unifié, combinée à la suppression des services backend-db intermédiaires, a permis de réduire significativement cette complexité. Les résultats sont tangibles : la consommation mémoire est passée de 3 Go à 800 Mo à vide, et la maintenabilité du code s'en trouve considérablement améliorée.

L'organisation du code source a également été repensée. La séparation en dépôts Git indépendants au sein d'une organisation GitHub dédiée offre une modularité et une réutilisabilité accrues, tout en facilitant la contribution externe. Chaque dépôt dispose désormais de pipelines CI/CD automatisés incluant tests unitaires, analyse de sécurité via CodeQL, mises à jour automatiques des dépendances avec Dependabot, et publication d'images Docker signées avec Cosign.

Le développement d'un monorepo de staging, basé sur les sous-modules Git, a permis de résoudre le défi de synchronisation entre les composants indépendants. Couplé à un docker-compose de développement complet, il offre un environnement de test et d'intégration reproductible, accessible en une seule commande. L'automatisation du déploiement, via des scripts de génération de configuration et l'outil Swagger2Krakend développé pour l'occasion, garantit une infrastructure cohérente et à jour entre les environnements de développement et de production.

La gouvernance du projet a été structurée autour d'une licence Apache 2.0, d'une politique de contribution claire définissant les rôles (mainteneurs, contributeurs internes et externes, utilisateurs), et d'outils de qualité logicielle (linting, formatage, hooks Git). Ces éléments sont essentiels pour encourager et faciliter les contributions externes.

Sur le plan communautaire, les fondations ont été posées pour accueillir et fidéliser les contributeurs. La documentation adaptée à différents publics (développeurs, chercheurs, entreprises), les canaux de communication structurés (issues GitHub, forums) et les processus de revue de code transparents créent un environnement propice à la collaboration. L'organisation GitHub OptimCE centralise l'ensemble de ces éléments et offre une vitrine claire pour le projet. La réussite de cette transition open-source dépendra désormais de la capacité à fédérer une communauté active autour du projet, en maintenant un équilibre entre l'accessibilité pour les nouveaux venus et la rigueur technique nécessaire à la qualité du code.

Notre participation s'est étendue au-delà du périmètre initial d'OptimCE, notamment avec le développement d'EcoArbiter, un algorithme de redistribution énergétique en temps réel écrit en Rust, conçu comme une alternative performante et équitable au projet proposé par l'ULiège dans le cadre du sous-projet EMS Global.

Les objectifs fixés en début de stage ont été atteints : le projet OptimCE est désormais stable, modulaire, documenté et prêt à être adopté par une communauté open-source. En résumé, nous avons transformé un prototype de recherche complexe et fragile en une solution robuste, simple à déployer et ouverte à la contribution collective — les trois piliers indispensables à sa pérennité.

Les perspectives futures incluent l'élargissement de la communauté de contributeurs, l'évolution vers un déploiement Kubernetes si la demande le justifie (notamment pour une offre SaaS), et l'intégration continue des retours des utilisateurs finaux pour guider les développements futurs. La transition vers l'open-source n'est pas un aboutissement, mais le début d'un processus d'amélioration continue qui devra être entretenu par la communauté.

= Déclaration d'utilisation de l'IA

Conformément aux consignes institutionnelles, nous déclarons avoir utilisé des outils d'intelligence artificielle (GitHub Copilot, agents d'IA de type LLM) de manière limitée pour :
- La reformulation et la correction orthographique et grammaticale de certaines sections.
- La recherche préparatoire de références bibliographiques et de bonnes pratiques techniques.
- La vérification de syntaxe Typst et la mise en forme du document.

La problématique, la méthodologie, l'analyse architecturale, les résultats et les conclusions de ce mémoire sont entièrement le fruit de notre travail personnel et de notre réflexion.
