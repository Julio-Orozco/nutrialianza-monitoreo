# NutriAlianza S.A. - Sistema de Monitoreo Inteligente con Docker e IA
 
## Descripción del proyecto
 
Este proyecto corresponde al avance actual del sistema de monitoreo inteligente para **NutriAlianza S.A.** Su objetivo es implementar una infraestructura local basada en Docker que permita supervisar servicios, recopilar métricas, visualizar información mediante dashboards, procesar alertas mediante inteligencia artificial y enviar notificaciones automáticas a Telegram en tiempo real.
 
El entorno fue desarrollado sobre **Windows** utilizando **WSL2 con Ubuntu**, **Docker Desktop** y **Docker Compose**, facilitando un entorno Linux sin necesidad de una máquina virtual tradicional.
 
En esta etapa se incorporó **Grafana** como herramienta de visualización, permitiendo mostrar de forma gráfica el estado de los servicios monitoreados, métricas del sistema y paneles de control asociados al funcionamiento general del ecosistema Docker.
 
---
 
## Tecnologías utilizadas
 
- Windows
- PowerShell
- WSL2 con Ubuntu
- Docker Desktop
- Docker Compose
- Nginx
- MySQL 8.0
- Prometheus
- Node Exporter
- Loki
- Filebeat
- N8N
- Groq API
- Telegram Bot API
- Grafana
 
---
 
## Estructura del proyecto
 
```text
nutrialianza-monitoreo/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
├── nginx/
│   ├── default.conf
│   └── html/
│       └── index.html
├── mysql/
│   └── init/
│       └── 01_schema.sql
├── prometheus/
│   └── prometheus.yml
├── loki/
│   └── loki-config.yml
├── filebeat/
│   └── filebeat.yml
├── n8n/
│   └── alerta-ia-nutrialianza.json
├── grafana/
│   └── dashboards/
│       └── nutrialianza-grafana-dashboard.json
└── evidencias/
    └── evidencias-avance.pdf
```
 
---
 
## Requisitos previos
 
Antes de ejecutar el proyecto es necesario contar con:
 
- Docker Desktop instalado.
- Docker Compose disponible.
- WSL2 con Ubuntu instalado y configurado.
- Integración entre Docker Desktop y WSL2 habilitada.
- Conexión a Internet.
- Cuenta gratuita en Groq.
- Bot de Telegram creado mediante BotFather.
- Token del bot de Telegram.
- Chat ID del grupo o canal de Telegram.
- Navegador web para acceder a Nginx, Prometheus, N8N y Grafana.
- Acceso al repositorio del proyecto.
 
---
 
## Configuración de variables de entorno
 
El repositorio incluye el archivo:
 
```text
.env.example
```
 
Para ejecutar el proyecto se debe crear el archivo `.env` a partir del archivo de ejemplo:
 
```bash
cp .env.example .env
```
 
Luego editarlo:
 
```bash
nano .env
```
 
Y completar las siguientes variables:
 
```env
MYSQL_ROOT_PASSWORD=PEGAR_AQUI_PASSWORD_ROOT_MYSQL
MYSQL_DATABASE=nutrialianza_db
MYSQL_USER=nutriapp
MYSQL_PASSWORD=PEGAR_AQUI_PASSWORD_MYSQL
 
GROQ_API_KEY=PEGAR_AQUI_LA_API_KEY_DE_GROQ
TELEGRAM_BOT_TOKEN=PEGAR_AQUI_EL_TOKEN_DEL_BOT
TELEGRAM_CHAT_ID=PEGAR_AQUI_EL_CHAT_ID
 
N8N_BASIC_AUTH_USER=PEGAR_AQUI_USUARIO_N8N
N8N_BASIC_AUTH_PASSWORD=PEGAR_AQUI_PASSWORD_N8N
 
GRAFANA_ADMIN_USER=PEGAR_AQUI_USUARIO_GRAFANA
GRAFANA_ADMIN_PASSWORD=PEGAR_AQUI_PASSWORD_GRAFANA
```
 
> **Importante:** El archivo `.env` contiene credenciales privadas y **no debe subirse al repositorio**. Por esa razón se encuentra incluido dentro del archivo `.gitignore`.
 
---
 
## Cómo levantar el proyecto
 
Ingresar a WSL2 desde PowerShell:
 
```bash
wsl
```
 
Entrar a la carpeta del proyecto:
 
```bash
cd ~/nutrialianza-monitoreo
```
 
Levantar todos los servicios:
 
```bash
docker compose up -d
```
 
Verificar que los contenedores estén ejecutándose:
 
```bash
docker compose ps
```
 
Validar la configuración de Docker Compose:
 
```bash
docker compose config
```
 
Detener todos los servicios:
 
```bash
docker compose stop
```
 
---
 
## URLs principales
 
Una vez iniciado el ecosistema Docker, los servicios estarán disponibles en:
 
| Servicio | URL |
|----------|-----|
| Nginx | http://localhost |
| Health Check Nginx | http://localhost/health |
| Prometheus | http://localhost:9090 |
| Node Exporter | http://localhost:9100/metrics |
| Loki | http://localhost:3100/ready |
| N8N | http://localhost:5678 |
| Grafana | http://localhost:3000 |
 
---
 
## Pruebas realizadas
 
Durante el desarrollo del avance actual se verificó el funcionamiento de los siguientes componentes:
 
- Docker ejecutándose correctamente sobre WSL2.
- Docker Compose disponible y operativo.
- UFW instalado y activo.
- Fail2ban instalado y activo.
- Contenedores Docker ejecutándose correctamente.
- Nginx respondiendo desde el navegador.
- Endpoint `/health` de Nginx respondiendo correctamente.
- Prometheus obteniendo métricas mediante la consulta `up`.
- Prometheus detectando correctamente el estado de `prometheus:9090`.
- Prometheus detectando correctamente el estado de `node-exporter:9100`.
- Node Exporter exponiendo métricas del sistema.
- Loki respondiendo con el estado `ready`.
- MySQL inicializado con la base de datos y tablas correspondientes.
- Workflow de N8N funcionando correctamente.
- Groq generando respuestas mediante inteligencia artificial.
- Telegram recibiendo alertas automáticas en tiempo real.
- Grafana agregado al ecosistema Docker.
- Grafana conectado correctamente con Prometheus como fuente de datos.
- Dashboard general creado en Grafana.
- Paneles de monitoreo creados para servicios activos, estado de servicios, CPU, memoria RAM y disco.
- Dashboard de Grafana exportado y almacenado en el repositorio.
 
---
 
## Flujo de automatización
 
El flujo implementado dentro de N8N sigue la siguiente secuencia:
 
```text
Schedule Trigger
        │
        ▼
Consultar Prometheus
        │
        ▼
Código JavaScript
        │
        ▼
Groq IA
        │
        ▼
Enviar mensaje a Telegram
```
 
Durante este proceso, **Prometheus** consulta el estado de los servicios, **N8N** procesa la información recibida, **Groq** genera un análisis utilizando inteligencia artificial y finalmente **Telegram** recibe la notificación automática en tiempo real.
 
---
 
## Dashboard de Grafana
 
En esta etapa se integró **Grafana** para visualizar el estado general del sistema de monitoreo.
 
El dashboard principal creado se llama:
 
```text
NutriAlianza - Monitoreo General
```
 
El archivo exportado del dashboard se encuentra en:
 
```text
grafana/dashboards/nutrialianza-grafana-dashboard.json
```
 
Los paneles configurados incluyen:
 
- Estado de servicios monitoreados.
- Servicios activos.
- Uso de CPU del servidor.
- Uso de memoria RAM.
- Uso de disco.
 
Para conectar Grafana con Prometheus se utilizó la siguiente URL interna dentro de Docker:
 
```text
http://prometheus:9090
```
 
> Nota: dentro de Grafana no se debe usar `localhost:9090`, ya que Grafana se ejecuta dentro de un contenedor Docker. Por eso se utiliza el nombre del servicio `prometheus`.
 
---
 
## Evidencias
 
Las evidencias correspondientes al avance del proyecto se encuentran almacenadas en la carpeta:
 
```text
evidencias/
```
 
Archivo principal:
 
```text
evidencias-avance.pdf
```
 
En este documento se incluyen capturas del funcionamiento del sistema, los contenedores activos, las pruebas realizadas y la recepción de alertas automáticas en Telegram.
 
Para esta etapa también se deben incluir evidencias de:
 
- Grafana funcionando correctamente.
- Dashboard general de monitoreo.
- Prometheus mostrando `prometheus:9090` y `node-exporter:9100` en estado `1`.
- N8N ejecutando el flujo de alerta.
- Telegram recibiendo notificaciones.
- Servicios Docker activos mediante `docker compose ps`.
 
---
 
## Estado del avance
 
Actualmente el proyecto cumple con los objetivos establecidos para el avance actual:
 
- Servidor local funcionando mediante Docker.
- Hardening básico aplicado mediante UFW y Fail2ban.
- Ecosistema Docker inicializado y comunicándose correctamente.
- Integración funcional entre Prometheus, N8N, Groq y Telegram.
- Notificación automatizada generada por inteligencia artificial y enviada exitosamente al bot de Telegram.
- Flujo de automatización exportado en formato JSON para facilitar su reutilización e importación.
- Grafana integrado al archivo `docker-compose.yml`.
- Grafana funcionando desde `http://localhost:3000`.
- Prometheus agregado como fuente de datos en Grafana.
- Dashboard general creado para visualizar métricas del sistema.
- Dashboard exportado en formato JSON dentro de `grafana/dashboards/nutrialianza-grafana-dashboard.json`.
- Node Exporter funcionando correctamente y reportando métricas a Prometheus.
- Servicios principales verificados mediante la consulta `up`.
 
Queda pendiente complementar el proyecto con la ejecución documentada de los escenarios de estrés, capturas finales, informe de ingeniería final y presentación ejecutiva.
 
---
