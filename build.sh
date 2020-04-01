#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

# Build the release and overwrite the existing release directory
_build/prod/rel/test_app/bin/test_app eval "TestApp.Release.migrate"
MIX_ENV=prod mix release --overwrite