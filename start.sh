#!/usr/bin/env bash
set -e

OPTIONS=(
  "MariaDB + Adminer (SQL Database & Web UI)"
  "MongoDB + Mongo Express (NoSQL & Web UI)"
  "PostgreSQL + pgAdmin (SQL Database & Web UI)"
  "Redis + Redis Insight (In-Memory Cache & Web UI)"
  "Eclipse Mosquitto + MQTTX Web (MQTT Broker + Web UI)"
  "Monitoring Stack (Prometheus + Alertmanager + Grafana + Mailpit)"
  "Jenkins (CI/CD Server with Docker CLI)"
  "SonarQube (Code Quality & Static Analysis)"
  "Mailpit (Fake SMTP Server & Webmail UI)"
  "Private Docker Registry + Web UI"
  "MinIO (S3-Compatible Object Storage)"
  "LocalStack (AWS Cloud Emulator)"
  "Keycloak (OAuth2 / OIDC Identity Provider)"
  "Sonatype Nexus (Maven / npm / PyPI / Docker Registry)"
  "HashiCorp Vault (Secrets Management)"
  "OWASP ZAP (Web Security Scanner UI)"
  "ALL Services"
)

PROFILES=(
  "mariadb"
  "mongodb"
  "postgres"
  "redis"
  "mosquitto"
  "monitoring"
  "jenkins"
  "sonarqube"
  "mailpit"
  "registry"
  "minio"
  "localstack"
  "keycloak"
  "nexus"
  "vault"
  "zap"
  "all"
)

SELECTED=(false false false false false false false false false false false false false false false false false)


CURSOR=0
COUNT=${#OPTIONS[@]}

# Cursor verstecken und beim Beenden sicher wiederherstellen
tput civis
trap 'tput cnorm' EXIT

render_menu() {
  clear
  echo "=========================================================="
  echo "  Dev Environment - Select Services to Start"
  echo "=========================================================="
  echo "  [↑/↓] Navigate   [Space] Toggle   [Enter] Start   [q] Quit"
  echo "  (Portainer Management UI always starts automatically on :9443)"
  echo "----------------------------------------------------------"
  for i in "${!OPTIONS[@]}"; do
    if [[ "${SELECTED[$i]}" == "true" ]]; then
      CHECK="[x]"
    else
      CHECK="[ ]"
    fi

    if [[ $i -eq $CURSOR ]]; then
      echo -e "  \033[1;36m> $CHECK ${OPTIONS[$i]}\033[0m"
    else
      echo "    $CHECK ${OPTIONS[$i]}"
    fi
  done
  echo "----------------------------------------------------------"
}

while true; do
  render_menu

  # Tasteneingabe lesen
  IFS= read -rsn1 key
  if [[ "$key" == $'\x1b' ]]; then
    read -rsn2 key
    case "$key" in
      '[A') # Pfeil hoch
        ((CURSOR = (CURSOR - 1 + COUNT) % COUNT))
        ;;
      '[B') # Pfeil runter
        ((CURSOR = (CURSOR + 1) % COUNT))
        ;;
    esac
  elif [[ "$key" == " " ]]; then
    if [[ "${SELECTED[CURSOR]}" == "true" ]]; then
      SELECTED[CURSOR]=false
    else
      SELECTED[CURSOR]=true
    fi
  elif [[ "$key" == "" ]]; then
    break
  elif [[ "$key" == "q" || "$key" == "Q" ]]; then
    echo "Aborted."
    exit 0
  fi
done

# Ausgewählte Profile einsammeln
PROFILE_ARGS=()
ALL_SELECTED=false

for i in "${!PROFILES[@]}"; do
  if [[ "${SELECTED[$i]}" == "true" ]]; then
    if [[ "${PROFILES[$i]}" == "all" ]]; then
      ALL_SELECTED=true
      break
    fi
    PROFILE_ARGS+=("--profile" "${PROFILES[$i]}")
  fi
done

if [[ "$ALL_SELECTED" == "true" ]]; then
  echo "Starting ALL services..."
  docker compose --profile "*" up -d
elif [[ ${#PROFILE_ARGS[@]} -eq 0 ]]; then
  echo "No services selected. Nothing started."
  exit 0
else
  echo "Starting selected services: ${PROFILE_ARGS[*]}"
  docker compose "${PROFILE_ARGS[@]}" up -d
fi

echo ""
docker compose ps
