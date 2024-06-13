FROM mysql:5.7

# Add database initialization script
COPY init.sql /docker-entrypoint-initdb.d/
