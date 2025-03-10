FROM hieuxyz00/dev

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "127.0.0.1 hieuxyz" | sudo tee -a /etc/hosts

RUN apt-get update && apt full-upgrade -y
# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*