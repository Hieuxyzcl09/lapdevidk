FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Ho_Chi_Minh

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    ffmpeg \
    curl \
    nano \
    git \
    sudo \
    neofetch \
    htop \
    screen \
    ffmpeg \
    tzdata \
    tmate \
    speedtest-cli \
    build-essential \
    automake \
    pkg-config \
    libevent-dev \
    libncurses5-dev \
    bison \
    iputils-ping \
    lynx \
    zip \
    unzip \
    unrar \
    genisoimage \
    xz-utils \
    qemu-system-x86 \
    tor \
    torsocks \
    zlib1g-dev \
    ruby-full \
    nodejs \
    npm \
    nginx \
    gpg \
    imagemagick \
    webp \
    curl \
    libssl-dev \
    libreadline-dev \
    ca-certificates \
    ruby-full \
    imagemagick \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# Setup docker
RUN for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
RUN sudo install -m 0755 -d /etc/apt/keyrings
RUN sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN sudo chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN sudo apt-get update
RUN sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Py
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip3 install psutil schedule Pillow requests aiohttp numpy moviepy opencv-python-headless python-dotenv discord.py deep_translator pexpect cryptography qrcode openpyxl stem configparser beautifulsoup4 fake-useragent PySocks pycryptodome pyfiglet pyDes aider-chat aiofiles matplotlib

# Ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install -y ngrok

RUN mkdir -p /root/.config/ngrok && echo "version: \"2\"" > /root/.config/ngrok/ngrok.yml

RUN mkdir -p /home/ubuntu/.config/ngrok && echo "version: \"2\"" > /root/.config/ngrok/ngrok.yml

# Install Rust
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt-get clean && rm -rf /var/lib/apt/lists/*