ARG BASE_IMAGE=ashleykza/runpod-base:2.1.0-python3.10-cuda12.1.1-torch2.4.0
FROM ${BASE_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    SHELL=/bin/bash

WORKDIR /
ARG INDEX_URL
ARG TORCH_VERSION
ARG XFORMERS_VERSION
ARG LIVEPORTRAIT_COMMIT
COPY --chmod=755 build/* ./
RUN /install.sh && rm /install.sh

# Remove existing SSH host keys
RUN rm -f /etc/ssh/ssh_host_*

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
