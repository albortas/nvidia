
# Paquetes necesarios para el sistema
#programas, configuraciones, directorios, etc...
pacstrap /mnt base base-devel nano
#Binarios de controladores generalmente propietarios.
pacstrap /mnt linux-firmware linux linux-headers mkinitcpio

#gestionar las conexiones a Internet cableadas
pacstrap /mnt dhcpcd networkmanager iwd net-tools ifplugd 

#gestionar las conexiones a Internet Inalámbrica (Wifi)
pacstrap /mnt iw wireless_tools wpa_supplicant dialog wireless-regdb

#El archivo fstab
#Es usado para definir cómo las particiones,
#Estas definiciones se montaran de forma dinámica en el arranque
genfstab -p /mnt >> /mnt/etc/fstab
#Generar el archivo fstab para las etiquetas de nuestras particiones
#Revisamos
cat /mnt/etc/fstab

#Chroot
#Entramos a la raíz del nuevo sistema como usuario root.
arch-chroot /mnt

#Defina la distribución de teclado en vconsole.conf
echo KEYMAP=es > /etc/vconsole.conf

#Dentro de nuestro sistema vamos a configurar idioma, teclado, hora y usuarios.
nano /etc/locale.gen
locale-gen
echo LANG=es_PE.UTF-8 > /etc/locale.conf
export LANG=es_PE.UTF-8

#Zona Horaria
ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
#Estable el RTC a partir de la hora del sistema.
hwclock -w

#Nombre del equipo
echo nombre_de_pc > /etc/hostname
#Modificamos el archivo Hosts
nano /etc/hosts

#Contraseña para root
passwd root

#Creamos nuestro usuario, para entrar a nuestro sistema
useradd -m -g users -G wheel -s /bin/bash nombre_de_usuario
passwd nombre_de_usuario
#Sudo tendrá efecto si nuestro usuario esta en la lista de Sudoers
nano /etc/sudoers

#Activando Servicios
systemctl enable dhcpcd  NetworkManager iwd
# Si instalaron paquetes de Bluetooth activen el servicio
systemctl enable bluetooth

#Gestor de Arranque
ls /boot/
pacman -S grub efibootmgr os-prober ntfs-3g
# Para BIOS
grub-install /dev/sda
ls /boot/grub
fdisk -l

#Entrar a la configuracion de grub
nano /etc/default/grub
os-prober
#Deberia reconocer
Windonws
# Si en caso no reconoce hay que montarlo
mkdir /mnt/winboot
mount /dev/sda1 /mnt/winboot
os-prober
# Con esto ya deberia reconocer
# En este punto hay que generar el archivo de configuracio
# Que sale al iniciar archlinux
grub-mkconfig -o /boot/grub/grub.cfg

