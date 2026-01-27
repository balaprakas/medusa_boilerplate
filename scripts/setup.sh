#!/bin/bash

# Exit on error
set -e

echo "Starting setup..."

# 1. Copy env files if they don't exist
[ ! -f backend/.env ] && cp backend/.env.template backend/.env
[ ! -f storefront/.env.local ] && cp storefront/.env.template storefront/.env.local

# 2. Generate and Append Publishable Key
# Pattern: pk_ followed by 64 hex characters (32 bytes)
PK_KEY="pk_$(openssl rand -hex 32)"

echo "MEDUSA_PUBLISHABLE_KEY=$PK_KEY" >> backend/.env
echo "NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=$PK_KEY" >> storefront/.env.local

# 3. Seed
echo "Seeding backend..."
pnpm --filter backend run seed

echo "Setup complete!"
