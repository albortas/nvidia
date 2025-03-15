
# Configuracion de teclado
loadkeys es
loadkeys la-latin1

#Conectarse a una red wifi
#Verificar la salida, si el software esta cagando
ls /sys/class/net
#La salida debe ser wlan0

#Conectarse a una red wifi con iwd
iwctl --passphrase 'password' station wlan0 connect 'nombre-de-red'

#Configurar temporalmente el idioma del liveCD
echo "es_ES.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LANG=es_ES.UTF-8

#Actualizar los paqutes
pacman -Sy
#Instalar paquetes
pacman -S archlinux-keyring
pacman -S archinstall

#Verifivar el modo de arranque
ls /sys/firmware/efi/efivars
# Si existe el directorio especificado mostrara con archivos existentes -> UEFI
# Si no muestra nada BIOS

# Consular tabla de particiones
fdisk -l
# O tambien se puede usar
lsblk

#Crear particiones
cfdisk /dev/sda

# Formateando particiones
# Formateo de la Partición de arranque:
mkfs.fat -F 32 /dev/sda1
#Formateo de la Partición de Root y Home:
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
#Partición de memoria virtual - memoria de intercambio SWAP:
mkswap /dev/sda4
# Activar partición SWAP:
swapon /dev/sda4

#MONTAR PARTICIONES
#montar la raiz
mount /dev/sda2 /mnt/
# Crear carpetas en caso de que exista home y efi
mkdir -p /mnt/efi
mkdir -p /mnt/home

# Verificamos que se hayan creado correctamente los directorios
ls /mnt/
# Montando la partición de Arranque /efi
mount /dev/sda1 /mnt/efi
# Montando la partición /home
mount /dev/sda3 /mnt/home

# Desde aqui podemos utilizar archinstall o armar nuestro propio sistema
