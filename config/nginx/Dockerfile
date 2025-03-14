FROM nginx:alpine

# Installation des outils de base
RUN apk add --no-cache \
    curl \
    vim

# Suppression de la configuration par défaut
RUN rm /etc/nginx/conf.d/default.conf

# Copie de notre configuration
COPY default.conf /etc/nginx/conf.d/

# Création des répertoires pour les logs
RUN mkdir -p /var/log/nginx

# Configuration des permissions
RUN chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /var/log/nginx

# Exposition des ports
EXPOSE 80 443

# Commande de démarrage
CMD ["nginx", "-g", "daemon off;"] 