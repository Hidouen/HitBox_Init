# Utilisation d'une image Node.js légère
FROM node:23-alpine

# Définition du répertoire de travail
WORKDIR /app

# Copier le script d'entrée
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exposer le port 3000 pour le serveur de développement
EXPOSE 3000

# Définir le point d'entrée
ENTRYPOINT ["docker-entrypoint.sh"]
