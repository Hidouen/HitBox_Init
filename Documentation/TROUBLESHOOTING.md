# 🔧 HitBox Troubleshooting Guide

## 🚨 Common Issues and Solutions

### Docker Related Issues

#### Containers Won't Start
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

#### Permission Issues
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

### Backend Issues

#### PHP-FPM Connection Refused
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

#### Symfony Cache Issues
**Solution:**
```bash
./dev.sh backend
php bin/console cache:clear
php bin/console cache:warmup
```

### Frontend Issues

#### Node Modules Issues
```bash
Error: Cannot find module
```
**Solution:**
```bash
./dev.sh frontend
rm -rf node_modules
pnpm install
```

#### Build Errors
**Solution:**
1. Clear cache:
   ```bash
   ./dev.sh frontend
   rm -rf .nuxt
   pnpm dev
   ```

### Database Issues

#### Connection Failed
```bash
Error: Connection refused
```
**Solution:**
1. Check PostgreSQL logs:
   ```bash
   docker compose logs hitbox_postgres
   ```
2. Verify environment variables:
   ```bash
   cat .env | grep POSTGRES
   ```

#### Migration Errors
**Solution:**
```bash
./dev.sh backend
php bin/console doctrine:schema:validate
php bin/console doctrine:migrations:sync-metadata-storage
php bin/console doctrine:migrations:migrate
```

## 🔍 Diagnostic Commands

### System Status
```bash
# Check all containers
docker compose ps

# Check logs
docker compose logs

# Check network
docker network ls
```

### Resource Usage
```bash
# Container stats
docker stats

# Disk usage
docker system df
```

### Database Checks
```bash
# Connect to database
./dev.sh db

# Check tables
\dt

# Check connections
SELECT * FROM pg_stat_activity;
```

## 🚑 Emergency Procedures

### Complete Reset
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

### Data Recovery
```bash
# Backup database
docker compose exec -T hitbox_postgres pg_dump -U hitbox > backup.sql

# Restore database
cat backup.sql | docker compose exec -T hitbox_postgres psql -U hitbox
```

## 📞 Support Channels

1. **Development Team**
   - Internal Discord: #hitbox-support
   - Email: dev@hitbox.com

2. **External Resources**
   - Symfony Documentation
   - Vue.js Discord
   - Docker Forums

## 🔄 Update Procedures

### Safe Update Process
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
pnpm update
pnpm build
```

## Docker Cleanup Commands

### Docker Prune Commands
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

### Specific Docker Commands
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

### Docker Compose Commands
```bash
# Stop and remove containers, networks
docker compose down

# Same as above but also remove volumes
docker compose down -v

# Remove orphaned containers
docker compose down --remove-orphans
```

## Git Cleanup Commands

### Git Prune Commands
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

### Git Cache Commands
```bash
# Clear git cache
git rm -r --cached .
git add .
git commit -m "chore: clear git cache"
```

## Common Issues

### Docker Issues
1. **Container won't start**
   ```bash
   # Check logs
   docker logs [container_name]
   
   # Verify ports
   docker compose ps
   ```

2. **Volume permissions**
   ```bash
   # Fix permissions
   sudo chown -R $USER:$USER .
   ```

### Git Issues
1. **Large files rejected**
   ```bash
   # Reset last commit
   git reset --soft HEAD~1
   
   # Clean git cache
   git rm -r --cached .
   ```

2. **Branch conflicts**
   ```bash
   # Abort merge
   git merge --abort
   
   # Reset to origin
   git reset --hard origin/[branch_name]
   ```
