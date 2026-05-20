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
      first-name: "",
      last-name: "",
      role: "",
    )
  ),
  bibliography-file: "../ref.bib",
  annex: include "annex.typ"
)
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

== Conclusion

By the end of this work, the OptimCE project is transformed into a stable, modular, and easily reusable solution, characterized by reduced technical complexity. This restructuring promotes its adoption by the open-source community while ensuring its longevity and laying the foundations for collaborative and adaptable governance.
#pagebreak()

#set text(lang: "fr")
= Introduction
Ce mémoire s'inscrit dans le cadre de la mise en open source#footnote[Modèle de développement où le code source est rendu public sous une licence (ex. : Apache 2.0, MIT) permettant sa consultation, modification et redistribution.] du projet *OptimCE*, un composant clé du projet *Locomotrice*. L'objectif principal d'OptimCE est de fournir une plateforme administrative de gestion de membres et d'informations spécifiques à la gestion d'une communauté d'énergie.

L'entreprise repreneuse a émis pour seules exigences techniques l'utilisation de :
- *Node.js*
- *Kubernetes*
sans exprimer de préférence particulière quant au système de gestion de bases de données. Ces décisions architecturales seront détaillées ultérieurement dans ce document.

Le projet *OptimCE* atteint un niveau de maturité technologique (TRL#footnote[Technology Readiness Level : niveau de maturité technologique (1-9) indiquant la proximité d'un déploiement en production. Le niveau 7 signifie un système déjà testé et à faible risque.]) de 7 #cite(<Horizon_Europe_2026_gouv>). Ce niveau indique que le projet est proche d'un état opérationnel, prêt à être déployé en production. Initialement, ce développement était prévu pour être réalisé par un seul développeur dans le cadre interne de la Haute École de la Province de Liège (HEPL).


C'est dans ce cadre que s'inscrit mon mémoire, dont l'objectif est d'aider à la réalisation de ce délivrable.

= Présentation de l'entreprise et du stage
== L'organisation

=== Entreprise
Le CeCoTePe (Centre de Coopération Technique et Pédagogique) est une ASBL qui encadre des formations professionnelles continues, ainsi que de la recherche. Dans le cadre de la recherche, la HEPL et le CeCoTePe entretiennent une collaboration étroite.#cite(<cecotepe>)
=== Projet Locomotrice
Le projet Locomotrice est un projet de recherche financé grâce à l'appel à projets Win2Wal incluant le CeCoTePe, l'équipe BEMS (ULiège) et Émission Zéro en tant que partenaire industriel. L'objectif est de tracer la voie vers une transition énergétique participative et efficace. En développant un logiciel open source en collaboration avec l'Université de Liège et des coopératives citoyennes, il permettra de maîtriser et d'opérationnaliser les actions des citoyens engagés dans la transition énergétique. Intégrant les communautés d'énergie, ce projet offre une plateforme novatrice pour mobiliser les citoyens et les impliquer activement dans la construction d'un avenir énergétique durable.#cite(<locomotrice>)

Concrètement, le projet comporte deux parties :
- OptimCE — sur lequel la majorité du travail a été effectué. Réalisé par le CeCoTePe avec le support de l'équipe EMS de l'université.
- EMS (Energy Management System) — sous-projet domotique de contrôle de la consommation électrique. Géré par l'université avec le support de l'équipe « IT » du CeCoTePe.

= Cadre du stage
== Lieux
Le stage s'est déroulé au sein des locaux de l'ISIL (Institut Supérieur Industriel de Liège), où un bureau dédié a été mis à disposition pour la réalisation des missions.

== Cadre temporel
- Durée : Le stage s'est étendu sur une période de 8 mois, d'octobre à mai.
- Rythme :
  - Temps partiel jusqu'en décembre (pour permettre une transition progressive).
  - Temps plein à partir du deuxième quadrimestre (janvier à fin avril), afin de s'investir pleinement dans les projets confiés.
== Encadrement
Le stage a été encadré par Eric Paques lors de communications régulières.

Le projet étant réalisé en partie en collaboration avec l'Université de Liège, des réunions avec ces derniers étaient organisées hebdomadairement.
= Problématique, objectifs et enjeux
== Problématique
=== Problématique générale

Le projet Locomotrice, initialement développé dans un cadre de recherche, doit être rendu open source afin d'être accessible à la communauté d'utilisateurs ainsi qu'aux entreprises susceptibles de le reprendre. Cette transition hors du contexte académique pose plusieurs défis majeurs.

=== Problématiques spécifiques

- Licences
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
  image("assets/Notion02.png", height: 5cm),
  caption: [Documentation partiellement organisée autour des décisions prises],
)
Une bonne partie de ce mémoire a notamment été écrite en relisant les recherches en amont des différentes implémentations.

== Analyse d'organisations open-source existantes
Pour structurer notre mise en open-source, nous nous sommes inspirés d'autres organisations afin de ne pas nous disperser.

Nous nous sommes principalement intéressés au projet *Nextcloud*#footnote[Plateforme open-source de synchronisation et partage de fichiers, auto-hébergée. Alternative à Dropbox ou Google Drive.] et à d'autres projets open-source rencontrés dans notre stack technique.

=== Hébergement du code
Nous avons cherché l'approche la plus standard utilisée dans la majorité des exemples open-source rencontrés :
==== Git
Git est le gestionnaire de versions de code le plus populaire et donc le plus connu des développeurs.
==== GitHub
GitHub#footnote[Plateforme web pour héberger et gérer des dépôts Git. Offre CI/CD, gestion des issues, wikis, releases, et collaboration pour les projets open-source.] est devenu en quelque sorte synonyme de Git, plateforme la plus connue, offrant toute une série de services aux développeurs open-source. Nous avons néanmoins envisagé des alternatives telles que Gitea et GitLab pour leur hébergement aisé et leur indépendance vis-à-vis de Microsoft. Toutefois, l'offre de Microsoft l'a emporté pour son accessibilité et ses pipelines CI/CD#footnote[Intégration Continue/Déploiement Continu : automatisation qui teste, compile et déploie le code à chaque commit pour détecter les erreurs tôt.] gratuits.
=== Bug Reporting
GitHub fournit un système d'issues. Nous avons donc décidé d'utiliser une approche hybride : une boîte mail pour les utilisateurs finaux et l'accès aux issues pour les contributeurs.
=== Gestion de collaboration au niveau du code
Nous avons reproduit la logique et la philosophie suivantes dans nos contributions :
- Commits atomiques : nous avons essayé de garder des commits de petite taille retraçant chaque modification effectuée.
- Utilisation intensive de branches :
  - Branche principale : code destiné à être mis en production.
  - features/features-name : branche destinée à ajouter une fonctionnalité au projet.
  - fix/fix-name : branche destinée à corriger un bug.
- Suivi d'une demande de fusion :
  - Nous effectuons une relecture humaine.
  - Utilisation d'un agent IA pour compléter cette revue (Copilot fourni par GitHub).
  - Exécution des CI/CD.
  - Itération jusqu'à obtenir une version qui nous convient.
Nous validons la fusion et l'effectuons.

Nous reparlerons de tout cela dans la section dédiée au travail effectué.

=== Accroche utilisateurs finaux
Développement d'un site web dédié aux utilisateurs finaux et aux contributeurs potentiels.
- Un blog et une newsletter pour tenir les personnes intéressées informées.
- Liens vers les différents canaux de communication du projet.
- Liens vers la démo/bêta du projet.
Cet aspect était nécessaire pour la communication du projet et pour les tests permettant des retours utilisateurs.
= Travail réalisé
Dans ce chapitre, nous allons nous intéresser au travail effectué, dans l'ordre chronologique des modifications et des ajouts de fonctionnalités.
== Revue du code et analyse de l'architecture

L'analyse initiale du code source a révélé que l'architecture micro-services, bien qu'adaptée aux grandes équipes et aux déploiements cloud natifs, pose plusieurs défis majeurs dans le cadre d'un projet open source.

Bien que conçue pour offrir la résilience, la scalabilité et un déploiement indépendant des composants, cette architecture introduit une complexité opérationnelle accrue, notamment en matière de tests, de compréhension globale du système et de maintenance.

Chaque micro-service, bien que faiblement couplé et déployable individuellement, nécessite une gestion fine des interconnexions, des protocoles de communication et des mécanismes de tolérance aux pannes, ce qui peut rendre le projet difficile à appréhender pour de nouveaux contributeurs ou pour une petite équipe de développeurs.

Elle nécessite donc une infrastructure et une culture de développement orientées vers les grandes équipes et/ou les entreprises. Un autre problème est que nous n'avions aucune certitude quant au déploiement du produit en tant que SaaS ; il pourrait très bien suivre une architecture auto-hébergée.
=== Illustration du problème
Lors de la division initiale, sur papier, le code paraissait assez simple à suivre avec des frontières claires entre les composants.
#figure(
  image("assets/architecture_simple.png"),
  caption: [Architecture initialement prévue],
)
Or cette division est un domaine de recherche à part entière nommé *Domain Driven Design*#footnote[Méthode de conception où l'architecture suit la structure du domaine métier plutôt que la technologie. Aide à définir les frontières entre microservices.] (DDD) #cite(<2026_microsoft>). Son objectif est d'étudier l'interaction et la définition des objets au sein de l'ensemble du code source d'un produit.

L'objectif principal, pour résumer, est d'éviter que plusieurs services référencent un même objet de manière identique et aient donc les mêmes besoins.
L'intérêt du micro-service apparaît principalement lorsque ces services manipulent les objets de façon totalement différente et ne les définissent même pas de la même manière.

Cela permet une communication asynchrone où les données sont partiellement ou entièrement copiées et modifiées via un bus de communication.
#figure(
  image("assets/micro-service.png"),
  caption: [Une vraie implémentation micro-services],
)
En pratique, cette démarche d'analyse s'avère complexe. Dans le cadre de ce projet, l'évolution continue du domaine au cours de sa réalisation et une vision initiale incomplète de son ensemble ont mené à une définition imprécise des entités, entraînant ainsi une augmentation graduelle de la complexité technique.
== Proposition de modifications
Devant la complexité du projet, et dans l'objectif d'améliorer la lisibilité et l'expérience développeur, nous avons entrepris un important refactoring.

Le projet était tombé dans un anti-pattern : le *monolithe distribué*#footnote[Anti-pattern où les microservices, bien séparés, restent fortement couplés (appels synchrones fréquents, doublons de code). Combine les désavantages du monolithe et des microservices.] #cite(<Algolia_2026_dev>). Des parties du projet étaient trop proches au niveau du domaine d'analyse et nécessitaient techniquement trop d'appels synchrones.

Ces appels synchrones rendaient les micro-services très interdépendants et nécessitaient la modification de nombreuses parties de code dans différents composants pour chaque fonctionnalité.
#figure(
  image("assets/architecture.png"),
  caption: [Augmentation de la complexité],
)
L'idée était donc de rassembler les fonctionnalités redondantes dans des services plus importants afin de réduire cette complexité, tout en anticipant la capacité future du produit à supporter une charge croissante.
=== Suppression des backend-db
Une série de services avait pour rôle de convertir les appels vers les bases de données en API REST. Nous avons donc décidé de les fusionner avec les services qui les utilisaient.


=== Fusion de composants
Nous avons également procédé à une fusion de micro-services en raison d'appels synchrones trop fréquents et de leur impact négatif sur les performances :
- Opérations de partage
- Communauté
- Membres
Ces fonctionnalités ont été regroupées vers un service unifié : le CRM (Customer Relationship Management).
//TODO: Will probably need improvement
=== Garder certains micro-services
On pourrait se demander pourquoi ne pas simplement tout fusionner dans l'application centrale.

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
Composants micro-services :
- Notifications : gère les notifications asynchrones (ex. : e-mails, alertes).
- Simulation/Génération de clés : responsable des tâches de simulation et de génération de clés, qui peuvent être plus lourdes ou nécessiter des langages spécifiques.
- Template : gère les modèles de documents ou d'e-mails, nécessitant une logique spécifique.
Composants tiers :
- KrakenD : API Gateway, utilisé pour exposer les différentes API de manière unifiée et sécurisée.
- Keycloak : service d'identité et de gestion des utilisateurs, utilisé pour l'authentification et l'autorisation.
- MinIO : service de stockage d'objets, utilisé pour stocker les fichiers liés aux communautés (ex. : logos).
- Broker de messages (ex. : RabbitMQ#footnote[Broker de messages open-source permettant la communication asynchrone entre composants via des files d'attente. Garant d'une livraison fiable des messages.]) : utilisé pour la communication asynchrone entre les composants, notamment pour les notifications et les tâches de simulation/génération de clés.
== Refactoring architectural
=== Suppression des backend-db
Afin de conserver une architecture solide et modulaire, nous avons adopté la structure suivante :
==== Mapping objet-relationnel
Une librairie ORM#footnote[Object-Relational Mapping : traduit automatiquement les lignes de base de données en objets de code (ex. Community ↔ table community). Simplifie les requêtes SQL.] permet de :
- Définir des entités (comme Community) qui reflètent les tables de la base de données.
- Établir des relations entre les entités (ex. : une communauté peut avoir plusieurs utilisateurs, et chaque utilisateur peut appartenir à plusieurs communautés).
- Gérer les champs spécifiques (identifiants uniques, URLs, descriptions, etc.) et leurs contraintes (unicité, nullabilité, etc.).

Extrait de code :
//TODO: Choose to store or not code in annex
```typescript
import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryColumn,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from "typeorm";
import { Role } from "../../../shared/dtos/role.js";
import { User } from "../../users/domain/user.models.js";
import { Address } from "../../../shared/address/address.models.js";

/**
 * Entity representing a Community.
 * Stores community details and links to members.
 */
@Entity("community")
export class Community {
  /**
   * Unique ID of the community.
   * Auto-generated identity column.
   */
  @PrimaryGeneratedColumn("identity", { generatedIdentity: "ALWAYS" })
  id!: number;

  /**
   * Name of the community.
   * Must be unique.
   */
  @Column({ type: "varchar", length: 255, unique: true })
  name!: string;

  /**
   * External Authentication ID for the community (e.g. from Keycloak/Auth0).
   */
  @Column({ name: "auth_community_id", type: "varchar", length: 255, unique: true, nullable: false })
  auth_community_id!: string;

  @Column({ name: "website_url", type: "varchar", length: 255, nullable: true })
  website_url!: string | null;

  @Column({ name: "logo_url", type: "varchar", length: 255, nullable: true })
  logo_url!: string | null;

  @Column({ type: "text", nullable: true })
  description!: string | null;

  @Column({ name: "headquarters_address_id", type: "int", nullable: true })
  headquarters_address_id!: number | null;

  @ManyToOne(() => Address, { nullable: true })
  @JoinColumn({ name: "headquarters_address_id" })
  headquarters_address!: Address | null;

  @CreateDateColumn({ name: "created_at" })
  created_at!: Date;

  @UpdateDateColumn({ name: "updated_at" })
  updated_at!: Date;

  // Inverse side: One Community has many CommunityUser entries
  @OneToMany(() => CommunityUser, (communityUser) => communityUser.community)
  users!: CommunityUser[];
}

```
==== Services
Un ensemble de services est responsable des tâches suivantes :
- Récupérer les données depuis la base de données en fonction des requêtes (ex. : lister toutes les communautés publiques).
- Traiter les données avant de les retourner (ex. : générer des URLs temporaires pour les logos des communautés).
- Gérer les erreurs (ex. : journaliser les échecs de génération d'URL pour les logos).
- Paginer les résultats.
Exemple :
//TODO: Choose to store or not code in annex
```typescript
async getAllPublicCommunities(query: CommunityQueryDTO): Promise<[PublicCommunityDTO[], Pagination]> {
  const [values, total] = await this.community_repository.getAllPublicCommunities(query);
  const return_values = await Promise.all(
    values.map(async (community) => {
      let logo_presigned_url: string | null = null;
      if (community.logo_url) {
        try {
          logo_presigned_url = await this.storage_service.getDocumentUrl(community.logo_url);
        } catch (err) {
          logger.error(
            { operation: "getAllPublicCommunities", error: err, communityId: community.id },
            "Failed to generate presigned URL for community logo",
          );
        }
      }
      return toPublicCommunityDTO(community, logo_presigned_url);
    }),
  );
  const total_pages = Math.ceil(total / query.limit);
  return [return_values, { page: query.page, limit: query.limit, total, total_pages }];
}
```
=== DTO
Les objets de transfert de données (DTO) structurent les informations retournées au client.
//TODO: Choose to store or not code in annex
```typescript
/**
 * DTO returned by the public communities list. Includes a short-lived
 * presigned logo URL so the client can render the image directly.
 */
export class PublicCommunityDTO#footnote[Data Transfer Object : objet contenant uniquement les données à retourner au client, sans logique métier. Isole l'API interne de l'API publique.] {
  @Expose()
  id!: number;

  @Expose()
  name!: string;

  @Expose()
  logo_url!: string | null;

  /** Short-lived presigned URL (~15 min). Null when the community has no logo or URL generation failed. */
  @Expose()
  logo_presigned_url!: string | null;
}
```
==== Architecture complète
Cette approche permet une séparation claire des différentes couches, ce qui est essentiel pour le principe de séparation des responsabilités #cite(<Separati80:online>).

Nous retrouvons ainsi une arborescence de fichiers organisée de la manière suivante pour chaque module :
```
└── src
    └── community
        ├── api
        │   ├── community.controller.ts
        │   ├── community.dtos
        │   ├── community.routes.ts
        │   └── community.swagger.ts
        ├── domain
        │   ├── community.models.ts
        │   ├── i-community.repository.ts
        │   └── i-community.services.ts
        ├── infra
        │   ├── community.repository.ts
        │   └── community.service.ts
        └── shared
            ├── community.error.ts
            ├── to_dto.ts
            └── to_model.ts
```
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
La seconde partie de la refonte a concerné la fusion des composants users, community et opération de partage dans le composant Gestionnaire de relation client.

L'objectif a donc été de remplacer les nombreux appels REST entre ces composants par une gestion orientée objets de ces informations.
== Mise en open-source
=== Réorganisation du code en sous-dépôts
L'ancienne organisation des fichiers dans le code source était fonctionnelle mais complexe, avec de nombreux sous-dossiers. L'inconvénient principal était qu'un seul dépôt Git gérait l'entièreté du code source, ce qui augmentait fortement le nombre de fichiers à suivre.

En conséquence, même des opérations basiques comme les commits et les fetch devenaient progressivement plus lentes.
```bash
├── Authentification
│   ├── auth-back-end
│   ├── back-end
│   └── front-end
├── crm
│   ├── assets
│   ├── config
│   ├── database_script
│   ├── images
│   ├── src
│   └── tests
├── crm-frontend
│   ├── public
│   └── src
├── databases
│   ├── community_database
│   ├── key-database-ms
│   ├── user_back_end
│   └── user_db_ms
├── deploiement-new-version
│   ├── kc-groupid-mapper
│   ├── keycloak-config
│   └── script
├── documentation-app
│   └── src
├── Gestionnaire de clef de répartition
│   ├── back_end
│   ├── front-end
│   ├── Generators
│   └── SimulateurMS
├── Gestionnaire de communautés
│   ├── back_end
│   ├── community-back-end
│   └── front-end
├── Gestionnaire de documents
│   ├── back-end
│   ├── back-end-database
│   └── front-end
├── Gestionnaire de membres
│   ├── back_end
│   ├── front-end
│   └── members_database_back_end
├── images
├── KarateTesting
│   └── KarateMaven
├── optimce-app
│   ├── apps
│   └── libs
├── proxies
│   ├── back_end_proxy
│   └── front-end-orchestrator
├── services
│   ├── notification_back_end
│   └── openfiles
├── template
│   ├── back-end-database-template
│   ├── back-end-template
│   └── front-end-service
├── tools
│   ├── LoggingTracing
│   └── RSA_generation
└── Users
    ├── back-end
    ├── front-end
    └── users-back-end

66 directories
```
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
==== Linting et formatage
Pour garantir la qualité du code et faciliter les contributions, nous avons précisé que le code doit être formaté et linté selon les règles définies dans le README.md.
- Nous avons intégré des outils de linting et de formatage dans les pipelines CI/CD pour automatiser ce processus et assurer une cohérence dans le code soumis par les contributeurs.
- Nous avons également fourni des configurations de linting et de formatage dans les dépôts, ainsi que des scripts npm pour faciliter leur utilisation en local avant de soumettre une pull request.
- Nous encourageons l'utilisation de hooks Git (ex. : lint-staged) pour exécuter automatiquement les vérifications de linting et de formatage avant chaque commit, afin de réduire les erreurs et d'améliorer la qualité du code dès le début du processus de contribution.

Nous utilisons donc les linters/formatters suivants selon les différentes technologies utilisées :
- TypeScript : ESLint et Prettier
- SQL : SQLFluff
- Python : ruff
Ainsi que des configurations qui peuvent être encore plus spécifiques selon les besoins de chaque composant.

Nous fournissons également un fichier agents.md pour aider les contributeurs à utiliser des agents d'IA (ex. : GitHub Copilot) pour compléter leurs relectures de code, en fournissant des conseils sur les meilleures pratiques et en suggérant des améliorations potentielles. Celui-ci contient les recommandations de linting et de formatage.

=== CI/CD
Chaque dépôt est configuré avec des pipelines CI/CD sur GitHub Actions#footnote[Service GitHub permettant d'exécuter automatiquement des workflows (tests, builds, déploiements) à chaque commit ou pull request.], permettant d'automatiser les tests, les builds et les déploiements. Ces pipelines sont conçus pour garantir la qualité du code et faciliter le processus de contribution.
==== Exemple de pipeline CI/CD
On peut voir ci-dessous un exemple de l'arborescence des fichiers d'un dépôt, avec les différents workflows CI/CD configurés pour les tests, la publication Docker, la notification de mise à jour du monorepo et la mise à jour de la documentation.

```sh
.
├── dependabot.yml
└── workflows
    ├── codeql.yml
    ├── docker-publish.yml
    ├── notify_monorepo_update.yml
    ├── test.yml
    └── update-documentation.yml

2 directories, 7 files
```
Nous allons revenir sur chacun de ces workflows dans les sections suivantes.
==== Test
Le sobrement nommé *test.yml* est déclenché à chaque pull request et à chaque push sur la branche principale. Il exécute une série de tests unitaires et d'intégration pour s'assurer que les modifications proposées n'introduisent pas de régressions ou de bugs dans le code existant.
```yaml
name: Test

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v6

      - uses: actions/setup-node@v6
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm run test-all
```
==== Description du workflow de test
Ce workflow GitHub Actions se déclenche sur les pushes et les pull requests visant la branche `main`. Il exécute un job nommé `test` sur le runner `ubuntu-latest` pour automatiser la validation des contributions. Les étapes principales sont :

- `actions/checkout@v6` : récupère le code du dépôt.
- `actions/setup-node@v6` : installe Node.js (ici la version 22) et active le cache `npm` pour accélérer les builds.
- `npm ci` : installe les dépendances de manière reproductible.
- `npm run test-all` : lance l'ensemble des tests unitaires et d'intégration définis pour le projet.

Cette action permet de voir rapidement si les modifications proposées passent les tests, assurant ainsi la qualité du code avant de fusionner les changements dans la branche principale.
==== Sécurité
Plusieurs workflows sont dédiés à la sécurité du projet, notamment :
- *CodeQL* :
Le workflow *codeql.yml* est dédié à l'analyse de sécurité du code. Il utilise l'outil CodeQL de GitHub pour scanner le code à la recherche de vulnérabilités connues et de mauvaises pratiques de sécurité. Ce workflow est également déclenché sur les pushes et les pull requests vers la branche principale, garantissant que chaque contribution est analysée pour les risques de sécurité avant d'être intégrée au projet.

Les résultats de l'analyse sont disponibles dans l'onglet « Security » du dépôt, nous permettant de suivre et de corriger rapidement les problèmes de sécurité identifiés.
#figure(
  image("assets/security_reporting.png"),
  caption: [Exemple de rapport de sécurité],
)
GitHub nous propose une liste de vulnérabilités avec un niveau de sévérité.
#figure(
  image("assets/security_workflow_permissions.png"),
  caption: [Permissions et workflow de sécurité],
)
Chaque rapport de vulnérabilité contient une description du problème, des recommandations pour le corriger, et un lien vers la base de données CVE correspondante pour plus d'informations.
- *Dependabot* :
Le fichier *dependabot.yml* configure Dependabot, un outil de GitHub qui surveille les dépendances du projet à la recherche de vulnérabilités. Dependabot crée automatiquement des pull requests pour mettre à jour les dépendances vulnérables, ce qui nous permet de maintenir le projet à jour et sécurisé sans effort manuel.
```yaml
---
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: npm
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "devcontainers"
    directory: "/"
    schedule:
      interval: "weekly"
```
Le code ci-dessus configure toutes les technologies utilisées dans le projet. Une vérification hebdomadaire est effectuée pour chaque technologie, et des pull requests sont créées automatiquement pour les mises à jour nécessaires.
#figure(
  image("assets/dependabot.png"),
  caption: [Exemple de Pull Request générée par Dependabot],
)
On peut voir ci-dessus un exemple de pull request créée par Dependabot. Elle s'intègre parfaitement dans notre processus de contribution, avec des tests automatisés qui s'exécutent pour valider la mise à jour avant de fusionner les changements.

Dans ce cas précis, la pull request met à jour la version de TypeScript utilisée dans le projet, mais casse le processus de build. Cela nous permet d'éviter de casser la branche principale avec une mise à jour qui n'est pas encore compatible avec notre code, tout en nous alertant de la nécessité de mettre à jour notre code pour rester compatible avec les dernières versions des dépendances.

==== Docker build and publish
Le workflow *docker-publish.yml* est responsable de la construction et de la publication des images Docker pour les différents composants du projet. Il est déclenché à chaque push sur la branche principale, et utilise les secrets GitHub pour se connecter à un registre d'images Docker, dans notre cas GitHub Container Registry.
```yaml
name: Test

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v6

      - uses: actions/setup-node@v6
        with:
          node-version: 22
          cache: npm
      - run: npm ci
      - run: npm run test-all
```
==== Tests
Ce code est une GitHub Actions qui se déclenche sur les pushes et les pull requests visant la branche `main`. Il exécute un job nommé `test` sur un runnerle `ubuntu-latest` pour automatiser la validation des contributions. Les étapes principales sont :

- `actions/checkout@v6` : récupère le code du dépôt.
- `actions/setup-node@v6` : installe Node.js (ici la version 22) et active le cache `npm` pour accélérer les builds.
- `npm ci` : installe les dépendances de manière reproductible.
- `npm run test-all` : lance l'ensemble des tests unitaires et d'intégration définis pour le projet.

Cette action permet de voir rapidement si les modifications proposées passent les tests, assurant ainsi la qualité du code avant de fusionner les changements dans la branche principale.
==== Sécurité
Plusieurs workflows sont dédiés à la sécurité du projet, notamment
- *CodeQL* :
Le workflow *codeql.yml* est dédié à l'analyse de sécurité du code. Il utilise l'outil CodeQL de GitHub pour scanner le code à la recherche de vulnérabilités connues et de mauvaises pratiques de sécurité. Ce workflow est également déclenché sur les pushes et les pull requests vers la branche principale, garantissant que chaque contribution est analysée pour les risques de sécurité avant d'être intégrée au projet.

Les résultats de l'analyse sont disponibles dans l'onglet "Security" du dépôt, nous permettant de suivre et de corriger rapidement les problèmes de sécurité identifiés.
#figure(
  image("assets/security_reporting.png"),
  caption: [Exemple de rapport de sécurité],
)
Github nous propose une liste de vulnérabilités avec un niveau de sévérité.
#figure(
  image("assets/security_workflow_permissions.png"),
  caption: [Permissions et workflow de sécurité],
)
Chaque rapport de vulnérabilité contient une description du problème, des recommandations pour le corriger, et un lien vers la base de données CVE correspondante pour plus d'informations.
- *Dependabot* :
Le fichier *dependabot.yml* configure Dependabot, un outil de GitHub qui surveille les dépendances du projet à la recherche de vulnérabilités. Dependabot crée automatiquement des pull requests pour mettre à jour les dépendances vulnérables, ce qui nous permet de maintenir le projet à jour et sécurisé sans effort manuel.
```yaml
---
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: npm
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "devcontainers"
    directory: "/"
    schedule:
      interval: "weekly"
```
Le code ci dessus configure tous les technologies utilisées dans le projet. Une vérification hebdomadaire est effectuée pour chaque technologie, et des pull requests sont créées automatiquement pour les mises à jour nécessaires.
#figure(
  image("assets/dependabot.png"),
  caption: [Exemple de Pull Request générée par Dependabot],
)
On peut voir ci-dessus un exemple de pull request créée par dependabot. Elle s'intègre parfaitement dans notre processus de contribution, avec des tests automatisés qui s'exécutent pour valider la mise à jour avant de fusionner les changements.

Dans ce cas précis, la pull request met à jour la version de TypeScript utilisée dans le projet, mais casse le processeur de build. Cela nous permet d'éviter de casser la branche principale avec une mise à jour qui n'est pas encore compatible avec notre code, tout en nous alertant de la nécessité de mettre à jour notre code pour rester à jour avec les dernières versions des dépendances.

==== Docker build and publish
Le workflow *docker-publish.yml* est responsable de la construction et de la publication des images Docker pour les différents composants du projet. Il est déclenché à chaque push sur la branche principale, et utilise les secrets GitHub pour se connecter à un registre d'images Docker dans notre cas GitHub Container Registry.
```yaml
name: Docker
on:
  workflow_dispatch:
  push:
    branches: [ "main" ]
    tags: [ 'v*.*.*' ]
  pull_request:
    branches: [ "main" ]
env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}


jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
      id-token: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Install cosign
        if: github.event_name != 'pull_request'
        uses: sigstore/cosign-installer@6f9f17788090df1f26f669e9d70d6ae9567deba6
        with:
          cosign-release: 'v2.2.4'

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@4d04d5d9486b7bd6fa91e7baf45bbb4f8b9deedd

      - name: Log into registry ${{ env.REGISTRY }}
        if: github.event_name != 'pull_request'
        uses: docker/login-action@4907a6ddec9925e35a0a9e82d7399ccc52663121
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract Docker metadata
        id: meta
        uses: docker/metadata-action@030e881283bb7a6894de51c315a6bfe6a94e05cf
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}

      - name: Build and push Docker image
        id: build-and-push
        uses: docker/build-push-action@bcafcacb16a39f128d818304e6c9c0c18556b85f
        with:
          context: .
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Sign the published Docker image
        if: ${{ github.event_name != 'pull_request' }}
        env:
          TAGS: ${{ steps.meta.outputs.tags }}
          DIGEST: ${{ steps.build-and-push.outputs.digest }}
        run: echo "${TAGS}" | xargs -I {} cosign sign --yes {}@${DIGEST}
```
Ce workflow est déclenché par les pushes et les pull requests vers la branche `main`, ainsi que manuellement via l'interface GitHub. Il utilise plusieurs actions pour construire et publier une image Docker, notamment :
- actions/checkout : récupère le code du dépôt.
- sigstore/cosign-installer : installe l'outil Cosign pour signer les images Docker.
- docker/setup-buildx-action : configure Docker Buildx pour construire des images multi-plateformes.
- docker/login-action : se connecte au registre Docker (ici GitHub Container Registry) en utilisant les secrets GitHub.
- docker/metadata-action : extrait les métadonnées pour les images Docker (tags, labels).
- docker/build-push-action : construit et pousse l'image Docker vers le registre.
- cosign : signe l'image Docker publiée pour garantir son intégrité et sa provenance.

La publication de l'image Docker est conditionnée à ce que le workflow ne soit pas déclenché par une pull request, afin d'éviter de publier des images non validées. Cependant, les tests de construction sont exécutés pour toutes les contributions, assurant ainsi que les modifications proposées peuvent être construites correctement avant d'être fusionnées dans la branche principale.

==== Update documentation
Le workflow *update-documentation.yml* est conçu pour maintenir la documentation du projet à jour. Il est déclenché à chaque push sur la branche principale et utilise des outils de génération de documentation (par exemple Swagger/OpenAPI#footnote[Standard ouvert décrivant les API REST (endpoints, paramètres, réponses). Permet de générer automatiquement documentation et clients.] pour les API) afin de produire des versions actualisées de la documentation. Celle-ci est ensuite publiée sur un site web dédié et réutilisée ultérieurement par d'autres composants du projet.
```yaml
name: Update OpenAPI documentation

on:
  workflow_dispatch:
  push:
    branches:
      - main
    paths-ignore:
      - docs/**
jobs:
  build-and-deploy:
    if: github.actor != 'github-actions[bot]'
    runs-on: ubuntu-latest
    env:
      NODE_ENV: development

    permissions:
      contents: write
      pages: write
      id-token: write

    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Setup Node
        uses: actions/setup-node@v6
        with:
          node-version: 22

      - name: Setup Pages
        uses: actions/configure-pages@v6

      - name: Install dependencies
        run: npm ci

      - name: Build OpenAPI documentation
        run: |
          npm run swagger
          npm run swagger:doc:md
          npm run swagger:doc:html

      - name: Move and rename swagger file
        run: mv docs/openapi/swagger.yaml docs/swagger.yml

      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v5
        with:
          path: docs

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v5
```
Ce workflow est déclenché par les pushes vers la branche `main`, à l'exception des modifications dans le dossier `docs/` pour éviter les boucles de déploiement. Il utilise plusieurs actions pour construire et déployer la documentation, notamment :
- actions/configure-pages : configure GitHub Pages pour le dépôt.
- actions/upload-pages-artifact : télécharge les fichiers de documentation générés en tant qu'artifact.
- actions/deploy-pages : déploie les fichiers de documentation sur GitHub Pages.

Une dépendance npm permet également de générer la documentation à partir des fichiers Swagger/OpenAPI, via les commandes suivantes :
```sh
    npm run swagger
    npm run swagger:doc:md
    npm run swagger:doc:html
```
qui génèrent respectivement les fichiers Swagger, la documentation au format Markdown, et la documentation au format HTML. Ces commandes sont intégrées dans le fichier package.json du projet.
== Développement d'un monorepo de staging
Pouvoir travailler sur chaque composant de manière indépendante constitue un avantage majeur pour la modularité et la maintenabilité du projet. Cela peut toutefois introduire des défis en termes de synchronisation et de coordination entre les différents composants. C'est pourquoi nous avons développé un monorepo de staging, qui sert de point central pour intégrer et tester les différentes parties du projet avant de les publier dans leurs dépôts respectifs.
=== Git submodules
Nous avons utilisé la fonctionnalité de Git submodules#footnote[Fonctionnalité Git permettant d'inclure d'autres dépôts comme sous-répertoires, chacun conservant son historique et ses branches propres. Utile pour les monorepos.] pour intégrer les différents dépôts de composants dans le monorepo de staging. Chaque composant est ajouté en tant que sous-module, ce qui permet de maintenir une séparation claire entre les différents projets tout en facilitant la synchronisation et l'intégration.
```gitmodules
[submodule "crm-backend"]
	path = crm-backend
	url = ../crm-backend.git
[submodule "crm-frontend"]
	path = crm-frontend
	url = ../crm-frontend.git
[submodule "keycloak/kc-groupid-mapper"]
	path = keycloak/kc-groupid-mapper
	url = ../kc-groupid-mapper.git
[submodule "krakend/swagger2krakend"]
	path = krakend/swagger2krakend
	url = ../swagger2krakend.git
[submodule "optimce-keycloak-theme"]
	path = keycloak/optimce-keycloak-theme
	url = ../optimce-keycloak-theme.git
```
Dans la syntaxe du fichier de configuration, on peut constater l'un des avantages de l'organisation GitHub : la possibilité d'utiliser des chemins relatifs pour les URL des submodules, ce qui facilite la gestion et la synchronisation des différents composants du projet.

Cela permet aussi de télécharger l'ensemble du projet avec une seule commande `git clone --recurse-submodules`, ce qui est particulièrement utile pour les nouveaux contributeurs qui souhaitent se lancer dans le développement sans avoir à cloner chaque dépôt individuellement.

Les différents IDE permettent aussi de gérer les versions de submodules de manière relativement simple, avec des interfaces graphiques pour synchroniser les submodules, vérifier les changements, etc.

Nous avons principalement utilisé Visual Studio Code pour gérer les submodules.
#figure(
  image("assets/vscode_submodules.png"),
  caption: [Gestion des submodules dans Visual Studio Code],
)
Cette capture d'écran présente l'interface de Visual Studio Code pour la gestion des submodules. Elle permet de visualiser les changements dans chaque submodule, de les synchroniser avec leurs dépôts respectifs, et de gérer les différentes branches et commits pour chaque composant du projet.

La possibilité d'isoler et de tester chaque branche de manière indépendante pour les divers composants s'avère particulièrement utile lors du développement et des tests, car elle permet de travailler sur des fonctionnalités spécifiques sans impacter les autres sous-projets.

=== Synchronisation automatique submodule vers monorepo
Afin de faciliter la synchronisation entre les dépôts de composants et le monorepo de staging, nous avons mis en place un workflow GitHub Actions se déclenchant à chaque push sur les branches principales des dépôts de composants. Ce workflow utilise des scripts pour mettre à jour automatiquement les submodules dans le monorepo de staging, garantissant ainsi que celui-ci intègre toujours les dernières modifications apportées aux différents composants.

Il est composé de deux éléments principaux :
- Un workflow dans chaque dépôt de composant, déclenché à chaque push sur la branche principale, qui envoie un événement de type `repository_dispatch`#footnote[Événement GitHub permettant de déclencher un workflow dans un autre dépôt via l'API, avec des données personnalisées. Utile pour la synchronisation entre dépôts.] au dépôt du monorepo.
```yaml
name: Notify Monorepo

on:
  push:
    branches:
      - main

jobs:
  notify:
    runs-on: ubuntu-latest
    permissions:
      contents: read

    steps:
      - name: Send repository dispatch
        run: |
          curl -X POST \
            -H "Authorization: Bearer ${{ secrets.MONOREPO_TOKEN }}" \
            -H "Accept: application/vnd.github+json" \
            https://api.github.com/repos/OptimCE/monorepo/dispatches \
            -d '{
              "event_type": "submodule-updated",
              "client_payload": {
                "repo": "crm-backend"
              }
            }'
```
Ce workflow est déclenché par les pushes vers la branche `main` de chaque dépôt de composant. Il utilise la commande `curl` pour envoyer une requête POST à l'API GitHub, déclenchant ainsi un événement de type `repository_dispatch` dans le dépôt du monorepo. Le payload de l'événement contient des informations sur le dépôt qui a été mis à jour, ce qui permet au monorepo d'identifier le submodule à synchroniser.
```yaml
name: Update Submodules

on:
  repository_dispatch:
    types: [submodule-updated]

jobs:
  update:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout monorepo
        uses: actions/checkout@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          submodules: recursive
          fetch-depth: 0

      - name: Setup Git identity
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions@github.com"

      - name: Update only changed submodule
        run: |
          git submodule update --remote --merge ${{ github.event.client_payload.repo }}

      - name: Commit and push changes
        run: |
          git add .

          if git diff --cached --quiet; then
            echo "No changes to commit"
            exit 0
          fi

          git commit -m "chore: update submodule ${{ github.event.client_payload.repo }}"
          git push origin HEAD
```
Ce workflow est déclenché par l'événement `repository_dispatch` envoyé par les workflows des dépôts de composants. Il met à jour le submodule correspondant au dépôt qui a été modifié, puis commit et push les changements dans la branche principale du monorepo. Si aucun changement n'est détecté (par exemple, si le submodule est déjà à jour), le workflow s'arrête sans faire de commit.

Le token MONOREPO_TOKEN est généré sur demande par les mainteneurs du projet, et est stocké en tant que secret dans les paramètres de l'organisation, ce qui garantit sa sécurité tout en permettant une utilisation facile dans les workflows GitHub Actions.
==== Docker Compose de développement
Pour faciliter le développement et les tests d'intégration, nous utilisons un fichier docker-compose#footnote[Outil Docker simplifiant le démarrage de plusieurs conteneurs interconnectés à partir d'un fichier YAML. Pratique pour le développement et les déploiements simples.] dans le monorepo de staging qui permet de lancer l'ensemble de l'infrastructure du projet en local. Ce docker-compose intègre tous les composants du projet, ainsi que les services nécessaires pour leur fonctionnement.

Voici les principaux services définis dans le fichier docker-compose.dev.yml #cite(<monorepo75:online>), ainsi que leur rôle dans l'environnement local :

- *crm-database* : base de données PostgreSQL du backend CRM. Elle est lancée avec le profil `dev`, initialise son schéma via un script SQL et expose le port `8080:5432` pour les besoins du développement local.
- *keycloak-db* : base PostgreSQL dédiée à Keycloak#footnote[Serveur open-source d'authentification et d'autorisation (SSO). Gère utilisateurs, rôles, sessions et fournit des protocoles standard (OAuth 2, OIDC).]. Elle fournit la persistance du service d'identité et expose le port `8081:5432`.
- *keycloak* : serveur d'authentification et de gestion des identités. Il dépend de la base Keycloak et du service de configuration, importe automatiquement le realm de développement et expose l'interface d'administration sur `8082:8080`.
- *minio* : service de stockage compatible S3 utilisé pour les fichiers du projet. Il expose à la fois l'API et l'interface d'administration, avec les ports `8091:9000` et `8092:9001`.
- *minio-init* : service d'initialisation de MinIO#footnote[Service open-source de stockage d'objets compatible S3. Permet de stocker des fichiers sans dépendre d'Amazon AWS.]. Il crée automatiquement le bucket attendu par l'application afin que les autres composants puissent accéder au stockage sans intervention manuelle.
- *jaeger* : solution de traçage distribuée#footnote[Outil (Jaeger) qui enregistre le chemin des requêtes à travers tous les microservices, permettant de mesurer latences et d'identifier goulots d'étranglement.] utilisée pour observer les appels entre services et faciliter le diagnostic des performances et des erreurs.
- *swagger-doc-gen* : service temporaire chargé de générer la documentation OpenAPI à partir du backend CRM. Il prépare les fichiers qui seront ensuite réutilisés par le reste de la chaîne.
- *krakend-config* : service de génération de configuration Krakend. Il transforme les spécifications OpenAPI en configuration exploitable par l'API gateway.
- *krakend* : passerelle API exposée au reste de l'infrastructure. Elle centralise l'accès au backend et à Keycloak, tout en restant connectée au réseau interne du projet.
- *reverse-proxy* : proxy inverse Nginx qui sert de point d'entrée pour les services exposés au navigateur, notamment l'interface web et les composants frontaux.
- *crm-backend* : application principale du backend. Elle dépend de la base de données, de l'initialisation MinIO et du traçage, ce qui garantit que les services nécessaires sont prêts avant son démarrage.
- *keycloak-config* : service de génération de configuration pour Keycloak. Il produit le fichier de configuration du realm à partir d'un modèle et des variables d'environnement.
- *nginx-config* : service de génération de configuration Nginx. Il adapte le reverse proxy selon que l'environnement utilise HTTP ou HTTPS.
- *crm-frontend-config* : service de génération de configuration front-end. Il prépare les paramètres consommés par l'application web avant son lancement.
- *crm-frontend* : interface utilisateur du projet. Elle récupère sa configuration depuis un volume monté et est exposée derrière le réseau `reverse-proxy`.

#figure(
  image("assets/docker-compose-dev.png"),
  caption: ["Diagramme — docker-compose de développement"],
)

Dans `docker-compose`, l'intégration repose surtout sur trois mécanismes : les profils (`dev` et `init`) pour séparer les services permanents des services d'initialisation, les dépendances `depends_on` pour ordonner le démarrage, et les réseaux Docker pour isoler les communications internes entre le backend, le proxy et les services exposés.

Le mapping des ports permet de rendre accessible chaque service à l'extérieur du réseau Docker, ce qui est essentiel pour le développement. Les développeurs ont aussi accès à une liste des ports utilisés par chaque service dans la documentation du projet, afin de faciliter les tests et le debug en local.

Il est à noter que dans ce docker-compose, il y a beaucoup de *services de configuration*. Nous reviendrons sur ceux-ci plus tard dans la section dédiée à l'automatisation du déploiement, mais ils sont déjà utilisés dans le docker-compose de développement pour préparer les fichiers de configuration nécessaires au bon fonctionnement de l'infrastructure en local.

==== Test de staging
Le monorepo de staging est utilisé pour intégrer et tester les différentes parties du projet avant de les publier dans leurs dépôts respectifs. En raison de leur temps d'exécution potentiellement très long, nous n'avons pas intégré de pipelines de tests d'intégration automatisés directement sur GitHub.

Néanmoins, nous avons conçu un script nommé `docker-stack.sh` permettant de déployer l'intégralité des composants du projet en environnement local via un fichier Docker Compose. Le docker-compose intégrant des health checks pour chaque service, nous pouvons facilement vérifier que tous les composants fonctionnent correctement ensemble avant de publier les changements dans les dépôts respectifs.

Tout en nous permettant de faire des tests manuels d'intégration, ce qui est particulièrement utile pour les nouvelles fonctionnalités ou les changements majeurs pouvant avoir des impacts importants sur l'ensemble du projet.

Un test complet de staging avec injection de données mockées peut en effet prendre plusieurs dizaines de minutes, car il reconstruit chaque image Docker, puis lance l'ensemble de l'infrastructure.

L'utilisation des submodules prend tout son sens dans ce contexte, car elle nous permet de tester les différentes branches de chaque composant indépendamment, sans avoir à cloner chaque dépôt individuellement ou à gérer manuellement les différentes versions des composants et à les construire manuellement en une commande.

Le code source du script est disponible dans le dépôt du monorepo, et est conçu pour être facilement modifiable en fonction des besoins spécifiques de chaque composant ou de l'infrastructure utilisée pour les tests.#cite(<monorepo72:online>)
==== Automatisation du déploiement
L'automatisation du déploiement est une étape cruciale pour garantir la rapidité et la fiabilité des mises à jour du projet. Nous avons développé une série de petits scripts de déploiement qui génèrent automatiquement les fichiers de configuration nécessaires, construisent les images Docker, et déploient les différents composants du projet sur l'infrastructure de développement et de production.

- *swagger-doc-gen* : ce service génère la documentation OpenAPI à partir du backend CRM. Ils sont utilisés par le service suivant.
- *krakend-config* : ce service génère la configuration de l'API gateway Krakend à partir des spécifications OpenAPI produites par le service précédent. Cela permet de maintenir la configuration de l'API gateway à jour avec les dernières modifications du backend, sans nécessiter d'intervention manuelle.
- *Templated configuration* : plusieurs services sont dédiés à la génération de fichiers de configuration à partir de modèles et de variables d'environnement. Cela inclut :
  - *keycloak-config*
  - *nginx-config*
  - *crm-frontend-config*
Chacun de ces services prend en entrée un template de configuration, ainsi que les variables d'environnement nécessaires, et produit un fichier de configuration prêt à être utilisé par les services correspondants (Keycloak, Nginx, CRM Frontend).

Je reviendrai plus en détail sur ces services dans la section Swagger2krakend et outils pipeline docker, mais ils sont déjà utilisés dans le docker-compose de développement et de production pour préparer les fichiers de configuration nécessaires au bon fonctionnement de l'infrastructure en local.
== Développement d'une version Production
Comme vu dans la section précédente, nous avons développé un script de déploiement qui permet de lancer l'ensemble de l'infrastructure du projet 
en local à l'aide d'un docker compose. 
Et une série de scripts de configuration qui génèrent automatiquement les fichiers de configuration nécessaires.

Différence entre la version de développement et la version de production :
- Retrait des montages de ports pour les services qui ne sont pas censés être exposés à l'extérieur du réseau Docker, afin de renforcer la sécurité et d'éviter les accès non autorisés.
- Utilisation d'images Docker pré-construites et publiées sur un registre d'images, plutôt que de construire les images localement à partir du code source.
- Ajout de la persistance des données pour les services qui en ont besoin, afin de garantir que les données ne sont pas perdues lors du redémarrage des conteneurs.
- Politique de communication plus restrictive entre les services, en limitant les connexions aux seuls services nécessaires pour chaque composant, afin de réduire la surface d'attaque et d'améliorer la sécurité de l'infrastructure.
- Ajout de mécanismes de backup des bases de données, pour garantir la résilience et la récupération en cas de défaillance.
=== Registre d'image container
Nous avons choisi d'utiliser GitHub Container Registry pour héberger les images Docker de notre projet. Cette solution offre une intégration transparente avec GitHub Actions, ce qui facilite la construction et la publication des images à partir de nos pipelines CI/CD.

Cela permet un déploiement plus rapide car nous contrôlons entièrement le processus de build et de publication, et nous pouvons facilement mettre à jour les images en fonction des changements dans le code source.

De plus, GitHub Container Registry offre des fonctionnalités de sécurité avancées, telles que la signature d'images avec Cosign, ce qui renforce la confiance dans les images utilisées pour le déploiement.

Cette modification était par ailleurs nécessaire pour les déploiements Kubernetes.
=== Docker Compose
La version de production est elle aussi faite en docker-compose.
Mais nous pouvons aisément faire des traductions du docker compose vers d'autres orchestrateurs de conteneurs, notamment :
- Docker Swarm#footnote[Orchestrateur de conteneurs natif Docker. Plus simple que Kubernetes mais moins flexible. Gère scaling, failover et load-balancing.] : 
Docker Swarm est très proche de docker compose, et la plupart des fonctionnalités utilisées dans notre docker-compose sont compatibles avec Docker Swarm. Cela nous permet de déployer notre infrastructure sur un cluster Docker Swarm sans nécessiter de modifications majeures, en utilisant simplement le même fichier docker-compose avec quelques ajustements mineurs pour les spécificités de Swarm (ex. : utilisation de secrets, configuration des services en mode swarm, etc.).
- Kubernetes#footnote[Orchestrateur de conteneurs open-source (CNCF). Gère déploiement, scaling automatique, et résurrection des pods. Standard de l'industrie pour production cloud.] :
En utilisant l'outil fourni par docker : *Docker Compose Bridge* #cite(<Usethede7:online>), qui permet de convertir un fichier docker-compose en une configuration compatible avec d'autres orchestrateurs de conteneurs. Cela nous offre une grande flexibilité pour déployer notre infrastructure sur différentes plateformes, en fonction des besoins spécifiques de chaque environnement (développement, staging, production).
=== Déploiement réel
La version actuellement déployée est basée sur Docker Compose, et est hébergée sur un VPS#footnote[Serveur privé virtuel (équivalent EC2 d'Amazon)] chez Hostinger#footnote[Hébergeur low-cost européen]. 
- Nous avons choisi cette solution pour garder les données en Europe.
- Son bas coût.
- La simplicité de son interface de gestion. Ce qui se rapproche de comment un utilisateur final pourrait déployer le projet, ce qui nous permet d'avoir une vision réaliste des performances et des défis de déploiement pour un utilisateur final.
==== Pourquoi ne pas faire un déploiement sur cluster Kubernetes ?
Nous pensons que les communautés d'énergies renouvelables sont par nature décentralisées, et que les utilisateurs finaux ne sont pas automatiquement intéressés par les technologies de pointe, mais plutôt par des solutions simples et accessibles qui répondent à leurs besoins spécifiques.

Nous avons cependant gardé l'option de faire un déploiement avec un orchestrateur de conteneurs plus avancé. Si la demande apparaît pour par exemple une offre SaaS#footnote[Software as a service: Modèle de monétisation où une application est hébergée par un fournisseur et accessible via un abonnement].

Si cela devient nécessaire, nous pourrons ainsi facilement faire le pivot.

== Sous-contributions
Je vais maintenant revenir sur les différentes sous-contributions auxquelles j'ai participé durant ce projet, sachant que j'ai principalement travaillé sur des problématiques DevOps, mais aussi dans le cadre du projet sur du simple développement de fonctionnalités, de correction de bugs, etc.
=== Swagger2Krakend
Swagger2Krakend est un outil que nous avons développé pour automatiser la génération des configurations de l'API gateway Krakend à partir de spécifications OpenAPI.

Il s'agit d'un projet open-source repris dans le monorepo et qui est utilisé dans les pipelines de développement et de production pour maintenir le tout à jour.

Cet outil est développé en Python et permet de spécifier via un fichier de configuration YAML les différentes règles à appliquer sur les spécifications de différentes API définies dans le format OpenAPI.

Par exemple, on peut sécuriser la connexion d'une API en spécifiant qu'elle doit vérifier le JWT#footnote[JSON Web Token: Format de jeton d'authentification sécurisé et signé utilisé pour valider l'identité d'un utilisateur/service] pour toutes les connexions entrantes sur tel ou tel endpoint, ou faire du rate-limiting#footnote[Mécanisme de contrôle du nombre de requêtes autorisées sur une période donnée]. Ce petit outil a été conçu initialement dans un souci de gain de temps, mais il nous a également permis de faire évoluer l'infrastructure et de la sécuriser rapidement.

Son amélioration et son intégration dans les pipelines est une étape essentielle de nos processus de développement et de déploiement.
=== Outils pipeline docker
Certains services ont nécessité le développement de petits outils pour préparer leurs fichiers, ou l'utilisation de sidecars#footnote[Conteneur auxiliaire d'un autre conteneur qui partage des ressources avec le conteneur principal. Dans des objectifs de monitoring, configuration, etc.].

- Le premier problème récurrent était la génération de fichiers de configuration à partir de templates (il est à noter que Kubernetes a une solution pour ce problème nommée ConfigMap qui n'existe pas chez Docker).
    - On a donc simplement créé des fichiers de templates pour chaque fichier que l'on voulait modifier automatiquement.
    - On a ensuite utilisé un utilitaire Unix nommé envsubst, qui a pour rôle de remplacer les variables d'environnement dans un fichier par leur valeur actuelle, et de créer le fichier de configuration final.
    - Que l'on monte ensuite dans le conteneur correspondant.
On a créé une petite image OCI#footnote[Format de conteneur standardisé] qui contient cet utilitaire.
- Vérification des healthchecks: Docker Compose propose bien une fonctionnalité de healthcheck, mais elle repose sur l'utilisation de scripts à l'intérieur du conteneur.
    - Nous avons donc créé des sidecars qui vérifient la santé des services en utilisant un conteneur ne contenant que curl.
=== Ajout de features
- Ajout de route de healthcheck pour les services qui n'en avaient pas, notamment le backend CRM
- Création de l'annuaire de communauté d'énergie. Donc modification de l'interface angular et ajout de la logique backend pour gérer les accès à la base de données.
=== Unification de thèmes
- Nous avons unifié les thèmes keycloak avec celui du frontend pour offrir une identité visuelle cohérente à l'ensemble du projet.
=== Projet EMS Global
- J'ai participé aux décisions d'architecture du projet EMS Global, notamment les choix technologiques, la logique d'authentification et d'autorisation et son intégration avec le reste du projet.
==== EcoArbiter
J'ai écrit un concurrent au projet de l'ULiège de redistribution énergétique en temps réel proposé par leurs étudiants en fin d'études.

Il s'agit d'un projet écrit en Rust qui implémente une logique de distribution équitable de l'énergie entre différents EMS locaux en fonction de leurs besoins, dans l'objectif de maximiser l'autoconsommation collective. Il est conçu pour être facilement intégrable avec le reste du projet, et être capable de gérer une quantité importante de données en gardant une latence de décision très faible.

Ce projet est officiellement personnel, mais est conçu pour être facilement intégrable au reste du projet, et open-source sous la même licence que le reste du projet.

Il a été développé car leur algorithme était lent, ne prenait pas en compte les notions de parité entre utilisateurs et n'était pas en open-source comme l'EMS est censé l'être à l'issue du projet. 
= Résultats et analyse
== Expérience développeur
== Hébergement
== Sécurité
== Gain de performance
=== Latence
=== CPU
=== Consommation de RAM
Le produit consommait 3 GO à vide sans activité, nous sommes descendus à 800 Mo.
= Discussion et apports personnels
