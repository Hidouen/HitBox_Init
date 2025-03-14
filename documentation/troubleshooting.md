# 🔧 HitBox troubleshooting guide

## 🚨 Common issues and solutions

### Docker related issues

#### Containers won't start
```bash
Error: Ports are already in use
```
**Solution:**
1. Check for running containers:
   ```bash
   docker ps
   ```
2. Stop conflicting services:
   ```bash
   sudo lsof -i :3000,9000,8443,8080,5433
   sudo kill <PID>
   ```

#### Permission issues
```bash
Error: Permission denied
```
**Solution:**
1. Check file ownership:
   ```bash
   sudo chown -R $USER:$USER .
   ```
2. Fix script permissions:
   ```bash
   chmod +x dev.sh
   ```

### Backend issues

#### PHP-FPM connection refused
```bash
ERROR: connect() to hitbox_backend:9000 failed
```
**Solution:**
1. Check PHP-FPM status:
   ```bash
   docker compose logs hitbox_backend
   ```
2. Restart PHP-FPM:
   ```bash
   docker compose restart hitbox_backend
   ```

#### Symfony cache issues
**Solution:**
```bash
./dev.sh backend
php bin/console cache:clear
php bin/console cache:warmup
```

### Frontend issues

#### Node modules issues
```bash
Error: Cannot find module
```
**Solution:**
```bash
./dev.sh frontend
rm -rf node_modules
npm install
```

#### Build errors
**Solution:**
1. Clear cache:
   ```bash
   ./dev.sh frontend
   rm -rf .nuxt
   npm dev
   ```

### Database issues

#### Connection failed
```bash
Error: Connection refused
```
**Solution:**
1. Check PostgreSQL logs:
   ```bash
   docker compose logs hitbox_db
   ```
2. Verify environment variables:
   ```bash
   cat .env | grep POSTGRES
   ```

#### Migration errors
**Solution:**
```bash
./dev.sh backend
php bin/console doctrine:schema:validate
php bin/console doctrine:migrations:sync-metadata-storage
php bin/console doctrine:migrations:migrate
```

## 🔍 Diagnostic commands

### System status
```bash
# Check all containers
docker compose ps

# Check logs
docker compose logs

# Check network
docker network ls
```

### Resource usage
```bash
# Container stats
docker stats

# Disk usage
docker system df
```

### Database checks
```bash
# Connect to database
./dev.sh db

# Check tables
\dt

# Check connections
SELECT * FROM pg_stat_activity;
```

## 🚑 Emergency procedures

### Complete reset
```bash
# Stop all containers
./dev.sh stop

# Remove containers
docker compose down -v

# Clean Docker system
docker system prune -a

# Rebuild
./dev.sh init
./dev.sh start
```

### Data recovery
```bash
# Backup database
docker compose exec -T hitbox_db pg_dump -U hitbox > backup.sql

# Restore database
cat backup.sql | docker compose exec -T hitbox_db psql -U hitbox
```

## 🔄 Update procedures

### Safe update process
1. Backup data
2. Pull latest changes
3. Update dependencies
4. Run migrations
5. Clear caches
6. Run tests

```bash
# Backend update
./dev.sh backend
composer update
php bin/console doctrine:migrations:migrate
php bin/console cache:clear

# Frontend update
./dev.sh frontend
npm update
npm build
```

## Docker cleanup commands

### Docker prune commands
```bash
# Remove all unused containers, networks, images and volumes
docker system prune -a --volumes

# Remove only dangling images (untagged images)
docker image prune

# Remove unused containers
docker container prune

# Remove all unused networks
docker network prune

# Remove all unused volumes
docker volume prune

# Remove everything unused older than 24h
docker system prune -a --volumes --filter "until=24h"
```

### Specific docker commands
```bash
# List all containers (running and stopped)
docker ps -a

# Stop all running containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm $(docker ps -aq)

# Remove all images
docker rmi $(docker images -q)
```

### Docker compose commands
```bash
# Stop and remove containers, networks
docker compose down

# Same as above but also remove volumes
docker compose down -v

# Remove orphaned containers
docker compose down --remove-orphans
```

## Git cleanup commands

### Git prune commands
```bash
# Prune remote-tracking branches no longer on remote
git remote prune origin

# Prune unreachable objects
git gc --prune=now

# Prune local branches that have been merged
git branch --merged | grep -v "main\|dev" | xargs git branch -d

# Clean untracked files and directories
git clean -fd
```

### Git cache commands
```bash
# Clear git cache
git rm -r --cached .
git add .
git commit -m "chore: clear git cache"
```