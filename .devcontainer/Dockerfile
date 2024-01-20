# The devcontainer will be based on debian bullseye
# The base container already has entrypoint, vscode user account, etc. out of the box
FROM mcr.microsoft.com/vscode/devcontainers/base:bullseye

# containelab version will be set in devcontainer.json
ARG _CLAB_VERSION

# Set permissions for mounts in devcontainer.json
RUN mkdir -p /home/vscode/.vscode-server/bin
RUN chown -R vscode:vscode /home/vscode/.vscode-server

# install some basic tools inside the container
# adjust this list based on your demands
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    sshpass \
    curl \
    iputils-ping \
    htop \
    yamllint \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# install preferred version of the containerlab
RUN bash -c "$(curl -sL https://get.containerlab.dev)" -- -v ${_CLAB_VERSION}

