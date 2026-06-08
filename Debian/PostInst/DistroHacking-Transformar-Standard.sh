#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para transformar Debian standard sin entorno gráfico en una distro de hacking
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/h-resources/refs/heads/main/Debian/PostInst/DistroHacking-Transformar-Standard.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/h-resources/refs/heads/main/Debian/PostInst/DistroHacking-Transformar-Standard.sh | sed 's-sudo--g' | bash
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/h-resources/refs/heads/main/Debian/PostInst/DistroHacking-Transformar-Standard.sh | nano -
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
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 13 (Trixie) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    # Para que el script sea más compatible con ejecución automatizada, pondría esto al principio para evitar prompts interactivos durante la instalación
      export DEBIAN_FRONTEND=noninteractive

    # Actualizar la lista de paquetes disponibles en los repositorios
      sudo apt-get -y update

    # Herramientas para tener trazabilidad de lo que se haya ejecutado
      sudo apt-get -y install --no-install-recommends auditd
      sudo apt-get -y install --no-install-recommends acct
      sudo apt-get -y install --no-install-recommends rsyslog
      sudo apt-get -y install --no-install-recommends logrotate

    # Utilidades de aislamiento, contención y ejecución controlada
      sudo apt-get -y install --no-install-recommends bubblewrap
      sudo apt-get -y install --no-install-recommends firejail
      sudo apt-get -y install --no-install-recommends systemd-container
      sudo apt-get -y install --no-install-recommends schroot
      sudo apt-get -y install --no-install-recommends chrootuid

    # DFIR
      sudo apt-get -y install --no-install-recommends forensics-all   # Sólo herramientas para consola
      sudo apt-get -y install --no-install-recommends forensics-extra # Herramientas extra para consola

    # Binarios, reversing, pwn y compilación
      sudo apt-get -y install --no-install-recommends build-essential
      sudo apt-get -y install --no-install-recommends gcc
      sudo apt-get -y install --no-install-recommends clang
      sudo apt-get -y install --no-install-recommends make
      sudo apt-get -y install --no-install-recommends cmake
      sudo apt-get -y install --no-install-recommends pkg-config
      sudo apt-get -y install --no-install-recommends git
      sudo apt-get -y install --no-install-recommends gdb
      sudo apt-get -y install --no-install-recommends gdb-multiarch
      sudo apt-get -y install --no-install-recommends lldb
      sudo apt-get -y install --no-install-recommends strace
      sudo apt-get -y install --no-install-recommends ltrace
      sudo apt-get -y install --no-install-recommends valgrind
      sudo apt-get -y install --no-install-recommends binutils
      sudo apt-get -y install --no-install-recommends elfutils
      sudo apt-get -y install --no-install-recommends capstone-tool
      sudo apt-get -y install --no-install-recommends checksec
      sudo apt-get -y install --no-install-recommends patchelf
      sudo apt-get -y install --no-install-recommends nasm
      sudo apt-get -y install --no-install-recommends yasm
      sudo apt-get -y install --no-install-recommends qemu-user
      sudo apt-get -y install --no-install-recommends qemu-user-static
      sudo apt-get -y install --no-install-recommends qemu-system-x86
      sudo apt-get -y install --no-install-recommends qemu-system-arm
      sudo apt-get -y install --no-install-recommends qemu-system-misc
      sudo apt-get -y install --no-install-recommends libc6-i386
      sudo apt-get -y install --no-install-recommends libc6-dev-i386
      sudo apt-get -y install --no-install-recommends gcc-multilib
      sudo apt-get -y install --no-install-recommends libc6-dbg
      sudo apt-get -y install --no-install-recommends gdbserver
      sudo apt-get -y install --no-install-recommends binutils-multiarch
      sudo apt-get -y install --no-install-recommends python3-pwntools
      sudo apt-get -y install --no-install-recommends python3-ropgadget
      sudo apt-get -y install --no-install-recommends pwntools
      sudo apt-get -y install --no-install-recommends ropgadget
      sudo apt-get -y install --no-install-recommends python3-capstone
      sudo apt-get -y install --no-install-recommends python3-unicorn
      sudo apt-get -y install --no-install-recommends python3-pyelftools
      sudo apt-get -y install --no-install-recommends gcc-aarch64-linux-gnu
      sudo apt-get -y install --no-install-recommends gcc-arm-linux-gnueabihf
      sudo apt-get -y install --no-install-recommends honggfuzz
      sudo apt-get -y install --no-install-recommends 'g++'
      sudo apt-get -y install --no-install-recommends 'g++-multilib'
      sudo apt-get -y install --no-install-recommends 'g++-aarch64-linux-gnu'
      sudo apt-get -y install --no-install-recommends 'g++-arm-linux-gnueabihf'
      sudo apt-get -y install --no-install-recommends 'afl++'

    # Lenguajes y entornos
      sudo apt-get -y install --no-install-recommends python3
      sudo apt-get -y install --no-install-recommends python3-pip
      sudo apt-get -y install --no-install-recommends python3-venv
      sudo apt-get -y install --no-install-recommends python3-dev
      sudo apt-get -y install --no-install-recommends pipx
      sudo apt-get -y install --no-install-recommends ruby
      sudo apt-get -y install --no-install-recommends ruby-dev
      sudo apt-get -y install --no-install-recommends golang
      sudo apt-get -y install --no-install-recommends rustc
      sudo apt-get -y install --no-install-recommends cargo
      sudo apt-get -y install --no-install-recommends nodejs
      sudo apt-get -y install --no-install-recommends npm
      sudo apt-get -y install --no-install-recommends default-jdk
      sudo apt-get -y install --no-install-recommends php-cli
      sudo apt-get -y install --no-install-recommends perl
      sudo apt-get -y install --no-install-recommends lua5.4

    # Utilidades generales
      sudo apt-get -y install --no-install-recommends curl
      sudo apt-get -y install --no-install-recommends wget
      sudo apt-get -y install --no-install-recommends aria2
      sudo apt-get -y install --no-install-recommends ca-certificates
      sudo apt-get -y install --no-install-recommends gnupg
      sudo apt-get -y install --no-install-recommends procps
      sudo apt-get -y install --no-install-recommends psmisc
      sudo apt-get -y install --no-install-recommends lsof
      sudo apt-get -y install --no-install-recommends coreutils # Proporciona timeout
      sudo apt-get -y install --no-install-recommends parallel
      sudo apt-get -y install --no-install-recommends expect
      sudo apt-get -y install --no-install-recommends moreutils
      sudo apt-get -y install --no-install-recommends rlwrap
      sudo apt-get -y install --no-install-recommends pv
      sudo apt-get -y install --no-install-recommends sysstat
      sudo apt-get -y install --no-install-recommends jq
      sudo apt-get -y install --no-install-recommends yq
      sudo apt-get -y install --no-install-recommends xmlstarlet
      sudo apt-get -y install --no-install-recommends ripgrep
      sudo apt-get -y install --no-install-recommends fd-find
      sudo apt-get -y install --no-install-recommends bat
      sudo apt-get -y install --no-install-recommends xxd
      sudo apt-get -y install --no-install-recommends file
      sudo apt-get -y install --no-install-recommends unzip
      sudo apt-get -y install --no-install-recommends zip
      sudo apt-get -y install --no-install-recommends 7zip
      sudo apt-get -y install --no-install-recommends 7zip-rar
      sudo apt-get -y install --no-install-recommends unar
      sudo apt-get -y install --no-install-recommends cabextract
      sudo apt-get -y install --no-install-recommends lz4
      sudo apt-get -y install --no-install-recommends zstd
      sudo apt-get -y install --no-install-recommends brotli
      sudo apt-get -y install --no-install-recommends bzip2
      sudo apt-get -y install --no-install-recommends bzip3
      sudo apt-get -y install --no-install-recommends gzip
      sudo apt-get -y install --no-install-recommends xz-utils
      sudo apt-get -y install --no-install-recommends cpio
      sudo apt-get -y install --no-install-recommends sqlite3
      sudo apt-get -y install --no-install-recommends nano

    # Redes servicios y protocolos
      sudo apt-get -y install --no-install-recommends nmap
      sudo apt-get -y install --no-install-recommends netdiscover
      sudo apt-get -y install --no-install-recommends bettercap
      sudo apt-get -y install --no-install-recommends ncat
      sudo apt-get -y install --no-install-recommends ndiff
      sudo apt-get -y install --no-install-recommends masscan
      sudo apt-get -y install --no-install-recommends arp-scan
      sudo apt-get -y install --no-install-recommends arping
      sudo apt-get -y install --no-install-recommends fping
      sudo apt-get -y install --no-install-recommends hping3
      sudo apt-get -y install --no-install-recommends iproute2
      sudo apt-get -y install --no-install-recommends iputils-ping
      sudo apt-get -y install --no-install-recommends traceroute
      sudo apt-get -y install --no-install-recommends whois
      sudo apt-get -y install --no-install-recommends tcpdump
      sudo apt-get -y install --no-install-recommends tshark
      sudo apt-get -y install --no-install-recommends suricata
      sudo apt-get -y install --no-install-recommends ngrep
      sudo apt-get -y install --no-install-recommends tcpick
      sudo apt-get -y install --no-install-recommends tcpflow
      sudo apt-get -y install --no-install-recommends net-tools
      sudo apt-get -y install --no-install-recommends socat
      sudo apt-get -y install --no-install-recommends netcat-openbsd
      sudo apt-get -y install --no-install-recommends openssl
      sudo apt-get -y install --no-install-recommends sslsplit
      sudo apt-get -y install --no-install-recommends testssl.sh
      sudo apt-get -y install --no-install-recommends sslscan
      sudo apt-get -y install --no-install-recommends ssh-audit
      sudo apt-get -y install --no-install-recommends impacket
      sudo apt-get -y install --no-install-recommends smbclient
      sudo apt-get -y install --no-install-recommends nbtscan
      sudo apt-get -y install --no-install-recommends smbmap
      sudo apt-get -y install --no-install-recommends enum4linux
      sudo apt-get -y install --no-install-recommends ldap-utils # Proporciona ldapsearch
      sudo apt-get -y install --no-install-recommends snmp
      sudo apt-get -y install --no-install-recommends braa
      sudo apt-get -y install --no-install-recommends ike-scan

    # DNS, OSINT y Web
      sudo apt-get -y install --no-install-recommends bind9-dnsutils
      sudo apt-get -y install --no-install-recommends ldnsutils
      sudo apt-get -y install --no-install-recommends dnsrecon
      sudo apt-get -y install --no-install-recommends dnsenum
      sudo apt-get -y install --no-install-recommends dnsmap
      sudo apt-get -y install --no-install-recommends dnstracer
      sudo apt-get -y install --no-install-recommends dnstwist
      sudo apt-get -y install --no-install-recommends fierce
      sudo apt-get -y install --no-install-recommends altdns
      sudo apt-get -y install --no-install-recommends assetfinder
      sudo apt-get -y install --no-install-recommends sherlock
      sudo apt-get -y install --no-install-recommends waymore
      sudo apt-get -y install --no-install-recommends arjun
      sudo apt-get -y install --no-install-recommends paramspider
      sudo apt-get -y install --no-install-recommends sqlmap
      sudo apt-get -y install --no-install-recommends ffuf
      sudo apt-get -y install --no-install-recommends gobuster
      sudo apt-get -y install --no-install-recommends dirb
      sudo apt-get -y install --no-install-recommends dirsearch
      sudo apt-get -y install --no-install-recommends wfuzz
      sudo apt-get -y install --no-install-recommends whatweb
      sudo apt-get -y install --no-install-recommends wafw00f

    # Contraseñas, wordlists y cracking
      sudo apt-get -y install --no-install-recommends hydra
      sudo apt-get -y install --no-install-recommends medusa
      sudo apt-get -y install --no-install-recommends ncrack
      sudo apt-get -y install --no-install-recommends patator
      sudo apt-get -y install --no-install-recommends brutespray
      sudo apt-get -y install --no-install-recommends john
      sudo apt-get -y install --no-install-recommends hashcat
      sudo apt-get -y install --no-install-recommends hashcat-data
      sudo apt-get -y install --no-install-recommends hashid
      sudo apt-get -y install --no-install-recommends cewl
      sudo apt-get -y install --no-install-recommends crunch
      sudo apt-get -y install --no-install-recommends cupp
      sudo apt-get -y install --no-install-recommends maskprocessor
      sudo apt-get -y install --no-install-recommends statsprocessor
      sudo apt-get -y install --no-install-recommends fcrackzip
      sudo apt-get -y install --no-install-recommends pdfcrack
      sudo apt-get -y install --no-install-recommends bruteforce-luks
      sudo apt-get -y install --no-install-recommends bruteforce-salted-openssl
      sudo apt-get -y install --no-install-recommends bruteforce-wallet
      sudo apt-get -y install --no-install-recommends cisco7crack
      sudo apt-get -y install --no-install-recommends ophcrack-cli
      sudo apt-get -y install --no-install-recommends samdump2
      sudo apt-get -y install --no-install-recommends chntpw

    # forense, carving, imágenes, metadatos y estego
      sudo apt-get -y install --no-install-recommends binwalk
      sudo apt-get -y install --no-install-recommends foremost
      sudo apt-get -y install --no-install-recommends scalpel
      sudo apt-get -y install --no-install-recommends kpartx
      sudo apt-get -y install --no-install-recommends sleuthkit
      sudo apt-get -y install --no-install-recommends testdisk
      sudo apt-get -y install --no-install-recommends cryptsetup
      sudo apt-get -y install --no-install-recommends plaso
      sudo apt-get -y install --no-install-recommends yara
      sudo apt-get -y install --no-install-recommends ssdeep
      sudo apt-get -y install --no-install-recommends hashdeep
      sudo apt-get -y install --no-install-recommends hashrat
      sudo apt-get -y install --no-install-recommends libimage-exiftool-perl
      sudo apt-get -y install --no-install-recommends exiftool
      sudo apt-get -y install --no-install-recommends exiv2
      sudo apt-get -y install --no-install-recommends pngcheck
      sudo apt-get -y install --no-install-recommends jpeginfo
      sudo apt-get -y install --no-install-recommends imagemagick
      sudo apt-get -y install --no-install-recommends exifprobe
      sudo apt-get -y install --no-install-recommends metacam
      sudo apt-get -y install --no-install-recommends steghide
      sudo apt-get -y install --no-install-recommends stegseek
      sudo apt-get -y install --no-install-recommends outguess
      sudo apt-get -y install --no-install-recommends stegsnow
      sudo apt-get -y install --no-install-recommends snowdrop
      sudo apt-get -y install --no-install-recommends recoverjpeg
      sudo apt-get -y install --no-install-recommends magicrescue
      sudo apt-get -y install --no-install-recommends ext4magic
      sudo apt-get -y install --no-install-recommends extundelete
      sudo apt-get -y install --no-install-recommends dislocker
      sudo apt-get -y install --no-install-recommends mount
      sudo apt-get -y install --no-install-recommends xmount
      sudo apt-get -y install --no-install-recommends pff-tools
      sudo apt-get -y install --no-install-recommends regripper
      sudo apt-get -y install --no-install-recommends rifiuti
      sudo apt-get -y install --no-install-recommends rifiuti2
      sudo apt-get -y install --no-install-recommends winregfs

    # WiFi, WPA, Bluetooth básico y tarjetas/RFID
      sudo apt-get -y install --no-install-recommends aircrack-ng
      sudo apt-get -y install --no-install-recommends hcxdumptool
      sudo apt-get -y install --no-install-recommends hcxtools
      sudo apt-get -y install --no-install-recommends hcxkeys
      sudo apt-get -y install --no-install-recommends cowpatty
      sudo apt-get -y install --no-install-recommends bully
      sudo apt-get -y install --no-install-recommends reaver
      sudo apt-get -y install --no-install-recommends pixiewps
      sudo apt-get -y install --no-install-recommends wifite
      sudo apt-get -y install --no-install-recommends mdk3
      sudo apt-get -y install --no-install-recommends mdk4
      sudo apt-get -y install --no-install-recommends macchanger
      sudo apt-get -y install --no-install-recommends rfkill
      sudo apt-get -y install --no-install-recommends kismet
      sudo apt-get -y install --no-install-recommends btscanner
      sudo apt-get -y install --no-install-recommends mfcuk
      sudo apt-get -y install --no-install-recommends mfoc

    # Android y aplicaciones móviles
      sudo apt-get -y install --no-install-recommends apktool
      sudo apt-get -y install --no-install-recommends adb
      sudo apt-get -y install --no-install-recommends fastboot

    # Criptografía, matemáticas y scripting científico
      sudo apt-get -y install --no-install-recommends sagemath
      sudo apt-get -y install --no-install-recommends pari-gp
      sudo apt-get -y install --no-install-recommends maxima
      sudo apt-get -y install --no-install-recommends z3
      sudo apt-get -y install --no-install-recommends python3-z3
      sudo apt-get -y install --no-install-recommends python3-sympy
      sudo apt-get -y install --no-install-recommends python3-cryptography
      sudo apt-get -y install --no-install-recommends python3-pycryptodome
      sudo apt-get -y install --no-install-recommends python3-gmpy2
      sudo apt-get -y install --no-install-recommends python3-numpy
      sudo apt-get -y install --no-install-recommends python3-scipy

  elif [ $cVerSO == "12" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 12 (Bookworm) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 12 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "11" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 11 (Bullseye) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 11 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "10" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 10 (Buster) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 10 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "9" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 9 (Stretch) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 9 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "8" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 8 (Jessie) standard sin entorno gráfico en una distro de hacking...${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 8 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  elif [ $cVerSO == "7" ]; then

    echo ""
    echo -e "${cColorAzulClaro}  Script de NiPeGun para transformar Debian 7 (Wheezy) standard sin entorno gráfico en una distro de hacking....${cFinColor}"
    echo ""

    echo ""
    echo -e "${cColorRojo}    Comandos para Debian 7 todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
    echo ""

  fi
