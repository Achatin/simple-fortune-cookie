#!/usr/bin/env bash
set -euo pipefail

APP_URL=$1

echo "🔎 Running deployment test against $APP_URL"

# 1. Health check
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL/healthz")
if [ "$STATUS" -ne 200 ]; then
  echo "❌ Health check failed (status $STATUS)"
  exit 1
fi
echo "✅ Health check OK"

# 2. Create fortune via frontend
curl -s -X POST "$APP_URL/api/add" \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello from deployment test"}' > /dev/null

# 3. Fetch all fortunes and check message
RESULT=$(curl -s "$APP_URL/api/all")
if echo "$RESULT" | grep -q "Hello from deployment test"; then
  echo "✅ Fortune frontend works"
else
  echo "❌ Fortune frontend test failed"
  exit 1
fi

