CREATE DATABASE IF NOT EXISTS laravel;
CREATE USER 'paulkusuma'@'%' IDENTIFIED BY 'pauwerfull';
GRANT ALL PRIVILEGES ON laravel.* TO 'paulkusuma'@'%';
FLUSH PRIVILEGES;
