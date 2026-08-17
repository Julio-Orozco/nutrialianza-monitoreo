# NutriAlianza S.A. - Sistema de Monitoreo Inteligente con Docker e IA

## Integrantes

- **Julio Gutiérrez Orozco**
- **María José Miranda López**

- **Curso:** BCD 7212 - Redes de Computadoras
- **Periodo Académico:** II Cuatrimestre 2026
- **Proyecto:** Sistema de Monitoreo Inteligente con Docker e IA
- **Institución:** LEAD University

---

## Descripción del proyecto

Este proyecto implementa un sistema de monitoreo inteligente para **NutriAlianza S.A.**, orientado a supervisar servicios críticos, recopilar métricas y logs, detectar incidentes operativos, generar análisis técnicos mediante inteligencia artificial y enviar alertas automáticas al equipo de TI.

La solución se ejecuta localmente mediante **Docker y Docker Compose** y fue desarrollada sobre **Windows con WSL2 Ubuntu y Docker Desktop**.

El sistema integra componentes de infraestructura, observabilidad, automatización, visualización y notificación:

- Nginx.
- MySQL 8.0.
- Prometheus.
- Node Exporter.
- Nginx Prometheus Exporter.
- MySQL Prometheus Exporter.
- Filebeat.
- Logstash.
- Loki.
- N8N.
- Groq API.
- Telegram Bot API.
- Grafana.

La arquitectura permite correlacionar el estado de los servicios con métricas y registros operativos para generar alertas con mayor contexto técnico.

---

# Estado actual del proyecto

Actualmente se encuentran implementados y validados los siguientes componentes:

- Infraestructura Docker mediante Docker Compose.
- Nginx como servidor web.
- HTTP mediante puerto 80.
- HTTPS mediante puerto 443.
- Certificado SSL autofirmado para el entorno académico local.
- Endpoint `/health`.
- MySQL 8.0.
- Base de datos `nutrialianza_db`.
- **335.000 registros validados en la tabla `formulas`.**
- Datos iniciales disponibles en la tabla `inventario`.
- Prometheus.
- Node Exporter.
- Nginx Prometheus Exporter.
- MySQL Prometheus Exporter.
- Filebeat.
- Logstash como puente entre Filebeat y Loki.
- Loki.
- N8N.
- Groq API.
- Telegram Bot API.
- Grafana.
- Dashboard general de monitoreo.
- UFW.
- Fail2ban.
- Workflows independientes para los tres escenarios obligatorios.
- Evidencias técnicas de los escenarios ejecutados.
- Recolección de logs de Nginx hacia Loki.
- Recolección de slow queries de MySQL hacia Loki.
- Automatización de alertas mediante inteligencia artificial.

Los tres escenarios obligatorios fueron ejecutados satisfactoriamente:

1. **Saturación HTTP en Nginx.**
2. **Saturación de conexiones MySQL.**
3. **Caída del servicio web Nginx.**

---

# Arquitectura general

El flujo de métricas funciona de la siguiente manera:

```text
Node Exporter ──────────────┐
Nginx Exporter ─────────────┤
MySQL Exporter ─────────────┤
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

El flujo de logs implementado es:

```text
Nginx access/error logs ──────┐
                              │
MySQL slow/error logs ────────┤
                              ▼
                           Filebeat
                              │
                              ▼
                           Logstash
                              │
                              ▼
                             Loki
                              │
                              ▼
                           Grafana
```

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
- Filebeat 8.13.4
- Logstash con Loki Output Plugin
- Loki
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
│   ├── nutrialianza.cnf
│   ├── nutrialianza_db.sql
│   │
│   └── init/
│       ├── 01_schema.sql
│       └── 02_seed_335k_formulas.sql
│
├── prometheus/
│   └── prometheus.yml
│
├── loki/
│   └── loki-config.yml
│
├── logstash/
│   └── loki.conf
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

Los archivos locales de respaldo con extensión `*.bak` están excluidos mediante `.gitignore`.

---

# Requisitos previos

Antes de ejecutar el proyecto se requiere:

- Git.
- Docker Desktop en Windows/macOS o Docker Engine en Linux.
- Docker Compose v2.
- Conexión a Internet.
- Puertos requeridos disponibles.
- Cuenta en Groq.
- API Key de Groq.
- Bot de Telegram creado mediante BotFather.
- Token del bot.
- Chat ID del grupo, canal o conversación utilizada para recibir alertas.

En el entorno utilizado durante el desarrollo también se empleó:

- Windows.
- PowerShell.
- WSL2.
- Ubuntu.

---

# Guía de instalación desde cero

## 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
```

Entrar en la carpeta:

```bash
cd nutrialianza-monitoreo
```

---

## 2. Configurar variables de entorno

El repositorio contiene:

```text
.env.example
```

Crear el archivo local `.env`:

```bash
cp .env.example .env
```

Editar:

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

> **Importante:** `.env` contiene credenciales privadas y no debe subirse al repositorio. El archivo está excluido mediante `.gitignore`.

Los workflows de N8N utilizan variables de entorno para consumir las credenciales de Groq y Telegram. Los tokens reales no deben almacenarse directamente dentro de los archivos JSON exportados.

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

Los servicios principales deben aparecer en estado:

```text
Up
```

Para consultar los logs de un servicio:

```bash
docker compose logs <nombre-del-servicio>
```

Ejemplo:

```bash
docker compose logs mysql
```

---

# Servicios principales

| Servicio | Puerto | Acceso |
|---|---:|---|
| Nginx HTTP | 80 | http://localhost |
| Nginx HTTPS | 443 | https://localhost |
| MySQL | 3306 | localhost:3306 |
| Grafana | 3000 | http://localhost:3000 |
| Loki | 3100 | http://localhost:3100 |
| Logstash Beats | 5044 | localhost:5044 |
| N8N | 5678 | http://localhost:5678 |
| Prometheus | 9090 | http://localhost:9090 |
| Node Exporter | 9100 | http://localhost:9100/metrics |
| MySQL Exporter | 9104 | http://localhost:9104/metrics |
| Nginx Exporter | 9113 | http://localhost:9113/metrics |

---

# HTTPS y certificado local

Nginx está configurado para:

```text
HTTP  → puerto 80
HTTPS → puerto 443
```

El entorno académico utiliza un certificado SSL autofirmado almacenado en:

```text
nginx/certs/
```

Archivos:

```text
nutrialianza.crt
nutrialianza.key
```

El certificado es únicamente para pruebas locales.

Prueba HTTPS:

```bash
curl -k https://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK HTTPS
```

---

# Health Checks de Nginx

## HTTP

```bash
curl http://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK
```

## HTTPS

```bash
curl -k https://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK HTTPS
```

## Puerto TCP 443

```bash
timeout 3 bash -c '</dev/tcp/127.0.0.1/443' && echo "PUERTO 443 ABIERTO" || echo "PUERTO 443 CERRADO"
```

En condiciones normales:

```text
PUERTO 443 ABIERTO
```

---

# Base de datos MySQL

La base principal se denomina:

```text
nutrialianza_db
```

La base contiene las tablas:

```text
formulas
inventario
```

## Estado validado

```text
Tabla formulas:
335000 registros

Primer ID:
1

Último ID:
335000

Tabla inventario:
3 registros iniciales
```

La cantidad de **335.000 registros corresponde específicamente a la tabla `formulas`**.

La tabla `inventario` conserva datos iniciales para las pruebas funcionales. La especificación del proyecto no establece que `inventario` deba contener 335.000 registros.

---

# Generación reproducible de las 335.000 fórmulas

El script:

```text
mysql/init/02_seed_335k_formulas.sql
```

genera automáticamente:

```text
335000 registros
```

sin almacenar 335.000 sentencias `INSERT` independientes.

El script:

1. Limpia los registros de prueba de `formulas`.
2. Reinicia el identificador.
3. Genera una secuencia del 1 al 335000.
4. Crea nombres, ingredientes, cantidades y fechas.
5. Inserta exactamente 335.000 fórmulas.
6. Verifica la cantidad final.

Los IDs se generan ordenadamente:

```text
1      → Formula Engorde A
2      → Formula Lechera B
3      → Formula Avicola C
4      → Formula NutriAlianza 000004
...
335000 → Formula NutriAlianza 335000
```

---

# Archivo consolidado de la base de datos

El repositorio incluye:

```text
mysql/nutrialianza_db.sql
```

Este archivo combina:

```text
mysql/init/01_schema.sql
mysql/init/02_seed_335k_formulas.sql
```

y permite una importación manual reproducible.

Importar manualmente:

```bash
docker compose exec -T mysql mysql \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  nutrialianza_db \
  < mysql/nutrialianza_db.sql
```

Verificar:

```bash
docker compose exec mysql mysql \
  -u"$MYSQL_USER" \
  -p"$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" \
  -e "SELECT COUNT(*) AS total_formulas, MIN(id) AS primer_id, MAX(id) AS ultimo_id FROM formulas; SELECT COUNT(*) AS total_inventario FROM inventario;"
```

Resultado validado:

```text
total_formulas = 335000
primer_id      = 1
ultimo_id      = 335000
total_inventario = 3
```

---

# Inicialización automática de MySQL

Los scripts dentro de:

```text
mysql/init/
```

se montan en:

```text
/docker-entrypoint-initdb.d
```

Cuando MySQL se inicializa con un volumen nuevo, los scripts se ejecutan automáticamente en orden:

```text
01_schema.sql
02_seed_335k_formulas.sql
```

Si el volumen de MySQL ya existe, los scripts de inicialización no vuelven a ejecutarse automáticamente. En ese caso puede utilizarse `mysql/nutrialianza_db.sql` para realizar una importación manual.

---

# Configuración de logs de MySQL

MySQL utiliza:

```text
mysql/nutrialianza.cnf
```

La configuración activa:

```text
slow_query_log = ON
long_query_time = 2 segundos
slow_query_log_file = /var/lib/mysql/slow.log
log_error = /var/lib/mysql/error.log
```

Estado validado:

```text
slow_query_log = ON
long_query_time = 2.000000
slow_query_log_file = /var/lib/mysql/slow.log
log_error = /var/lib/mysql/error.log
```

---

# Usuario de monitoreo para MySQL Exporter

El MySQL Exporter utiliza un usuario independiente:

```text
exporter
```

Cargar variables:

```bash
source .env
```

Crear el usuario:

```bash
docker compose exec mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY '${MYSQL_EXPORTER_PASSWORD}' WITH MAX_USER_CONNECTIONS 3; GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%'; FLUSH PRIVILEGES;"
```

Verificar:

```bash
docker compose exec mysql mysql \
  -uroot \
  -p"$MYSQL_ROOT_PASSWORD" \
  -e "SELECT User,Host,max_user_connections FROM mysql.user WHERE User='exporter';"
```

Resultado esperado:

```text
exporter | % | 3
```

---

# Prometheus

Prometheus está disponible en:

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

Jobs configurados:

```text
prometheus
node-exporter
nginx
mysql
```

---

## Validar Nginx Exporter

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

PromQL:

```promql
up{job="node-exporter"}
```

Resultado esperado:

```text
1
```

---

# Nginx Exporter

Disponible en:

```text
http://localhost:9113/metrics
```

Prueba:

```bash
curl -s http://localhost:9113/metrics | grep "^nginx_up "
```

Resultado esperado:

```text
nginx_up 1
```

También se utiliza:

```text
nginx_http_requests_total
```

para monitorear tráfico HTTP.

---

# MySQL Exporter

Disponible en:

```text
http://localhost:9104/metrics
```

Prueba:

```bash
curl -s http://localhost:9104/metrics | grep "^mysql_up "
```

Resultado esperado:

```text
mysql_up 1
```

Métricas utilizadas:

```text
mysql_global_status_threads_connected
mysql_global_variables_max_connections
mysql_global_status_connection_errors_total
```

---

# Filebeat, Logstash y Loki

La canalización de logs implementada es:

```text
Nginx / MySQL
      ↓
   Filebeat
      ↓
   Logstash
      ↓
     Loki
```

Filebeat recolecta:

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
/var/lib/mysql/slow.log
/var/lib/mysql/error.log
```

Filebeat envía los eventos hacia:

```text
logstash:5044
```

Logstash utiliza:

```text
logstash/loki.conf
```

para reenviar los eventos hacia:

```text
http://loki:3100/loki/api/v1/push
```

---

# Validación de logs de Nginx en Loki

Durante las pruebas se generó una solicitud identificable:

```bash
curl "http://localhost/health?prueba_loki=NGINX_LOKI_OK_2026"
```

Consulta en Loki:

```bash
curl -sG http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode 'query={job="nutrialianza"} |= "NGINX_LOKI_OK_2026"' \
  --data-urlencode 'limit=20'
```

El resultado validado incluyó:

```text
job="nutrialianza"
service="nginx"
log_type="access"
```

y la solicitud:

```text
GET /health?prueba_loki=NGINX_LOKI_OK_2026
```

Resultado:

```text
Nginx → Filebeat → Logstash → Loki ✅
```

---

# Validación de slow queries MySQL en Loki

Se generó una consulta deliberadamente lenta:

```bash
docker compose exec mysql mysql \
  -u"$MYSQL_USER" \
  -p"$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" \
  -e "SELECT SLEEP(3);"
```

Como:

```text
long_query_time = 2
```

la consulta quedó registrada en:

```text
/var/lib/mysql/slow.log
```

La consulta en Loki:

```bash
curl -sG http://localhost:3100/loki/api/v1/query_range \
  --data-urlencode 'query={job="nutrialianza",service="mysql",log_type="slow_query"} |= "SELECT SLEEP(3)"' \
  --data-urlencode 'limit=20'
```

devolvió el registro:

```text
SELECT SLEEP(3);
```

Resultado:

```text
MySQL → Filebeat → Logstash → Loki ✅
```

---

# Loki

Loki está disponible en:

```text
http://localhost:3100
```

Validación:

```bash
curl http://localhost:3100/ready
```

Resultado esperado:

```text
ready
```

---

# Workflows de N8N

N8N está disponible en:

```text
http://localhost:5678
```

Los workflows exportados están almacenados en:

```text
n8n/
```

Archivos:

```text
alerta-ia-nutrialianza.json
escenario-01-saturacion-http-nginx.json
escenario-02-saturacion-conexiones-mysql.json
escenario-03-caida-servicio-nginx.json
```

---

# Importar workflows N8N

1. Abrir:

```text
http://localhost:5678
```

2. Ingresar a N8N.

3. Seleccionar la opción para importar un workflow desde archivo.

4. Importar los archivos JSON de:

```text
n8n/
```

5. Verificar variables de entorno de Groq y Telegram.

6. Revisar la configuración de cada nodo.

7. Publicar o activar el workflow correspondiente a la prueba que se desea ejecutar.

> Se recomienda mantener activo únicamente el workflow relacionado con el escenario en ejecución para evitar alertas repetidas.

---

# Flujo general de automatización

Los escenarios utilizan:

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

Cuando N8N detecta una condición anormal, Groq genera una alerta técnica en español con:

- Severidad.
- Descripción del incidente.
- Causa probable.
- Impacto.
- Recomendación técnica inmediata.

---

# Grafana

Grafana está disponible en:

```text
http://localhost:3000
```

Dashboard principal:

```text
NutriAlianza - Monitoreo General
```

Archivo exportado:

```text
grafana/dashboards/nutrialianza-grafana-dashboard.json
```

Prometheus se utiliza como fuente de datos mediante:

```text
http://prometheus:9090
```

Los paneles configurados incluyen:

- Estado general de los servicios.
- Servicios activos.
- Uso de CPU.
- Uso de memoria RAM.
- Uso de disco.

> Dentro de Grafana debe utilizarse el nombre interno `prometheus` y no `localhost`, ya que ambos servicios se ejecutan en contenedores.

---

# Escenario 1 - Saturación HTTP en Nginx

## Objetivo

Simular una cantidad elevada de solicitudes HTTP contra Nginx hasta provocar respuestas HTTP `503`.

## Endpoint

```text
/stress
```

## Prueba ejecutada

```bash
ab -n 50000 -c 50 http://localhost/stress
```

Parámetros:

```text
Solicitudes totales: 50000
Concurrencia: 50
```

## Resultados

```text
Complete requests: 50000
Failed requests: 49936
Non-2xx responses: 49936
Requests per second: 4664.76
Time taken for tests: 10.719 segundos
```

Nginx produjo:

```text
HTTP 503
```

Prometheus registró aproximadamente:

```text
629.59 solicitudes por segundo
```

Umbral utilizado:

```text
20 solicitudes por segundo
```

Cadena de detección:

```text
ApacheBench
     ↓
Nginx
     ↓
Nginx Exporter
     ↓
Prometheus
     ↓
N8N
     ↓
Groq
     ↓
Telegram
```

Resultado:

```text
ESCENARIO 1 COMPLETADO
```

---

# Escenario 2 - Saturación de conexiones MySQL

## Objetivo

Superar el máximo de conexiones simultáneas permitido por MySQL y provocar:

```text
1040 Too many connections
```

## Estado inicial

```text
max_connections = 151
Connection_errors_max_connections = 0
```

## Prueba

Se utilizó `mysqlslap` con:

```text
220 clientes concurrentes
```

y la consulta:

```sql
SELECT SLEEP(10);
```

## Resultados

Durante la prueba se observaron múltiples mensajes:

```text
mysqlslap: Error when connecting to server: 1040 Too many connections
```

Resultados:

```text
Number of clients running queries: 220
Average time: 16.492 segundos
```

El contador alcanzó:

```text
Connection_errors_max_connections = 897
```

Después de la prueba:

```text
Threads_connected = 1
```

Consulta Prometheus:

```promql
increase(mysql_global_status_connection_errors_total{error="max_connections"}[1m])
```

Cadena de detección:

```text
mysqlslap
     ↓
MySQL
     ↓
MySQL Exporter
     ↓
Prometheus
     ↓
N8N
     ↓
Groq
     ↓
Telegram
```

Resultado:

```text
ESCENARIO 2 COMPLETADO
```

---

# Escenario 3 - Caída del servicio web Nginx

## Objetivo

Simular la caída completa del servidor web y comprobar:

- Falla del health check.
- Indisponibilidad HTTP.
- Indisponibilidad HTTPS.
- Cierre del puerto TCP 443.
- Detección mediante Prometheus.
- Alerta mediante Telegram.
- Recuperación del servicio.

## Estado inicial

```text
nginx_up = 1
HTTP /health = NutriAlianza OK
HTTPS /health = NutriAlianza OK HTTPS
Puerto 443 = ABIERTO
```

## Provocar la caída

```bash
docker compose stop nginx
```

## Estado durante el incidente

```text
nginx_up = 0
HTTP = Connection refused
HTTPS = Connection refused
Puerto 443 = CERRADO
```

Consulta utilizada:

```promql
max(nginx_up) or vector(0)
```

Cadena de detección:

```text
Nginx detenido
      ↓
Nginx Exporter
      ↓
Prometheus
      ↓
N8N
      ↓
Groq
      ↓
Telegram
```

## Recuperación

```bash
docker compose start nginx
```

Después:

```text
HTTP /health = NutriAlianza OK
HTTPS /health = NutriAlianza OK HTTPS
nginx_up = 1
```

Secuencia completa:

```text
1 → 0 → 1
```

Resultado:

```text
ESCENARIO 3 COMPLETADO
```

---

# Evidencias

Las evidencias técnicas y académicas están almacenadas en:

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

Los documentos contienen:

- Procedimiento realizado.
- Configuración utilizada.
- Capturas de consola.
- Métricas observadas.
- Parámetros utilizados.
- Resultados numéricos.
- Ejecución de N8N.
- Alertas de Telegram.
- Interpretación técnica.
- Recuperación.
- Conclusiones.

---

# Seguridad

El proyecto contempla:

- Variables privadas almacenadas mediante `.env`.
- `.env` excluido mediante `.gitignore`.
- Tokens no almacenados directamente en workflows N8N.
- Contraseñas no almacenadas directamente en el README.
- UFW instalado.
- Fail2ban instalado.
- Servicios conectados mediante red interna Docker.
- Usuario independiente para MySQL Exporter.
- HTTPS habilitado en Nginx.
- Certificado SSL local.
- Archivos `*.bak` excluidos del repositorio.

---

# Detener el ambiente sin eliminar información

Detener temporalmente:

```bash
docker compose stop
```

Iniciar nuevamente:

```bash
docker compose start
```

Consultar estado:

```bash
docker compose ps
```

> Los volúmenes Docker contienen información persistente de servicios como MySQL, N8N y Grafana.

---

# Verificaciones rápidas

## Docker

```bash
docker compose ps
```

## Nginx HTTP

```bash
curl http://localhost/health
```

## Nginx HTTPS

```bash
curl -k https://localhost/health
```

## Prometheus - Nginx

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=nginx_up'
```

## Prometheus - MySQL

```bash
curl -sG http://localhost:9090/api/v1/query \
  --data-urlencode 'query=mysql_up'
```

## Nginx Exporter

```bash
curl -s http://localhost:9113/metrics | grep "^nginx_up "
```

## MySQL Exporter

```bash
curl -s http://localhost:9104/metrics | grep "^mysql_up "
```

## Loki

```bash
curl http://localhost:3100/ready
```

## Base de datos

```bash
docker compose exec mysql mysql \
  -u"$MYSQL_USER" \
  -p"$MYSQL_PASSWORD" \
  "$MYSQL_DATABASE" \
  -e "SELECT COUNT(*) AS total_formulas, MIN(id) AS primer_id, MAX(id) AS ultimo_id FROM formulas; SELECT COUNT(*) AS total_inventario FROM inventario;"
```

---

# Resultado general

| Componente / prueba | Estado |
|---|---|
| Docker Compose | Completado |
| Nginx HTTP/HTTPS | Completado |
| MySQL | Completado |
| Base de 335.000 fórmulas | Completado |
| Prometheus | Completado |
| Node Exporter | Completado |
| Nginx Exporter | Completado |
| MySQL Exporter | Completado |
| Filebeat | Completado |
| Logstash | Completado |
| Loki | Completado |
| Nginx logs → Loki | Completado |
| MySQL slow queries → Loki | Completado |
| N8N + Groq + Telegram | Completado |
| Grafana | Implementado |
| Escenario 1 | Completado |
| Escenario 2 | Completado |
| Escenario 3 | Completado |
| README reproducible | Completado |

---

# Historial de implementación

El desarrollo fue organizado mediante ramas y commits de Git para conservar trazabilidad.

Entre los cambios principales se encuentran:

```text
Infraestructura de monitoreo para escenarios 1 y 2
Escenario 1 - Saturación HTTP Nginx
Escenario 2 - Saturación de conexiones MySQL
Infraestructura HTTPS para escenario 3
Escenario 3 - Caída del servicio web Nginx
Evidencias de los escenarios obligatorios
Integra logs de Nginx y MySQL con Filebeat y Loki
Agrega base reproducible con 335000 formulas
Actualiza README con base de datos final
```

---

# Paquete de acceso para auditoría

El repositorio contiene:

- `docker-compose.yml`
- `.env.example`
- `.gitignore`
- `README.md`
- Configuración de Nginx.
- Certificado local de Nginx.
- Configuración de MySQL.
- SQL de inicialización.
- Seed de 335.000 fórmulas.
- `mysql/nutrialianza_db.sql`.
- Configuración de Prometheus.
- Configuración de Filebeat.
- Configuración de Logstash.
- Configuración de Loki.
- Workflows N8N exportados.
- Dashboard Grafana exportado.
- Evidencias de los escenarios obligatorios.

Las credenciales privadas de:

- Groq.
- Telegram.
- MySQL.
- N8N.
- Grafana.

no forman parte directamente del repositorio.

---

# Pendientes de cierre académico

La infraestructura técnica principal y los tres escenarios obligatorios se encuentran completados.

Antes de la entrega final quedan principalmente actividades de cierre:

- Verificación final del dashboard Grafana.
- Evidencias finales de UFW y Fail2ban.
- Informe de ingeniería final.
- Diagrama definitivo de arquitectura.
- Muestreo de las alertas de Groq.
- Análisis teórico solicitado por el curso.
- Conclusiones individuales.
- Referencias bibliográficas.
- Presentación ejecutiva.
- Ensayo de la demo interactiva.

---

# Conclusión

El sistema de monitoreo inteligente de **NutriAlianza S.A.** integra infraestructura basada en Docker, métricas recopiladas por Prometheus, logs almacenados en Loki, automatización mediante N8N, análisis mediante Groq y notificaciones en Telegram.

Los tres escenarios obligatorios fueron ejecutados correctamente y permitieron demostrar el comportamiento de la solución frente a:

- Saturación HTTP.
- Saturación de conexiones MySQL.
- Caída completa del servidor web.

También se validó la canalización de logs de Nginx y MySQL mediante:

```text
Filebeat → Logstash → Loki
```

La base de datos de NutriAlianza fue configurada con **335.000 registros de fórmulas**, cumpliendo el volumen solicitado para la tabla principal del proyecto.

La solución permite detectar eventos operativos, recopilar evidencia técnica y convertir métricas y registros en alertas comprensibles y accionables mediante inteligencia artificial.

El proyecto queda preparado para el cierre documental, la validación final de Grafana y hardening, la elaboración del informe de ingeniería y la presentación ejecutiva.
