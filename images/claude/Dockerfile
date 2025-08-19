FROM node:20-bookworm


RUN mkdir /src/
RUN apt-get update && apt-get install -y ripgrep
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN npm install -g @anthropic-ai/claude-code
RUN usermod -l claude -d /home/claude -m node
RUN chown -R claude /src
USER claude
RUN mkdir $HOME/.claude
WORKDIR /src

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
