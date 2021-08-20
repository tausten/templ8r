# base is plain alpine
ARG BASE_VARIANT="3.14"
ARG GOMPLATE_VARIANT="3.8.0"
FROM alpine:${BASE_VARIANT} AS builder

WORKDIR /app

COPY . .

FROM hairyhenderson/gomplate:v${GOMPLATE_VARIANT} AS gomplate_source
FROM alpine:${BASE_VARIANT} AS runtime

COPY --from=gomplate_source /gomplate /bin/gomplate
COPY --from=builder /app/LICENSE /LICENSE
COPY --from=builder /app/apply /apply
COPY --from=builder /app/cfg.env /cfg.env

CMD ["/apply"]
