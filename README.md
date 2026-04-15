# Upload Widget Server

A RESTful API for uploading and managing images, built with Fastify, Drizzle ORM, and Cloudflare R2 storage.

## Features

- Upload images (JPG, JPEG, PNG, WEBP) up to 2MB to Cloudflare R2
- List uploads with search, sorting, and pagination
- Export uploads list as a CSV file streamed directly to R2
- OpenAPI documentation via Swagger UI at `/docs`

## Tech Stack

- **Runtime**: Node.js with TypeScript
- **Framework**: Fastify 5 + fastify-type-provider-zod
- **Database**: PostgreSQL via Drizzle ORM
- **Storage**: Cloudflare R2 (S3-compatible)
- **Validation**: Zod
- **Linting**: Biome
- **Testing**: Vitest

## Requirements

- Node.js 20+
- Docker & Docker Compose
- A Cloudflare R2 bucket

## Getting Started

### 1. Clone and install dependencies

```bash
npm install
```

### 2. Configure environment variables

Copy the example below into a `.env` file at the project root:

```env
PORT=3333
NODE_ENV=development

# Database
POSTGRES_USER=docker
POSTGRES_PASSWORD=docker
POSTGRES_DB=upload
DATABASE_URL="postgresql://docker:docker@upload-widget-db:5432/upload"

# Cloudflare R2
CLOUDFLARE_ACCOUNT_ID=
CLOUDFLARE_ACCESS_KEY_ID=
CLOUDFLARE_SECRET_ACCESS_KEY=
CLOUDFLARE_BUCKET=
CLOUDFLARE_PUBLIC_URL=
```

### 3. Start the database

```bash
docker-compose up -d db
```

### 4. Run migrations

```bash
npm run db:migrate
```

### 5. Start the development server

```bash
npm run dev
```

The server will be available at `http://localhost:3333`.  
API docs: `http://localhost:3333/docs`

## Running with Docker

To run the full stack (API + database):

```bash
docker-compose up -d
```

## API Endpoints

| Method | Path               | Description                                  |
| ------ | ------------------ | -------------------------------------------- |
| GET    | `/health`          | Health check                                 |
| POST   | `/uploads`         | Upload an image file (multipart/form-data)   |
| GET    | `/uploads`         | List uploads with optional search/pagination |
| POST   | `/uploads/exports` | Export uploads list as a CSV                 |

### Query parameters for `GET /uploads`

| Parameter       | Type   | Default | Description                    |
| --------------- | ------ | ------- | ------------------------------ |
| `searchQuery`   | string | —       | Filter by file name            |
| `sortBy`        | string | —       | Field to sort by (`createdAt`) |
| `sortDirection` | string | —       | `asc` or `desc`                |
| `page`          | number | `1`     | Page number                    |
| `pageSize`      | number | `20`    | Items per page                 |

## Scripts

| Command               | Description                              |
| --------------------- | ---------------------------------------- |
| `npm run dev`         | Start development server with hot reload |
| `npm run build`       | Build for production                     |
| `npm run test`        | Run tests once                           |
| `npm run test:watch`  | Run tests in watch mode                  |
| `npm run db:generate` | Generate Drizzle migration files         |
| `npm run db:migrate`  | Apply migrations                         |
| `npm run db:studio`   | Open Drizzle Studio                      |

## Testing

Create a `.env.test` file with a separate test database URL, then run:

```bash
npm run test
```

Migrations are applied automatically before each test run.
