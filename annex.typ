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
== Docker Compose pour développement local <annex:docker-compose-dev>
```yaml
services:
  crm-database:
    profiles: ["dev"]
    image: postgres:18-alpine@sha256:4da1a4828be12604092fa55311276f08f9224a74a62dcb4708bd7439e2a03911
    restart: unless-stopped
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_DB=crm_db
      - POSTGRES_PASSWORD=${CRM_DB_PASSWORD}
    volumes:
      - ./crm-backend/tests/sql/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    ports:
      - "8080:5432"
    networks:
      - backend
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -h localhost || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  keycloak-db:
    profiles: ["dev"]
    image: postgres:18-alpine@sha256:4da1a4828be12604092fa55311276f08f9224a74a62dcb4708bd7439e2a03911
    restart: unless-stopped
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_DB=keycloak
      - POSTGRES_PASSWORD=${KEYCLOAK_DB_PASSWORD}
    ports:
      - "8081:5432"
    networks:
      - backend
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -h localhost || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  allocation-key-db:
    profiles: ["dev"]
    image: postgres:18-alpine@sha256:4da1a4828be12604092fa55311276f08f9224a74a62dcb4708bd7439e2a03911
    restart: unless-stopped
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_DB=allocation_key_local
      - POSTGRES_PASSWORD=${ALLOCATION_KEY_DB_PASSWORD}
    volumes:
      - ./allocation-key-generation/scripts/sql/schema.sql:/docker-entrypoint-initdb.d/init.sql:ro
    ports:
      - "8093:5432"
    networks:
      - backend
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -h localhost || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  keycloak:
    profiles: ["dev"]
    build:
      context: keycloak
      dockerfile: Dockerfile
    restart: unless-stopped
    command:
      [
        "start-dev",
        "--import-realm",
        "--verbose",
        "--proxy-headers=xforwarded",
        "--http-relative-path=/keycloak",
      ]
    environment:
      - KEYCLOAK_ADMIN=admin
      - KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_BOOTSTRAP_ADMIN_PASSWORD}
      - KEYCLOAK_IMPORT=/opt/keycloak/data/import/realm-config.json
      - KC_DB=postgres
      - KC_DB_URL=jdbc:postgresql://keycloak-db:5432/keycloak
      - KC_DB_USERNAME=postgres
      - KC_DB_PASSWORD=${KEYCLOAK_DB_PASSWORD}
      - KC_HOSTNAME=${KEYCLOAK_HOSTNAME}
      - KC_HOSTNAME_PORT=8087
      - KC_HTTP_ENABLED=true
      - KC_BOOTSTRAP_ADMIN_USERNAME=admin
      - KC_BOOTSTRAP_ADMIN_PASSWORD=${KEYCLOAK_BOOTSTRAP_ADMIN_PASSWORD}
    ports:
      - "8082:8080"
    networks:
      - backend
      - reverse-proxy
    depends_on:
      keycloak-db:
        condition: service_healthy
      keycloak-config:
        condition: service_completed_successfully
    volumes:
      - ./keycloak/realm/dev-config.json:/opt/keycloak/data/import/realm-config.json

  minio:
    profiles: ["dev"]
    image: pgsty/minio:latest
    command: server /data --console-address ":9001"
    restart: unless-stopped
    environment:
      - MINIO_ROOT_USER=${MINIO_ROOT_USER:-minioadmin}
      - MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-minioadmin}
    ports:
      - "8091:9000"
      - "8092:9001"
    volumes:
      - minio_data:/data
    networks:
      - backend
      - reverse-proxy
    healthcheck:
      test: ["CMD", "mc", "ready", "local"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 10s

  minio-init:
    profiles: ["dev"]
    image: pgsty/mc:latest
    depends_on:
      minio:
        condition: service_healthy
    environment:
      - MINIO_ROOT_USER=${MINIO_ROOT_USER:-minioadmin}
      - MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD:-minioadmin}
      - STORAGE_BUCKET=${STORAGE_BUCKET:-crm-files}
    entrypoint: >
      /bin/sh -c "
      sleep 5;
      mc alias set local ${STORAGE_API_URL} $${MINIO_ROOT_USER:-minioadmin} $${MINIO_ROOT_PASSWORD:-minioadmin};
      mc mb --ignore-existing local/$${STORAGE_BUCKET:-crm-files};
      exit 0;
      "
    networks:
      - backend

  nats:
    profiles: ["dev"]
    image: nats:2.10-alpine
    restart: unless-stopped
    command: ["-js", "-m", "8222", "-sd", "/data"]
    ports:
      - "8094:4222"
      - "8095:8222"
    volumes:
      - nats_data:/data
    networks:
      - backend
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "wget -q -O - 'http://localhost:8222/healthz?js-enabled-only=true' || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 15s

  jaeger:
    profiles: ["dev"]
    image: jaegertracing/jaeger:latest@sha256:bf7f805da4c2bc8d58a6c81ee650fdb6b8e4287698f95fbe231c09c865bc397f
    restart: unless-stopped
    ports:
      - "8084:6831/udp"
      - "8085:16686"
    environment:
      - COLLECTOR_OTLP_ENABLED=true
    networks:
      - backend

  swagger-doc-gen:
    profiles: ["init", "dev"]
    build:
      context: crm-backend
      dockerfile: Dockerfile.dev
    volumes:
      - ./krakend/config:/app/docs/openapi
    command: sh -c "npm run swagger && sleep 3 && mv /app/docs/openapi/swagger.yaml /app/docs/openapi/root.yaml"

  generation-doc-gen:
    profiles: ["init", "dev"]
    build:
      context: allocation-key-generation
      dockerfile: Dockerfile
    volumes:
      - ./krakend/config:/output
    environment:
      - ENV=local
      - CRM_DATABASE_URL=postgresql+asyncpg://placeholder:placeholder@placeholder:5432/placeholder
      - LOCAL_DATABASE_URL=postgresql+asyncpg://placeholder:placeholder@placeholder:5432/placeholder
      - ALLOW_ORIGIN=*
    entrypoint: ["python", "scripts/export_openapi.py", "/output/generation.json"]

  krakend-config:
    profiles: ["init", "dev"]
    build:
      context: krakend/swagger2krakend
      dockerfile: Dockerfile
    volumes:
      - ./krakend/config:/config
    environment:
      - CONFIG_FILE=/config/krakend-builder.yaml
      - OUTPUT_FILE=/config/krakend.json
    depends_on:
      swagger-doc-gen:
        condition: service_completed_successfully
      generation-doc-gen:
        condition: service_completed_successfully

  krakend:
    profiles: ["dev"]
    image: krakend:latest@sha256:bd392b692271209927da6c62f1b42d7f8f7bd0cd60b00d97c93bb5b8d42b4999
    ports:
      - "8086:8080"
    volumes:
      - ./krakend/config:/etc/krakend
    networks:
      - backend
      - reverse-proxy
    depends_on:
      crm-backend:
        condition: service_started
      allocation-key-generation:
        condition: service_started
      keycloak:
        condition: service_started

  reverse-proxy:
    profiles: ["dev"]
    image: nginx:latest@sha256:7150b3a39203cb5bee612ff4a9d18774f8c7caf6399d6e8985e97e28eb751c18
    ports:
      - "8087:80"
      - "8088:443"
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
      - ./nginx/certs:/etc/nginx/certs
    networks:
      - reverse-proxy
    depends_on:
      nginx-config:
        condition: service_completed_successfully
      krakend:
        condition: service_started

  crm-backend:
    profiles: ["dev"]
    build:
      context: crm-backend
      dockerfile: Dockerfile.dev
    command: npm run dev
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - PORT=80
      - MICROSERVICE_NAME=crm-backend
      - ALLOWED_ORIGIN=${APP_CORS_ALLOWED_ORIGIN}
      - SERVER_HOST=0.0.0.0
      - SERVER_PORT=80
      - IAM_SERVICE_NAME=KEYCLOAK
      - IAM_REALM=optimce-realm
      - IAM_REALM_NAME=optimce-realm
      - IAM_BASE_URL=http://keycloak:8080/keycloak
      - IAM_CLIENT_ID=optimce-backend
      - IAM_GRANT_TYPE=client_credentials
      - IAM_CLIENT_SECRET=${AUTH_CLIENT_SECRET}
      - STORAGE_SERVICE_NAME=S3
      - STORAGE_ENDPOINT=${STORAGE_API_URL}
      - STORAGE_REGION=us-east-1
      - STORAGE_BUCKET=${STORAGE_BUCKET:-crm-files}
      - STORAGE_ACCESS_KEY=${MINIO_ROOT_USER:-minioadmin}
      - STORAGE_SECRET_KEY=${MINIO_ROOT_PASSWORD:-minioadmin}
      - STORAGE_PUBLIC_ENDPOINT=${MINIO_PUBLIC_ENDPOINT}
      - REMOTE_LOGGING=${REMOTE_LOGGING}
      - OTEL_EXPORTER_OTLP_ENDPOINT=${OTEL_EXPORTER_OTLP_ENDPOINT}
      - OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
      - DB_TYPE=postgres
      - DB_HOST=crm-database
      - DB_PORT=5432
      - DB_USERNAME=postgres
      - DB_PASSWORD=${CRM_DB_PASSWORD}
      - DB_NAME=crm_db
    ports:
      - "8089:80"
    networks:
      - backend
    depends_on:
      crm-database:
        condition: service_healthy
      minio-init:
        condition: service_completed_successfully
      jaeger:
        condition: service_started

  allocation-key-generation:
    profiles: ["dev"]
    build:
      context: allocation-key-generation
      dockerfile: Dockerfile
    restart: unless-stopped
    environment:
      - ENV=local
      - CRM_DATABASE_URL=postgresql+asyncpg://postgres:${CRM_DB_PASSWORD}@crm-database:5432/crm_db
      - LOCAL_DATABASE_URL=postgresql+asyncpg://postgres:${ALLOCATION_KEY_DB_PASSWORD}@allocation-key-db:5432/allocation_key_local
      - NATS_URL=nats://nats:4222
      - ALLOW_ORIGIN=*
      - CRM_DB_POOL_SIZE=5
      - CRM_DB_MAX_OVERFLOW=5
      - LOCAL_DB_POOL_SIZE=5
      - LOCAL_DB_MAX_OVERFLOW=5
      - STORAGE_ENDPOINT=${STORAGE_API_URL}
      - STORAGE_BUCKET=${STORAGE_BUCKET:-crm-files}
      - STORAGE_ACCESS_KEY=${MINIO_ROOT_USER:-minioadmin}
      - STORAGE_SECRET_KEY=${MINIO_ROOT_PASSWORD:-minioadmin}
      - STORAGE_REGION=us-east-1
    ports:
      - "8002:8000"
    networks:
      - backend
    depends_on:
      allocation-key-db:
        condition: service_healthy
      crm-database:
        condition: service_healthy
      nats:
        condition: service_healthy
      minio-init:
        condition: service_completed_successfully
    healthcheck:
      test:
        - "CMD-SHELL"
        - "python -c \"import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:8000/health/readiness', timeout=3).status==200 else 1)\""
      interval: 15s
      timeout: 5s
      retries: 5
      start_period: 45s

  allocation-key-generation-worker:
    profiles: ["dev"]
    build:
      context: allocation-key-generation
      dockerfile: Dockerfile.worker
    restart: unless-stopped
    environment:
      - ENV=local
      - CRM_DATABASE_URL=postgresql+asyncpg://postgres:${CRM_DB_PASSWORD}@crm-database:5432/crm_db
      - LOCAL_DATABASE_URL=postgresql+asyncpg://postgres:${ALLOCATION_KEY_DB_PASSWORD}@allocation-key-db:5432/allocation_key_local
      - NATS_URL=nats://nats:4222
      - ALLOW_ORIGIN=*
      - CRM_DB_POOL_SIZE=5
      - CRM_DB_MAX_OVERFLOW=5
      - LOCAL_DB_POOL_SIZE=5
      - LOCAL_DB_MAX_OVERFLOW=5
      - STORAGE_ENDPOINT=${STORAGE_API_URL}
      - STORAGE_BUCKET=${STORAGE_BUCKET:-crm-files}
      - STORAGE_ACCESS_KEY=${MINIO_ROOT_USER:-minioadmin}
      - STORAGE_SECRET_KEY=${MINIO_ROOT_PASSWORD:-minioadmin}
      - STORAGE_REGION=us-east-1
    networks:
      - backend
    depends_on:
      allocation-key-db:
        condition: service_healthy
      crm-database:
        condition: service_healthy
      nats:
        condition: service_healthy
      minio-init:
        condition: service_completed_successfully

  keycloak-config:
    profiles: ["init", "dev"]
    image: ghcr.io/ourouk/alpine-envsubst:main@sha256:10899e32576d793f054ddbf23889dc6ef6295726d350a377efc110a976c1a11e
    env_file:
      - .env.dev
    volumes:
      - ./keycloak/realm:/config
    command:
      - < /config/dev-config.template.json > /config/dev-config.json

  nginx-config:
    profiles: ["init", "dev"]
    image: ghcr.io/ourouk/alpine-envsubst:main@sha256:10899e32576d793f054ddbf23889dc6ef6295726d350a377efc110a976c1a11e
    env_file:
      - .env.dev
    environment:
      - CRM_FRONTEND_UPSTREAM=crm-frontend:80
      - KRAKEND_UPSTREAM=krakend:8080
      - KEYCLOAK_UPSTREAM=keycloak:8080
      - MINIO_UPSTREAM=minio:9000
      - CRM_FRONTEND_PROTOCOL=http
      - KRAKEND_PROTOCOL=http
      - KEYCLOAK_PROTOCOL=http
      - MINIO_PROTOCOL=http
    volumes:
      - ./nginx/conf-template.d:/config
      - ./nginx/conf.d:/output
    entrypoint: /bin/sh
    command:
      - "-c"
      - |
        if [ "${USE_HTTPS}" = "true" ]; then
          cp /config/default-https.template.conf /tmp/template.conf;
        else
          cp /config/default-http.template.conf /tmp/template.conf;
        fi
        envsubst < /tmp/template.conf | sed 's/§/$/g' > /output/default.conf

  crm-frontend-config:
    profiles: ["init", "dev"]
    image: ghcr.io/ourouk/alpine-envsubst:main@sha256:10899e32576d793f054ddbf23889dc6ef6295726d350a377efc110a976c1a11e
    env_file:
      - .env.dev
    volumes:
      - ./crm-frontend-config:/config
    command:
      - < /config/config.template.json > /config/config.json

  crm-frontend:
    profiles: ["dev"]
    build:
      context: crm-frontend
      dockerfile: Dockerfile
    volumes:
      - ./crm-frontend-config/config.json:/usr/share/nginx/html/assets/config/config.json
    environment:
      - NODE_ENV=production
    ports:
      - "8090:80"
    networks:
      - reverse-proxy

volumes:
  minio_data:
  nats_data:

networks:
  backend:
  reverse-proxy:
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
== Docker Compose production <annex:docker-compose-prod>
```yaml
services:
  # ============================================
  # INIT PROFILE - Configuration generation
  # ============================================
  swagger-doc-gen:
    profiles: ["init"]
    image: alpine/curl:latest
    command:
      - "-fL"
      - "https://optimce.github.io/crm-backend/swagger.yml"
      - "-o"
      - "/data/root.yaml"
    volumes:
      - ./krakend_config:/data:z
    restart: on-failure

  krakend-config:
    profiles: ["init"]
    image: ghcr.io/optimce/swagger2krakend:main
    volumes:
      - ./krakend_config:/config
    environment:
      - CONFIG_FILE=/config/krakend-builder.yaml
      - OUTPUT_FILE=/config/krakend.json
      - KEYCLOAK_URL=${AUTH_INTERNAL_URL}
      - REALM_NAME=${AUTH_REALM}
      - ISSUER=${DOMAIN}${WEB_AUTH_URL}/realms/${AUTH_REALM}
    restart: on-failure
    depends_on:
      swagger-doc-gen:
        condition: service_completed_successfully

  keycloak-config:
    profiles: ["init"]
    image: ghcr.io/ourouk/alpine-envsubst:main
    env_file:
      - .env
    volumes:
      - ./keycloak/realm:/config
    command:
      - < /config/prod-config.template.json > /config/prod-config.json

  nginx-config:
    profiles: ["init"]
    image: ghcr.io/ourouk/alpine-envsubst:main
    env_file:
      - .env
    volumes:
      - ./nginx/conf-template.d:/config
      - ./nginx/conf.d:/output
    entrypoint: /bin/sh
    command:
      - "-c"
      - |
        if [ "${USE_HTTPS}" = "true" ]; then
          cp /config/default-https.template.conf /tmp/template.conf;
        else
          cp /config/default-http.template.conf /tmp/template.conf;
        fi
        envsubst < /tmp/template.conf | sed 's/§/$/g' > /output/default.conf

  crm-frontend-config:
    profiles: ["init"]
    image: ghcr.io/ourouk/alpine-envsubst:main
    env_file:
      - .env
    volumes:
      - ./crm-frontend-config:/config
    command:
      - < /config/config.template.json > /config/config.json


  keycloak-group-id-mapper:
    profiles: ["init"]
    image: alpine/curl:latest
    command:
      - "-fL"
      - "https://github.com/OptimCE/kc-groupid-mapper/releases/download/v0.0.1/kc-groupid-mapper-1.0.0.jar"
      - "-o"
      - "/data/kc-groupid-mapper-1.0.0.jar"
    volumes:
      - ./keycloak/providers:/data:z
    restart: on-failure

  keycloak-optimce-theme:
    profiles: ["init"]
    image: alpine:3.20
    entrypoint: /bin/sh
    working_dir: /data
    volumes:
      - ./keycloak/providers:/data:z
    command:
      - "-c"
      - |
        set -eu
        apk add --no-cache curl unzip zip >/dev/null
        WORK=$$(mktemp -d)
        JAR=/data/keycloak-theme-for-kc-all-other-versions.jar
        curl -fsSL \
          https://github.com/OptimCE/optimce-keycloak-theme/releases/download/v0.0.2/keycloak-theme-for-kc-all-other-versions.jar \
          -o "$$WORK/src.jar"
        mkdir -p "$$WORK/unpacked"
        cd "$$WORK/unpacked"
        unzip -o "$$WORK/src.jar" >/dev/null
        if [ -d theme/keycloakify-starter ] && [ ! -d theme/optimce ]; then
          mv theme/keycloakify-starter theme/optimce
        fi
        mkdir -p META-INF
        echo '{"themes":[{"name":"optimce","types":["login"]}]}' > META-INF/keycloak-themes.json
        rm -f "$$JAR"
        zip -r "$$JAR" META-INF theme >/dev/null
        rm -rf "$$WORK"
    restart: on-failure
  # ============================================
  # BACKEND PROFILE - Databases and runtime
  # ============================================
  crm-database:
    profiles: ["backend"]
    image: postgres:18-alpine
    restart: unless-stopped
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_DB=crm_db
      - POSTGRES_PASSWORD=${CRM_DB_PASSWORD}
      - PGDATA=/var/lib/postgresql/data
    volumes:
      - crm_db_data:/var/lib/postgresql/data
      - ./crm-backend-db/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d
    networks:
      - crm
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -h localhost || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  keycloak-db:
    profiles: ["backend"]
    image: postgres:18-alpine
    restart: unless-stopped
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_DB=keycloak
      - POSTGRES_PASSWORD=${KEYCLOAK_DB_PASSWORD}
      - PGDATA=/var/lib/postgresql/data
    volumes:
      - keycloak_db_data:/var/lib/postgresql/data
    networks:
      - keycloak
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "pg_isready -U $$POSTGRES_USER -d $$POSTGRES_DB -h localhost || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s

  keycloak:
    profiles: ["backend"]
    image: quay.io/keycloak/keycloak:26.5.5@sha256:a7b0cb7a43a1235a61872883414d3f1d9a3ceac9df6e5907bd12202778a6265c
    restart: unless-stopped
    command:
      - "start"
      - "--import-realm"
      - "--health-enabled=true"
      - "--metrics-enabled=true"
      - "--proxy-headers=xforwarded"
      - "--http-relative-path=/keycloak"
    environment:
      - KC_BOOTSTRAP_ADMIN_USERNAME=admin
      - KC_BOOTSTRAP_ADMIN_PASSWORD=${KEYCLOAK_BOOTSTRAP_ADMIN_PASSWORD}
      - KEYCLOAK_IMPORT=/opt/keycloak/data/import/prod-config.json
      - KC_DB=postgres
      - KC_DB_URL=jdbc:postgresql://keycloak-db:5432/keycloak
      - KC_DB_USERNAME=postgres
      - KC_DB_PASSWORD=${KEYCLOAK_DB_PASSWORD}
      - KC_HOSTNAME=${KEYCLOAK_HOSTNAME}
      - KC_HTTP_ENABLED=true
      - KC_HEALTH_ENABLED=true
      - KC_METRICS_ENABLED=true
    volumes:
      - ./keycloak/realm/prod-config.json:/opt/keycloak/data/import/prod-config.json
      - ./keycloak/providers:/opt/keycloak/providers/
    networks:
      - keycloak
      - api-gateway
      - reverse-proxy
    depends_on:
      keycloak-db:
        condition: service_healthy



  keycloak-healthcheck:
    profiles: ["backend"]
    image: alpine/curl
    command: ["tail", "-f", "/dev/null"]
    networks:
      - keycloak
    depends_on:
      - keycloak
    restart: unless-stopped
    healthcheck:
      test:
        [
          "CMD-SHELL",
          "curl --head -fsS http://keycloak:9000/keycloak/health/ready || exit 1",
        ]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 60s

  minio:
    profiles: ["backend"]
    image: pgsty/minio:latest
    restart: unless-stopped
    command: server /data --console-address ":9001"
    environment:
      - MINIO_ROOT_USER=${MINIO_ROOT_USER}
      - MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
      - MINIO_SERVER_ADDRESS=:9000
    volumes:
      - minio_data:/data
    networks:
      - reverse-proxy
      - minio
    healthcheck:
      test: ["CMD", "mc", "ready", "local"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 10s

  minio-init:
    profiles: ["backend"]
    image: minio/mc:latest
    depends_on:
      minio:
        condition: service_healthy
    environment:
      - MINIO_ROOT_USER=${MINIO_ROOT_USER}
      - MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
      - STORAGE_BUCKET=${STORAGE_BUCKET}
    entrypoint: >
      /bin/sh -c "
      sleep 5;
      mc alias set local http://minio:9000 $${MINIO_ROOT_USER} $${MINIO_ROOT_PASSWORD};
      mc mb --ignore-existing local/$${STORAGE_BUCKET};
      exit 0;
      "
    networks:
      - minio

  krakend:
    profiles: ["backend"]
    image: krakend:latest
    volumes:
      - ./krakend_config:/etc/krakend
    networks:
      - api-gateway
      - reverse-proxy
    depends_on:
      crm-backend:
        condition: service_started
      keycloak:
        condition: service_started

  crm-backend:
    profiles: ["backend"]
    image: ghcr.io/optimce/crm-backend:main
    command: npm start
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - MICROSERVICE_NAME=crm-backend
      - ALLOWED_ORIGIN=${APP_CORS_ALLOWED_ORIGIN}
      - SERVER_HOST=0.0.0.0
      - SERVER_PORT=80
      - IAM_SERVICE_NAME=KEYCLOAK
      - IAM_REALM=${AUTH_REALM}
      - IAM_REALM_NAME=${AUTH_REALM}
      - IAM_BASE_URL=${AUTH_INTERNAL_URL}
      - IAM_CLIENT_ID=optimce-backend
      - IAM_GRANT_TYPE=client_credentials
      - IAM_CLIENT_SECRET=${AUTH_CLIENT_SECRET}
      - STORAGE_SERVICE_NAME=S3
      - STORAGE_ENDPOINT=http://minio:9000
      - STORAGE_REGION=us-east-1
      - STORAGE_BUCKET=${STORAGE_BUCKET}
      - STORAGE_ACCESS_KEY=${MINIO_ROOT_USER}
      - STORAGE_SECRET_KEY=${MINIO_ROOT_PASSWORD}
      - STORAGE_PUBLIC_ENDPOINT=${MINIO_PUBLIC_ENDPOINT}
      - REMOTE_LOGGING=${REMOTE_LOGGING}
      - OTEL_EXPORTER_OTLP_ENDPOINT=${OTEL_EXPORTER_OTLP_ENDPOINT}
      - OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
      - DB_TYPE=postgres
      - DB_HOST=crm-database
      - DB_PORT=5432
      - DB_USERNAME=postgres
      - DB_PASSWORD=${CRM_DB_PASSWORD}
      - DB_NAME=crm_db
    networks:
      - api-gateway
      - crm
      - keycloak
      - minio
      - opentelemetry
    depends_on:
      crm-database:
        condition: service_healthy
      keycloak-healthcheck:
        condition: service_healthy
      minio:
        condition: service_started

  # ============================================
  # MIGRATION PROFILE - CRM schema migrations
  # ============================================
  optimce-migrator:
    profiles: ["migration"]
    image: ghcr.io/optimce/migrator:main
    restart: "no"
    environment:
      - OPTIMCE_CRM_DATABASE_URL=postgresql+asyncpg://postgres:${CRM_DB_PASSWORD}@crm-database:5432/crm_db
    networks:
      - crm
    depends_on:
      crm-database:
        condition: service_healthy

  # ============================================
  # FRONTEND PROFILE - Web serving
  # ============================================
  reverse-proxy:
    profiles: ["frontend"]
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
      - ./nginx/certs:/etc/nginx/certs
    networks:
      - reverse-proxy
      - minio
      - api-gateway
      - keycloak
      - crm

  certbot:
    profiles: ["frontend"]
    image: certbot/certbot:latest
    volumes:
      - ./nginx/certs:/etc/letsencrypt
      - ./nginx/certbot-webroot:/webroot
    command: certonly --webroot -w /webroot -d ${DOMAIN_HOST} --agree-tos -m ${SSL_EMAIL} --non-interactive
    environment:
      - DOMAIN_HOST=${DOMAIN_HOST}
      - SSL_EMAIL=${SSL_EMAIL}

  crm-frontend:
    profiles: ["frontend"]
    image: ghcr.io/optimce/crm-frontend:main
    volumes:
      - ./crm-frontend-config/config.json:/usr/share/nginx/html/assets/config/config.json
    networks:
      - reverse-proxy

  # ============================================
  # BACKUP PROFILE - Database backups
  # ============================================
  crm-database-backup:
    profiles: ["backup"]
    image: postgres:18-alpine
    volumes:
      - ./backups:/backups
    environment:
      - PGPASSWORD=${CRM_DB_PASSWORD}
    command: >
      sh -c '
        pg_dump -h crm-database -U postgres -d crm_db -f /backups/crm_db_$(date +%Y%m%d_%H%M%S).sql ;
      '
    networks:
      - crm

  keycloak-db-backup:
    profiles: ["backup"]
    image: postgres:18-alpine
    volumes:
      - ./backups:/backups
    environment:
      - PGPASSWORD=${KEYCLOAK_DB_PASSWORD}
    command: >
      sh -c '
        pg_dump -h keycloak-db -U postgres -d keycloak -f /backups/keycloak_$(date +%Y%m%d_%H%M%S).sql ;
      '
    networks:
      - keycloak

volumes:
  crm_db_data:
  keycloak_db_data:
  minio_data:
  krakend_config:
  keycloak_data:

networks:
  reverse-proxy:
  api-gateway:
  crm:
  keycloak:
  minio:
  opentelemetry:
```
== Swagger to Krakend Yaml Builder Configuration <annex:swagger-to-krakend-config>
```yaml
global:
  # Global configurations applied to all endpoints (e.g. Auth validators)
  extra_config: ./config/auth.json
  # Variables that will be substituted in the global extra_config
  variables:
    KEYCLOAK_URL: http://keycloak:8080/keycloak
    REALM_NAME: optimce-realm
    ISSUER: http://localhost:8087/keycloak/realms/optimce-realm

services:
  # The key 'crm-backend' is the service name (used as the default prefix: /crm-backend/...)
  crm-backend:
    swagger: ./docs/openapi/swagger.yaml
    host: "http://crm-backend:80"
    # Specific per-service configuration (e.g. Rate limits)
    extra_config: ./config/ratelimit.json
    variables:
      max_rate: 100

  # 'root' is a special key that maps directly to the root path (/) by default
  root:
    swagger: ./config/root.yaml
    host: "http://crm-backend:80"
    
  # You can override the prefix explicitly
  microservice:
    swagger: ./microservice/openapi.yaml
    host: "http://microservice:8080"
    prefix: "/custom_prefix"
```
== Envsubstub Dockerfile <annex:envsubstub-dockerfile>
```yaml
FROM alpine:latest
RUN apk --no-cache add gettext
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]No
CMD ["envsubst"]
```
```shell
#!/bin/sh
set -e

# If first arg starts with < or contains >, it's likely shell syntax
# so run everything through sh -c
case "$1" in
    \<*|*\>*)
        echo "Executing command: envsubst $*"
        exec sh -c "envsubst $*"
        ;;
esac

# Prepend "envsubst" if the first argument is not an executable
if ! type -- "$1" &> /dev/null; then
    set -- envsubst "$@"
fi

# Show which command will be executed.
echo "Executing command: $*"

exec "$@"
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
= Mermaid Diagrams
== Abstract Refactored Architecture <annex:refactored-architecture>
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px"
  }
}}%%

graph TB

    %% ======================
    %% External
    %% ======================
    User[👤 Utilisateur<br/>Navigateur]

    %% ======================
    %% Docker Swarm Architecture
    %% ======================
    subgraph K8S["Docker Swarm"]

        %% ===== Edge =====
        subgraph EdgeNS["Namespace: edge"]
            Ingress[🌍 Ingress / LB]
            Krakend[🚪 Krakend<br/>API Gateway]
        end

        %% ===== Frontend =====
        subgraph FrontendNS["Namespace: frontend"]
            Angular[🅰 Angular App<br/>NGINX Pod]
        end

        %% ===== Security =====
        subgraph SecurityNS["Namespace: security"]
            Keycloak[🔐 Keycloak Pod]
            KCDB[(🗄 Keycloak DB)]
        end

        %% ===== Business =====
        subgraph BusinessNS["Namespace: business"]
            CRM[💼 CRM Service Pod]
            CRMDB[(🗄 CRM DB)]
            OpenFiles[📂 S3 Compatible Server]
        end

        %% ===== Event-driven =====
        subgraph EventNS["Namespace: event-services"]
            Notification[📨 Notification MS]
            TemplateGen[📝 Template Generator MS]
            KeyGen[🔑 Key Generation MS]
            KeySim[🧪 Key Simulation MS]
            KeyGenDB[(🗄 KeyGen DB)]
            KeySimDB[(🗄 KeySim DB)]
        end

        %% ===== Infra =====
        subgraph InfraNS["Namespace: infra"]
            EventBus[(📡 Event Bus)]
        end
    end

    %% ======================
    %% Connections
    %% ======================

    User --> Ingress

    Ingress --> Angular
    Ingress --> Krakend

    Angular --> Krakend

    Krakend --> Keycloak
    Krakend --> CRM
    Krakend --> Notification
    Krakend --> TemplateGen
    Krakend --> KeyGen
    Krakend --> KeySim

    Keycloak --> KCDB

    CRM --> CRMDB
    CRM --> OpenFiles
    CRM --> EventBus

    KeyGen --> KeyGenDB
    KeySim --> KeySimDB

    EventBus --> Notification
    EventBus --> TemplateGen
    EventBus --> KeyGen
    EventBus --> KeySim


    %% ======================
    %% Styling Classes
    %% ======================

    classDef edge fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#111827
    classDef frontend fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#111827
    classDef security fill:#fef3c7,stroke:#d97706,stroke-width:2px,color:#111827
    classDef business fill:#ede9fe,stroke:#7c3aed,stroke-width:2px,color:#111827
    classDef event fill:#fce7f3,stroke:#db2777,stroke-width:2px,color:#111827
    classDef infra fill:#e5e7eb,stroke:#4b5563,stroke-width:2px,color:#111827
    classDef database fill:#ffffff,stroke:#111827,stroke-width:2px,stroke-dasharray: 5 5

    class Ingress,Krakend edge
    class Angular frontend
    class Keycloak security
    class CRM,OpenFiles business
    class Notification,TemplateGen,KeyGen,KeySim event
    class EventBus infra
    class KCDB,CRMDB,KeyGenDB,KeySimDB database
```
== Docker Compose Dev Architecture <annex:docker-compose-dev-architecture>
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#ffffff",
    "primaryTextColor": "#111827",
    "primaryBorderColor": "#4b5563",
    "lineColor": "#6b7280",
    "secondaryColor": "#f9fafb",
    "tertiaryColor": "#ffffff"
  }
}}%%

flowchart TB

%% =========================
%% STYLE
%% =========================
classDef data fill:#E8F1FF,stroke:#2B5AA6,stroke-width:1px,color:#0B1F3A;
classDef identity fill:#E9FFF3,stroke:#1F7A4C,stroke-width:1px,color:#0B2E1A;
classDef app fill:#FFF4E5,stroke:#A66A00,stroke-width:1px,color:#3A2400;
classDef edge fill:#F3E8FF,stroke:#6B2FA3,stroke-width:1px,color:#220B3A;
classDef config fill:#F5F5F5,stroke:#666,stroke-width:1px,color:#222;

%% =========================
%% CONFIG LAYER (top support layer)
%% =========================
subgraph CONFIG["Configuration / Build-Time Pipeline"]
direction LR
SWAGGER["swagger-doc-gen"]
KRAKEND_CFG["krakend-config"]
NGINX_CFG["nginx-config"]
KEYCLOAK_CFG["keycloak-config"]
FRONTEND_CFG["crm-frontend-config"]

SWAGGER --> KRAKEND_CFG
end
class CONFIG config;

%% =========================
%% DATA LAYER
%% =========================
subgraph DATA["Data Layer"]
direction LR
CRM_DB["crm-database\n(Postgres)"]
KC_DB["keycloak-db\n(Postgres)"]
MINIO["minio\n(Object Storage)"]
MINIO_INIT["minio-init"]
JAEGER["jaeger\n(Tracing)"]

MINIO --> MINIO_INIT
end
class DATA data;

%% =========================
%% IDENTITY LAYER
%% =========================
subgraph IDENTITY["Identity & Access"]
direction LR
KEYCLOAK["keycloak"]
end
class IDENTITY identity;

KC_DB --> KEYCLOAK
KEYCLOAK_CFG --> KEYCLOAK

%% =========================
%% APPLICATION LAYER
%% =========================
subgraph APP["Application Layer"]
direction LR
CRM["crm-backend"]
KRAKEND["krakend\n(API Gateway)"]
end
class APP app;

CRM_DB --> CRM
MINIO_INIT --> CRM
JAEGER --> CRM
KEYCLOAK --> CRM

CRM --> KRAKEND
KEYCLOAK --> KRAKEND
KRAKEND_CFG --> KRAKEND

%% =========================
%% EDGE / DELIVERY LAYER
%% =========================
subgraph EDGE["Edge & Delivery"]
direction LR
FRONTEND["crm-frontend"]
NGINX["reverse-proxy (Nginx)"]
end
class EDGE edge;

FRONTEND_CFG --> FRONTEND

FRONTEND --> NGINX
KRAKEND --> NGINX
KEYCLOAK --> NGINX
MINIO --> NGINX
NGINX_CFG --> NGINX

%% =========================
%% ENTRY POINT
%% =========================
USER((User))
USER --> NGINX
```
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#ffffff",
    "primaryTextColor": "#111827",
    "primaryBorderColor": "#4b5563",
    "lineColor": "#6b7280",
    "secondaryColor": "#f9fafb",
    "tertiaryColor": "#ffffff"
  }
}}%%

flowchart LR

    subgraph CorePlatform[Core Platform]
        CRMBackend
        AKG
        AKGWorker
    end

    subgraph SharedInfra[Shared Infrastructure]
        NATS
        MinIO
        Jaeger
    end

    subgraph Persistence[Persistence Layer]
        CRMDB[(CRM DB)]
        AKGDB[(Allocation DB)]
        KeycloakDB[(Keycloak DB)]
    end

    subgraph Security[Security]
        Keycloak
    end

    CRMBackend --> CRMDB
    CRMBackend --> Keycloak
    CRMBackend --> Jaeger

    AKG --> CRMDB
    AKG --> AKGDB
    AKG --> NATS
    AKG --> MinIO

    AKGWorker --> CRMDB
    AKGWorker --> AKGDB
    AKGWorker --> NATS
    AKGWorker --> MinIO

    Keycloak --> KeycloakDB
```
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#ffffff",
    "primaryTextColor": "#111827",
    "primaryBorderColor": "#4b5563",
    "lineColor": "#6b7280",
    "secondaryColor": "#f9fafb",
    "tertiaryColor": "#ffffff"
  }
}}%%

flowchart TB

    subgraph Sources[Configuration Sources]
        ENV[Environment Variables]
        FILES[Template Files]
        SECRETS[Secrets / Credentials]
        COMPOSE[Docker Compose Definitions]
    end

    subgraph Generation[Configuration Generation]
        INIT[Entrypoint Init Scripts]
        TEMPLATE[Template Engine]
        MERGE[Configuration Merge Logic]
    end

    subgraph Outputs[Generated Runtime Config]
        KRAKENDCFG[KrakenD Configuration]
        NGINXCFG[NGINX Configuration]
        SERVICECFG[Service Runtime Config]
        KC_CFG[Keycloak Runtime Config]
    end

    subgraph Runtime[Running Containers]
        KrakenD
        NGINX
        CRMBackend
        Keycloak
    end

    ENV --> INIT
    FILES --> TEMPLATE
    SECRETS --> MERGE
    COMPOSE --> MERGE

    INIT --> TEMPLATE
    TEMPLATE --> MERGE

    MERGE --> KRAKENDCFG
    MERGE --> NGINXCFG
    MERGE --> SERVICECFG
    MERGE --> KC_CFG

    KRAKENDCFG --> KrakenD
    NGINXCFG --> NGINX
    SERVICECFG --> CRMBackend
    KC_CFG --> Keycloak
```
=== General Configuration Generation Logic <annex:general-config-generation-logic>
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#ffffff",
    "primaryTextColor": "#111827",
    "primaryBorderColor": "#4b5563",
    "lineColor": "#6b7280",
    "secondaryColor": "#f9fafb",
    "tertiaryColor": "#ffffff"
  }
}}%%

flowchart TB

    subgraph Sources[Configuration Sources]
        ENV[Environment Variables]
        FILES[Template Files]
        SECRETS[Secrets / Credentials]
        COMPOSE[Docker Compose Definitions]
    end

    subgraph Generation[Configuration Generation]
        INIT[Entrypoint Init Scripts]
        TEMPLATE[Template Engine]
        MERGE[Configuration Merge Logic]
    end

    subgraph Outputs[Generated Runtime Config]
        KRAKENDCFG[KrakenD Configuration]
        NGINXCFG[NGINX Configuration]
        SERVICECFG[Service Runtime Config]
        KC_CFG[Keycloak Runtime Config]
    end

    subgraph Runtime[Running Containers]
        KrakenD
        NGINX
        CRMBackend
        Keycloak
    end

    ENV --> INIT
    FILES --> TEMPLATE
    SECRETS --> MERGE
    COMPOSE --> MERGE

    INIT --> TEMPLATE
    TEMPLATE --> MERGE

    MERGE --> KRAKENDCFG
    MERGE --> NGINXCFG
    MERGE --> SERVICECFG
    MERGE --> KC_CFG

    KRAKENDCFG --> KrakenD
    NGINXCFG --> NGINX
    SERVICECFG --> CRMBackend
    KC_CFG --> Keycloak
```

== CI/CD Pipeline <annex:cicd-pipeline>
```mermaid
%%{init: {
  "theme": "neutral",
  "themeVariables": {
    "fontFamily": "Inter, Segoe UI, sans-serif",
    "fontSize": "14px",
    "primaryColor": "#ffffff",
    "primaryTextColor": "#111827",
    "primaryBorderColor": "#4b5563",
    "lineColor": "#6b7280",
    "secondaryColor": "#f9fafb",
    "tertiaryColor": "#ffffff"
  },
  "flowchart": {
    "nodeSpacing": 30,
    "rankSpacing": 40,
    "curve": "basis"
  }
}}%%

graph TB

    PushPR(("Push / Pull Request")) --> Branch{"main branch ?"}

    Branch -->|oui| Test["Test"]
    Branch -->|non| TestOnly["Test"]
    Branch -->|oui| Security["Sécurité"]
    Branch -->|non| SecurityOnly["Sécurité"]

    subgraph TestRunner["Tests"]
        Lint["Lint<br/>ESLint / Ruff / SQLFluff"]
        Unit["Tests unitaires<br/>npm test"]
        Integ["Tests intégration<br/>npm run test-all"]
        Lint --> Unit --> Integ
    end

    Test --> TestRunner

    subgraph SecurityRunner["Sécurité"]
        CodeQL["CodeQL Scan<br/>Vulnérabilités"]
        Dependabot["Dependabot<br/>Dépendances npm/Docker"]
        Dependabot -.-> AutoPR["Pull Request auto<br/>Mise à jour sécurité"]
    end

    Security --> SecurityRunner

    TestRunner -->|"push main"| DockerBuild["Docker Build & Publish"]
    SecurityRunner -->|"push main"| DockerBuild

    subgraph DockerRunner["Docker"]
        Build["Docker Buildx<br/>Multi-platform"]
        Sign["Cosign Sign<br/>Keyless Sigstore"]
        Push["Push to GHCR"]
        Build --> Sign --> Push
    end

    DockerBuild --> DockerRunner

    DockerRunner --> Doc["Update Documentation"]
    DockerRunner --> Notify["Notify Monorepo"]

    subgraph DocRunner["Documentation"]
        Swagger["Generate Swagger<br/>OpenAPI"]
        Pages["Deploy GitHub Pages"]
        Swagger --> Pages
    end

    Doc --> DocRunner

    subgraph NotifRunner["Synchronisation"]
        Dispatch["repository_dispatch<br/>Payload: composant modifié"]
        Submodule["Monorepo staging<br/>Submodule mis à jour"]
        Dispatch --> Submodule
    end

    Notify --> NotifRunner
```

== Configuration DevContainer <annex:devcontainer-config>
```json
{
	"name": "Node.js & TypeScript",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	"image": "mcr.microsoft.com/devcontainers/typescript-node:4-24-trixie",
	"features": {
		"ghcr.io/devcontainers/features/github-cli:1": {}
	},
	// Mount an optional volume to have git working properly
	"mounts": [
		"source=${localWorkspaceFolder}/../.git/modules/crm-backend,target=/workspaces/.git/modules/crm-backend,type=bind"
	]
	// Features to add to the dev container. More info: https://containers.dev/features.
	// "features": {},

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	// "forwardPorts": [],

	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "yarn install",

	// Configure tool-specific properties.
	// "customizations": {},

	// Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
	// "remoteUser": "root"
}
```

#pagebreak()
= Liens avec les Objectifs de Développement Durable (ODD)

Ce mémoire et le projet Locomotrice s'inscrivent directement dans la réalisation de plusieurs Objectifs de Développement Durable (ODD) définis par l'Organisation des Nations Unies, visant à relever les défis de la transition énergétique, de la résilience communautaire et de l'innovation technologique.

== ODD 7 : Énergie propre et d'un coût abordable
La plateforme *OptimCE* est conçue pour faciliter la gestion et le développement des communautés d'énergie (CEC et CER). Ces entités permettent aux citoyens, PME et autorités locales de produire, consommer et s'échanger de l'énergie renouvelable localement. En mutualisant les ressources, elles rendent l'énergie propre beaucoup plus accessible et abordable, tout en réduisant la dépendance vis-à-vis des acteurs traditionnels du marché.

== ODD 9 : Industrie, innovation et infrastructure
La refonte architecturale abordée dans ce travail (passage d'un monolithe distribué vers une approche modulaire stable, mise en place de l'outillage DevOps, pipelines CI/CD) crée une infrastructure logicielle résiliente et pérenne. Par ailleurs, la démarche même du projet, soit le passage vers un modèle logiciel collaboratif et *open-source*, favorise l'innovation partagée où différentes entreprises et institutions peuvent baser leur développement sur une fondation commune et optimisée (baisse de consommation mémoire drastique).

== ODD 11 : Villes et communautés durables
Les communautés d'énergie transforment le modèle énergétique des villes et des villages en créant des structures énergétiques participatives réparties. En rapprochant la production de la consommation, les réseaux de distribution locaux sont moins sujets aux pertes liées au transport. De ce fait, elles contribuent directement à impliquer les citoyens dans un environnement de vie solidaire et plus durable.

== ODD 12 : Consommation et production responsables
Le projet Locomotrice, qui intègre les volets d'OptimCE et l'EMS de l'ULiège (Energy Management System), encourage une production mesurée et un suivi intelligent de la consommation. Les gestionnaires de clefs de répartition permettent de distribuer l'énergie au moment de l'offre locale maximale, incitant ainsi les membres à adapter ou automatiser leur consommation énergétique en fonction de la production d'énergie verte.

== ODD 13 : Mesures relatives à la lutte contre les changements climatiques
En promouvant de nouveaux acteurs coopératifs entièrement dédiés aux énergies renouvelables et exempts de la pression à la rentabilité typique des acteurs traditionnels, l'infrastructure soutient les vastes stratégies de l'Union européenne visant la décarbonisation. Elle joue donc un rôle direct et technique de lutte continue face à l'urgence climatique mondiale.
