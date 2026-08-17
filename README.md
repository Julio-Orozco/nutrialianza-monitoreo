# NutriAlianza S.A. - Sistema de Monitoreo Inteligente con Docker e IA

## Integrantes

- **Julio Gutiérrez Orozco**
- **María José Miranda López**

**Curso:** BCD 7212 - Redes de Computadoras
**Periodo Académico:** II Cuatrimestre 2026
**Institución:** LEAD University

---

## 1. Descripción del proyecto

Este proyecto implementa un sistema local de monitoreo inteligente para **NutriAlianza S.A.** mediante Docker y Docker Compose.

La solución supervisa servicios críticos, recopila métricas y logs, detecta incidentes operativos, utiliza inteligencia artificial para generar análisis técnicos y envía alertas automáticas mediante Telegram.

El entorno fue desarrollado sobre **Windows + WSL2 Ubuntu + Docker Desktop**.

### Componentes principales

- Nginx
- MySQL 8.0
- Prometheus
- Node Exporter
- Nginx Prometheus Exporter
- MySQL Prometheus Exporter
- Blackbox Exporter
- Filebeat
- Logstash
- Loki
- N8N
- Groq API
- Telegram Bot API
- Grafana
- UFW
- Fail2ban
- vnStat
- OpenSSH

---

## 2. Estado final del proyecto

Actualmente están implementados y validados:

- Docker Compose con el stack completo.
- Nginx HTTP y HTTPS.
- Certificado SSL autofirmado para entorno local.
- Endpoint `/health`.
- MySQL 8.0.
- Base de datos `nutrialianza_db`.
- **335.000 registros en la tabla `formulas`.**
- Datos iniciales en `inventario`.
- Prometheus.
- Node Exporter.
- Nginx Exporter.
- MySQL Exporter.
- Blackbox Exporter.
- Filebeat.
- Logstash.
- Loki.
- N8N.
- Groq.
- Telegram.
- Grafana.
- Provisioning automático de Grafana.
- 9 puntos de monitoreo operativos.
- Tres escenarios obligatorios documentados.
- Hardening del servidor validado.

### Escenarios obligatorios completados

1. Saturación HTTP en Nginx.
2. Saturación de conexiones MySQL.
3. Caída del servicio web Nginx.

---

## 3. Arquitectura general

### Métricas

```text
Node Exporter ───────────────┐
Nginx Exporter ──────────────┤
MySQL Exporter ──────────────┤
Blackbox Exporter ───────────┤
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

### Logs

```text
Nginx access/error logs ─────┐
MySQL slow/error logs ───────┤
auth.log SSH ────────────────┤
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

## 4. Estructura del proyecto

```text
nutrialianza-monitoreo/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
│
├── nginx/
│   ├── default.conf
│   ├── certs/
│   │   ├── nutrialianza.crt
│   │   └── nutrialianza.key
│   └── html/
│       └── index.html
│
├── mysql/
│   ├── nutrialianza.cnf
│   ├── nutrialianza_db.sql
│   └── init/
│       ├── 01_schema.sql
│       └── 02_seed_335k_formulas.sql
│
├── prometheus/
│   └── prometheus.yml
│
├── blackbox/
│   └── blackbox.yml
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
│   ├── dashboards/
│   │   └── nutrialianza-grafana-dashboard.json
│   └── provisioning/
│       ├── dashboards/
│       │   └── dashboards.yml
│       └── datasources/
│           └── datasources.yml
│
└── evidencias/
    ├── evidencias-avance.pdf
    ├── escenario-01-saturacion-http-nginx.pdf
    ├── escenario-02-saturacion-conexiones-mysql.pdf
    └── escenario-03-caida-servicio-nginx.pdf
```

Los archivos locales `*.bak` y `.env` están excluidos mediante `.gitignore`.

---

## 5. Requisitos

### Software principal

- Git
- Docker Desktop o Docker Engine
- Docker Compose v2
- WSL2 + Ubuntu en Windows
- Cuenta y API Key de Groq
- Bot de Telegram
- Chat ID de Telegram

### Herramientas utilizadas en el host

```bash
sudo apt update
sudo apt install -y ufw fail2ban vnstat openssh-server unattended-upgrades
```

`sshpass` se utilizó únicamente para generar intentos SSH fallidos de forma controlada durante la validación del punto de monitoreo 9.

---

## 6. Variables de entorno

Crear `.env` a partir de:

```bash
cp .env.example .env
```

Editar:

```bash
nano .env
```

Variables requeridas:

```env
MYSQL_ROOT_PASSWORD=CAMBIAR_PASSWORD_ROOT
MYSQL_DATABASE=nutrialianza_db
MYSQL_USER=nutriapp
MYSQL_PASSWORD=CAMBIAR_PASSWORD_MYSQL

MYSQL_EXPORTER_PASSWORD=CAMBIAR_PASSWORD_EXPORTER

GROQ_API_KEY=PEGAR_API_KEY_GROQ
TELEGRAM_BOT_TOKEN=PEGAR_TOKEN_TELEGRAM
TELEGRAM_CHAT_ID=PEGAR_CHAT_ID

N8N_BASIC_AUTH_USER=CAMBIAR_USUARIO_N8N
N8N_BASIC_AUTH_PASSWORD=CAMBIAR_PASSWORD_N8N

GRAFANA_ADMIN_USER=CAMBIAR_USUARIO_GRAFANA
GRAFANA_ADMIN_PASSWORD=CAMBIAR_PASSWORD_GRAFANA
```

> `.env` contiene credenciales privadas y no debe subirse a GitHub.

---

## 7. Levantar el proyecto

```bash
docker compose up -d
```

Verificar:

```bash
docker compose ps
```

Validar Compose:

```bash
docker compose config
```

Detener sin eliminar información:

```bash
docker compose stop
```

Reanudar:

```bash
docker compose start
```

---

## 8. Servicios y puertos

| Servicio | Puerto |
|---|---:|
| Nginx HTTP | 80 |
| Nginx HTTPS | 443 |
| MySQL | 3306 |
| Grafana | 3000 |
| Loki | 3100 |
| Logstash Beats | 5044 |
| N8N | 5678 |
| Prometheus | 9090 |
| Node Exporter | 9100 |
| MySQL Exporter | 9104 |
| Nginx Exporter | 9113 |
| Blackbox Exporter | 9115 |

URLs principales:

```text
http://localhost
https://localhost
http://localhost:3000
http://localhost:3100
http://localhost:5678
http://localhost:9090
http://localhost:9115
```

---

## 9. Nginx y HTTPS

Health check HTTP:

```bash
curl http://localhost/health
```

Health check HTTPS:

```bash
curl -k https://localhost/health
```

Resultado esperado:

```text
NutriAlianza OK
NutriAlianza OK HTTPS
```

El certificado local está almacenado en:

```text
nginx/certs/nutrialianza.crt
nginx/certs/nutrialianza.key
```

---

## 10. Base de datos MySQL

Base:

```text
nutrialianza_db
```

Tablas principales:

```text
formulas
inventario
```

Estado validado:

```text
total_formulas   = 335000
primer_id        = 1
ultimo_id        = 335000
total_inventario = 3
```

La cantidad de **335.000 registros corresponde específicamente a `formulas`**.

### Generación reproducible

```text
mysql/init/02_seed_335k_formulas.sql
```

genera exactamente 335.000 fórmulas.

El archivo consolidado:

```text
mysql/nutrialianza_db.sql
```

permite importar manualmente la base:

```bash
docker compose exec -T mysql mysql   -uroot   -p"$MYSQL_ROOT_PASSWORD"   nutrialianza_db   < mysql/nutrialianza_db.sql
```

Verificación:

```bash
docker compose exec mysql mysql   -u"$MYSQL_USER"   -p"$MYSQL_PASSWORD"   "$MYSQL_DATABASE"   -e "SELECT COUNT(*) AS total_formulas, MIN(id) AS primer_id, MAX(id) AS ultimo_id FROM formulas; SELECT COUNT(*) AS total_inventario FROM inventario;"
```

---

## 11. Logs de MySQL

Configuración:

```text
mysql/nutrialianza.cnf
```

Valores validados:

```text
slow_query_log       = ON
long_query_time      = 2.000000
slow_query_log_file  = /var/lib/mysql/slow.log
log_error            = /var/lib/mysql/error.log
```

---

## 12. Prometheus y exportadores

Prometheus:

```text
http://localhost:9090
```

Jobs principales:

```text
prometheus
node-exporter
nginx
mysql
blackbox-icmp
blackbox-dns
blackbox-http
blackbox-tcp
```

### Nginx Exporter

```bash
curl -s http://localhost:9113/metrics | grep "^nginx_up "
```

Resultado esperado:

```text
nginx_up 1
```

### MySQL Exporter

```bash
curl -s http://localhost:9104/metrics | grep "^mysql_up "
```

Resultado esperado:

```text
mysql_up 1
```

---

## 13. Blackbox Exporter

Configuración:

```text
blackbox/blackbox.yml
```

Módulos utilizados:

```text
icmp_ipv4
dns_google
http_2xx
tcp_connect
```

Validación:

```text
ICMP 8.8.8.8        probe_success = 1
DNS google.com       probe_success = 1
HTTP /health         status 200 / probe_success = 1
TCP nginx:443        probe_success = 1
TCP mysql:3306       probe_success = 1
TCP n8n:5678         probe_success = 1
```

---

## 14. Los 9 puntos de monitoreo

| # | Punto | Umbral | Resultado validado |
|---:|---|---|---|
| 1 | Ping / latencia | >200 ms o sin respuesta | ~41 ms, 0% pérdida |
| 2 | Verificación DNS | Sin respuesta DNS | Resolución correcta |
| 3 | Health check HTTP | Código != 200 o >3 s | HTTP 200 |
| 4 | Puertos TCP críticos | 443, 3306 o 5678 cerrados | Los 3 disponibles |
| 5 | Ancho de banda | >80 Mbps | RX/TX muy por debajo del umbral |
| 6 | CPU y RAM | CPU >85% / RAM >90% | CPU ~32.44% / RAM ~68.98% |
| 7 | Errores Nginx | >50 errores 5xx en 5 min | 54 errores detectados |
| 8 | Slow queries MySQL | >10 en 5 min | 19 detectadas |
| 9 | Intentos SSH fallidos | >20 en 10 min | 22 detectados |

### Punto 5 - Ancho de banda

Interfaz WSL:

```text
eth0
```

vnStat:

```bash
vnstat -i eth0
vnstat -l -i eth0
```

Prometheus:

```promql
rate(node_network_receive_bytes_total{device="eth0"}[1m])*8/1000000
rate(node_network_transmit_bytes_total{device="eth0"}[1m])*8/1000000
```

Valores observados:

```text
RX ≈ 0.000325 Mbps
TX ≈ 0.00575 Mbps
```

### Punto 6 - CPU y RAM

CPU:

```promql
100-(avg(rate(node_cpu_seconds_total{mode="idle"}[1m]))*100)
```

RAM:

```promql
(1-(node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes))*100
```

### Punto 7 - Errores Nginx

```logql
sum(count_over_time({job="nutrialianza",service="nginx",log_type="access"} |~ " 5[0-9][0-9] " [5m]))
```

Resultado:

```text
54
```

### Punto 8 - Slow queries

```logql
sum(count_over_time({job="nutrialianza",service="mysql",log_type="slow_query"} |= "SELECT SLEEP(3)" [5m]))
```

Resultado:

```text
19
```

### Punto 9 - Intentos SSH fallidos

Filebeat recolecta:

```text
/var/log/host/auth.log
```

Consulta:

```logql
sum(count_over_time({job="nutrialianza",service="ssh",log_type="auth"} |= "Failed password" [10m]))
```

Resultado:

```text
22
```

---

## 15. Filebeat, Logstash y Loki

Flujo:

```text
Nginx ──┐
MySQL ──┼──> Filebeat ──> Logstash ──> Loki
SSH ────┘
```

Filebeat recolecta:

```text
/var/log/nginx/access.log
/var/log/nginx/error.log
/var/lib/mysql/slow.log
/var/lib/mysql/error.log
/var/log/host/auth.log
```

Salida:

```text
logstash:5044
```

Logstash reenvía hacia:

```text
http://loki:3100/loki/api/v1/push
```

Loki:

```bash
curl http://localhost:3100/ready
```

Resultado:

```text
ready
```

Validaciones:

```text
Nginx → Filebeat → Logstash → Loki ✅
MySQL → Filebeat → Logstash → Loki ✅
SSH auth.log → Filebeat → Logstash → Loki ✅
```

---

## 16. N8N, Groq y Telegram

N8N:

```text
http://localhost:5678
```

Workflows:

```text
n8n/alerta-ia-nutrialianza.json
n8n/escenario-01-saturacion-http-nginx.json
n8n/escenario-02-saturacion-conexiones-mysql.json
n8n/escenario-03-caida-servicio-nginx.json
```

Flujo:

```text
Schedule Trigger
      ↓
Prometheus / Loki
      ↓
JavaScript
      ↓
Groq
      ↓
Telegram
```

Las alertas incluyen severidad, descripción, causa probable, impacto y recomendación técnica inmediata.

---

## 17. Grafana

Grafana:

```text
http://localhost:3000
```

Dashboard:

```text
NutriAlianza - Monitoreo General
```

Paneles:

- Estado de servicios monitoreados.
- Servicios activos.
- CPU.
- RAM.
- Disco.

Durante la validación final el dashboard mostró datos correctamente, incluyendo 10 servicios activos.

### Provisioning automático

```text
grafana/provisioning/datasources/datasources.yml
grafana/provisioning/dashboards/dashboards.yml
```

Datasources:

```text
Prometheus → http://prometheus:9090
Loki       → http://loki:3100
```

Dashboard:

```text
grafana/dashboards/nutrialianza-grafana-dashboard.json
```

---

## 18. Escenario 1 - Saturación HTTP Nginx

```bash
ab -n 50000 -c 50 http://localhost/stress
```

Resultados:

```text
Complete requests: 50000
Failed requests: 49936
Non-2xx responses: 49936
Requests per second: 4664.76
Time taken: 10.719 s
Prometheus: ~629.59 solicitudes/s
```

Resultado:

```text
Alerta automática de saturación Nginx enviada por Telegram ✅
```

---

## 19. Escenario 2 - Saturación de conexiones MySQL

Estado inicial:

```text
max_connections = 151
```

Prueba:

```text
mysqlslap
220 clientes concurrentes
SELECT SLEEP(10)
```

Resultados:

```text
1040 Too many connections
Number of clients running queries: 220
Average time: 16.492 s
Connection_errors_max_connections = 897
Threads_connected después = 1
```

PromQL:

```promql
increase(mysql_global_status_connection_errors_total{error="max_connections"}[1m])
```

Resultado:

```text
Alerta automática de saturación MySQL enviada por Telegram ✅
```

---

## 20. Escenario 3 - Caída de Nginx

Estado normal:

```text
nginx_up = 1
HTTP /health = OK
HTTPS /health = OK
Puerto 443 = abierto
```

Caída:

```bash
docker compose stop nginx
```

Durante el incidente:

```text
nginx_up = 0
HTTP = Connection refused
HTTPS = Connection refused
Puerto 443 = cerrado
```

Recuperación:

```bash
docker compose start nginx
```

Secuencia:

```text
1 → 0 → 1
```

Resultado:

```text
Alerta automática de caída de Nginx enviada por Telegram ✅
```

---

## 21. Hardening

| Control | Estado |
|---|---|
| Usuario no-root (`julio`) | ✅ |
| UFW activo | ✅ |
| Fail2ban activo | ✅ |
| Jail `sshd` | ✅ |
| OpenSSH activo | ✅ |
| SSH por llave ED25519 | ✅ |
| `unattended-upgrades` | ✅ |
| HTTPS | ✅ |

### UFW

```bash
sudo ufw status
```

Reglas principales validadas:

```text
22/tcp
80/tcp
443/tcp
3306/tcp
5678/tcp
9090/tcp
9100/tcp
3100/tcp
```

### Fail2ban

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

### SSH por llave

Archivos:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519.pub
~/.ssh/authorized_keys
```

Prueba:

```bash
ssh   -i ~/.ssh/id_ed25519   -o PasswordAuthentication=no   -o PreferredAuthentications=publickey   julio@127.0.0.1   'echo SSH_KEY_OK'
```

Resultado:

```text
SSH_KEY_OK
```

### Parches automáticos

```bash
systemctl is-enabled unattended-upgrades
```

Resultado:

```text
enabled
```

---

## 22. Evidencias

Carpeta:

```text
evidencias/
```

Contiene el avance y los tres escenarios obligatorios.

Para el informe final también se conservaron capturas de:

- 335.000 registros MySQL.
- 9 puntos de monitoreo.
- Loki con logs Nginx/MySQL/SSH.
- Grafana con métricas.
- UFW.
- Fail2ban.
- SSH por llave.
- Telegram.
- Prometheus.
- Blackbox Exporter.

---

## 23. Verificaciones rápidas

```bash
docker compose ps
curl http://localhost/health
curl -k https://localhost/health
curl http://localhost:3100/ready
curl -s http://localhost:3000/api/health
```

Prometheus:

```bash
curl -sG http://localhost:9090/api/v1/query   --data-urlencode 'query=nginx_up'
```

```bash
curl -sG http://localhost:9090/api/v1/query   --data-urlencode 'query=mysql_up'
```

```bash
curl -sG http://localhost:9090/api/v1/query   --data-urlencode 'query=probe_success'
```

Base de datos:

```bash
docker compose exec mysql mysql   -u"$MYSQL_USER"   -p"$MYSQL_PASSWORD"   "$MYSQL_DATABASE"   -e "SELECT COUNT(*) AS total_formulas FROM formulas;"
```

---

## 24. Resultado general

| Componente | Estado |
|---|---|
| Docker Compose | ✅ |
| Nginx HTTP/HTTPS | ✅ |
| MySQL | ✅ |
| 335.000 fórmulas | ✅ |
| Prometheus | ✅ |
| Node Exporter | ✅ |
| Nginx Exporter | ✅ |
| MySQL Exporter | ✅ |
| Blackbox Exporter | ✅ |
| Filebeat | ✅ |
| Logstash | ✅ |
| Loki | ✅ |
| N8N | ✅ |
| Groq | ✅ |
| Telegram | ✅ |
| Grafana | ✅ |
| Provisioning Grafana | ✅ |
| 9 puntos de monitoreo | ✅ |
| Escenario 1 | ✅ |
| Escenario 2 | ✅ |
| Escenario 3 | ✅ |
| Hardening | ✅ |

---

## 25. Pendientes académicos

La infraestructura técnica principal está finalizada.

Pendientes de cierre:

- Informe de ingeniería final.
- Diagrama final de arquitectura.
- Análisis teórico.
- Conclusiones individuales.
- Referencias.
- Presentación ejecutiva.
- Ensayo de la demostración final.

---

## 26. Conclusión

El proyecto de NutriAlianza S.A. implementa un ecosistema local de monitoreo y respuesta basado en Docker.

La solución integra métricas mediante Prometheus, pruebas activas mediante Blackbox Exporter, logs mediante Filebeat/Logstash/Loki, visualización mediante Grafana, automatización mediante N8N, análisis mediante Groq y notificaciones mediante Telegram.

Se validaron:

- 335.000 registros de fórmulas.
- 9 puntos de monitoreo.
- Tres escenarios obligatorios de falla y saturación.
- Logs Nginx, MySQL y SSH.
- Grafana con provisioning reproducible.
- Hardening del servidor.

La infraestructura queda lista para la documentación final, presentación ejecutiva y demostración ante el docente.
