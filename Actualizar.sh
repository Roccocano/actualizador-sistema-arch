#!/bin/bash

# Comprobar si pamac está instalado
if ! command -v pamac &> /dev/null; then
    echo "pamac no está instalado. Instalando pamac..."
    sudo pacman -Syu pamac --noconfirm
else
    echo "Pamac ya está instalado"
fi

# Actualizar repositorios e información de paquetes con pacman
sudo pacman -Sy archlinux-keyring --noconfirm && sudo pacman -Su --noconfirm

# Actualizar paquetes del sistema con pacman
sudo pacman -Syu --noconfirm

# Comprobar si yay está instalado
if ! command -v yay &> /dev/null; then
    echo "yay no está instalado. Instalando yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi

# Actualizar paquetes del AUR con yay
yay -Syu --noconfirm
sudo pamac update --aur --no-confirm
yay -Sua

# Actualizar paquetes con pamac
sudo pamac update --no-confirm
sudo pamac upgrade --no-confirm

# Verificar si Flatpak está instalado
if ! command -v flatpak &> /dev/null; then
    echo "Flatpak no está instalado. Instalando Flatpak..."
    sudo pacman -Syu flatpak --noconfirm
else
    echo "Flatpak ya está instalado"
    # Actualizar Flatpak (repositorios y aplicaciones)
    flatpak update -y
fi

# Verificar si Snap está instalado
if ! command -v snap &> /dev/null; then
    echo "Snap no está instalado. Instalando Snap..."
    sudo pacman -Syu snapd --noconfirm
    sudo systemctl enable --now snapd.socket
else
    echo "Snap ya está instalado"
    # Actualizar Snap (si es necesario)
    sudo snap refresh
fi

# Eliminar paquetes huérfanos
orphans=$(pacman -Qdtq)
if [ -n "$orphans" ]; then
    sudo pacman -Rns $orphans --noconfirm
else
    echo "No hay paquetes huérfanos para eliminar."
fi

# Limpiar cache de pacman y yay
sudo pacman -Scc --noconfirm
yay -Yc --noconfirm

# Limpiar registros del sistema
sudo journalctl --vacuum-size=50M
sudo journalctl --vacuum-time=2weeks

# Optimización de rendimiento (opcional)
# sudo nano /etc/systemd/journald.conf
