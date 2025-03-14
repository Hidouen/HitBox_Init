#!/bin/bash

# Fonction pour afficher les messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Configuration du timeout
MAX_RETRIES=60  # Timeout après 60 secondes
RETRY_COUNT=0

log "Attente de PostgreSQL..."
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
    RETRY_COUNT=$((RETRY_COUNT + 1))
    if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
        log "Erreur : PostgreSQL n'est pas prêt après $MAX_RETRIES secondes. Abandon."
        exit 1
    fi
    log "PostgreSQL n'est pas encore prêt - attente ($RETRY_COUNT/$MAX_RETRIES)..."
    sleep 1
done
log "PostgreSQL est prêt!"

# Créer la base de données si elle n'existe pas
log "Vérification et création de la base de données si nécessaire..."
if ! PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -lqt | cut -d \| -f 1 | grep -qw "$POSTGRES_DB"; then
    log "La base de données n'existe pas. Création de la base de données..."
    PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -c "CREATE DATABASE $POSTGRES_DB;"
    log "Base de données $POSTGRES_DB créée."
else
    log "La base de données $POSTGRES_DB existe déjà."
fi

# Vérifier si des scripts SQL existent
if [ -z "$(ls -A /docker-entrypoint-initdb.d/*.sql 2>/dev/null)" ]; then
    log "Aucun script SQL trouvé dans /docker-entrypoint-initdb.d/. Rien à faire."
    exit 0
fi

# Vérification de l'initialisation des données
log "Vérification de l'initialisation de la base de données..."
if PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'users');" | grep -q "t"; then
    log "La base de données est déjà initialisée."
    exit 0
fi

# Exécuter les scripts SQL dans l'ordre
log "Exécution des scripts d'initialisation..."
for script in /docker-entrypoint-initdb.d/*.sql; do
    if [ -f "$script" ]; then
        log "Exécution de $script..."
        if ! PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f "$script"; then
            log "Erreur lors de l'exécution de $script"
            exit 1
        fi
    fi
done

log "Initialisation de la base de données terminée!" 