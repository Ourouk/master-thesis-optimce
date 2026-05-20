= Extraits de code <annexe-code>
Voici les extraits de code référencés dans le mémoire.

== Entité Community ORM <annex:community-entity>
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

== Service getAllPublicCommunities <annex:getAllPublicCommunities>
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

== DTO PublicCommunityDTO <annex:public-community-dto>
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

== Architecture des fichiers du module <annex:file-architecture>
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

== Ancienne structure de répertoires <annex:old-directory-structure>
```bash
├── Authentification
│   ├── auth-back-end
│   ├── back-end
│   └── front-end
├── crm
│   ├── assets
│   ├── config
│   ├── database_script
│   ├── images
│   ├── src
│   └── tests
├── crm-frontend
│   ├── public
│   └── src
├── databases
│   ├── community_database
│   ├── key-database-ms
│   ├── user_back_end
│   └── user_db_ms
├── deploiement-new-version
│   ├── kc-groupid-mapper
│   ├── keycloak-config
│   └── script
├── documentation-app
│   └── src
├── Gestionnaire de clef de répartition
│   ├── back_end
│   ├── front-end
│   ├── Generators
│   └── SimulateurMS
├── Gestionnaire de communautés
│   ├── back_end
│   ├── community-back-end
│   └── front-end
├── Gestionnaire de documents
│   ├── back-end
│   ├── back-end-database
│   └── front-end
├── Gestionnaire de membres
│   ├── back_end
│   ├── front-end
│   └── members_database_back_end
├── images
├── KarateTesting
│   └── KarateMaven
├── optimce-app
│   ├── apps
│   └── libs
├── proxies
│   ├── back_end_proxy
│   └── front-end-orchestrator
├── services
│   ├── notification_back_end
│   └── openfiles
├── template
│   ├── back-end-database-template
│   ├── back-end-template
│   └── front-end-service
├── tools
│   ├── LoggingTracing
│   └── RSA_generation
└── Users
    ├── back-end
    ├── front-end
    └── users-back-end

66 directories
```

== Arborescence CI/CD <annex:cicd-file-tree>
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

== Workflow de test (test.yml) <annex:test-workflow>
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

== Configuration Dependabot <annex:dependabot-config>
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

== Workflow Docker Build & Publish <annex:docker-build-publish>
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

== Workflow de mise à jour de la documentation <annex:update-docs-workflow>
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

== Commandes npm Swagger <annex:swagger-npm-commands>
```sh
    npm run swagger
    npm run swagger:doc:md
    npm run swagger:doc:html
```

== Configuration Git Submodules <annex:gitmodules-config>
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

== Workflow Notify Monorepo <annex:notify-monorepo-workflow>
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

== Workflow Update Submodules <annex:update-submodules-workflow>
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
== EMS Global logic <annex:ems-global-logic>
```rust
use serde::{Deserialize, Serialize};

use crate::emsl::EmslData;

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct EmsgData {
    pub emsl_vector: Vec<EmslData>,
    pub emsg_delta: f64,
    pub emsg_elastic_consumption_available: f64,
    pub emsg_delta_from_net_producer: f64,
    pub emsg_delta_from_net_consumer: f64,
    pub emsg_net_producer_count: usize,
    pub emsg_net_consumer_count: usize,
    pub scenario: u8,
}

impl EmsgData {
    pub fn new() -> Self {
        Self::default()
    }

    fn deficit_emsl_indices(&self) -> Vec<usize> {
        self.emsl_vector
            .iter()
            .enumerate()
            .filter(|(_, e)| e.delta.unwrap_or(0.0) < 0.0)
            .map(|(i, _)| i)
            .collect()
    }

    pub fn get_emsl_index(&self, topic: &str) -> Option<usize> {
        self.emsl_vector.iter().position(|e| e.topic == topic)
    }

    pub fn len(&self) -> usize {
        self.emsl_vector.len()
    }

    pub fn is_empty(&self) -> bool {
        self.emsl_vector.is_empty()
    }

    pub fn find_emsl(&self, topic: &str) -> Option<&EmslData> {
        self.emsl_vector.iter().find(|e| e.topic == topic)
    }

    pub fn get_allowance_for_topic(&self, topic: &str) -> Option<f64> {
        self.find_emsl(topic).and_then(|e| e.allowance)
    }

    pub fn remove_emsl(&mut self, topic: &str) -> Option<EmslData> {
        if let Some(index) = self.get_emsl_index(topic) {
            let removed = self.emsl_vector.remove(index);
            self.recalculate_global_state();
            self.recalculate_allowances();
            Some(removed)
        } else {
            None
        }
    }

    pub fn clear(&mut self) {
        self.emsl_vector.clear();
        self.emsg_delta = 0.0;
        self.emsg_elastic_consumption_available = 0.0;
        self.emsg_delta_from_net_producer = 0.0;
        self.emsg_delta_from_net_consumer = 0.0;
        self.emsg_net_producer_count = 0;
        self.emsg_net_consumer_count = 0;
    }

    pub fn recalculate_global_state(&mut self) {
        self.emsg_delta = self.emsl_vector.iter().filter_map(|e| e.delta).sum();
        self.emsg_elastic_consumption_available = self
            .emsl_vector
            .iter()
            .filter_map(|e| e.elastic_consumption_available)
            .sum();
        self.recalculate_net_counts_and_deltas();
    }

    fn recalculate_net_counts_and_deltas(&mut self) {
        let mut producer_delta = 0.0;
        let mut consumer_delta = 0.0;
        let mut producer_count = 0;
        let mut consumer_count = 0;
        for emsl in &self.emsl_vector {
            if let Some(delta) = emsl.delta {
                if delta > 0.0 {
                    producer_delta += delta;
                    producer_count += 1;
                } else if delta < 0.0 {
                    consumer_delta += delta.abs();
                    consumer_count += 1;
                }
            }
        }
        self.emsg_delta_from_net_producer = producer_delta;
        self.emsg_delta_from_net_consumer = consumer_delta;
        self.emsg_net_producer_count = producer_count;
        self.emsg_net_consumer_count = consumer_count;
    }

    fn recalculate_allowances(&mut self) {
        if self.emsl_vector.is_empty() {
            return;
        }


        self.update_scenario();
        let deficit_count = self.emsg_net_consumer_count;
        let deficit_indices = self.deficit_emsl_indices();

        match self.scenario {
            1 => {}
            2 => self.apply_scenario_2_excess(&deficit_indices),
            3 => self.apply_scenario_3_insufficient(deficit_count, &deficit_indices),
            _ => {}
        }
    }

    fn update_scenario(&mut self) {
        self.scenario = if self.emsg_delta < 0.0 {
            1 // DEFICIT
        } else if self.emsg_delta >= self.emsg_elastic_consumption_available {
            2 // EXCESS
        } else {
            3 // INSUFFICIENT
        };
    }

    fn apply_scenario_2_excess(&mut self, deficit_indices: &[usize]) {
        for &i in deficit_indices {
            let elastic = self.emsl_vector[i]
                .elastic_consumption_available
                .unwrap_or(0.0);
            self.emsl_vector[i].allowance = Some(elastic);
        }
    }

    fn apply_scenario_3_insufficient(&mut self, deficit_count: usize, deficit_indices: &[usize]) {
        if deficit_count == 0 {
            return;
        }
        self.split_equally_mathematicaly_correct(deficit_count, deficit_indices);
    }

    // fn split_equally(&mut self, deficit_count: usize, deficit_indices: &[usize]) {
    //     let share = self.emsg_delta / deficit_count as f64;
    //     for &i in deficit_indices {
    //         let elastic = self.emsl_vector[i]
    //             .elastic_consumption_available
    //             .unwrap_or(0.0);
    //         let allowance = elastic.min(share);
    //         self.emsl_vector[i].allowance = Some(allowance);
    //     }
    // }

    fn split_equally_mathematicaly_correct(
        &mut self,
        deficit_count: usize,
        deficit_indices: &[usize],
    ) {
        if deficit_count == 0 || self.emsg_delta <= 0.0 {
            return;
        }

        let mut items: Vec<(usize, f64)> = deficit_indices
            .iter()
            .map(|&i| {
                (
                    i,
                    self.emsl_vector[i]
                        .elastic_consumption_available
                        .unwrap_or(0.0),
                )
            })
            .collect();
        items.sort_by(|a, b| a.1.partial_cmp(&b.1).unwrap_or(std::cmp::Ordering::Equal));

        let mut remaining_surplus = self.emsg_delta;
        let mut remaining_count = items.len();

        for (idx, elastic) in items {
            if remaining_count == 0 || remaining_surplus <= 0.0 {
                self.emsl_vector[idx].allowance = Some(0.0);
                continue;
            }
            let fair_share = remaining_surplus / remaining_count as f64;
            if fair_share <= elastic {
                self.emsl_vector[idx].allowance = Some(fair_share);
                remaining_surplus -= fair_share;
                remaining_count -= 1;
            } else {
                self.emsl_vector[idx].allowance = Some(elastic);
                remaining_surplus -= elastic;
                remaining_count -= 1;
            }
        }
    }

    pub fn scenario_name(&self) -> &'static str {
        match self.scenario {
            1 => "DEFICIT",
            2 => "EXCESS",
            3 => "INSUFFICIENT",
            _ => "UNKNOWN",
        }
    }

    pub fn update_emsl(
        &mut self,
        topic: &str,
        production: Option<f64>,
        consumption: Option<f64>,
        elastic_consumption_available: Option<f64>,
    ) -> f64 {
        let idx = self.get_emsl_index(topic);

        match idx {
            Some(i) => {
                self.update_existing_emsl_impl(
                    i,
                    production,
                    consumption,
                    elastic_consumption_available,
                );
                self.recalculate_allowances();
                self.emsl_vector[i].allowance.unwrap_or(0.0)
            }
            None => {
                self.create_new_emsl_impl(
                    topic,
                    production,
                    consumption,
                    elastic_consumption_available,
                );
                self.recalculate_allowances();
                self.emsl_vector.last().unwrap().allowance.unwrap_or(0.0)
            }
        }
    }

    fn update_existing_emsl_impl(
        &mut self,
        idx: usize,
        production: Option<f64>,
        consumption: Option<f64>,
        elastic_consumption_available: Option<f64>,
    ) -> f64 {
        let old_delta = self.emsl_vector[idx].delta.unwrap_or(0.0);

        self.emsl_vector[idx].production = production;
        self.emsl_vector[idx].consumption = consumption;

        let new_delta = EmslData::calculate_delta(production, consumption);
        self.emsl_vector[idx].delta = new_delta;

        let delta_value = new_delta.unwrap_or(0.0);
        self.emsg_delta += delta_value - old_delta;

        let old_elastic = self.emsl_vector[idx]
            .elastic_consumption_available
            .unwrap_or(0.0);
        let new_elastic = elastic_consumption_available.unwrap_or(0.0);
        self.emsl_vector[idx].elastic_consumption_available = elastic_consumption_available;
        self.emsg_elastic_consumption_available += new_elastic - old_elastic;

        let was_producer = old_delta > 0.0;
        let was_consumer = old_delta < 0.0;
        let is_producer = delta_value > 0.0;
        let is_consumer = delta_value < 0.0;

        if was_producer && !is_producer {
            self.emsg_net_producer_count -= 1;
            self.emsg_delta_from_net_producer -= old_delta;
        } else if !was_producer && is_producer {
            self.emsg_net_producer_count += 1;
            self.emsg_delta_from_net_producer += delta_value;
        } else if was_producer && is_producer {
            self.emsg_delta_from_net_producer += delta_value - old_delta;
        }

        if was_consumer && !is_consumer {
            self.emsg_net_consumer_count -= 1;
            self.emsg_delta_from_net_consumer -= old_delta.abs();
        } else if !was_consumer && is_consumer {
            self.emsg_net_consumer_count += 1;
            self.emsg_delta_from_net_consumer += delta_value.abs();
        } else if was_consumer && is_consumer {
            self.emsg_delta_from_net_consumer += delta_value.abs() - old_delta.abs();
        }

        self.emsl_vector[idx].allowance.unwrap_or(0.0)
    }

    fn create_new_emsl_impl(
        &mut self,
        topic: &str,
        production: Option<f64>,
        consumption: Option<f64>,
        elastic_consumption_available: Option<f64>,
    ) -> f64 {
        let delta = EmslData::calculate_delta(production, consumption);
        let delta_value = delta.unwrap_or(0.0);

        self.emsl_vector.push(EmslData {
            topic: topic.to_string(),
            production,
            consumption,
            delta,
            allowance: Some(0.0),
            elastic_consumption_available,
        });

        self.emsg_delta += delta_value;

        let elastic = elastic_consumption_available.unwrap_or(0.0);
        self.emsg_elastic_consumption_available += elastic;

        if delta_value > 0.0 {
            self.emsg_net_producer_count += 1;
            self.emsg_delta_from_net_producer += delta_value;
        } else if delta_value < 0.0 {
            self.emsg_net_consumer_count += 1;
            self.emsg_delta_from_net_consumer += delta_value.abs();
        }

        delta_value
    }

    pub fn get_effective_allowance(&self) -> f64 {
        self.emsl_vector.iter().filter_map(|e| e.allowance).sum()
    }

    pub fn get_grid_injected(&self) -> f64 {
        (self.emsg_delta - self.get_effective_allowance()).max(0.0)
    }

    pub fn get_total_production(&self) -> f64 {
        self.emsl_vector.iter().filter_map(|e| e.production).sum()
    }

    pub fn get_total_consumption(&self) -> f64 {
        self.emsl_vector.iter().filter_map(|e| e.consumption).sum()
    }

    pub fn get_surplus(&self) -> f64 {
        self.emsg_delta.max(0.0)
    }

    pub fn get_deficit(&self) -> f64 {
        self.emsg_delta.min(0.0).abs()
    }

    pub fn get_surplus_count(&self) -> usize {
        self.emsg_net_producer_count
    }

    pub fn get_deficit_count(&self) -> usize {
        self.emsg_net_consumer_count
    }

    pub fn get_summary(&self) -> EmsgSummary {
        EmsgSummary {
            emsl_count: self.emsl_vector.len(),
            emsg_delta: self.emsg_delta,
            emsg_elastic: self.emsg_elastic_consumption_available,
            effective_allowance: self.get_effective_allowance(),
            grid_injected: self.get_grid_injected(),
            total_production: self.get_total_production(),
            total_consumption: self.get_total_consumption(),
            surplus_count: self.get_surplus_count(),
            deficit_count: self.get_deficit_count(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct EmsgSummary {
    pub emsl_count: usize,
    pub emsg_delta: f64,
    pub emsg_elastic: f64,
    pub effective_allowance: f64,
    pub grid_injected: f64,
    pub total_production: f64,
    pub total_consumption: f64,
    pub surplus_count: usize,
    pub deficit_count: usize,
}
```