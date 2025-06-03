#!/bin/bash

# =============================================================================
# Script: helpmemory.sh
# Descripción: Herramienta para implementación de port forwarding y pivoting
# Autor: Oliver
# Fecha: 2024
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
    echo -e "${YELLOW}Seleccione el tipo de port forwarding:${NC}"
    echo -e "${GREEN}1.${NC} Port Forwarding Local (-L)"
    echo -e "${GREEN}2.${NC} Port Forwarding Remoto (-R)"
    echo -e "${GREEN}3.${NC} Port Forwarding Dinámico (-D)"
    echo -e "${GREEN}4.${NC} Pivoting"
    echo -e "${GREEN}5.${NC} Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el menú de Port Forwarding Local
show_local_forwarding_menu() {
    clear_screen
    echo -e "${BLUE}=== Port Forwarding Local (-L) ===${NC}"
    echo -e "${YELLOW}Seleccione el método:${NC}"
    echo -e "${GREEN}1.${NC} SSH Local Forwarding"
    echo -e "${GREEN}2.${NC} Socat Local Forwarding"
    echo -e "${GREEN}3.${NC} Chisel Local Forwarding"
    echo -e "${GREEN}4.${NC} Volver al menú principal"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el menú de Port Forwarding Remoto
show_remote_forwarding_menu() {
    clear_screen
    echo -e "${BLUE}=== Port Forwarding Remoto (-R) ===${NC}"
    echo -e "${YELLOW}Seleccione el método:${NC}"
    echo -e "${GREEN}1.${NC} SSH Remote Forwarding"
    echo -e "${GREEN}2.${NC} Socat Remote Forwarding"
    echo -e "${GREEN}3.${NC} Chisel Remote Forwarding"
    echo -e "${GREEN}4.${NC} Volver al menú principal"
    echo
    echo -n "Seleccione una opción: "
}

# Función para mostrar el menú de Port Forwarding Dinámico
show_dynamic_forwarding_menu() {
    clear_screen
    echo -e "${BLUE}=== Port Forwarding Dinámico (-D) ===${NC}"
    echo -e "${YELLOW}Seleccione el método:${NC}"
    echo -e "${GREEN}1.${NC} SSH Dynamic Forwarding"
    echo -e "${GREEN}2.${NC} Chisel Dynamic Forwarding"
    echo -e "${GREEN}3.${NC} SocksOverRDP"
    echo -e "${GREEN}4.${NC} Volver al menú principal"
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
    echo -e "${GREEN}4.${NC} Volver al menú principal"
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
                    show_local_forwarding_menu
                    read -r local_option

                    case $local_option in
                        1) implement_ssh_local_forwarding ;;
                        2) implement_socat_forwarding ;;
                        3) implement_chisel_forwarding ;;
                        4) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            2)
                while true; do
                    show_remote_forwarding_menu
                    read -r remote_option

                    case $remote_option in
                        1) implement_ssh_remote_forwarding ;;
                        2) implement_socat_forwarding ;;
                        3) implement_chisel_forwarding ;;
                        4) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            3)
                while true; do
                    show_dynamic_forwarding_menu
                    read -r dynamic_option

                    case $dynamic_option in
                        1) implement_ssh_dynamic_forwarding ;;
                        2) implement_chisel_forwarding ;;
                        3) implement_socks_over_rdp ;;
                        4) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            4)
                while true; do
                    show_pivoting_menu
                    read -r pivoting_option

                    case $pivoting_option in
                        1) implement_sshuttle ;;
                        2) implement_proxychains ;;
                        3) implement_metasploit_autoroute ;;
                        4) break ;;
                        *) show_error "Opción inválida" ;;
                    esac

                    wait_for_enter
                done
                ;;
            5)
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
