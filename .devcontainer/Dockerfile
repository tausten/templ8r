# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.191.1/containers/alpine/.devcontainer/base.Dockerfile

# [Choice] Alpine version: 3.14, 3.13, 3.12, 3.11
ARG VARIANT="3.14"
ARG GOMPLATE_VARIANT="3.8.0"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-${VARIANT}

# ** [Optional] Uncomment this section to install additional packages. **
# RUN apk update \
#     && apk add --no-cache <your-package-list-here>

# TODO: For some reason, we get a "circular dependency" here if try to do via "FROM"
#FROM hairyhenderson/gomplate:v${GOMPLATE_VARIANT} AS dev_gomplate_source

# gomplate - for repo template bootstrapping - https://docs.gomplate.ca/
COPY --from=hairyhenderson/gomplate:v3.8.0 /gomplate /bin/gomplate
