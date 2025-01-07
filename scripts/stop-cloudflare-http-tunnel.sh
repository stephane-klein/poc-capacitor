#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

PID_FILE="./.cloudflared_tunnel.pid"
LOG_FILE="./.cloudflared_tunnel.log"
TUNNEL_URL_FILE="./.cloudflared_tunnel_url"

if [ ! -f "$PID_FILE" ]; then
    echo "No tunnel is currently running."
    exit 1
fi

TUNNEL_PID=$(cat "$PID_FILE")

echo "Stopping the tunnel (PID: $TUNNEL_PID)..."
kill "$TUNNEL_PID" 2>/dev/null

# Check if the process has stopped
sleep 1
if kill -0 "$TUNNEL_PID" 2>/dev/null; then
  echo "Failed to stop the tunnel."
  exit 1
fi

# Clean up PID and log files
rm -f "$PID_FILE" "$LOG_FILE" "$TUNNEL_URL_FILE"
echo "Tunnel stopped successfully."
