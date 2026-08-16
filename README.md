# NutriAlianza S.A. - Sistema de Monitoreo Inteligente con Docker e IA

## Integrantes

- **Julio Gutiérrez Orozco**
- **María José Miranda López**

**Curso:** BCD 7212 - Redes de Computadoras
**Periodo Académico:** II Cuatrimestre 2026
**Proyecto:** Sistema de Monitoreo Inteligente con Docker e IA

---

## Descripción del proyecto

Este proyecto implementa un sistema de monitoreo inteligente para **NutriAlianza S.A.**, desarrollado como parte del curso **BCD 7212 - Redes de Computadoras**.

La solución utiliza una infraestructura local basada en contenedores Docker para supervisar servicios, recopilar métricas, visualizar información, detectar incidentes operativos y generar alertas técnicas mediante inteligencia artificial.

El sistema integra componentes de monitoreo, automatización, visualización y notificación, entre ellos:

- Nginx.
- MySQL.
- Prometheus.
- Node Exporter.
- Nginx Prometheus Exporter.
- MySQL Prometheus Exporter.
- N8N.
- Groq.
- Telegram.
- Grafana.
- Loki.
- Filebeat.

La infraestructura fue desarrollada y probada sobre **Windows utilizando WSL2 con Ubuntu, Docker Desktop y Docker Compose**, lo cual permite ejecutar un entorno Linux completo sin utilizar una máquina virtual tradicional.

El flujo principal de monitoreo implementado es:

```text
Servicios e infraestructura
        │
        ├── Node Exporter
        ├── Nginx Exporter
        └── MySQL Exporter
                │
                ▼
           Prometheus
                │
                ▼
               N8N
                │
                ▼
              Groq IA
                │
                ▼
             Telegram
```

Grafana se utiliza como herramienta de visualización para consultar métricas y representar gráficamente el estado general de la infraestructura.

---

# Estado actual del proyecto

Actualmente se encuentran implementados y probados los siguientes componentes:

- Infraestructura Docker mediante Docker Compose.
- Nginx como servidor web.
- HTTP mediante puerto 80.
- HTTPS mediante puerto 443.
- Certificado SSL autofirmado para el entorno académico local.
- Endpoint `/health`.
- MySQL 8.0.
- Prometheus.
- Node Exporter.
- Nginx Prometheus Exporter.
- MySQL Prometheus Exporter.
- N8N.
- Groq API.
- Telegram Bot API.
- Grafana.
- Loki.
- Filebeat.
- Dashboard general de monitoreo.
- Workflows independientes para los tres escenarios obligatorios.
- Evidencias técnicas de los escenarios ejecutados.
- UFW.
- Fail2ban.
- Automatización de alertas mediante inteligencia artificial.

Los tres escenarios obligatorios de estrés fueron ejecutados satisfactoriamente:

1. **Saturación HTTP en Nginx.**
2. **Saturación de conexiones MySQL.**
3. **Caída del servicio web Nginx.**

---

# Tecnologías utilizadas

- Windows
- PowerShell
- WSL2
- Ubuntu
- Docker Desktop
- Docker Compose
- Git
- GitHub
- Nginx
- OpenSSL
- MySQL 8.0
- Prometheus
- Node Exporter
- Nginx Prometheus Exporter
- MySQL Prometheus Exporter
- Loki
- Filebeat
- N8N
- Groq API
- Telegram Bot API
- Grafana
- ApacheBench
- mysqlslap
- UFW
- Fail2ban

---

# Estructura del proyecto

```text
nutrialianza-monitoreo/
│
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
│
├── nginx/
│   ├── default.conf
│   │
│   ├── certs/
│   │   ├── nutrialianza.crt
│   │   └── nutrialianza.key
│   │
│   └── html/
│       └── index.html
│
├── mysql/
│   └── init/
│       └── 01_schema.sql
│
├── prometheus/
│   └── prometheus.yml
│
├── loki/
│   └── loki-config.yml
│
├── filebeat/
│   └── filebeat.yml
│
├── n8n/
│   ├── alerta-ia-nutrialianza.json
│   ├── escenario-01-saturacion-http-nginx.json
│   ├── escenario-02-saturacion-conexiones-mysql.json
│   └── escenario-03-caida-servicio-nginx.json
│
├── grafana/
│   └── dashboards/
│       └── nutrialianza-grafana-dashboard.json
│
└── evidencias/
    ├── evidencias-avance.pdf
    ├── escenario-01-saturacion-http-nginx.pdf
    ├── escenario-02-saturacion-conexiones-mysql.pdf
    └── escenario-03-caida-servicio-nginx.pdf
```

Los archivos locales utilizados como respaldo durante las pruebas utilizan extensión:

```text
*.bak
```

Estos archivos están excluidos mediante `.gitignore` y no forman parte del repositorio.

---

# Requisitos previos

Antes de ejecutar el proyecto se debe contar con:

- Git.
- Docker Desktop en Windows o macOS, o Docker Engine en Linux.
- Docker Compose v2.
- Conexión a Internet.
- Puertos requeridos disponibles.
- Cuenta gratuita en Groq.
- API Key de Groq.
- Bot de Telegram creado mediante BotFather.
- Token del bot de Telegram.
- Chat ID del grupo, canal o conversación utilizada para recibir alertas.

El ambiente utilizado durante el desarrollo incluye adicionalmente:

- Windows.
- PowerShell.
- WSL2.
- Ubuntu.

---

# Guía de instalación desde cero

## 1. Clonar el repositorio

Desde una terminal:

```bash
git clone <URL_DEL_REPOSITORIO>
```

Entrar al proyecto:

```bash
cd nutrialianza-monitoreo
```

---

## 2. Configurar variables de entorno

El repositorio contiene el archivo:

```text
.env.example
```

Se debe crear una copia llamada `.env`:

```bash
cp .env.example .env
```

Editar el archivo:

```bash
nano .env
```

Completar las variables requeridas:

```env
MYSQL_ROOT_PASSWORD=CAMBIAR_PASSWORD_ROOT
MYSQL_DATABASE=nutrialianza_db
MYSQL_USER=nutriapp
MYSQL_PASSWORD=CAMBIAR_PASSWORD_MYSQL

MYSQL_EXPORTER_PASSWORD=CAMBIAR_PASSWORD_EXPORTER

GROQ_API_KEY=PEGAR_AQUI_LA_API_KEY_DE_GROQ
TELEGRAM_BOT_TOKEN=PEGAR_AQUI_EL_TOKEN_DEL_BOT
TELEGRAM_CHAT_ID=PEGAR_AQUI_EL_CHAT_ID

N8N_BASIC_AUTH_USER=CAMBIAR_USUARIO_N8N
N8N_BASIC_AUTH_PASSWORD=CAMBIAR_PASSWORD_N8N

GRAFANA_ADMIN_USER=CAMBIAR_USUARIO_GRAFANA
GRAFANA_ADMIN_PASSWORD=CAMBIAR_PASSWORD_GRAFANA
```

> **Importante:** el archivo `.env` contiene credenciales privadas y no debe subirse a GitHub. Se encuentra incluido dentro del archivo `.gitignore`.

Los workflows de N8N utilizan variables de entorno para consumir las credenciales de Groq y Telegram.

Los tokens reales no se almacenan directamente dentro de los archivos JSON exportados.

---

# Levantar el ecosistema Docker

Desde la raíz del proyecto:

```bash
docker compose up -d
```

Verificar los contenedores:

```bash
docker compose ps
```

Validar la configuración:

```bash
docker compose config
```

Los servicios principales deben aparecer con estado:

```text
Up
```

En caso de problemas con un servicio específico:

```bash
docker compose logs <nombre-del-servicio>
```

Ejemplo:

```bash
docker compose logs nginx
```

---

# MySQL

MySQL utiliza la base de datos:

```text
nutrialianza_db
```

Las credenciales son obtenidas desde el archivo `.env`.

Para comprobar que MySQL está disponible:

```bash
docker compose exec mysql mysql \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  -e "SHOW DATABASES;"
```

---

# Usuario de monitoreo para MySQL Exporter

`mysqld-exporter` utiliza un usuario independiente llamado:

```text
exporter
```

Primero se deben cargar las variables:

```bash
source .env
```

Crear el usuario:

```bash
docker compose exec mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY '${MYSQL_EXPORTER_PASSWORD}' WITH MAX_USER_CONNECTIONS 3; GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%'; FLUSH PRIVILEGES;"
```

Comprobarlo:

```bash
docker compose exec mysql mysql \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  -e "SELECT User,Host,max_user_connections FROM mysql.user WHERE User='exporter';"
```

El resultado esperado incluye:

```text
exporter | % | 3
```

---

# HTTPS y certificado local

Nginx está configurado para utilizar:

```text
HTTP  → puerto 80
HTTPS → puerto 443
```

El entorno académico utiliza un certificado SSL autofirmado almacenado dentro de:

```text
nginx/certs/
```

Archivos:

```text
nutrialianza.crt
nutrialianza.key
```

Este certificado se utiliza únicamente para pruebas locales y no debe considerarse un certificado válido para un ambiente productivo real.

Debido a que se trata de un certificado autofirmado, las pruebas HTTPS mediante `curl` utilizan:

```bash
curl -k https://localhost/health
```

---

# Servicios y puertos

| Servicio | Puerto | Acceso |
|---|---:|---|
| Nginx HTTP | 80 | http://localhost |
| Nginx HTTPS | 443 | https://localhost |
| MySQL | 3306 | localhost:3306 |
| Grafana | 3000 | http://localhost:3000 |
| N8N | 5678 | http://localhost:5678 |
| Prometheus | 9090 | http://localhost:9090 |
| Node Exporter | 9100 | http://localhost:9100/metrics |
| MySQL Exporter | 9104 | http://localhost:9104/metrics |
| Nginx Exporter | 9113 | http://localhost:9113/metrics |
| Loki | 3100 | http://localhost:3100 |

---

# Health Checks

## HTTP

```bash
curl http://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK
```

---

## HTTPS

```bash
curl -k https://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK HTTPS
```

---

## Puerto TCP 443

Para comprobar que HTTPS está disponible:

```bash
timeout 3 bash -c '</dev/tcp/127.0.0.1/443' && echo "PUERTO 443 ABIERTO" || echo "PUERTO 443 CERRADO"
```

En condiciones normales:

```text
PUERTO 443 ABIERTO
```

---

# Prometheus

Prometheus se encuentra disponible en:

```text
http://localhost:9090
```

Actualmente recibe métricas de:

```text
prometheus:9090
node-exporter:9100
nginx-exporter:9113
mysqld-exporter:9104
```

Los jobs configurados son:

```text
prometheus
node-exporter
nginx
mysql
```

---

## Validar Nginx Exporter

Consulta:

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=nginx_up'
```

Estado normal:

```text
1
```

---

## Validar MySQL Exporter

Consulta:

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=mysql_up'
```

Estado normal:

```text
1
```

---

## Validar Node Exporter

Desde Prometheus:

```promql
up{job="node-exporter"}
```

Resultado esperado:

```text
1
```

---

# Nginx Exporter

El Nginx Prometheus Exporter se encuentra disponible en:

```text
http://localhost:9113/metrics
```

Para comprobarlo:

```bash
curl -s http://localhost:9113/metrics | grep "^nginx_up "
```

Resultado esperado:

```text
nginx_up 1
```

También se utiliza la métrica:

```text
nginx_http_requests_total
```

para analizar tráfico HTTP.

---

# MySQL Exporter

El MySQL Prometheus Exporter se encuentra disponible en:

```text
http://localhost:9104/metrics
```

Para comprobarlo:

```bash
curl -s http://localhost:9104/metrics | grep "^mysql_up "
```

Resultado esperado:

```text
mysql_up 1
```

Entre las métricas utilizadas durante las pruebas se encuentran:

```text
mysql_global_status_threads_connected
mysql_global_variables_max_connections
mysql_global_status_connection_errors_total
```

---

# Workflows de N8N

N8N se encuentra disponible en:

```text
http://localhost:5678
```

Los workflows exportados están almacenados en:

```text
n8n/
```

Archivos disponibles:

```text
alerta-ia-nutrialianza.json
escenario-01-saturacion-http-nginx.json
escenario-02-saturacion-conexiones-mysql.json
escenario-03-caida-servicio-nginx.json
```

---

## Importar workflows

1. Abrir:

```text
http://localhost:5678
```

2. Ingresar a N8N.

3. Ir a la opción de importar workflow desde archivo.

4. Seleccionar el archivo JSON requerido dentro de:

```text
n8n/
```

5. Verificar las variables de entorno utilizadas por Groq y Telegram.

6. Confirmar las configuraciones de cada nodo.

7. Publicar o activar el workflow correspondiente al escenario que se desea ejecutar.

> Durante las pruebas se recomienda mantener activo únicamente el workflow correspondiente al escenario en ejecución para evitar alertas repetidas o innecesarias.

---

# Flujo general de automatización

Los escenarios utilizan la siguiente estructura:

```text
Schedule Trigger
        │
        ▼
Consultar Prometheus
        │
        ▼
Code in JavaScript
        │
        ▼
Groq
        │
        ▼
Enviar Telegram
```

Durante las pruebas se utilizó un intervalo de:

```text
10 segundos
```

Prometheus entrega la métrica correspondiente al incidente.

N8N interpreta el resultado y determina si existe una condición anormal.

Cuando se detecta un incidente:

```text
Prometheus
     ↓
N8N
     ↓
JavaScript
     ↓
Groq
     ↓
Telegram
```

Groq recibe información técnica del incidente y genera una alerta en español con:

- Severidad.
- Descripción del incidente.
- Causa probable.
- Impacto posible.
- Recomendación técnica inmediata.

---

# Grafana

Grafana se encuentra disponible en:

```text
http://localhost:3000
```

El dashboard principal creado se denomina:

```text
NutriAlianza - Monitoreo General
```

El archivo exportado del dashboard se encuentra en:

```text
grafana/dashboards/nutrialianza-grafana-dashboard.json
```

Prometheus se configura como fuente de datos mediante:

```text
http://prometheus:9090
```

Los paneles creados permiten visualizar:

- Estado general de servicios.
- Servicios activos.
- Uso de CPU.
- Uso de memoria RAM.
- Uso de disco.

> Dentro de Grafana debe utilizarse el nombre interno del servicio `prometheus` y no `localhost`, debido a que Grafana se ejecuta dentro de un contenedor Docker.

---

# Loki

Loki está disponible en:

```text
http://localhost:3100
```

Para validar su disponibilidad:

```bash
curl http://localhost:3100/ready
```

El resultado esperado es:

```text
ready
```

---

# Filebeat

El proyecto incluye:

```text
filebeat/filebeat.yml
```

Filebeat forma parte de la arquitectura de recopilación de logs contemplada para el sistema.

Antes de la entrega final debe verificarse que la salida configurada en `filebeat.yml` corresponda exactamente con la arquitectura final de almacenamiento y consulta de logs utilizada por el grupo.

---

# Escenarios obligatorios ejecutados

# Escenario 1 - Saturación HTTP en Nginx

## Objetivo

Simular una cantidad elevada de solicitudes HTTP contra Nginx hasta provocar respuestas HTTP de error debido al mecanismo de rate limiting configurado.

---

## Endpoint utilizado

```text
/stress
```

Nginx utiliza una zona de limitación de solicitudes configurada específicamente para este escenario.

---

## Prueba realizada

Se utilizó ApacheBench:

```bash
ab -n 50000 -c 50 http://localhost/stress
```

Parámetros:

```text
Solicitudes totales: 50000
Concurrencia: 50
Endpoint: /stress
```

---

## Resultados

Resultados obtenidos:

```text
Complete requests: 50000
Failed requests: 49936
Non-2xx responses: 49936
Requests per second: 4664.76
Time taken for tests: 10.719 segundos
```

Durante la prueba Nginx produjo respuestas:

```text
HTTP 503
```

Prometheus registró aproximadamente:

```text
629.59 solicitudes por segundo
```

El umbral configurado en N8N fue:

```text
20 solicitudes por segundo
```

La cadena de detección fue:

```text
ApacheBench
     ↓
Nginx
     ↓
nginx-exporter
     ↓
Prometheus
     ↓
N8N
     ↓
Groq
     ↓
Telegram
```

La alerta automática llegó correctamente al bot de Telegram.

Resultado:

```text
ESCENARIO 1 COMPLETADO
```

---

# Escenario 2 - Saturación de conexiones MySQL

## Objetivo

Superar el máximo de conexiones simultáneas permitido por MySQL y provocar el error:

```text
1040 Too many connections
```

---

## Estado inicial

El servidor MySQL tenía:

```text
max_connections = 151
```

Antes de la prueba:

```text
Connection_errors_max_connections = 0
```

---

## Prueba realizada

Se utilizó:

```text
mysqlslap
```

con:

```text
220 clientes concurrentes
```

La consulta utilizada fue:

```sql
SELECT SLEEP(10);
```

El objetivo de `SLEEP(10)` fue mantener las conexiones abiertas durante un periodo suficiente para superar el límite de conexiones simultáneas.

---

## Resultado del benchmark

Durante la prueba se observaron múltiples mensajes:

```text
mysqlslap: Error when connecting to server: 1040 Too many connections
```

El benchmark utilizó:

```text
Number of clients running queries: 220
Average time: 16.492 segundos
```

---

## Estado de MySQL después de la prueba

El contador:

```text
Connection_errors_max_connections
```

alcanzó:

```text
897
```

Después de terminar la saturación:

```text
Threads_connected = 1
```

Esto confirmó que las conexiones temporales fueron liberadas y MySQL recuperó su funcionamiento normal.

---

## Consulta Prometheus utilizada

```promql
increase(mysql_global_status_connection_errors_total{error="max_connections"}[1m])
```

Esta consulta permite detectar conexiones rechazadas nuevas dentro de la última ventana de un minuto.

La cadena de monitoreo fue:

```text
mysqlslap
     ↓
MySQL
     ↓
mysqld-exporter
     ↓
Prometheus
     ↓
N8N
     ↓
Groq
     ↓
Telegram
```

La alerta automática fue recibida correctamente.

Resultado:

```text
ESCENARIO 2 COMPLETADO
```

---

# Escenario 3 - Caída del servicio web Nginx

## Objetivo

Simular la caída completa del servidor web Nginx y comprobar:

- Falla del health check.
- Indisponibilidad HTTP.
- Indisponibilidad HTTPS.
- Cierre del puerto TCP 443.
- Detección automática mediante Prometheus.
- Procesamiento mediante N8N.
- Análisis mediante Groq.
- Notificación mediante Telegram.
- Recuperación posterior del servicio.

---

## Estado inicial

Antes de ejecutar la caída:

```text
nginx_up = 1
HTTP /health = NutriAlianza OK
HTTPS /health = NutriAlianza OK HTTPS
Puerto 443 = ABIERTO
```

---

## Provocar la caída

Se ejecutó:

```bash
docker compose stop nginx
```

---

## Estado durante el incidente

Después de detener Nginx:

```text
nginx_up = 0
```

El health check HTTP produjo:

```text
Connection refused
```

El health check HTTPS produjo:

```text
Connection refused
```

La validación del puerto 443 mostró:

```text
PUERTO 443 CERRADO
```

---

## Consulta utilizada por N8N

```promql
max(nginx_up) or vector(0)
```

En condiciones normales:

```text
1
```

Durante la caída:

```text
0
```

---

## Alerta automática

La cadena de detección fue:

```text
Nginx detenido
      ↓
nginx-exporter
      ↓
Prometheus
      ↓
N8N
      ↓
Groq
      ↓
Telegram
```

Telegram recibió correctamente una alerta de:

```text
Caída del servicio web Nginx
```

con severidad alta, explicación del incidente, impacto y recomendaciones técnicas.

---

## Recuperación

El servicio se restauró mediante:

```bash
docker compose start nginx
```

Después de iniciar nuevamente Nginx:

```text
HTTP /health = NutriAlianza OK
HTTPS /health = NutriAlianza OK HTTPS
nginx_up = 1
```

La secuencia completa observada fue:

```text
1 → 0 → 1
```

Esto representa:

```text
Servicio saludable
        ↓
Servicio caído
        ↓
Servicio recuperado
```

Resultado:

```text
ESCENARIO 3 COMPLETADO
```

---

# Evidencias

Las evidencias técnicas y académicas del proyecto están almacenadas en:

```text
evidencias/
```

Archivos:

```text
evidencias-avance.pdf
escenario-01-saturacion-http-nginx.pdf
escenario-02-saturacion-conexiones-mysql.pdf
escenario-03-caida-servicio-nginx.pdf
```

Los documentos incluyen:

- Procedimiento realizado.
- Configuración utilizada.
- Capturas de consola.
- Métricas observadas.
- Parámetros utilizados.
- Resultados numéricos.
- Errores producidos durante las pruebas.
- Capturas de Prometheus.
- Capturas de N8N.
- Alertas recibidas en Telegram.
- Interpretación técnica.
- Recuperación de los servicios.
- Conclusiones.

---

# Seguridad

El proyecto utiliza diferentes medidas para evitar exposición innecesaria de credenciales y mejorar la seguridad del entorno.

Entre ellas:

- Variables privadas almacenadas mediante `.env`.
- `.env` excluido del repositorio mediante `.gitignore`.
- Tokens no almacenados directamente en workflows N8N.
- Contraseñas no almacenadas directamente dentro del README.
- UFW instalado.
- Fail2ban instalado.
- Servicios separados mediante la red interna de Docker.
- Usuario independiente para MySQL Exporter.
- HTTPS habilitado en Nginx.
- Certificado SSL utilizado exclusivamente para el laboratorio.
- Archivos de respaldo `*.bak` excluidos del repositorio.

---

# Detener el ambiente sin eliminar información

Para detener temporalmente los servicios:

```bash
docker compose stop
```

Para iniciarlos nuevamente:

```bash
docker compose start
```

Consultar estado:

```bash
docker compose ps
```

> Los volúmenes Docker contienen información persistente utilizada por servicios como MySQL, N8N y Grafana.

---

# Verificaciones rápidas

## Docker

```bash
docker compose ps
```

---

## Nginx HTTP

```bash
curl http://localhost/health
```

---

## Nginx HTTPS

```bash
curl -k https://localhost/health
```

---

## Prometheus - Nginx

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=nginx_up'
```

---

## Prometheus - MySQL

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=mysql_up'
```

---

## Nginx Exporter

```bash
curl -s http://localhost:9113/metrics | grep "^nginx_up "
```

---

## MySQL Exporter

```bash
curl -s http://localhost:9104/metrics | grep "^mysql_up "
```

---

## Loki

```bash
curl http://localhost:3100/ready
```

---

# Resultado general de los escenarios obligatorios

| Escenario | Estado |
|---|---|
| Escenario 1 - Saturación HTTP Nginx | Completado |
| Escenario 2 - Saturación de conexiones MySQL | Completado |
| Escenario 3 - Caída del servicio web Nginx | Completado |

Los tres escenarios permitieron comprobar la cadena completa de automatización:

```text
Incidente
    ↓
Servicio afectado
    ↓
Exporter
    ↓
Prometheus
    ↓
N8N
    ↓
Groq
    ↓
Telegram
```

El sistema demostró capacidad para:

- Supervisar el estado de servicios.
- Detectar incidentes.
- Identificar condiciones anormales.
- Procesar métricas.
- Generar contexto técnico.
- Utilizar inteligencia artificial para analizar incidentes.
- Enviar alertas automáticas.
- Detectar la recuperación de los servicios.

---

# Historial de implementación de escenarios

El desarrollo de los escenarios fue organizado mediante Git para mantener trazabilidad de las modificaciones.

Se utilizaron commits separados para:

```text
Infraestructura de monitoreo para escenarios 1 y 2
Escenario 1 - Saturación HTTP Nginx
Escenario 2 - Saturación de conexiones MySQL
Infraestructura HTTPS para escenario 3
Escenario 3 - Caída del servicio web Nginx
Evidencias de los escenarios obligatorios
```

Esto permite identificar la evolución técnica del proyecto y mantener un historial organizado de los cambios realizados.

---

# Paquete de acceso para auditoría

El repositorio contiene los elementos necesarios para reproducir y revisar el proyecto:

- `docker-compose.yml`
- `.env.example`
- `.gitignore`
- `README.md`
- Configuración de Nginx.
- Certificado local utilizado por Nginx.
- Configuración de MySQL.
- Configuración de Prometheus.
- Configuración de Loki.
- Configuración de Filebeat.
- Workflows N8N exportados.
- Dashboard Grafana exportado.
- Evidencias de los escenarios obligatorios.

Las credenciales privadas de:

- Groq.
- Telegram.
- MySQL.
- N8N.
- Grafana.

no están incluidas directamente en el repositorio.

---

# Verificaciones pendientes antes de la entrega final

Aunque los tres escenarios obligatorios ya fueron completados, existen elementos que deben verificarse antes de considerar finalizado el proyecto completo.

## Base de datos de NutriAlianza

La especificación académica establece una base de datos con aproximadamente:

```text
335,000 registros de fórmulas
```

La versión del script SQL incluida en el repositorio debe comprobarse antes de la entrega final para garantizar que contiene la cantidad y estructura de datos solicitadas.

La validación puede realizarse mediante:

```bash
docker compose exec mysql mysql \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  -e "USE nutrialianza_db; SELECT COUNT(*) FROM formulas;"
```

---

## Integración Filebeat y Loki

Debe verificarse que la configuración final de:

```text
filebeat/filebeat.yml
```

envíe los logs al componente de almacenamiento de logs definido por la arquitectura final.

También debe comprobarse que Loki pueda recibir y consultar dichos registros.

---

## Informe de ingeniería

Debe completarse el informe técnico final con:

- Marco teórico.
- Arquitectura.
- Configuración.
- Escenarios.
- Resultados.
- Análisis.
- Evidencias.
- Conclusiones.
- Respuestas de análisis teórico requeridas por el proyecto.

---

## Presentación ejecutiva

Debe prepararse la presentación final y la demostración interactiva del sistema.

---

# Conclusión

El sistema de monitoreo inteligente de **NutriAlianza S.A.** integra infraestructura basada en Docker, métricas de Prometheus, automatización mediante N8N, análisis mediante Groq y notificaciones en Telegram.

Los tres escenarios obligatorios fueron ejecutados correctamente y permitieron demostrar el comportamiento del sistema frente a:

- Saturación HTTP.
- Saturación de conexiones de base de datos.
- Caída completa del servidor web.

Los resultados comprobaron que la solución no se limita a almacenar métricas, sino que permite detectar eventos operativos y convertirlos en alertas técnicas comprensibles y accionables.

La infraestructura también incorpora Grafana para visualización, HTTPS para Nginx y mecanismos básicos de seguridad mediante variables de entorno, UFW y Fail2ban.

El proyecto queda preparado para completar las verificaciones finales de datos, logs, documentación técnica y presentación ejecutiva antes de la entrega definitiva.
