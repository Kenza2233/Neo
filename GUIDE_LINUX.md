# 🐧 Panduan untuk Pengembang Linux (Desktop & Ponsel via Termux)

Panduan ini mencakup penyiapan lingkungan pengembangan NiTe di desktop Linux dan di ponsel Android melalui Termux. Prosesnya sangat mirip.

### **Tahap 1: Persiapan Lingkungan**

1.  **Instal Prasyarat:**
    *   Buka terminal Anda.
    *   Pastikan Anda memiliki `git` dan `wget`. Jika tidak, instal menggunakan manajer paket Anda (misalnya, `sudo apt-get install git wget` di sistem berbasis Debian/Ubuntu).

2.  **Instal Flutter SDK:**
    *   **Langkah A: Unduh Flutter SDK.** Kunjungi [situs web Flutter SDK](https://flutter.dev/docs/get-started/install/linux) dan salin tautan unduhan untuk "Linux (ARM64)" jika Anda menggunakan Termux atau perangkat berbasis ARM, atau "Linux (x64)" untuk sebagian besar desktop. Gunakan `wget` untuk mengunduh file tersebut. Contoh untuk x64:
        ```bash
        wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.0-stable.tar.xz
        ```
    *   **Langkah B: Ekstrak File.** Setelah unduhan selesai, ekstrak file tersebut:
        ```bash
        tar xf flutter_linux_3.13.0-stable.tar.xz
        ```
        Ini akan membuat folder `flutter` di direktori Anda saat ini.
    *   **Langkah C: Konfigurasi PATH.** Agar Anda dapat menjalankan perintah `flutter` dari mana saja, Anda perlu menambahkan direktori `bin` Flutter ke `PATH` Anda. Jalankan perintah berikut:
        ```bash
        echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
        ```
        (Ganti `~/.bashrc` dengan `~/.zshrc` jika Anda menggunakan Zsh).
    *   **Langkah D: Terapkan Perubahan.** Muat ulang konfigurasi shell Anda:
        ```bash
        source ~/.bashrc
        ```
    *   **Langkah E: Verifikasi Instalasi.** Sekarang, tutup dan buka kembali terminal, lalu jalankan:
        ```bash
        flutter doctor
        ```
    *   Ikuti instruksi apa pun dari `flutter doctor` untuk menginstal dependensi yang hilang (misalnya, `clang`, `cmake`, `ninja-build`).

### **Tahap 2: Memulai Proyek NiTe**

1.  **Kloning & Persiapan:**
    *   Kloning repositori:
        ```bash
        git clone https://github.com/pengguna/nite.git
        ```
    *   Arahkan ke direktori proyek:
        ```bash
        cd nite
        ```
    *   Ambil semua dependensi Flutter:
        ```bash
        flutter pub get
        ```

### **Tahap 3: Edit, Bangun, dan Jalankan**

1.  **Edit Kode:** Gunakan editor kode favorit Anda (seperti VS Code, Sublime Text, atau Acode di ponsel) untuk mengedit file proyek.
2.  **Jalankan Aplikasi:**
    *   Di terminal, pastikan Anda berada di direktori `nite`.
    *   Jalankan perintah berikut untuk membangun dan menjalankan aplikasi:
        ```bash
        flutter run
        ```
    *   Di desktop, ini akan meluncurkan aplikasi dalam mode debug. Di Termux, ini akan membangun dan menginstal APK di ponsel Anda.
