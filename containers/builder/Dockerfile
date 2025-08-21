FROM docker.io/amd64/ubuntu:24.04

USER root

ENV DEBIAN_FRONTEND='noninteractive' \
    TZ='Etc/UTC'



SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for the Server that starts
# but lacks all features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND=noninteractive
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -yqq \
    # - `apt-get upgrade` is run to patch known vulnerabilities in system packages
    #   as the Ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    && apt-get upgrade -yqq \
    && apt-get install -yqq \
        'ca-certificates' \
        'locales' \
        'curl' \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  \
    && echo "C.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen

RUN sh -c "$(curl -fsSL https://taskfile.dev/install.sh)" -- -d

WORKDIR /root

COPY --chown=root:root Taskfile.yaml ./
RUN task prereq

COPY --chown=root:root patcher.sh ./patcher.sh
RUN chmod +x ./patcher.sh