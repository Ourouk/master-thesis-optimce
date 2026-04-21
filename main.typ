#import  "template/template.typ":  *

#show: project.with(
  main-title: "De la recherche à l'open source : une approche structurée pour la pérennisation",
  sub-title: "Restructuration technique, intégration continue et gouvernance pour l'open source",
  fullTitlePage: true,
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ingénieur Industriel",
      specialty: "Génie Électrique Informatique",
    ),
  ),
  thanks: (
    (
      first-name: "",
      last-name: "",
      role: "",
    )
  ),
  bibliography-file: "../ref.bib",
)
= Abstract

Ce Travail de Fin d'Études présente la transition du projet Locomotrice, développé en contexte académique, vers un modèle open source. L'objectif est de restructurer le projet pour le rendre accessible, maintenable et adaptable à une communauté diversifiée (recherche, entreprises).

== Problématique

Les défis incluent :
- Licence : Choix d'une licence open source adaptée aux usages communautaires et commerciaux.
- Qualité du code : Amélioration de la lisibilité, modularité et expérience développeur.
- Reproductibilité : Simplification de l'infrastructure pour une installation fluide.
- Documentation : Création de ressources claires pour différents publics.
- Tests : Mise en place de tests unitaires et d'intégration pour garantir la stabilité.
- Communication : Stratégie de promotion pour maximiser l'adoption.
- Gouvernance : Processus collaboratifs pour un développement efficace.

== Méthodologie

L'approche combine :
- Audit architectural : Identification d'anti-patterns (ex. : Distributed Monolith).
- Refactoring : Fusion de composants redondants (ex. : Backend Database et Backend).
- DevOps : Intégration de CI/CD et automatisation.
- Outils : Développement de solutions pour le déploiement et la collaboration.
- Benchmarking : Étude des bonnes pratiques de projets open source établis.

== Méthodologie

À l'issue de ce travail, le projet Locomotrice est transformé en une solution stable, modulaire et aisément réutilisable, caractérisée par une complexité technique réduite. Cette restructuration favorise son adoption par la communauté open source, tout en assurant sa pérennité et en établissant les fondations d'une gouvernance collaborative et scalable.

= Introduction
Ce mémoire s'inscrit dans le cadre de la mise en open source du projet *OptimCE*, un composant clé du projet *Locomotrice*. L'objectif principal d'OptimCE est de fournir une plateforme administrative de gestion de membres et d'informations spécifiques à la gestion d'une communauté d'énergie.

L'entreprise repreneuse a demandé que le projet soit codé en :
- *Node.js*
- *Kubernetes*
Sans préférence particulière sur la gestion des databases. Nous reviendrons tout au long du projet sur ces décisions.

Le projet *OptimCE* atteint un niveau de maturité technologique (TRL) de 7 #cite(<Horizon_Europe_2026_gouv>). Ce niveau indique que le projet est proche d'un rendu opérationnel, prêt à être déployé en production. Initialement, ce développement était prévu pour être réalisé par un seul développeur dans le cadre interne de la Haute École de la Province de Liège (HEPL).


C'est dans ce cadre que s'inscrit mon mémoire, dont l'objectif est d'aider à la réalisation de ce deliversable.

= Présentation de l'entreprise et du stage
== L'organisation

=== Entreprise
Le CeCoTePe (Le Centre de Coopération Technique et Pédagogique) est une ASBL qui encadre des formations professionnelles continues, ainsi que de la recherche. Dans le cadre de la recherche, la HEPL et le CeCoTePe ont une collaboration étroite.#cite(<cecotepe>)
=== Projet Locomotrice
Le projet Locomotrice est un projet de recherche financé grâce à l'appel à Projet Win2Wal incluant le CeCoTePe, l'équipe BEMS (Uliège) et Émission Zéro en tant que partenaire industriel.

Dont l'objectif est de tracer la voie vers une transition énergétique participative et efficace! En développant un logiciel open source en collaboration avec l'Université de Liège et des coopératives citoyennes, il permettra de maîtriser et d'opérationnaliser les actions des citoyens engagés dans la transition énergétique. Intégrant les communautés d'énergie, ce projet offre une plateforme novatrice pour mobiliser les citoyens et les impliquer activement dans la construction d'un avenir énergétique durable.#cite(<locomotrice>)

Concrètement le projet a deux parties :
- OptimCE - sur lequel la majorité du travail a été effectué. Réalisé par le CeCoTePe avec le support de l'équipe EMS de l'université.
- EMS - Energy Management System, sous-projet domotique de contrôle de la consommation électrique. Géré par l'université avec le support de l'équipe « IT » du CeCoTePe.

= Cadre du stage
== Lieux
Le stage s'est déroulé au sein des locaux de l'ISIL (Institut Supérieur Industriel de Liège), où un bureau dédié a été mis à disposition pour la réalisation des missions.

== Cadre Temporelle
- Durée : Le stage s'est étendu sur une période de 8 mois, d'octobre à mai.
- Rythme :
  - Temps partiel jusqu'en décembre (pour permettre une transition progressive).

  - Temps plein à partir du deuxième quadrimestre (janvier à fin avril), afin de s'investir pleinement dans les projets confiés.
== Encadrement
Le stage a été encadré par Eric Paques lors de communications régulières.

Le projet étant fait en partie en collaboration avec l'Université de Liège, des réunions avec ceux-ci étaient organisées hebdomadairement. 
= Problématique, objectifs et enjeux
== Problématique
=== Problématique générale

Le projet Locomotrice, initialement développé dans un cadre de recherche, doit être rendu open source afin d'être accessible à la communauté d'utilisateurs ainsi qu'aux entreprises susceptibles de le reprendre. Cette transition hors du contexte académique pose plusieurs défis majeurs.

=== Problématiques spécifiques

- Licensing
Comment choisir une licence open-source compatible avec les usages envisagés (usage communautaire, usage commercial, contributions externes) et sécuriser juridiquement la publication du code ?

- Lisibilité et qualité du code / Developer Experience 
Comment rendre un code historiquement développé par une équipe de recherche, souvent hétérogène et non formaté, plus lisible, cohérent et maintenable ?

- Reproductibilité et portabilité du projet
Comment réduire la complexité actuelle du projet pour permettre une installation simple ?

- Comment structurer l'architecture du code pour la rendre compréhensible par des développeurs externes ?
Quelle infrastructure minimale de développement et de production est nécessaire pour garantir une reproductibilité complète ?

- Documentation
Comment fournir une documentation claire, complète (installation, API, architecture, exemples), et adaptée à différents publics (développeurs, chercheurs, entreprises) ?

- Testing et qualité logicielle
Comment mettre en place une stratégie de tests (unitaires, intégration) permettant d'améliorer la qualité, détecter les régressions et renforcer la confiance dans le projet ?

== Les objectifs
En tant qu'ingénieur en informatique, mon objectif est de préparer la transition du projet Locomotrice vers une diffusion open-source. Pour cela, mon travail se concentre sur :

- L'amélioration de l'architecture et de la structure du code, afin de rendre le projet plus clair et modulaire.

- La lisibilité et la qualité du code, via des bonnes pratiques et des outils de vérification.

- La mise en place d'une infrastructure reproductible, facilitant l'installation, le développement et l'exécution du projet.

- La réduction de la complexité générale, pour simplifier l'adoption et la contribution par la communauté.

- L'objectif global est de rendre le projet stable, compréhensible et facilement réutilisable en open-source.
= Méthodologie
== Suivi du projet
Le suivi du projet a été effectué sur *Notion* (gestionnaire de projet et de notes). C'est similaire dans son fonctionnement à Trello ou Taiga.

#figure(
image("assets/Notion01.png"),
caption: [Notre Kanban pour gérer l'avancement et notre dette technique],
)

Un autre aspect du suivi du projet a été le processus de prise de décisions avec des étapes documentées :
#figure(
  image("assets/Notion02.png",height: 5cm),
  caption: [Documentation partiellement organisée autour des décisions prises],
)
Une bonne partie de ce mémoire a notamment été écrite en relisant les recherches en amont des différentes implémentations.

= Travail réalisé
== Review du code et analyse de l'architecture

L’analyse initiale du code-source a révélé que l’architecture microservice, bien qu’adaptée aux grandes équipes et aux déploiements cloud natifs, pose plusieurs défis majeurs dans le cadre d’un projet open source.

Conçue pour offrir :
- résilience
- scalabilité
- un déploiement indépendant des composants
mais cette architecture introduit une complexité opérationnelle accrue, notamment en matière de tests, de compréhension globale du système et de maintenance.

Chaque microservice, bien que faiblement couplé et déployable individuellement, nécessite une gestion fine des interconnexions, des protocoles de communication et des mécanismes de tolérance aux pannes, ce qui peut rendre le projet difficile à appréhender pour de nouveaux contributeurs ou pour une équipe composée de peu de développeur.

Elle nécessite donc une infrastructure et une culture de développement orientée grande équipe et/ou entreprise. Un autre problème est que l'on a aucune certitude que le produit soit voué à être déployé comme un SaS, il pourrait très bien suivre une architecture self-hosted.
=== Illustration du problème
Lors de la division initiale, sur papier le code paraissait assez simple à suivre avec des frontière claire entre les composants. 
#figure(
  image("assets/architecture_simple.png"),
  caption: [Architecture initialement prévue]
)
Hors cette division est un domaine de recherche à part entière nommé *Domain Driven Design* (DDD) #cite(<2026_microsoft>). Son objectif est d'étudier l'interaction et la définition des objets au sein d'un codebase, d'un produit.

L'objectif principal, pour résumer, est d'éviter que plusieurs services référencent un même objet de manière identique donc qu'ils aient les même besoins. 
L'intérêt du micro-service est principallement lorsque ces services manipulent les objet de façon totalement différente et ne le définissent même pas de la même manière.

Ce qui permet une communication Asynchrone où les données sont partiellement/entièrement
copiée et modifée à travers un bus de communication.
#figure(
  image("assets/micro-service.png"),
  caption: [Une vrai impémentation micro-service]
)
Soyons honnêtes cette analyse est complexe, et dans le cas de ce projet où le domaine évolue durant le projet et où l'on avait une idée incomplète de l'ensemble du projet. A été mal défini menant à une augmentation graduelle de la complexité.
== Proposition de modifications
== Fusion de composants
Devant la complexité du projet, et dans l'objectif d'améliorer la lisibilité et l'expérience développeur, nous avons entrepris un gros refactoring.

Le projet était tombé dans un anti-design-pattern : le Distributed Monolith #cite(<Algolia_2026_dev>).
Des parties du projet étant trop proches au niveau du domaine d'analyse et réclamant techniquement trop d'appels synchrones.
== Refactoring architectural

= Résultats et analyse
= Discussion et apports personnels
= Revue théorique
Dans ce chapitre je vais reprendre toutes les notions nécessaires à la compréhension du Travail de fin d'études.
== Microservices
L'architecture microservices consiste à découper une application en sous-composants peu interdépendants. Les processus de reconstruction et de redéploiement sont partiels, et les services communiquent à travers des API bien définies.

Cette approche offre une meilleure résilience et permet à plusieurs équipes de travailler de manière autonome sur une même application. Enfin, cette architecture favorise la cohabitation de technologies différentes au sein d'un même projet#cite(<Claytonsiemens77_2026_microsoft>).
=== Communication Synchrone
Type de communication où l'émetteur attend une réponse immédiate pour poursuivre son traitement. On parle de communication bloquante, car le flux d'exécution est suspendu tant que la réponse n'a pas été reçue.

=== Communication Asynchrone
Type de communication où l'émetteur transmet une requête et poursuit ses activités sans attendre de retour immédiat. Il s'agit d'une communication non bloquante, permettant de traiter la réponse ultérieurement (via une notification ou un système de rappel).

== Architecture Modulaire Monolithique
=== Object–relational mapping
=== Modular Add-on System
== CQRS

Le pattern *Command Query Responsibility Segregation* (CQRS) sépare les opérations de lecture et d'écriture en modèles distincts. Cela permet d'optimiser les performances selon le type d'opération et de faciliter l'évolution indépendante de chaque côté.

== Domain Driven Design

 

 #link("https://learn.microsoft.com/en-us/azure/architecture/microservices/model/domain-analysis")[Domain Analysis for Microservices]

=== Fusion des modules Backend Database et Backend
=== Fusion des modules Members et Community