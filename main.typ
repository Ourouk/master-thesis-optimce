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

Ce Travail de Fin d’Études présente la transition du projet Locomotrice, développé en contexte académique, vers un modèle open source. L’objectif est de restructurer le projet pour le rendre accessible, maintenable et adaptable à une communauté diversifiée (recherche, entreprises).

== Problématique

Les défis incluent :
- Licence : Choix d’une licence open source adaptée aux usages communautaires et commerciaux.
- Qualité du code : Amélioration de la lisibilité, modularité et expérience développeur.
- Reproductibilité : Simplification de l’infrastructure pour une installation fluide.
- Documentation : Création de ressources claires pour différents publics.
- Tests : Mise en place de tests unitaires et d’intégration pour garantir la stabilité.
- Communication : Stratégie de promotion pour maximiser l’adoption.
- Gouvernance : Processus collaboratifs pour un développement efficace.

== Méthodologie

L’approche combine :
- Audit architectural : Identification d’anti-patterns (ex. : Distributed Monolith).
- Refactoring : Fusion de composants redondants (ex. : Backend Database et Backend).
- DevOps : Intégration de CI/CD et automatisation.
- Outils : Développement de solutions pour le déploiement et la collaboration.
- Benchmarking : Étude des bonnes pratiques de projets open source établis.

== Résultats

Le projet est transformé en une solution stable, modulaire et réutilisable, favorisant son adoption par la communauté open source et assurant sa pérennité.

== Résultats

À l'issue de ce travail, le projet Locomotrice est transformé en une solution stable, modulaire et aisément réutilisable, caractérisée par une complexité technique réduite. Cette restructuration favorise son adoption par la communauté open source, tout en assurant sa pérennité et en établissant les fondations d'une gouvernance collaborative et scalable.

= Introduction
Ce mémoire s'inscrit dans le cadre de la mise en open source du projet *OptimCE*, un composant clé du projet *Locomotrice*. L'objectif principal d'OptimCE étant de fournir une platform administrative de gestions de membre et d'informations spécifiques à la gestion d'une communauté d'énergie.

L'entreprise repreneuse a demandée que le projet soit codé en
- *Node.js*
- *Kubernetes*
Sans préférence particulière sur la gestion des databases. Nous reviendrons tout au long du projet sur ces décisions.

Le projet *OptimCE* atteint un niveau de maturité technologique (TRL) de 7 #cite(<Horizon_Europe_2026_gouv>) Ce niveau indique que le projet est proche d’un rendu opérationnel, prêt à être déployé en production. Initialement, ce développement était prévu pour être réalisé par un seul développeur dans le cadre interne de la Haute École de la Province de Liège (HEPL).


C'est dans ce cadre que s'inscrit mon mémoire, dont l'objectif est d'aider à la réalisation de ce délivrable.

= Présentation de l'entreprise et du stage
== L'organisation
Le stage s’est déroulé au sein des locaux de l’ISIL (Institut Supérieur Industriel de Liège), où un bureau dédié a été mis à disposition pour la réalisation des missions.

=== Cadre Temporelle
- Durée : Le stage s’est étendu sur une période de 8 mois, d’octobre à mai.
- Rythme :
  - Temps partiel jusqu’en décembre (pour permettre une transition progressive).

  - Temps plein à partir du deuxième quadrimestre (janvier à fin avril), afin de s’investir pleinement dans les projets confiés.

=== Entreprise
Le CeCoTePe (Le Centre de Coopération Technique et Pédagogique), est une ASBL qui encadre des formations proffessionnel continues, ainsi que de la recherche. Dans le cadre de la recherche, la HEPL et le CeCoTePe on un collaboration étroite.#cite(<cecotepe>)
=== Projet Locomotrice
Le projet Locomotrice est un Win2All e en collaboration avec ULiège, Emission Zero


Dont l'objectif est de tracer la voie vers une transition énergétique participative et efficace! En développant un logiciel open source en collaboration avec l’Université de Liège et des coopératives citoyennes, il permettra de maîtriser et d’opérationnaliser les actions des citoyens engagés dans la transition énergétique. Intégrant les communautés d’énergie, ce projet offre une plateforme novatrice pour mobiliser les citoyens et les impliquer activement dans la construction d’un avenir énergétique durable.#cite(<locomotrice>)
== Le cadre du stage
=== Objectif
=== La durée du stage
=== La place de votre travail dans l'entreprise
=== Les outils ou logiciels utilisés
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
= Revue théorique
Dans ce chapitre je vais reprendre toutes les notions nécessaire à la compréhension du Travail de fin d'études.
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