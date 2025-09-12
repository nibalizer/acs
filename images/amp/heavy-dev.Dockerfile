FROM node:20-bookworm

# Install common build tools that might be needed
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    ca-certificates \
    postgresql-client \
    sudo \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN apt-get install -y wget && \
    wget -O go.tar.gz https://go.dev/dl/go1.24.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create Go workspace
RUN mkdir -p /go/src /go/bin /go/pkg


# Install Just
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

RUN mkdir /src/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN npm install -g @sourcegraph/amp
RUN usermod -l amp -d /home/amp -m node
RUN usermod -a -G sudo amp
RUN chown -R amp /src
USER amp
WORKDIR /src

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Verify installations
RUN node --version && \
    npm --version && \
    go version && \
    just --version

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
