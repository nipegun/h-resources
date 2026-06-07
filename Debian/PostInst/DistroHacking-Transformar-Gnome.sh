#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para transformar Debian con Gnome en una distro de hacking
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL x | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL x | sed 's-sudo--g' | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' x | bash
#
# Ejecución remota con parámetros:
#   curl -sL x | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL x | nano -
# ----------

# Definir constantes de color
  cColorAzul='\033[0;34m'
  cColorAzulClaro='\033[1;34m'
  cColorVerde='\033[1;32m'
  cColorRojo='\033[1;31m'
  # Para el color rojo también:
    #echo "$(tput setaf 1)Mensaje en color rojo. $(tput sgr 0)"
  cFinColor='\033[0m'

# Determinar la versión de Debian
  if [ -f /etc/os-release ]; then             # Para systemd y freedesktop.org.
    . /etc/os-release
    cNomSO=$NAME
    cVerSO=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then # Para linuxbase.org.
    cNomSO=$(lsb_release -si)
    cVerSO=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then          # Para algunas versiones de Debian sin el comando lsb_release.
    . /etc/lsb-release
    cNomSO=$DISTRIB_ID
    cVerSO=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then       # Para versiones viejas de Debian.
    cNomSO=Debian
    cVerSO=$(cat /etc/debian_version)
  else                                        # Para el viejo uname (También funciona para BSD).
    cNomSO=$(uname -s)
    cVerSO=$(uname -r)
  fi

# Ejecutar comandos dependiendo de la versión de Debian detectada

  if [ $cVerSO == "13" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 13 (Trixie) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    # Actualizar la lista de paquetes disponibles en los repositorios
      sudo apt-get -y update

    # DFIR
      sudo apt -y install --install-recommends forensics-full

    # Binarios, reversing, pwn y compilación
      sudo apt -y install --install-recommends build-essential
      sudo apt -y install --install-recommends gcc 
      sudo apt -y install --install-recommends g++
      sudo apt -y install --install-recommends clang
      sudo apt -y install --install-recommends make
      sudo apt -y install --install-recommends cmake
      sudo apt -y install --install-recommends pkg-config
      sudo apt -y install --install-recommends git
      sudo apt -y install --install-recommends gdb
      sudo apt -y install --install-recommends gdb-multiarch
      sudo apt -y install --install-recommends lldb
      sudo apt -y install --install-recommends strace
      sudo apt -y install --install-recommends ltrace
      sudo apt -y install --install-recommends valgrind
      sudo apt -y install --install-recommends binutils
      sudo apt -y install --install-recommends elfutils
      sudo apt -y install --install-recommends capstone-tool
      sudo apt -y install --install-recommends checksec
      sudo apt -y install --install-recommends patchelf
      sudo apt -y install --install-recommends nasm
      sudo apt -y install --install-recommends yasm
      sudo apt -y install --install-recommends qemu-user
      sudo apt -y install --install-recommends qemu-user-static
      sudo apt -y install --install-recommends qemu-system-x86
      sudo apt -y install --install-recommends qemu-system-arm
      sudo apt -y install --install-recommends qemu-system-misc
      sudo apt -y install --install-recommends libc6-i386
      sudo apt -y install --install-recommends libc6-dev-i386
      sudo apt -y install --install-recommends gcc-multilib
      sudo apt -y install --install-recommends g++-multilib

    # Lenguajes y entornos
      sudo apt -y install --install-recommends python3
      sudo apt -y install --install-recommends python3-pip
      sudo apt -y install --install-recommends python3-venv
      sudo apt -y install --install-recommends python3-dev
      sudo apt -y install --install-recommends pipx
      sudo apt -y install --install-recommends ruby
      sudo apt -y install --install-recommends ruby-dev
      sudo apt -y install --install-recommends golang
      sudo apt -y install --install-recommends rustc
      sudo apt -y install --install-recommends cargo
      sudo apt -y install --install-recommends nodejs
      sudo apt -y install --install-recommends npm
      sudo apt -y install --install-recommends default-jdk
      sudo apt -y install --install-recommends php-cli
      sudo apt -y install --install-recommends perl
      sudo apt -y install --install-recommends lua5.4

    # Utilidades generales
      sudo apt -y install --install-recommends curl
      sudo apt -y install --install-recommends wget
      sudo apt -y install --install-recommends aria2
      sudo apt -y install --install-recommends ca-certificates
      sudo apt -y install --install-recommends gnupg
      sudo apt -y install --install-recommends tmux
      sudo apt -y install --install-recommends screen
      sudo apt -y install --install-recommends jq
      sudo apt -y install --install-recommends yq
      sudo apt -y install --install-recommends xmlstarlet
      sudo apt -y install --install-recommends ripgrep
      sudo apt -y install --install-recommends fd-find
      sudo apt -y install --install-recommends bat
      sudo apt -y install --install-recommends xxd
      sudo apt -y install --install-recommends file
      sudo apt -y install --install-recommends less
      sudo apt -y install --install-recommends vim
      sudo apt -y install --install-recommends nano
      sudo apt -y install --install-recommends unzip
      sudo apt -y install --install-recommends zip
      sudo apt -y install --install-recommends 7zip
      sudo apt -y install --install-recommends 7zip-rar
      sudo apt -y install --install-recommends unar
      sudo apt -y install --install-recommends cabextract
      sudo apt -y install --install-recommends lz4
      sudo apt -y install --install-recommends zstd
      sudo apt -y install --install-recommends brotli
      sudo apt -y install --install-recommends bzip2
      sudo apt -y install --install-recommends bzip3
      sudo apt -y install --install-recommends gzip
      sudo apt -y install --install-recommends xz-utils
      sudo apt -y install --install-recommends cpio
      sudo apt -y install --install-recommends sqlite3

    # Redes servicios y protocolos
      sudo apt -y install --install-recommends nmap
      sudo apt -y install --install-recommends ncat
      sudo apt -y install --install-recommends ndiff
      sudo apt -y install --install-recommends masscan
      sudo apt -y install --install-recommends arp-scan
      sudo apt -y install --install-recommends arping
      sudo apt -y install --install-recommends fping
      sudo apt -y install --install-recommends hping3
      sudo apt -y install --install-recommends iproute2
      sudo apt -y install --install-recommends iputils-ping
      sudo apt -y install --install-recommends traceroute
      sudo apt -y install --install-recommends mtr-tiny
      sudo apt -y install --install-recommends whois
      sudo apt -y install --install-recommends tcpdump
      sudo apt -y install --install-recommends tshark
      sudo apt -y install --install-recommends wireshark
      sudo apt -y install --install-recommends ngrep
      sudo apt -y install --install-recommends tcpick
      sudo apt -y install --install-recommends net-tools
      sudo apt -y install --install-recommends socat
      sudo apt -y install --install-recommends netcat-openbsd
      sudo apt -y install --install-recommends openssl
      sudo apt -y install --install-recommends testssl.sh
      sudo apt -y install --install-recommends sslscan
      sudo apt -y install --install-recommends smbclient
      sudo apt -y install --install-recommends nbtscan
      sudo apt -y install --install-recommends smbmap
      sudo apt -y install --install-recommends snmp
      sudo apt -y install --install-recommends braa
      sudo apt -y install --install-recommends ike-scan

    # DNS, OSINT y Web
      sudo apt -y install --install-recommends bind9-dnsutils
      sudo apt -y install --install-recommends ldnsutils
      sudo apt -y install --install-recommends dnsrecon
      sudo apt -y install --install-recommends dnsenum
      sudo apt -y install --install-recommends dnsmap
      sudo apt -y install --install-recommends dnstracer
      sudo apt -y install --install-recommends dnstwist
      sudo apt -y install --install-recommends fierce
      sudo apt -y install --install-recommends altdns
      sudo apt -y install --install-recommends assetfinder
      sudo apt -y install --install-recommends sherlock
      sudo apt -y install --install-recommends waymore
      sudo apt -y install --install-recommends arjun
      sudo apt -y install --install-recommends paramspider
      sudo apt -y install --install-recommends sqlmap
      sudo apt -y install --install-recommends ffuf
      sudo apt -y install --install-recommends gobuster
      sudo apt -y install --install-recommends dirb
      sudo apt -y install --install-recommends dirsearch
      sudo apt -y install --install-recommends wfuzz
      sudo apt -y install --install-recommends whatweb
      sudo apt -y install --install-recommends wafw00f
      sudo apt -y install --install-recommends chromium
      sudo apt -y install --install-recommends chromium-driver

    # Contraseñas, wordlists y cracking
      sudo apt -y install --install-recommends hydra
      sudo apt -y install --install-recommends medusa
      sudo apt -y install --install-recommends ncrack
      sudo apt -y install --install-recommends brutespray
      sudo apt -y install --install-recommends john
      sudo apt -y install --install-recommends hashcat
      sudo apt -y install --install-recommends hashcat-data
      sudo apt -y install --install-recommends hashid
      sudo apt -y install --install-recommends cewl
      sudo apt -y install --install-recommends crunch
      sudo apt -y install --install-recommends cupp
      sudo apt -y install --install-recommends maskprocessor
      sudo apt -y install --install-recommends statsprocessor
      sudo apt -y install --install-recommends fcrackzip
      sudo apt -y install --install-recommends pdfcrack
      sudo apt -y install --install-recommends bruteforce-luks
      sudo apt -y install --install-recommends bruteforce-salted-openssl
      sudo apt -y install --install-recommends bruteforce-wallet
      sudo apt -y install --install-recommends cisco7crack
      sudo apt -y install --install-recommends ophcrack-cli
      sudo apt -y install --install-recommends samdump2
      sudo apt -y install --install-recommends chntpw

    # forense, carving, imágenes, metadatos y estego
      sudo apt -y install --install-recommends binwalk
      sudo apt -y install --install-recommends foremost
      sudo apt -y install --install-recommends scalpel
      sudo apt -y install --install-recommends sleuthkit
      sudo apt -y install --install-recommends testdisk
      sudo apt -y install --install-recommends plaso
      sudo apt -y install --install-recommends yara
      sudo apt -y install --install-recommends ssdeep
      sudo apt -y install --install-recommends hashdeep
      sudo apt -y install --install-recommends hashrat
      sudo apt -y install --install-recommends libimage-exiftool-perl
      sudo apt -y install --install-recommends exiv2
      sudo apt -y install --install-recommends pngcheck
      sudo apt -y install --install-recommends jpeginfo
      sudo apt -y install --install-recommends imagemagick
      sudo apt -y install --install-recommends exifprobe
      sudo apt -y install --install-recommends metacam
      sudo apt -y install --install-recommends steghide
      sudo apt -y install --install-recommends stegseek
      sudo apt -y install --install-recommends outguess
      sudo apt -y install --install-recommends stegosuite
      sudo apt -y install --install-recommends stegsnow
      sudo apt -y install --install-recommends snowdrop
      sudo apt -y install --install-recommends recoverjpeg
      sudo apt -y install --install-recommends magicrescue
      sudo apt -y install --install-recommends ext4magic
      sudo apt -y install --install-recommends extundelete
      sudo apt -y install --install-recommends dislocker
      sudo apt -y install --install-recommends xmount
      sudo apt -y install --install-recommends pff-tools
      sudo apt -y install --install-recommends regripper
      sudo apt -y install --install-recommends rifiuti
      sudo apt -y install --install-recommends rifiuti2
      sudo apt -y install --install-recommends winregfs

    # WiFi, WPA, Bluetooth básico y tarjetas/RFID
      sudo apt -y install --install-recommends aircrack-ng
      sudo apt -y install --install-recommends hcxdumptool
      sudo apt -y install --install-recommends hcxtools
      sudo apt -y install --install-recommends hcxkeys
      sudo apt -y install --install-recommends cowpatty
      sudo apt -y install --install-recommends bully
      sudo apt -y install --install-recommends reaver
      sudo apt -y install --install-recommends pixiewps
      sudo apt -y install --install-recommends wifite
      sudo apt -y install --install-recommends mdk3
      sudo apt -y install --install-recommends mdk4
      sudo apt -y install --install-recommends macchanger
      sudo apt -y install --install-recommends rfkill
      sudo apt -y install --install-recommends kismet
      sudo apt -y install --install-recommends btscanner
      sudo apt -y install --install-recommends mfcuk
      sudo apt -y install --install-recommends mfoc

    # Criptografía, matemáticas y scripting científico
      sudo apt -y install --install-recommends sagemath
      sudo apt -y install --install-recommends pari-gp
      sudo apt -y install --install-recommends maxima
      sudo apt -y install --install-recommends z3
      sudo apt -y install --install-recommends python3-z3
      sudo apt -y install --install-recommends python3-sympy
      sudo apt -y install --install-recommends python3-cryptography
      sudo apt -y install --install-recommends python3-pycryptodome
      sudo apt -y install --install-recommends python3-gmpy2
      sudo apt -y install --install-recommends python3-numpy
      sudo apt -y install --install-recommends python3-scipy

  elif [ $cVerSO == "12" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 12 (Bookworm) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 12 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "11" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 11 (Bullseye) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 11 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "10" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 10 (Buster) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 10 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "9" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 9 (Stretch) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 9 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "8" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 8 (Jessie) con Gnome en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 8 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "7" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 7 (Wheezy) con Gnome en una distro de hacking....${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 7 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  fi
