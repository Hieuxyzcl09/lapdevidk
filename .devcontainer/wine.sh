#!/bin/bash

# Start virtual framebuffer
Xvfb :0 -screen 0 1024x768x16 &
sleep 2  # Wait for Xvfb to start

# Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# Kích hoạt kiến trúc 32-bit
sudo dpkg --add-architecture i386

# Thêm kho lưu trữ WineHQ
sudo mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Thêm kho lưu trữ cho Ubuntu 24.04 (Noble Numbat)
echo "deb [signed-by=/etc/apt/keyrings/winehq-archive.key] https://dl.winehq.org/wine-builds/ubuntu/ noble main" | sudo tee /etc/apt/sources.list.d/winehq.list

# Cập nhật lại danh sách gói
sudo apt update

# Cài đặt Wine
DEBIAN_FRONTEND=noninteractive sudo apt install --install-recommends winehq-stable -y

# Xác minh cài đặt
wine --version

# Thiết lập biến môi trường WINEPREFIX
export WINEPREFIX=~/.wine

# Khởi tạo tiền tố Wine với virtual display
DISPLAY=:0 wineboot --init

# Cài đặt winetricks
sudo apt install winetricks -y

# Cài đặt một số thư viện phổ biến với virtual display
DISPLAY=:0 winetricks -q corefonts
DISPLAY=:0 winetricks -q vcrun6
DISPLAY=:0 winetricks -q vcrun2005
DISPLAY=:0 winetricks -q vcrun2008
DISPLAY=:0 winetricks -q vcrun2010
DISPLAY=:0 winetricks -q vcrun2012
DISPLAY=:0 winetricks -q vcrun2013
DISPLAY=:0 winetricks -q vcrun2015
DISPLAY=:0 winetricks -q vcrun2017
DISPLAY=:0 winetricks -q vcrun2019
DISPLAY=:0 winetricks -q dotnet48

# Kill Xvfb
pkill Xvfb