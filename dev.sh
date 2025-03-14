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

# Fonction pour vérifier si un conteneur est en cours d'exécution
check_container() {
    if ! docker container inspect "$1" >/dev/null 2>&1; then
        print_error "Le conteneur $1 n'est pas en cours d'exécution"
        return 1
    fi
    
    if [ "$(docker container inspect -f '{{.State.Status}}' "$1")" != "running" ]; then
        print_error "Le conteneur $1 n'est pas en cours d'exécution"
        return 1
    fi
    
    return 0
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
    
    # Arrêter les conteneurs existants et supprimer les volumes
    docker compose down -v > /dev/null 2>&1
    
    # Démarrer les conteneurs
    if docker compose up -d; then
        # Attendre que les conteneurs soient prêts
        print_message "Attente du démarrage des conteneurs..."
        sleep 5
        
        # Vérifier l'état des conteneurs
        local all_healthy=true
        for container in hitbox_db hitbox_backend hitbox_frontend hitbox_nginx; do
            if ! docker ps -q -f name="$container" | grep -q .; then
                print_error "Le conteneur $container n'a pas démarré"
                all_healthy=false
            fi
        done
        
        if $all_healthy; then
            print_success "Conteneurs démarrés"
        else
            print_error "Certains conteneurs n'ont pas démarré correctement"
            docker compose logs
            exit 1
        fi
    else
        print_error "Erreur lors du démarrage des conteneurs"
        exit 1
    fi
}

# Fonction pour arrêter les conteneurs
stop() {
    print_message "Arrêt des conteneurs..."
    if docker compose down; then
        print_success "Conteneurs arrêtés"
    else
        print_error "Erreur lors de l'arrêt des conteneurs"
        exit 1
    fi
}

# Fonction pour afficher les logs
logs() {
    print_message "Affichage des logs..."
    docker compose logs -f
}

# Fonction pour accéder au shell du backend
backend() {
    print_message "Accès au shell du backend..."
    if check_container "hitbox_backend"; then
        docker exec -it hitbox_backend sh
    fi
}

# Fonction pour accéder au shell du frontend
frontend() {
    print_message "Accès au shell du frontend..."
    if check_container "hitbox_frontend"; then
        docker exec -it hitbox_frontend sh
    fi
}

# Fonction pour accéder au shell de la base de données
db() {
    print_message "Accès au shell de la base de données..."
    if check_container "hitbox_db"; then
        docker exec -it hitbox_db psql -U hitbox
    fi
}

# Fonction pour afficher les crédits
credits() {
    echo -e "${RED}À${NC} ${YELLOW}l${GREEN}a${NC} ${RED}r${NC}${YELLOW}é${NC}${GREEN}a${NC}${BLUE}l${NC}${MAGENTA}i${NC}${CYAN}s${NC}${RED}a${NC}${YELLOW}t${NC}${GREEN}i${NC}${BLUE}o${NC}${MAGENTA}n${NC} ${YELLOW}:${NC} ${RED}c${NC}${YELLOW}'${NC}${GREEN}e${NC}${BLUE}s${NC}${MAGENTA}t${NC} ${RED}H${NC}${YELLOW}i${NC}${GREEN}d${NC}${BLUE}o${NC}${MAGENTA}u${NC}${CYAN}e${NC}${RED}n${NC} ${RED}&${NC} ${RED}C${NC}${YELLOW}'${NC}${GREEN}e${NC}${BLUE}s${NC}${MAGENTA}t${RED}L${NC}${YELLOW}'${NC}${GREEN}i${NC}${BLUE}a${NC}"    
}

# Fonction pour redémarrer les conteneurs
restart() {
    print_message "Redémarrage des conteneurs..."
    stop
    start
}

# Fonction pour afficher les logs du backend
logs_backend() {
    print_message "Affichage des logs du backend..."
    if check_container "hitbox_backend"; then
        docker logs -f hitbox_backend
    fi
}

# Fonction pour afficher les logs du frontend
logs_frontend() {
    print_message "Affichage des logs du frontend..."
    if check_container "hitbox_frontend"; then
        docker logs -f hitbox_frontend
    fi
}

# Fonction pour afficher les logs de la base de données
logs_db() {
    print_message "Affichage des logs de la base de données..."
    if check_container "hitbox_db"; then
        docker logs -f hitbox_db
    fi
}

# Fonction pour afficher les logs du nginx
logs_nginx() {
    print_message "Affichage des logs du nginx..."
    if check_container "hitbox_nginx"; then
        docker logs -f hitbox_nginx
    fi
}

# Fonction pour afficher l'aide
help() {
    echo "Usage: ./dev.sh [command]"
    echo ""
    echo "Commandes disponibles:"
    echo "  init          - Initialise le projet après téléchargement"
    echo "  start         - Démarre tous les conteneurs"
    echo "  stop          - Arrête tous les conteneurs"
    echo "  restart       - Redémarre tous les conteneurs"
    echo "  logs          - Affiche les logs de tous les conteneurs"
    echo "  logs:backend  - Affiche les logs du backend"
    echo "  logs:frontend - Affiche les logs du frontend"
    echo "  logs:db       - Affiche les logs de la base de données"
    echo "  logs:nginx    - Affiche les logs du nginx"
    echo "  backend       - Accès au shell du conteneur PHP"
    echo "  frontend      - Accès au shell du conteneur Frontend"
    echo "  db           - Accès au shell PostgreSQL"
    echo "  credits       - Affiche les crédits"
    echo "  help         - Affiche cette aide"
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
    "restart")
        restart
        ;;
    "logs")
        logs
        ;;
    "logs:backend")
        logs_backend
        ;;
    "logs:frontend")
        logs_frontend
        ;;
    "logs:db")
        logs_db
        ;;
    "logs:nginx")
        logs_nginx
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