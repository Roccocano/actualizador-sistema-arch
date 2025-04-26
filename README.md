# Actualizador de Sistema para Arch Linux

Este script en Bash automatiza completamente el proceso de actualización de paquetes en sistemas basados en Arch Linux. Integra herramientas como `pacman`, `yay`, `pamac`, `flatpak` y `snap`, y realiza tareas de mantenimiento como limpieza de caché, eliminación de paquetes huérfanos y optimización de logs del sistema.

## 🔧 Requisitos

- Sistema operativo basado en Arch Linux
- Acceso a `sudo`
- Conexión a Internet

## 🛠 Funcionalidades

- Instalación automática de `pamac`, `yay`, `flatpak` y `snapd` si no están presentes.
- Actualización de paquetes del sistema con `pacman`, `yay` y `pamac`.
- Actualización de paquetes Flatpak y Snap.
- Eliminación de paquetes huérfanos.
- Limpieza de cachés de `pacman` y `yay`.
- Reducción del tamaño de logs del sistema (`journalctl`).

## 🚀 Uso

```bash
chmod +x Actualizar.sh
./Actualizar.sh
