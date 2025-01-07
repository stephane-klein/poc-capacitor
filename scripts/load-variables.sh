export START_URL=$(cat .cloudflared_tunnel_url)
export ALLOW_NAVIGATION=$(echo "$START_URL" | sed -E 's#https://([^/]+).*#\1#')

cat << EOF
Variables loaded:

START_URL=${START_URL}
ALLOW_NAVIGATION=${ALLOW_NAVIGATION}
EOF
