# 🗄️ PostgreSQL Connection Guide

## 📊 Database Connection Information

### Connection Details
```
Host: localhost
Port: 5433
Database: hitbox
Username: [from .env file]
Password: [from .env file]
```

## 🔧 DBeaver Setup

1. **Install DBeaver**
   - Download from [dbeaver.io](https://dbeaver.io)
   - Install for your operating system

2. **Create New Connection**
   - Click "New Database Connection"
   - Select "PostgreSQL"
   - Enter connection details:
     ```
     Server Host: localhost
     Port: 5433
     Database: hitbox
     Username: hitbox
     Password: [from .env]
     ```

3. **SSL Configuration**
   - Tab: "SSL"
   - Mode: "Require"
   - Select SSL certificates if using production environment

4. **Driver Properties**
   - Tab: "Driver properties"
   - Set `allowEncodingChanges` to `true`

5. **Test Connection**
   - Click "Test Connection"
   - Should show "Connected"

## 🔧 pgAdmin Setup

1. **Install pgAdmin**
   - Download from [pgadmin.org](https://www.pgadmin.org)
   - Follow installation instructions

2. **Add New Server**
   - Right-click "Servers"
   - Select "Create" > "Server"
   - General Tab:
     ```
     Name: HitBox Local
     ```
   - Connection Tab:
     ```
     Host: localhost
     Port: 5433
     Database: hitbox
     Username: hitbox
     Password: [from .env]
     ```

3. **SSL Configuration**
   - SSL Tab:
     - SSL Mode: Require (production)
     - Root Certificate: [path to cert]

4. **Advanced Options**
   - Advanced Tab:
     ```
     DB Restriction: hitbox
     ```

## 🔍 Useful Queries

### Check Connection
```sql
SELECT version();
```

### List Tables
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```

### Check Table Sizes
```sql
SELECT 
    relname as table_name,
    pg_size_pretty(pg_total_relation_size(relid)) as total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
```

## 🔒 Security Best Practices

1. **Connection Security**
   - Never save passwords in tool configurations
   - Use environment variables
   - Enable SSL in production

2. **Access Control**
   - Use read-only user for queries
   - Separate users for different environments
   - Regular password rotation

3. **Monitoring**
   - Enable query logging in development
   - Monitor connection count
   - Track long-running queries

## 🚀 Performance Tips

1. **Connection Pooling**
   - Enable connection pooling
   - Set appropriate pool size
   - Monitor pool usage

2. **Query Optimization**
   - Use EXPLAIN ANALYZE
   - Create necessary indexes
   - Regular VACUUM and ANALYZE

3. **Tool Settings**
   - Limit result sets
   - Use query timeout
   - Enable auto-commit

## 🔄 Backup and Restore

### Using DBeaver
1. Right-click database
2. Select "Tools" > "Backup"
3. Choose options:
   - Format: Custom
   - Compression: Yes
   - Encoding: UTF-8

### Using pgAdmin
1. Right-click database
2. Select "Backup..."
3. Configure:
   - Format: Custom
   - Compression Ratio: 9
   - Encoding: UTF-8

### Command Line
```bash
# Backup
./dev.sh db
pg_dump -U hitbox > backup.sql

# Restore
./dev.sh db
psql -U hitbox < backup.sql
```

## 📚 Useful Resources

1. **Documentation**
   - [PostgreSQL Official Docs](https://www.postgresql.org/docs/)
   - [DBeaver Documentation](https://dbeaver.com/docs/wiki/)
   - [pgAdmin Documentation](https://www.pgadmin.org/docs/)

2. **Tools**
   - [pgFormatter](https://github.com/darold/pgFormatter)
   - [pg_activity](https://github.com/dalibo/pg_activity)

3. **Extensions**
   - uuid-ossp
   - pgcrypto
   - pg_stat_statements 