# 🗄️ PostgreSQL connection guide

## 📊 Database connection information

### Connection details
```
Host: localhost
Port: 5433
Database: hitbox
Username: [from .env file]
Password: [from .env file]
```

## 🔧 DBeaver setup

1. **Install DBeaver**
   - Download from [dbeaver.io](https://dbeaver.io)
   - Install for your operating system

2. **Create new connection**
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

3. **SSL configuration**
   - Tab: "SSL"
   - Mode: "Require"
   - Select SSL certificates if using production environment

4. **Driver properties**
   - Tab: "Driver properties"
   - Set `allowEncodingChanges` to `true`

5. **Test connection**
   - Click "Test Connection"
   - Should show "Connected"

## 🔧 pgAdmin setup

1. **Install pgAdmin**
   - Download from [pgadmin.org](https://www.pgadmin.org)
   - Follow installation instructions

2. **Add new server**
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

3. **SSL configuration**
   - SSL Tab:
     - SSL Mode: Require (production)
     - Root Certificate: [path to cert]

4. **Advanced options**
   - Advanced Tab:
     ```
     DB Restriction: hitbox
     ```

## 🔍 Useful queries

### Check connection
```sql
SELECT version();
```

### List tables
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
```

### Check table sizes
```sql
SELECT 
    relname as table_name,
    pg_size_pretty(pg_total_relation_size(relid)) as total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;
```

## 🔒 Security best practices

1. **Connection security**
   - Never save passwords in tool configurations
   - Use environment variables
   - Enable SSL in production

2. **Access control**
   - Use read-only user for queries
   - Separate users for different environments
   - Regular password rotation

3. **Monitoring**
   - Enable query logging in development
   - Monitor connection count
   - Track long-running queries

## 🚀 Performance tips

1. **Connection pooling**
   - Enable connection pooling
   - Set appropriate pool size
   - Monitor pool usage

2. **Query optimization**
   - Use EXPLAIN ANALYZE
   - Create necessary indexes
   - Regular VACUUM and ANALYZE

3. **Tool settings**
   - Limit result sets
   - Use query timeout
   - Enable auto-commit

## 🔄 Backup and restore

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

### Command line
```bash
# Backup
./dev.sh db
pg_dump -U hitbox > backup.sql

# Restore
./dev.sh db
psql -U hitbox < backup.sql
```

## 📚 Useful resources

1. **Documentation**
   - [PostgreSQL official docs](https://www.postgresql.org/docs/)
   - [DBeaver documentation](https://dbeaver.com/docs/wiki/)
   - [pgAdmin documentation](https://www.pgadmin.org/docs/)

2. **Tools**
   - [pgFormatter](https://github.com/darold/pgFormatter)
   - [pg_activity](https://github.com/dalibo/pg_activity)

3. **Extensions**
   - uuid-ossp
   - pgcrypto
   - pg_stat_statements 