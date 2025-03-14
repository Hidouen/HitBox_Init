# 🎮 Guide de Prise en Main HitBox

## 🎯 Objectifs du Projet

HitBox est une application web moderne conçue pour gérer des collections de jeux. Ce document explique les choix techniques et architecturaux du projet.

## 🏗️ Architecture Technique

### Backend (Symfony 7.2)
- **Choix de PHP 8.4** :
  - Performance optimale
  - Typage strict
  - Attributs et énumérations
  - Nouvelles fonctionnalités PHP

- **Symfony 7.2** :
  - Framework mature et stable
  - Excellent support LTS
  - Composants découplés
  - API Platform intégré

### Frontend (Vue.js 3)
- **Choix de Vue 3** :
  - Composition API pour une meilleure réutilisation
  - TypeScript natif
  - Performance optimisée
  - Excellente documentation

- **PNPM** :
  - Plus rapide que npm
  - Meilleure gestion du cache
  - Économie d'espace disque

### Base de Données (PostgreSQL 17.4)
- **Choix de PostgreSQL** :
  - Support natif des UUID
  - Performances JSONB
  - Triggers et procédures stockées
  - Excellent support des transactions

### Nginx
- **Configuration Multi-environnements** :
  - **Développement** :
    - SSL auto-signé pour simuler HTTPS
    - Configuration de CORS permissive
    - Logs détaillés pour le débogage
    - Compression gzip désactivée pour faciliter le débogage
    - Cache désactivé pour le développement en temps réel

  - **Test** :
    - Configuration minimale pour les tests
    - SSL Let's Encrypt staging
    - Logs d'erreurs uniquement
    - Cache basique activé
    - Compression gzip activée

  - **Production** :
    - SSL Let's Encrypt production
    - Configuration CORS stricte
    - Headers de sécurité (HSTS, CSP, etc.)
    - Cache agressif pour les assets statiques
    - Compression gzip optimisée
    - Rate limiting pour la protection DDoS

- **Rôles Principaux** :
  1. **Reverse Proxy** :
     - Routage des requêtes vers le backend (PHP-FPM) ou le frontend (Node.js)
     - Load balancing en production
     - Gestion des timeouts et des retry
     - Protection contre les attaques courantes

  2. **Sécurité** :
     - Terminaison SSL/TLS
     - Protection contre les injections
     - Filtrage des requêtes malveillantes
     - Headers de sécurité automatiques
     - Limitation des méthodes HTTP autorisées

  3. **Performance** :
     - Mise en cache des réponses
     - Compression des assets
     - Optimisation des connexions keepalive
     - Buffering des requêtes/réponses
     - Gestion efficace des fichiers statiques

  4. **Monitoring** :
     - Logs d'accès détaillés
     - Métriques de performance
     - Alertes en cas d'erreurs
     - Statistiques de trafic
     - Surveillance des ressources

- **Configuration Spécifique HitBox** :
  ```nginx
  # Frontend (Vue.js)
  location / {
      proxy_pass http://hitbox_frontend:3000;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection 'upgrade';
      proxy_cache_bypass $http_upgrade;
  }

  # Backend API (Symfony)
  location /api {
      proxy_pass http://hitbox_backend:9000;
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      fastcgi_pass hitbox_backend:9000;
      fastcgi_index index.php;
      include fastcgi_params;
  }

  # Assets Statiques
  location /assets {
      expires 7d;
      add_header Cache-Control "public, no-transform";
      try_files $uri $uri/ =404;
  }
  ```

- **Optimisations Spécifiques** :
  1. **API Gateway** :
     - Routage intelligent des requêtes
     - Gestion des versions d'API
     - Documentation OpenAPI accessible
     - Monitoring des endpoints

  2. **WebSocket** :
     - Support des connexions WebSocket
     - Gestion des timeouts spécifiques
     - Upgrade des connexions HTTP
     - Load balancing des connexions persistantes

  3. **Microservices** :
     - Découverte de services
     - Health checks
     - Circuit breaker
     - Retry policies

  4. **Caching** :
     - Stratégies par type de contenu
     - Invalidation sélective
     - Cache-Control personnalisé
     - Gestion du stale-while-revalidate

## 🔧 Choix Techniques Détaillés

### 1. Structure des Conteneurs

```yaml
services:
  nginx:
    # Reverse proxy et SSL
  
  backend:
    # PHP-FPM pour Symfony
  
  frontend:
    # Node.js pour Vue
  
  postgres:
    # Base de données
```

Pourquoi cette structure ?
- Isolation complète des services
- Scalabilité horizontale possible
- Maintenance facilitée
- Déploiement simplifié

### 2. Gestion des Ports

Développement :
- 3000 : Frontend (Vue.js)
- 9000 : Backend (PHP-FPM)
- 8443/8080 : Nginx
- 5433 : PostgreSQL

Choix des ports :
- Évite les conflits standards
- Facilite le débogage
- Compatible avec les outils de développement

### 3. Script Utilitaire (dev.sh)

Fonctionnalités :
- Installation automatisée
- Gestion des conteneurs
- Accès aux shells

Avantages :
- Uniformisation des commandes
- Réduction des erreurs
- Documentation intégrée

### 4. Sécurité

Mesures implémentées :
- Variables d'environnement sécurisées
- SSL en développement
- CORS configuré
- Rate limiting

## 📚 Conventions et Standards

### 1. Code

Backend (PHP) :
```php
declare(strict_types=1);

namespace App\Controller;

final class GameController
{
    public function __construct(
        private readonly GameService $gameService
    ) {}
}
```

Frontend (Vue) :
```typescript
<script setup lang="ts">
import { ref } from 'vue'
import type { Game } from '@/types'
</script>
```

### 2. Base de Données

Conventions :
- Tables en snake_case
- Clés primaires en UUID
- Timestamps automatiques
- Contraintes explicites

### 3. Git

Structure des commits :
```
type(scope): description

Corps du commit
```

Branches :
- main : production
- develop : développement
- feature/* : fonctionnalités
- bugfix/* : corrections

## 🔄 Workflow de Développement

1. **Installation** :
   ```bash
   git clone [repo]
   ./dev.sh init
   ./dev.sh start
   ```

2. **Développement** :
   - Création de branche
   - Développement local
   - Tests unitaires
   - Pull Request

3. **Review** :
   - Code review
   - Tests automatisés
   - Validation fonctionnelle

4. **Déploiement** :
   - Merge sur develop
   - Tests d'intégration
   - Déploiement production

## 📈 Évolutions Futures

1. **Techniques** :
   - Monitoring ELK
   - Cache Redis
   - Tests E2E
   - CI/CD GitLab

2. **Fonctionnelles** :
   - API mobile
   - SSO
   - Export données
   - Mode hors-ligne
