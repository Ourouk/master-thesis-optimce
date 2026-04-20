#import  "template/template.typ":  *

#show: project.with(
  main-title: "Structurer pour pérenniser",
  sub-title: "Mise en open-source d'un projet de recherche",
  fullTitlePage: false,
  authors: (
    (
      first-name: "Andrea",
      last-name: "Spelgatti",
      cursus: "M. Ing. Ind. - G. Électrique Informatique",
    ),
  ),
  bibliography-file: "../ref.bib",
)
= Abstract
= Introduction
= Présentation de l’entreprise et du stage
== L’organisation
=== Entreprise
=== Projet Locomotrice
== Le cadre du stage
=== Objectif
=== La durée du stage
=== La place de votre travail dans l’entreprise
=== Les outils ou logiciels utilisés
= Problématique, objectifs et enjeux
== Problématique
=== Problématique générale

Le projet Locomotrice, initialement développé dans un cadre de recherche, doit être rendu open source afin d’être accessible à la communauté d’utilisateurs ainsi qu’aux entreprises susceptibles de le reprendre. Cette transition hors du contexte académique pose plusieurs défis majeurs.

=== Problématiques spécifiques

- Licensing
Comment choisir une licence open-source compatible avec les usages envisagés (usage communautaire, usage commercial, contributions externes) et sécuriser juridiquement la publication du code ?

- Lisibilité et qualité du code / Developer Experience 
Comment rendre un code historiquement développé par une équipe de recherche, souvent hétérogène et non formaté, plus lisible, cohérent et maintenable ?

- Reproductibilité et portabilité du projet
Comment réduire la complexité actuelle du projet pour permettre une installation simple ?

- Comment structurer l’architecture du code pour la rendre compréhensible par des développeurs externes ?
Quelle infrastructure minimale de développement et de production est nécessaire pour garantir une reproductibilité complète ?

- Documentation
Comment fournir une documentation claire, complète (installation, API, architecture, exemples), et adaptée à différents publics (développeurs, chercheurs, entreprises) ?

- Testing et qualité logicielle
Comment mettre en place une stratégie de tests (unitaires, intégration) permettant d’améliorer la qualité, détecter les régressions et renforcer la confiance dans le projet ?

== Les objectifs
En tant qu’ingénieur en informatique, mon objectif est de préparer la transition du projet Locomotrice vers une diffusion open-source. Pour cela, mon travail se concentre sur :

- L’amélioration de l’architecture et de la structure du code, afin de rendre le projet plus clair et modulaire.

- La lisibilité et la qualité du code, via des bonnes pratiques et des outils de vérification.

- La mise en place d’une infrastructure reproductible, facilitant l’installation, le développement et l’exécution du projet.

- La réduction de la complexité générale, pour simplifier l’adoption et la contribution par la communauté.

- L’objectif global est de rendre le projet stable, compréhensible et facilement réutilisable en open-source.
= Revue théorique
Dans ce chapitre je vais reprendre toutes les notions nécessaire à la compréhension du Travail de fin d'études.
== Microservices
L'architecture microservices consiste à découper une application en sous-composants peu interdépendants. Les processus de reconstruction et de redéploiement sont partiels, et les services communiquent à travers des API bien définies.

Cette approche offre une meilleure résilience et permet à plusieurs équipes de travailler de manière autonome sur une même application. Enfin, cette architecture favorise la cohabitation de technologies différentes au sein d'un même projet#cite(<Claytonsiemens77_2026_microsoft>).
=== Communication Synchrone
Type de communication où l'émetteur attend une réponse immédiate pour poursuivre son traitement. On parle de *communication bloquante*, car le flux d'exécution est suspendu tant que la réponse n'a pas été reçue.

=== Communication Asynchrone
Type de communication où l'émetteur transmet une requête et poursuit ses activités sans attendre de retour immédiat. Il s'agit d'une communication *non bloquante*, permettant de traiter la réponse ultérieurement (via une notification ou un système de rappel).

== Architecture Modulaire Monolithique
=== Object–relational mapping
=== Modular Add-on System
== CQRS
= Méthodologie
== Suivi du projet
== Review du code et analyse de l'architecture
== Proposition de modifications
== Fusion de composants
Devant la complexité du projet, et dans l'objectif d'améliorer la lisibilité et l'expérience dévelopeur, nous avons entrepris un gros refactoring.

Le projet était tombé dans un anti-design-pattern : le Distributed monolith#cite(<Algolia_2026_dev>).
Des parties du projets étant trop proche au niveau du domaine d'analyse et réclamment techniquement trop d'appel syncrhone .

=== Fusion des modules Backend Database et Backend
=== Fusion des modules Members et Community
= Travail réalisé
= Résultats et analyse
= Discussion et apports personnels
= Bibliographie
= Remerciement
Merci à Guilain Ernotte pour sa template original et son soutien durant la fin de mes études.