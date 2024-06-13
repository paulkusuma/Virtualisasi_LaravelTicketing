-- Membuat database baru bernama 'laravel' jika belum ada
CREATE DATABASE IF NOT EXISTS laravel;

-- Membuat pengguna baru 'paulkusuma' dengan kata sandi 'pauwerfull'
CREATE USER 'paulkusuma'@'%' IDENTIFIED BY 'pauwerfull';

-- Memberikan semua hak istimewa pada semua tabel di database 'laravel' kepada pengguna 'paulkusuma'
GRANT ALL PRIVILEGES ON laravel.* TO 'paulkusuma'@'%';

-- Memperbarui hak istimewa sehingga perubahan berlaku segera
FLUSH PRIVILEGES;
