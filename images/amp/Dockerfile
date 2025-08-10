FROM node:20-bookworm


RUN mkdir /src/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN npm install -g @sourcegraph/amp
RUN usermod -l amp -d /home/amp -m node
RUN chown -R amp /src
USER amp
WORKDIR /src

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
