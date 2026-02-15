# VPS Deployment

## Configuration for VPS with Public IP

### 1. Create the .env file
Copy the example file and modify the URL:
```bash
cp .env.example .env
```

Edit `.env` with your VPS public IP:
```bash
WORDPRESS_URL=http://YOUR_PUBLIC_IP:31337
```

Or with a domain:
```bash
WORDPRESS_URL=http://yourdomain.com
```

### 2. Initial deployment
```bash
# Start the containers
docker-compose up -d

# Wait for MySQL to be ready (about 30 seconds)
sleep 30

# Install WordPress
docker-compose run --rm wp-cli install-wp
```

### 3. Update existing URL
If you already have WordPress installed and need to change the URL:

```bash
docker-compose run --rm wp-cli update-site-url OLD_URL NEW_URL
```

Example:
```bash
docker-compose run --rm wp-cli update-site-url http://127.0.0.1:31337 http://YOUR_PUBLIC_IP:31337
```

### 4. Firewall Configuration
Make sure port 31337 is open on your VPS:

**Ubuntu/Debian with UFW:**
```bash
sudo ufw allow 31337/tcp
```

**CentOS/RHEL with firewalld:**
```bash
sudo firewall-cmd --permanent --add-port=31337/tcp
sudo firewall-cmd --reload
```

### 5. Access
- WordPress: `http://YOUR_PUBLIC_IP:31337`
- Admin: `http://YOUR_PUBLIC_IP:31337/wp-admin`
  - Username: `admin`
  - Password: `admin`
- phpMyAdmin: `http://YOUR_PUBLIC_IP:31338`

## Security Notes
⚠️ **IMPORTANT**: This is a test environment with intentional vulnerabilities. DO NOT use in production!

- Change default credentials
- Use HTTPS in production
- Configure a reverse proxy (nginx/Apache) instead of directly exposing the port
