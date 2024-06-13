# Menggunakan image dasar MySQL versi 5.7
FROM mysql:5.7

# Menyalin skrip inisialisasi database ke dalam direktori yang akan dieksekusi saat container pertama kali dijalankan
COPY init.sql /docker-entrypoint-initdb.d/
