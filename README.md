# Local Dev Environment (Docker Compose Stack)

[![GitHub Actions CI](https://img.shields.io/github/actions/workflow/status/reiloe/dev-environment/ci.yml?branch=main&style=for-the-badge&logo=github&label=GitHub%20CI)](https://github.com/reiloe/dev-environment/actions/workflows/ci.yml)
[![GitLab Pipeline Status](https://img.shields.io/gitlab/pipeline-status/reilo2401%2Fdev-environment?branch=main&style=for-the-badge&logo=gitlab&label=GitLab%20CI)](https://gitlab.com/reilo2401/dev-environment/-/pipelines)

![Docker Compose](https://img.shields.io/badge/Docker_Compose-Multi--Arch-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Portainer](https://img.shields.io/badge/Portainer-Container_UI-13BEF9?style=for-the-badge&logo=portainer&logoColor=white)
![Architecture](https://img.shields.io/badge/Arch-ARM64_%7C_AMD64-lightgrey?style=for-the-badge)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)
![Eclipse Mosquitto](https://img.shields.io/badge/Mosquitto-3C5280?style=for-the-badge&logo=eclipsemosquitto&logoColor=white)
![Mailpit](https://img.shields.io/badge/Mailpit-Fake_SMTP-0078D4?style=for-the-badge&logo=maildotru&logoColor=white)

![MinIO](https://img.shields.io/badge/MinIO-C72E49?style=for-the-badge&logo=minio&logoColor=white)
![LocalStack](https://img.shields.io/badge/LocalStack-AWS_Emulator-232F3E?style=for-the-badge&logo=amazonwebservices&logoColor=white)
![Keycloak](https://img.shields.io/badge/Keycloak-OIDC-4D4D4D?style=for-the-badge&logo=keycloak&logoColor=white)

![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![SonarQube](https://img.shields.io/badge/SonarQube-Code_Quality-4E9BCD?style=for-the-badge&logo=sonarqube&logoColor=white)
![Sonatype Nexus](https://img.shields.io/badge/Nexus-Registry-1B222C?style=for-the-badge&logo=sonatype&logoColor=white)
![HashiCorp Vault](https://img.shields.io/badge/Vault-Secrets-FFEC6E?style=for-the-badge&logo=vault&logoColor=black)
![OWASP ZAP](https://img.shields.io/badge/OWASP_ZAP-Security-00549E?style=for-the-badge&logo=owasp&logoColor=white)

![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Alertmanager](https://img.shields.io/badge/Alertmanager-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?style=for-the-badge&logo=grafana&logoColor=white)

A modular, multi-architecture (`linux/arm64` for Apple Silicon & `linux/amd64`) **Docker Compose** infrastructure stack for local software development, IoT prototyping, CI/CD pipelines (Jenkins & SonarQube), and observability demos. Services are organized into logical **Docker Compose Profiles** and can be selectively launched via an interactive terminal checkbox menu (`./start.sh`).

---

## Included Services, Profiles & Default Ports

| Profile | Service | Container Name | Default Port(s) | Web UI / Endpoint | Default Credentials |
| :--- | :--- | :--- | :--- | :--- | :--- |
| *(always active)* | **Portainer CE (Docker UI)** | `dev-portainer` | `9443`, `8000` | `https://localhost:9443` | Create admin user on first visit |
| `jenkins` | **Jenkins (CI/CD)** | `dev-jenkins` | `8085`, `50000` | `http://localhost:8085` | Initial Admin Password via Container Logs |
| `sonarqube` | **SonarQube** | `dev-sonarqube` | `9000` | `http://localhost:9000` | `admin` / `admin` (change on first login) |
| `monitoring` | **Grafana** | `dev-grafana` | `3000` | `http://localhost:3000` | `admin` / `secretpassword` |
| `monitoring` | **Prometheus** | `dev-prometheus` | `9090` | `http://localhost:9090` | — |
| `monitoring` | **Alertmanager** | `dev-alertmanager` | `9093` | `http://localhost:9093` | — |
| `mongodb` | **MongoDB** | `dev-mongodb` | `27017` | `mongodb://localhost:27017` | `admin` / `secretpassword` |
| `mongodb` | **Mongo Express** | `dev-mongo-express` | `8081` | `http://localhost:8081` | `admin` / `secretpassword` |
| `mariadb` | **MariaDB (SQL)** | `dev-mariadb` | `3306` | `localhost:3306` (DB: `appdb`) | `appuser` / `secretpassword` |
| `mariadb` | **Adminer (SQL UI)** | `dev-adminer` | `8082` | `http://localhost:8082` | Server: `mariadb` / `appuser` / `secretpassword` |
| `postgres` | **PostgreSQL (SQL)** | `dev-postgres` | `5432` | `localhost:5432` (DB: `appdb`) | `appuser` / `secretpassword` |
| `postgres` | **pgAdmin 4 (SQL UI)** | `dev-pgadmin` | `8092` | `http://localhost:8092` | `admin@example.com` / `secretpassword` |
| `redis` | **Redis** | `dev-redis` | `6379` | `localhost:6379` (AOF enabled) | — |
| `redis` | **Redis Insight (UI)** | `dev-redisinsight` | `8083` | `http://localhost:8083` | Pre-connected to `redis:6379` |
| `mosquitto` | **Eclipse Mosquitto** | `dev-mosquitto` | `1883`, `9001` | MQTT (`1883`) / WebSockets (`9001`) | Anonymous enabled |
| `mosquitto` | **MQTTX Web (MQTT UI)** | `dev-mqttx-web` | `8084` | `http://localhost:8084` | Connect via `ws://localhost:9001` |
| `mailpit`, `monitoring` | **Mailpit (Fake SMTP)** | `dev-mailpit` | `1025`, `8025` | `http://localhost:8025` | SMTP: `localhost:1025` (any auth accepted) |
| `registry` | **Docker Registry** | `dev-registry` | `5050` | `localhost:5050` | Push via `docker push localhost:5050/<image>` |
| `registry` | **Docker Registry UI** | `dev-registry-ui` | `8091` | `http://localhost:8091` | Browse & delete local images |
| `minio` | **MinIO (S3 Storage)** | `dev-minio` | `9002`, `9003` | API: `9002` / UI: `http://localhost:9003` | `admin` / `secretpassword` |
| `localstack` | **LocalStack (AWS)** | `dev-localstack` | `4566` | `http://localhost:4566` | Dummy AWS credentials (`test` / `test`) |
| `keycloak` | **Keycloak (OIDC)** | `dev-keycloak` | `8086` | `http://localhost:8086` | `admin` / `secretpassword` |
| `nexus` | **Sonatype Nexus** | `dev-nexus` | `8087`, `8088` | `http://localhost:8087` | `admin` / password in `/nexus-data/admin.password` |
| `vault` | **HashiCorp Vault** | `dev-vault` | `8200` | `http://localhost:8200` | Token: `dev-root-token` |
| `zap` | **OWASP ZAP (DAST)** | `dev-zap` | `8090` | `http://localhost:8090` | Webswing Security Scanner UI |

> [!IMPORTANT]
> **Portainer First-Time Setup:** For security reasons, Portainer automatically locks its initial setup wizard if no administrator account is created within **5 minutes** of the first container startup. Right after starting the stack for the first time, open `https://localhost:9443` (accept the self-signed certificate warning in your browser) and create your local admin password. *(If the timeout expires, simply restart the container via `docker restart dev-portainer` to reset the 5-minute window.)*

> [!TIP]
> **MQTT Web UI:** When creating a new connection inside **MQTTX Web** (`http://localhost:8084`), select **`ws://`** as the protocol, **`localhost`** as the host, and **`9001`** as the WebSocket port (backend apps connect via `mqtt://localhost:1883`).

---

## Quick Start

### 1. Clone the Repository

Clone from [GitHub](https://github.com/reiloe/dev-environment) or [GitLab](https://gitlab.com/reilo2401/dev-environment):

```bash
# Clone from GitHub
git clone https://github.com/reiloe/dev-environment.git

# Or clone from GitLab
git clone https://gitlab.com/reilo2401/dev-environment.git

cd dev-environment
```

### 2. Configure Environment Variables (Optional)

Copy the example environment file if you want to customize ports or credentials (otherwise sensible defaults apply automatically):

```bash
cp .env.example .env
```

### 3. Start Services (Interactive Menu or CLI Profiles)

**Option A: Interactive Checkbox Selector (Recommended)**
Launch the terminal UI (`[↑/↓]` navigate, `[Space]` toggle, `[Enter]` start):

```bash
./start.sh
```

*(Note: The custom `jenkins/Dockerfile` includes the Docker CLI and mounts `/var/run/docker.sock`, allowing Jenkins pipelines to build and push Docker images directly on the host.)*

*(Note: Selecting **MongoDB** automatically launches both `mongodb` and `mongo-express`; selecting **MariaDB** automatically launches both `mariadb` and `adminer`.)*

**Option B: Direct Docker Compose Profile Commands**

```bash
# Start specific profiles directly
docker compose --profile mariadb --profile redis up -d

# Or start ALL services at once
docker compose --profile "*" up -d
```

**Retrieve Initial Jenkins Admin Password (first start only):**

```bash
docker exec dev-jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

### 4. Stop & Clean Up

Stop all running profile containers while keeping persistent data volumes intact:

```bash
./stop.sh
# Equivalent to: docker compose --profile "*" down
```

Stop all containers **and delete all persistent volumes** (full reset):

```bash
docker compose --profile "*" down -v
```

---

## Local Git Pre-Commit Hook (Optional)

This repository includes a versioned pre-commit hook (`scripts/pre-commit`) that automatically updates the project tree in `README.md` and validates JSON configs, `docker-compose.yml` profiles, shell scripts (`shellcheck`), and the custom `Dockerfile` (`hadolint`) before each commit:

```bash
cp scripts/pre-commit .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit
```

---

## Project Structure

*Maintained via `scripts/update-tree.py` (run `python3 scripts/update-tree.py` or configure a local Git `pre-commit` hook to update automatically before committing):*

<!-- TREE_START -->
```text
dev-environment/
├── .github/workflows/
│   └── ci.yml
├── alertmanager/
│   └── alertmanager.yml
├── grafana/provisioning/
│   ├── dashboards/
│   │   ├── prometheus-overview.json
│   │   └── provider.yml
│   └── datasources/
│       └── datasources.yml
├── jenkins/
│   └── Dockerfile
├── mosquitto/config/
│   └── mosquitto.conf
├── pgadmin/
│   └── servers.json
├── prometheus/
│   ├── prometheus.yml
│   └── rules.yml
├── scripts/
│   ├── pre-commit
│   └── update-tree.py
├── .env.example
├── .gitignore
├── .gitlab-ci.yml
├── docker-compose.yml
├── LICENSE
├── README.md
├── start.sh
└── stop.sh
```
<!-- TREE_END -->

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## Author

* **GitHub:** [@reiloe](https://github.com/reiloe)
* **GitLab:** [@reilo2401](https://gitlab.com/reilo2401)
