#!/bin/bash

remove_old_docker() {
  echo "Удаление старых версий Docker и связанных компонентов..."
  # Список пакетов для полного удаления
  packages=(
    docker
    docker.io
    docker-ce
    docker-ce-cli
    containerd
    containerd.io
    runc
    docker-doc
    docker-compose
    docker-compose-v2
    podman-docker
  )

  for pkg in "${packages[@]}"; do
    if dpkg -l | grep -q "$pkg"; then
      sudo apt-get remove --purge -y "$pkg"
      if [ $? -eq 0 ]; then
        echo "$pkg успешно удалён."
      else
        echo "Ошибка при удалении $pkg. Пропускаем..."
      fi
    fi
  done

  # Автоматическая очистка оставшихся зависимостей
  sudo apt-get autoremove -y
}

install_docker() {
  echo "Установка Docker и плагинов..."
  # Подготовка к добавлению официального репозитория Docker
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg lsb-release

  # Добавление ключа GPG Docker и репозитория
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Установка Docker CE, CLI, containerd и сопутствующих плагинов
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  if [ $? -eq 0 ]; then
    echo "Docker и плагины успешно установлены."
    # Проверка статуса Docker
    sudo systemctl is-active --quiet docker && echo "Docker активен" || echo "Docker не активен"
    docker version || echo "Ошибка: Docker не установлен или не работает"
  else
    echo "Ошибка при установке Docker. Проверьте логи."
  fi
}

echo -e "\033[1;36m"
echo -e "████╗░██████╗░███████╗████╗  ░█████╗░███████╗░█████╗░███████╗██╗░░░░░░█████╗░"
echo -e "██╔═╝██╔════╝░╚════██║╚═██║  ██╔══██╗╚════██║██╔══██╗╚════██║██║░░░░░██╔══██╗"
echo -e "██║░░██║░░██╗░░░░░██╔╝░░██║  ███████║░░███╔═╝███████║░░███╔═╝██║░░░░░██║░░██║"
echo -e "██║░░██║░░╚██╗░░░██╔╝░░░██║  ██╔══██║██╔══╝░░██╔══██║██╔══╝░░██║░░░░░██║░░██║"
echo -e "████╗╚██████╔╝░░██╔╝░░████║  ██║░░██║███████╗██║░░██║███████╗███████╗╚█████╔╝"
echo -e "╚═══╝░╚═════╝░░░╚═╝░░░╚═══╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░"
echo -e "\033[1;34m"
echo
echo -e "\033[1;32mTelegram community: \033[5;31mhttps://t.me/g7team_ru\033[0m"
echo -e "\033[0m"
echo "Обновление списка пакетов и установка обновлений..."
sudo apt update -y && sudo apt upgrade -y

# Установка необходимых пакетов
echo "Установка необходимых пакетов..."
PACKAGES=(
  curl
  git
  jq
  lz4
  build-essential
  unzip
  make
  gcc
  ncdu
  cmake
  clang
  pkg-config
  libssl-dev
  libzmq3-dev
  libczmq-dev
  python3-pip
  protobuf-compiler
  dos2unix
  screen
)

for PACKAGE in "${PACKAGES[@]}"; do
  echo "Установка $PACKAGE..."
  sudo apt install -y "$PACKAGE"
  if [ $? -eq 0 ]; then
    echo "$PACKAGE успешно установлен."
  else
    echo "Ошибка при установке $PACKAGE. Пропускаем..."
  fi
done

# Удаление старых версий Docker (полное)
remove_old_docker

# Установка Docker из официального репозитория
install_docker

echo "Начальная настройка сервера завершена."
