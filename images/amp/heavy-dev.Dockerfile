FROM node:20-bookworm

# Install common build tools that might be needed
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    ca-certificates \
    postgresql-client \
    sudo \
    curl \
    socat \
    jq

# Install Go
RUN apt-get install -y wget && \
    wget -O go.tar.gz https://go.dev/dl/go1.24.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# copy in nvim shit
COPY nvim /opt/nvim
COPY nvim-amp-setup.sh /opt/nvim-amp-setup.sh

# Create Go workspace
RUN mkdir -p /go/src /go/bin /go/pkg

# install beads
RUN curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

# Install Just
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
# Install python
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv python3-virtualenv python-is-python3
# Install uv
RUN wget https://astral.sh/uv/install.sh && bash install.sh
# install plumbr
RUN curl -fsSL https://docs.ml.plumbing/dl/plumbr-linux-amd64 -o plumbr && chmod +x plumbr && sudo mv plumbr /usr/local/bin/plumbr

# Install zendesk mcp
# well this didn't work at all
#RUN mkdir /opt/utilities/ && cd /opt/utilities/ && git clone https://github.com/reminia/zendesk-mcp-server && cd zendesk-mcp-server && virtualenv venv && ./venv/bin/pip install uv && ./venv/bin/pip install -e .

RUN mkdir /src/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN npm install -g @sourcegraph/amp
RUN usermod -l amp -d /home/amp -m node
RUN usermod -a -G sudo amp
RUN mkdir /home/amp/.cache && chown amp /home/amp/.cache
RUN mkdir /home/amp/.config && chown amp /home/amp/.config
COPY AGENTS.md /home/amp/.config/AGENTS.md
RUN chown -R amp /home/amp/.config/
RUN chown -R amp /src
USER amp
WORKDIR /src

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Verify installations
RUN node --version && \
    npm --version && \
    go version && \
    python --version && \
    just --version

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
