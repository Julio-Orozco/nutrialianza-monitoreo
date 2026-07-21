# NutriAlianza S.A. - Sistema de Monitoreo Inteligente con Docker e IA

## Descripción del proyecto

Este proyecto corresponde al primer avance del sistema de monitoreo inteligente para **NutriAlianza S.A.** Su objetivo es implementar una infraestructura local basada en Docker que permita supervisar servicios, recopilar métricas, procesar alertas mediante inteligencia artificial y enviar notificaciones automáticas a Telegram en tiempo real.

El entorno fue desarrollado sobre **Windows** utilizando **WSL2 con Ubuntu**, **Docker Desktop** y **Docker Compose**, facilitando un entorno Linux sin necesidad de una máquina virtual tradicional.

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
GROQ_API_KEY=PEGAR_AQUI_LA_API_KEY_DE_GROQ
TELEGRAM_BOT_TOKEN=PEGAR_AQUI_EL_TOKEN_DEL_BOT
TELEGRAM_CHAT_ID=PEGAR_AQUI_EL_CHAT_ID
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
| Prometheus | http://localhost:9090 |
| Loki | http://localhost:3100/ready |
| N8N | http://localhost:5678 |

---

## Pruebas realizadas

Durante el desarrollo del primer avance se verificó el funcionamiento de los siguientes componentes:

- Docker ejecutándose correctamente sobre WSL2.
- Docker Compose disponible y operativo.
- UFW instalado y activo.
- Fail2ban instalado y activo.
- Contenedores Docker ejecutándose correctamente.
- Nginx respondiendo desde el navegador.
- Prometheus obteniendo métricas mediante la consulta `up`.
- Loki respondiendo con el estado `ready`.
- MySQL inicializado con la base de datos y tablas correspondientes.
- Workflow de N8N funcionando correctamente.
- Groq generando respuestas mediante inteligencia artificial.
- Telegram recibiendo alertas automáticas en tiempo real.

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

## Evidencias

Las evidencias correspondientes al primer avance se encuentran almacenadas en la carpeta:

```text
evidencias/
```

Archivo principal:

```text
evidencias-avance.pdf
```

En este documento se incluyen capturas del funcionamiento del sistema, los contenedores activos, las pruebas realizadas y la recepción de alertas automáticas en Telegram.

---

## Estado del avance

Actualmente el proyecto cumple con los objetivos establecidos para el primer avance:

- Servidor local funcionando mediante Docker.
- Hardening básico aplicado mediante UFW y Fail2ban.
- Ecosistema Docker inicializado y comunicándose correctamente.
- Integración funcional entre Prometheus, N8N, Groq y Telegram.
- Notificación automatizada generada por inteligencia artificial y enviada exitosamente al bot de Telegram.
- Flujo de automatización exportado en formato JSON para facilitar su reutilización e importación.

---
