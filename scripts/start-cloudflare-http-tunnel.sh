#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

PID_FILE="./.cloudflared_tunnel.pid"
LOG_FILE="./.cloudflared_tunnel.log"
TUNNEL_URL_FILE="./.cloudflared_tunnel_url"

rm -f $PID_FILE
rm -f $LOG_FILE
rm -f $TUNNEL_URL_FILE

# Maximum time to wait for the tunnel to generate the URL (in seconds)
MAX_WAIT_TIME=15
CHECK_INTERVAL=2

if [ -f "$PID_FILE" ]; then
    echo "The tunnel is already running, if it is a error, you can delete .cloudflared-tunnel.pid file"
    exit 1
fi

echo "Starting the tunnel..."
nohup cloudflared tunnel --url http://localhost:8080 > "$LOG_FILE" 2>&1 &
CLOUDFLARED_TUNNEL_PID=$!
echo "$CLOUDFLARED_TUNNEL_PID" > "$PID_FILE"

# Wait for the URL to appear in the log file
SECONDS_WAITED=0
TUNNEL_URL=""
while [ $SECONDS_WAITED -lt $MAX_WAIT_TIME ]; do
    TUNNEL_URL=$(grep -oP 'https://[a-zA-Z0-9.-]*\.trycloudflare\.com' "$LOG_FILE" || true)
    if [ -n "$TUNNEL_URL" ]; then
        break
    fi
    echo -n "…wait… "
    sleep $CHECK_INTERVAL
    SECONDS_WAITED=$((SECONDS_WAITED + CHECK_INTERVAL))
done
echo ""

if [ -z "$TUNNEL_URL" ]; then
    echo "Error: Tunnel URL is empty. Could not retrieve the tunnel URL. Check the logs: $LOG_FILE"
    exit 1
fi

echo "$TUNNEL_URL" > "$TUNNEL_URL_FILE"

echo "Tunnel started successfully: $TUNNEL_URL"
