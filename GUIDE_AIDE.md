# 🅰️ Rekreasi di AIDE (Panduan Konseptual)

[AIDE (Android IDE)](https://www.android-ide.com/) adalah lingkungan pengembangan terintegrasi yang berjalan di Android itu sendiri, memungkinkan Anda membuat aplikasi Android asli menggunakan Java dan/atau C++. Anda tidak dapat menjalankan proyek Flutter seperti NiTe secara langsung, tetapi Anda dapat membangun aplikasi serupa dari awal. Panduan ini menjelaskan konsep-konsepnya.

### **1. Struktur Proyek di AIDE**
*   **Buat Proyek Baru:** Mulailah dengan membuat proyek "Aplikasi Android" baru di AIDE.
*   **Aktivitas Utama (`MainActivity.java`):** Ini akan menjadi layar daftar catatan Anda. Gunakan `ListView` atau `RecyclerView` untuk menampilkan catatan. Anda perlu membuat tata letak XML kustom (`list_item.xml`) untuk setiap item catatan.
*   **Aktivitas Editor (`EditorActivity.java`):** Buat aktivitas kedua untuk editor catatan. Ini akan berisi `EditText` untuk input teks.
*   **Kelas Model (`Note.java`):** Buat kelas Java `Note` untuk menampung data setiap catatan (ID, konten, path wallpaper, dll.).

### **2. Logika Inti (Java)**
*   **Penyimpanan Data:**
    *   **SharedPreferences:** Untuk pengaturan sederhana seperti tema atau batas kata.
    *   **Database SQLite:** Untuk menyimpan data catatan, gunakan kelas `SQLiteOpenHelper` bawaan Android. Ini adalah pendekatan yang lebih kuat daripada SharedPreferences untuk data terstruktur. Buat tabel untuk catatan Anda dan gunakan kursor untuk membaca dan menulis data.
*   **Adaptor ListView:** Anda perlu membuat `BaseAdapter` atau `ArrayAdapter` kustom untuk menghubungkan data catatan Anda (dari database) ke `ListView` di `MainActivity`.

### **3. Mereplikasi Fitur Unggulan**
*   **Wallpaper Catatan:**
    *   Di `editor_activity.xml`, tempatkan `ImageView` di belakang `EditText`.
    *   Gunakan `Intent` dengan `ACTION_PICK` atau `ACTION_GET_CONTENT` untuk membuka pemilih file/galeri.
    *   Simpan URI atau path file gambar yang dipilih di database SQLite Anda.
*   **Kunci Catatan:**
    *   Tambahkan kolom boolean `is_locked` dan string `password_hash` ke tabel database Anda.
    *   Saat item daftar diklik, periksa flag `is_locked`. Jika benar, tampilkan `AlertDialog` dengan `EditText` untuk kata sandi sebelum memulai `EditorActivity`.
*   **Perekaman Audio:**
    *   Gunakan kelas `MediaRecorder` untuk merekam audio. Anda perlu menangani izin `RECORD_AUDIO`.
    *   Simpan path file audio di database Anda.
    *   Gunakan kelas `MediaPlayer` untuk memutar audio.
*   **Text-to-Speech (Bot Suara):**
    *   Gunakan kelas `TextToSpeech` bawaan Android. Inisialisasi di `onCreate` dan gunakan metode `.speak()` untuk membacakan teks dari `EditText` Anda.

### **Tantangan di AIDE**
*   **Editor Teks Kaya:** Seperti Sketchware, ini sangat sulit. Anda akan terbatas pada pemformatan dasar menggunakan `SpannableString`.
*   **Draw to Text & Integrasi ML:** Mengintegrasikan pustaka ML seperti Google ML Kit di AIDE sangat canggih dan mungkin memerlukan pengaturan Gradle manual yang rumit, yang berada di luar cakupan AIDE standar.

Panduan ini menyediakan peta jalan tingkat tinggi. Anda perlu memiliki pemahaman yang kuat tentang pengembangan Android asli dengan Java untuk mengimplementasikannya. Selamat belajar dan mencoba!
