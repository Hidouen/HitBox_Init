# Utilisation d'une image Node.js légère
FROM node:23-alpine

# Ajout d'un utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Activation de pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Définition du répertoire de travail
WORKDIR /app

# S'assurer que les fichiers de configuration existent pour éviter des erreurs
RUN mkdir -p /app && chown -R appuser:appgroup /app

# Changement d'utilisateur (évite d'exécuter le conteneur en root)
USER appuser

# Exposition du port de développement
EXPOSE 3000

# Script d'entrée pour gérer l'initialisation
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Utilisation du script d'entrée
ENTRYPOINT ["docker-entrypoint.sh"]
