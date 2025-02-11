FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Ho_Chi_Minh
ENV ANDROID_HOME=/opt/android-sdk
ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH=$PATH:$DOTNET_ROOT:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

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
    libssl-dev \
    libreadline-dev \
    ca-certificates \
    openjdk-17-jdk \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# Setup Docker
RUN for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done \
    && sudo install -m 0755 -d /etc/apt/keyrings \
    && sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && sudo chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && sudo apt-get update \
    && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Setup Python virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip3 install psutil schedule Pillow requests aiohttp numpy moviepy opencv-python-headless \
    python-dotenv discord.py deep_translator pexpect cryptography qrcode openpyxl stem configparser \
    beautifulsoup4 flask

RUN sudo add-apt-repository ppa:deadsnakes/ppa \
    && sudo apt update \
    && sudo apt-get install python3.11 python3.11-venv

# Install .NET SDK
RUN wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0

# Install Android SDK and build tools
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && cd ${ANDROID_HOME}/cmdline-tools \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip \
    && unzip commandlinetools-linux-*_latest.zip \
    && rm commandlinetools-linux-*_latest.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools/latest \
    && mv cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest/ || true \
    && cd ${ANDROID_HOME}/cmdline-tools \
    && rm -rf cmdline-tools \
    && cd ${ANDROID_HOME}/cmdline-tools/latest/bin \
    && yes | ./sdkmanager --licenses \
    && ./sdkmanager "platform-tools" \
    && ./sdkmanager "platforms;android-34" \
    && ./sdkmanager "build-tools;34.0.0"

# Install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-8.5-bin.zip \
    && unzip gradle-8.5-bin.zip -d /opt \
    && rm gradle-8.5-bin.zip \
    && ln -s /opt/gradle-8.5/bin/gradle /usr/bin/gradle

# Thêm repository Mono
RUN apt install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list

# Cài đặt MSBuild và dependencies
RUN apt-get update && apt-get install -y \
    mono-devel \
    msbuild \
    g++-mingw-w64 \
    mono-complete

# Tải và cài đặt NuGet CLI
RUN curl -L -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
RUN echo '#!/bin/bash' > /usr/local/bin/nuget
RUN echo 'mono /usr/local/bin/nuget.exe "$@"' >> /usr/local/bin/nuget
RUN chmod 755 /usr/local/bin/nuget


# Setup Ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list \
    && apt-get update && apt-get install -y ngrok

RUN mkdir -p /root/.config/ngrok \
    && echo "version: \"2\"" > /root/.config/ngrok/ngrok.yml \
    && mkdir -p /home/ubuntu/.config/ngrok \
    && echo "version: \"2\"" > /home/ubuntu/.config/ngrok/ngrok.yml

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*