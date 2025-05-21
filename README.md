# Pivot34mo5-.sh
# HelpMemory - Guía de Implementación de Técnicas de Pivoting

## Descripción
HelpMemory es una herramienta interactiva en línea de comandos que proporciona una guía detallada para implementar diversas técnicas de pivoting y tunneling en entornos de red. Diseñada para profesionales de seguridad, pentesters y red teamers, esta herramienta ofrece instrucciones paso a paso para configurar y utilizar diferentes métodos de pivoting.

## Características
- Guía interactiva con menú de opciones
- Instrucciones detalladas para cada técnica
- Verificación de requisitos y dependencias
- Ejemplos prácticos de uso
- Soluciones a problemas comunes
- Mejores prácticas de seguridad

## Técnicas Implementadas
1. **Pivoting con rpivot**
   - Túneles SSH inversos
   - Configuración cliente-servidor
   - Enrutamiento de tráfico

2. **Socat**
   - Túneles bidireccionales
   - Shells encriptadas
   - Port forwarding

3. **Plink (PuTTY Link)**
   - Túneles SSH en Windows
   - Configuración de port forwarding
   - Autenticación con claves

4. **SSHuttle**
   - Túneles tipo VPN
   - Enrutamiento automático
   - Soporte para múltiples protocolos

5. **Windows Netsh**
   - Port forwarding en Windows
   - Configuración de reglas
   - Gestión de túneles

6. **Dnscat2**
   - Tunneling sobre DNS
   - Comando y Control cifrado
   - Evasión de firewalls

7. **Chisel**
   - Túneles HTTP/SSH
   - Modos normal y reverse
   - Integración con Proxychains

8. **ptunnel-ng**
   - Tunneling sobre ICMP
   - Evasión de firewalls
   - Encapsulamiento de tráfico

9. **SocksOverRDP**
   - Túneles SOCKS sobre RDP
   - Integración con Proxifier
   - Acceso a redes internas

10. **Metodologías de Pivoting en Escenarios Reales**
    - Técnicas avanzadas
    - Casos de uso prácticos
    - Mejores prácticas

## Requisitos
- Sistema operativo: Linux (preferiblemente Kali Linux)
- Bash shell
- Permisos de administrador para algunas funcionalidades
- Dependencias específicas para cada técnica (ver sección de instalación)

## Instalación
```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/helpmemory.git

# Dar permisos de ejecución
chmod +x helpmemory.sh

# Ejecutar el script
./helpmemory.sh
```

## Uso
1. Ejecutar el script: `./helpmemory.sh`
2. Seleccionar la técnica deseada del menú
3. Seguir las instrucciones paso a paso
4. Verificar la configuración según las indicaciones

## Consideraciones de Seguridad
- Usar solo en entornos autorizados
- Documentar todas las acciones realizadas
- Mantener un registro de cambios
- Seguir las mejores prácticas de seguridad
- Respetar las políticas de la organización

## Contribuciones
Las contribuciones son bienvenidas. Por favor:
1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## Licencia
Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Autor
[Tu Nombre]

## Agradecimientos
- Comunidad de seguridad
- Contribuidores
- Herramientas y recursos utilizados

## Contacto
- Email: [tu-email]
- Twitter: [@tu-usuario]
- GitHub: [github.com/tu-usuario]

## Disclaimer
Esta herramienta está diseñada únicamente para fines educativos y de prueba. El uso de esta herramienta para acceder a sistemas sin autorización es ilegal y no está permitido. El autor no se hace responsable del mal uso de esta herramienta. 
