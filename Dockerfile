FROM alpine:latest

ENV PORT=3000
ENV UUID=d42e30bc-f02c-40c1-92b9-883739bf0dcf
ENV WSPATH=/vless-ws

RUN apk add --no-cache curl jq gettext

# 下载最新版 Xray-core
RUN ARCH="$(uname -m)" && \
    case "$ARCH" in \
      x86_64) XRAY_ARCH="64" ;; \
      aarch64) XRAY_ARCH="arm64-v8a" ;; \
      *) XRAY_ARCH="64" ;; \
    esac && \
    mkdir -p /xray && \
    curl -L -s https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XRAY_ARCH}.zip -o /xray/xray.zip && \
    unzip -q /xray/xray.zip -d /xray && \
    rm /xray/xray.zip && \
    chmod +x /xray/xray

COPY config.template.json /xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000

CMD ["/entrypoint.sh"]
