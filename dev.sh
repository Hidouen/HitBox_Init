#!/bin/bash

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
print_message() {
    echo -e "${BLUE}[HitBox]${NC} $1"
}

print_error() {
    echo -e "${RED}[HitBox] ERROR:${NC} $1"
}

print_success() {
    echo -e "${GREEN}[HitBox] SUCCESS:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[HitBox] WARNING:${NC} $1"
}

# Fonction pour vérifier si Docker est en cours d'exécution
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker n'est pas en cours d'exécution"
        exit 1
    fi
}

# Fonction pour initialiser le projet
init() {
    print_message "Initialisation du projet..."
    
    # Copier le fichier .env.example en .env
    if [ ! -f .env ]; then
        cp .env.example .env
        print_success "Fichier .env créé"
    else
        print_warning "Le fichier .env existe déjà"
    fi

    # Créer les dossiers nécessaires
    mkdir -p Config/{nginx,backend,frontend,postgres}
    mkdir -p Backend
    mkdir -p Frontend
    mkdir -p Database/{scripts}
    mkdir -p Documentation

    print_success "Structure des dossiers créée"
}

# Fonction pour démarrer les conteneurs
start() {
    print_message "Démarrage des conteneurs..."
    docker compose up -d
    print_success "Conteneurs démarrés"
}

# Fonction pour arrêter les conteneurs
stop() {
    print_message "Arrêt des conteneurs..."
    docker compose down
    print_success "Conteneurs arrêtés"
}

# Fonction pour afficher les logs
logs() {
    print_message "Affichage des logs..."
    docker compose logs -f
}

# Fonction pour accéder au shell du backend
backend() {
    print_message "Accès au shell du backend..."
    docker compose exec hitbox_backend sh
}

# Fonction pour accéder au shell du frontend
frontend() {
    print_message "Accès au shell du frontend..."
    docker compose exec hitbox_frontend sh
}

# Fonction pour accéder au shell de la base de données
db() {
    print_message "Accès au shell de la base de données..."
    docker compose exec hitbox_postgres psql -U hitbox
}

# Fonction pour afficher les crédits
credits() {
    echo -e "${RED}À${NC} ${YELLOW}l${GREEN}a${NC} ${RED}r${NC}${YELLOW}é${NC}${GREEN}a${NC}${BLUE}l${NC}${MAGENTA}i${NC}${CYAN}s${NC}${RED}a${NC}${YELLOW}t${NC}${GREEN}i${NC}${BLUE}o${NC}${MAGENTA}n${NC} ${YELLOW}:${NC} ${RED}c${NC}${YELLOW}'${NC}${GREEN}e${NC}${BLUE}s${NC}${MAGENTA}t${NC} ${RED}H${NC}${YELLOW}i${NC}${GREEN}d${NC}${BLUE}o${NC}${MAGENTA}u${NC}${CYAN}e${NC}${RED}n${NC} ${RED}&${NC} ${RED}C${NC}${YELLOW}'${NC}${GREEN}e${NC}${BLUE}s${NC}${MAGENTA}t${RED}L${NC}${YELLOW}'${NC}${GREEN}i${NC}${BLUE}a${NC}"    
}

# Fonction pour afficher l'aide
help() {
    echo "Usage: ./dev.sh [command]"
    echo ""
    echo "Commandes disponibles:"
    echo "  init     - Initialise le projet après téléchargement"
    echo "  start    - Démarre tous les conteneurs"
    echo "  stop     - Arrête tous les conteneurs"
    echo "  logs     - Affiche les logs des conteneurs"
    echo "  backend  - Accès au shell du conteneur PHP"
    echo "  frontend - Accès au shell du conteneur Frontend"
    echo "  db       - Accès au shell PostgreSQL"
    echo "  credits  - Affiche les crédits"
    echo "  help     - Affiche cette aide"
}

# Vérifier que Docker est en cours d'exécution
check_docker

# Gestion des commandes
case "$1" in
    "init")
        init
        ;;
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    "logs")
        logs
        ;;
    "backend")
        backend
        ;;
    "frontend")
        frontend
        ;;
    "db")
        db
        ;;
    "credits")
        credits
        ;;
    "help"|"")
        help
        ;;
    *)
        print_error "Commande inconnue: $1"
        help
        exit 1
        ;;
esac 