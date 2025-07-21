# 🤖 Panduan untuk Pengembang Android

Panduan ini untuk mengembangkan NiTe untuk Android di lingkungan desktop (Windows/macOS/Linux).

### **Prasyarat**
1.  **Flutter SDK:** Pastikan Anda telah menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install) untuk sistem operasi Anda.
2.  **Android Studio:** Unduh dan instal [Android Studio](https://developer.android.com/studio). Ini adalah IDE yang direkomendasikan dan akan menginstal Android SDK, alat baris perintah, dan driver yang diperlukan.
3.  **Emulator atau Perangkat:** Siapkan Emulator Android melalui Manajer Perangkat Virtual Android (AVD) di Android Studio, atau aktifkan mode pengembang dan debugging USB di perangkat Android fisik Anda.

### **Langkah-langkah**
1.  **Verifikasi Penyiapan:** Buka terminal atau command prompt dan jalankan `flutter doctor`. Pastikan tidak ada masalah kritis di bawah kategori "Android toolchain" dan "Android Studio".
2.  **Kloning & Persiapan:**
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

3.  **Menjalankan Aplikasi:**
    *   Pastikan emulator Anda berjalan atau perangkat Anda terhubung.
    *   Jalankan aplikasi:
        ```bash
        flutter run
        ```
    *   Flutter akan secara otomatis mendeteksi perangkat yang tersedia dan menginstal aplikasi.

### **Pemecahan Masalah Umum Android**
*   **Masalah Lisensi SDK:** Jika `flutter doctor` mengeluh tentang lisensi Android, jalankan perintah berikut dan terima semua perjanjian:
    ```bash
    flutter doctor --android-licenses
    ```
*   **Perangkat Tidak Terdeteksi:** Pastikan debugging USB diaktifkan dan Anda telah mengizinkan koneksi di ponsel Anda. Jika masih tidak berfungsi, Anda mungkin perlu menginstal driver USB OEM untuk perangkat Anda.
