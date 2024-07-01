#!/bin/bash

# Get project name from argument
PROJECT_NAME=$1

# Create project directory
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME
mkdir -p docker
mkdir -p docker/certs
mkdir -p src

# Create README
cat << EOF > README.md
# $PROJECT_NAME
EOF

cd docker

# Create Dockerfile
cat << EOF > Dockerfile
FROM php:8.2-apache

# Install MySQL PDO extension
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache SSL and rewrite module
RUN a2enmod ssl
RUN a2enmod rewrite

# Copy custom php.ini
COPY php.ini /usr/local/etc/php/php.ini

# Copy SSL certificates
# COPY certs/server.crt /etc/apache2/ssl/server.crt
# COPY certs/server.key /etc/apache2/ssl/server.key

# Copy Apache SSL configuration
# COPY apache-ssl.conf /etc/apache2/sites-available/default-ssl.conf
# RUN a2ensite default-ssl.conf
EOF

# Create docker-compose.yml
cat << EOF > docker-compose.yml
version: '3.8'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: api
    volumes:
      - ../src:/var/www/html
      - ./php.ini:/usr/local/etc/php/php.ini
      - ./apache.conf:/etc/apache2/sites-available/000-default.conf
    ports:
      - "8080:80"
      - "8443:443"
    depends_on:
      - db
    environment:
      - TZ=Asia/Tokyo

  db:
    image: mysql:8.0
    container_name: my_db
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_DATABASE: \${DB_DATABASE:-${PROJECT_NAME}_db}
      MYSQL_USER: \${DB_USER:-root}
      MYSQL_PASSWORD: \${DB_PASS:-root}
      MYSQL_ROOT_PASSWORD: \${DB_ROOT_PASS:-root}
    ports:
      - "3306:3306"

volumes:
  db_data:
EOF

# Create php.ini
cat << EOF > php.ini
upload_max_filesize=40M
post_max_size=40M
max_execution_time=300
EOF

# Create .env
cat << EOF > .env
DB_PORT=3306
DB_DATABASE=${PROJECT_NAME}
DB_USER=developer
DB_PASS=password
DB_ROOT_PASS=root_password

TEST_DB_PORT=3307
TEST_DB_DATABASE=${PROJECT_NAME}-test
EOF

# Create apache.conf
cat << EOF > apache.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Create makefile
cat << EOF > Makefile
up:
	docker-compose up -d
down:
	docker-compose stop
restart:
	docker-compose restart
build:
	docker-compose build --no-cache --force-rm
web:
	docker-compose exec web bash
db:
	docker-compose exec db bash
log-web:
	docker-compose logs -f web
log-db:
	docker-compose logs -f db
EOF

# .gitignoreを作成
cat << EOF > .gitignore
/vendor
.env
EOF

echo "Docker environment $PROJECT_NAME created at this directory."

