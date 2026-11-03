#!/bin/sh
export PORT=${PORT:-3000}
export UUID=${UUID:-d42e30bc-f02c-40c1-92b9-883739bf0dcf}
export WSPATH=${WSPATH:-/vless-ws}

envsubst < /xray/config.template.json > /xray/config.json
exec /xray/xray run -config /xray/config.json
