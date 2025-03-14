#!/bin/sh

# Vérifier si le projet est déjà initialisé
if [ ! -f "package.json" ]; then
    echo "Initialisation du projet Vue..."
    
    # Créer un nouveau projet Vue
    pnpm create vue@latest . --hitbox --typescript --router --pinia --vitest --eslint --prettier
    
    # Installer les dépendances
    pnpm install
    
    # Créer un fichier .env pour le frontend
    cat > .env << EOL
    VITE_API_URL=http://hitbox_backend:9000/api
    VITE_APP_ENV=development
    VITE_APP_DEBUG=true
    VITE_APP_NAME=HitBox
    EOL
    
    # Créer un fichier .env.development
    cat > .env.development << EOL
    VITE_API_URL=http://hitbox_backend:9000/api
    VITE_APP_ENV=development
    VITE_APP_DEBUG=true
    VITE_APP_NAME=HitBox
    EOL
    
    echo "Projet Vue initialisé avec succès !"
    echo "Pour démarrer le serveur de développement, exécutez : pnpm dev"
    echo "Pour installer des dépendances supplémentaires, exécutez : pnpm add <package>"
    
    # Garder le conteneur en vie
    tail -f /dev/null
else
    # Si le projet est déjà initialisé, démarrer le serveur de développement
    echo "Démarrage du serveur de développement..."
    exec pnpm dev
fi 