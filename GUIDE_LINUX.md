# 🐧 Panduan Lengkap untuk Pengembang Linux

Selamat datang, pengembang Linux! Panduan ini akan memandu Anda melalui setiap langkah untuk menjalankan NiTe di lingkungan desktop Linux. Panduan ini juga berlaku untuk pengembangan di ponsel melalui [Termux](https://termux.com/), karena proses dasarnya sama.

### **Tahap 1: Menyiapkan Lingkungan Linux Anda**

Flutter terasa seperti di rumah sendiri di Linux. Mari kita siapkan.

1.  **Instal Prasyarat Flutter:**
    *   Flutter memerlukan beberapa alat baris perintah standar. Buka terminal Anda dan instal menggunakan manajer paket distro Anda.
    *   Untuk **Debian/Ubuntu**:
        ```bash
        sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
        ```
    *   Untuk **Fedora/RHEL/CentOS**:
        ```bash
        sudo dnf install clang cmake ninja-build pkg-config gtk3-devel
        ```
    *   Pastikan Anda juga memiliki `git` dan `wget`.

2.  **Instal Flutter SDK:**
    *   Cara termudah adalah mengunduh file tarball langsung dari [situs Flutter](https://flutter.dev/docs/get-started/install/linux).
    *   Pilih lokasi untuk menyimpan SDK (misalnya, `~/development`):
        ```bash
        cd ~/development
        wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.0-stable.tar.xz
        tar xf flutter_linux_3.13.0-stable.tar.xz
        ```
    *   Tambahkan Flutter ke `PATH` Anda secara permanen. Edit file konfigurasi shell Anda (`~/.bashrc` atau `~/.zshrc`):
        ```bash
        echo 'export PATH="$PATH":"$HOME/development/flutter/bin"' >> ~/.bashrc
        ```
    *   Muat ulang shell Anda: `source ~/.bashrc`.

3.  **Pemeriksaan Akhir dengan `flutter doctor`:**
    *   Jalankan `flutter doctor`. Perhatikan baik-baik outputnya.
    *   Anda harus melihat tanda centang hijau untuk "Flutter" dan "Linux toolchain".
    *   Jika Anda ingin mengembangkan untuk Android juga, ikuti panduan Android untuk menginstal Android Studio.

### **Tahap 2: Menjalankan NiTe**

1.  **Kloning & Persiapan Proyek:**
    *   Di Terminal, arahkan ke direktori kerja Anda, lalu kloning:
        ```bash
        git clone https://github.com/pengguna/nite.git
        cd nite
        ```
    *   Ambil semua dependensi Flutter:
        ```bash
        flutter pub get
        ```

2.  **Menjalankan Aplikasi:**
    *   Pastikan `flutter doctor` tidak menunjukkan masalah kritis.
    *   Aktifkan pengembangan desktop Linux:
        ```bash
        flutter config --enable-linux-desktop
        ```
    *   Jalankan aplikasi:
        ```bash
        flutter run -d linux
        ```
    *   Ini akan membangun dan meluncurkan aplikasi NiTe sebagai aplikasi desktop Linux asli.

### **Pemecahan Masalah Umum Linux**
*   **"GTK 3.0 development headers are required"**: Ini berarti Anda melewatkan `libgtk-3-dev` (atau `gtk3-devel`) selama instalasi prasyarat. Instal menggunakan manajer paket Anda.
*   **`snap` vs. `apt`/`dnf`:** Jika Anda menginstal Flutter menggunakan `snap`, `PATH`-nya mungkin dikelola secara berbeda. Pastikan `which flutter` menunjuk ke instalasi yang benar. Umumnya, mengelola instalasi Anda secara manual (seperti yang dijelaskan di atas) memberikan lebih banyak kontrol.
*   **Izin Direktori:** Pastikan Anda memiliki izin baca/tulis di direktori tempat Anda mengkloning dan mencoba membangun proyek. Hindari bekerja di direktori yang dimiliki oleh `root`.
