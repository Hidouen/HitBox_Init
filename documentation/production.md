# 🚀 Production guide

## 🛠️ Recommended tools and configurations

### 1. Infrastructure

#### Cloud provider
- **Primary**: OVH
  - OVHcloud for application servers
  - Pigsty for PostgreSQL
  - Cloudflare for CDN and DNS
  - EV for SSL certificates

#### Server configuration
- Ubuntu 24.04 LTS
- 4 vCPUs minimum
- 8GB RAM minimum
- 100GB SSD storage
- Dedicated load balancer

### 2. Monitoring stack

#### Application monitoring
- **New Relic**
  - Application performance monitoring
  - Error tracking
  - Custom dashboards
  - Alerting system

#### Log management
- **ELK Stack**
  ```yaml
  # Logstash configuration
  input {
    filebeat {
      port => 5044
    }
  }
  filter {
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }
  }
  output {
    elasticsearch {
      hosts => ["elasticsearch:9200"]
    }
  }
  ```

#### Metrics
- **Prometheus + Grafana**
  - System metrics
  - Business metrics
  - Custom alerts
  - Visual dashboards

### 3. Security measures

#### SSL/TLS
- Let's Encrypt with auto-renewal
- HSTS enabled
- TLS 1.3 only
- Strong cipher suites

```nginx
ssl_protocols TLSv1.3;
ssl_prefer_server_ciphers off;
ssl_session_timeout 1d;
ssl_session_cache shared:SSL:50m;
ssl_session_tickets off;
```

#### Firewall
- **UFW Configuration**
  ```bash
  ufw default deny incoming
  ufw default allow outgoing
  ufw allow ssh
  ufw allow http
  ufw allow https
  ufw enable
  ```

#### Security headers
```nginx
add_header X-Frame-Options "SAMEORIGIN";
add_header X-XSS-Protection "1; mode=block";
add_header X-Content-Type-Options "nosniff";
add_header Referrer-Policy "strict-origin-when-cross-origin";
add_header Content-Security-Policy "default-src 'self';";
```

### 4. Performance optimization

#### Caching strategy
- **Redis Cache**
  ```yaml
  redis:
    host: redis
    port: 6379
    database: 0
    prefix: hitbox:
    ttl: 3600
  ```

#### CDN configuration
```nginx
# CloudFront configuration
location /assets/ {
    proxy_cache_use_stale error timeout http_500 http_502 http_503 http_504;
    proxy_cache_valid 200 7d;
    proxy_cache_valid 404 1m;
    expires 7d;
}
```

#### Database optimization
```postgresql
# postgresql.conf optimizations
max_connections = 200
shared_buffers = 2GB
effective_cache_size = 6GB
maintenance_work_mem = 512MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 10485kB
min_wal_size = 1GB
max_wal_size = 4GB
```

### 5. Backup strategy

#### Database backups
- Daily full backups
- Hourly WAL archiving
- 30-day retention
- Off-site storage

#### Application backups
- Configuration files
- User uploads
- SSL certificates
- Logs archive

### 6. Deployment pipeline

#### CI/CD configuration (check DinD)
```yaml
# GitLab CI configuration
stages:
  - test
  - build
  - deploy

production:
  stage: deploy
  script:
    - docker compose -f docker-compose.prod.yml build
    - docker compose -f docker-compose.prod.yml up -d
  only:
    - main
```

### 7. Scaling strategy

#### Horizontal scaling
- Auto-scaling groups
- Load balancer configuration
- Session management
- Database replication

#### Vertical scaling
- Resource monitoring
- Performance metrics
- Upgrade paths
- Capacity planning

### 8. Maintenance procedures

#### Regular maintenance
- Security updates
- Performance optimization
- Log rotation
- Database vacuum

#### Emergency procedures
- Incident response plan
- Rollback procedures
- Communication templates
- Emergency contacts

### 9. Documentation

#### Required documentation
- Architecture diagrams
- Network topology
- Security procedures
- Backup/restore procedures
- Deployment guides
- Emergency procedures 