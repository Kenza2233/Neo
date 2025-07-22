# 🤖 Panduan Lengkap untuk Pengembang Android

Selamat datang, pengembang Android! Panduan ini akan memandu Anda melalui setiap langkah untuk menjalankan NiTe di lingkungan desktop (Windows/macOS/Linux) untuk pengembangan Android.

### **Tahap 1: Menyiapkan Lingkungan Android Studio**

Lingkungan pengembangan Android yang solid adalah kunci keberhasilan.

1.  **Instal Flutter SDK:**
    *   Jika Anda belum melakukannya, ikuti panduan resmi untuk menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install) untuk sistem operasi spesifik Anda (Windows, macOS, atau Linux).
    *   Pastikan direktori `bin` Flutter ada di `PATH` sistem Anda.

2.  **Instal Android Studio:**
    *   Unduh dan instal versi terbaru [Android Studio](https://developer.android.com/studio).
    *   Saat pertama kali menjalankan Android Studio, ikuti wizard penyiapan. Pastikan komponen berikut terinstal:
        *   Android SDK
        *   Android SDK Command-line Tools
        *   Android SDK Build-Tools

3.  **Konfigurasi Emulator (Opsional):**
    *   Di Android Studio, buka **Tools > AVD Manager**.
    *   Klik **"Create Virtual Device..."**, pilih model perangkat (misalnya, Pixel 6), dan pilih gambar sistem (disarankan versi terbaru).
    *   Selesaikan proses pembuatan. Anda sekarang dapat meluncurkan emulator ini kapan saja dari AVD Manager.

4.  **Konfigurasi Perangkat Fisik (Opsional):**
    *   Di perangkat Android Anda, buka **Pengaturan > Tentang Ponsel** dan ketuk **"Nomor build"** tujuh kali untuk mengaktifkan Opsi Pengembang.
    *   Kembali ke Pengaturan, buka **Sistem > Opsi Pengembang** dan aktifkan **"Debugging USB"**.
    *   Hubungkan perangkat Anda ke komputer. Anda mungkin melihat prompt di ponsel untuk "Izinkan debugging USB". Setujui.

5.  **Pemeriksaan Akhir dengan `flutter doctor`:**
    *   Buka terminal atau command prompt dan jalankan `flutter doctor`.
    *   Anda harus melihat tanda centang hijau untuk "Android toolchain" dan "Android Studio".
    *   Jika `flutter doctor` mengeluh tentang lisensi Android, jalankan perintah yang disarankan dan terima semua perjanjian:
        ```bash
        flutter doctor --android-licenses
        ```

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
    *   Pastikan emulator Anda berjalan atau perangkat fisik Anda terhubung dan dikenali. Anda dapat memeriksa dengan:
        ```bash
        flutter devices
        ```
        Anda akan melihat perangkat Anda terdaftar.
    *   Jalankan aplikasi:
        ```bash
        flutter run
        ```
    *   Flutter akan secara otomatis membangun, menginstal, dan meluncurkan aplikasi di perangkat yang dipilih. Nikmati *hot reload*!

### **Pemecahan Masalah Umum Android**
*   **"Could not find `aapt2`" atau Error Gradle Lainnya:** Ini biasanya berarti ada masalah dengan instalasi Android SDK atau Gradle. Coba buka proyek Android di Android Studio (`File > Open...` dan pilih folder `android` di dalam proyek NiTe). Android Studio sering kali dapat secara otomatis memperbaiki masalah dependensi atau versi Gradle. Setelah selesai, coba `flutter run` lagi.
*   **`INSTALL_FAILED_INSUFFICIENT_STORAGE`:** Perangkat atau emulator Anda kehabisan ruang. Hapus beberapa aplikasi atau data untuk memberi ruang.
*   **Aplikasi Langsung Crash (Terutama pada Build Rilis):** Ini bisa disebabkan oleh *multidexing* atau *code shrinking* (ProGuard/R8). Pastikan file `android/app/build.gradle` Anda dikonfigurasi dengan benar. Untuk `multidex`, pastikan `multiDexEnabled true` ada di blok `defaultConfig`.
*   **Perangkat Tidak Terdeteksi di Windows:** Anda mungkin perlu menginstal driver USB OEM dari produsen perangkat Anda. Cari "driver USB [nama produsen]" secara online.
