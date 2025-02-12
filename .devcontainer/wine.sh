#!/bin/bash

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
sudo apt install --install-recommends winehq-stable -y

# Xác minh cài đặt
wine --version

# Thiết lập biến môi trường WINEPREFIX
export WINEPREFIX=~/.wine

# Khởi tạo tiền tố Wine
wineboot --init

# Cài đặt winetricks
sudo apt install winetricks -y

# Cài đặt một số thư viện phổ biến (tùy chọn, có thể mất nhiều thời gian)
winetricks corefonts vcrun6 vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 vcrun2017 vcrun2019 dotnet48