# 👨‍💻 Rekreasi di Dcoder (Panduan Konseptual)

[Dcoder](https://play.google.com/store/apps/details?id=com.paprbit.dcoder) adalah IDE pengkodean seluler yang mendukung banyak bahasa. Meskipun tidak dapat menjalankan proyek Flutter secara langsung, Anda dapat menggunakan bagian "Android App" (yang menggunakan Java) untuk membuat aplikasi serupa. Panduan ini menjelaskan konsepnya.

> **Peringatan:** Membuat aplikasi yang kompleks seperti NiTe di Dcoder sangat menantang karena keterbatasan lingkungannya. Panduan ini ditujukan untuk tujuan pendidikan dan eksperimental.

### **1. Konsep Dasar Proyek**
*   **Proyek:** Buat proyek "Android App" baru di Dcoder.
*   **Struktur:** Anda akan bekerja terutama dengan dua file: `MainActivity.java` (logika Anda) dan `activity_main.xml` (tata letak Anda).
*   **Navigasi:** Untuk beberapa layar (seperti editor catatan), Anda perlu membuat aktivitas baru. Di Dcoder, ini berarti membuat proyek terpisah dan menggunakan `Intent` untuk beralih di antara mereka, yang tidak praktis. Pendekatan yang lebih baik adalah menggunakan satu aktivitas dan secara dinamis mengubah visibilitas `View` (misalnya, `ListView` untuk daftar catatan dan `LinearLayout` untuk editor).

### **2. Mereplikasi Fitur di `activity_main.xml`**
*   **Daftar Catatan:** Gunakan `<ListView>` untuk menampilkan catatan.
*   **Editor:** Gunakan `<EditText>` untuk input teks. Anda dapat menempatkannya di dalam `<LinearLayout>` yang awalnya disembunyikan (`android:visibility="gone"`).
*   **Tombol:** Gunakan `<Button>` atau `<ImageButton>` untuk tindakan seperti menyimpan, membuka kunci, atau merekam.

### **3. Mereplikasi Logika di `MainActivity.java`**
*   **Penyimpanan:**
    *   **SharedPreferences:** Gunakan ini untuk menyimpan pengaturan sederhana. Dapatkan instance dengan `getSharedPreferences("MyPrefs", Context.MODE_PRIVATE)`.
    *   **Penyimpanan Internal:** Untuk data catatan, cara termudah di Dcoder adalah dengan menyimpan setiap catatan sebagai file teks terpisah di penyimpanan internal aplikasi. Gunakan `openFileOutput()` dan `openFileInput()`.
*   **Kunci Catatan:**
    *   Simpan hash kata sandi di `SharedPreferences`.
    *   Saat pengguna mencoba membuka catatan yang terkunci, tampilkan `AlertDialog` dengan `EditText` untuk meminta kata sandi.
*   **Text-to-Speech:**
    *   Gunakan kelas `android.speech.tts.TextToSpeech`. Anda perlu menginisialisasinya dan kemudian memanggil `.speak()`.
*   **Wallpaper:**
    *   Ini sangat sulit di Dcoder karena penanganan file yang terbatas. Secara konseptual, Anda akan menggunakan `Intent` untuk memilih gambar, mendapatkan `Uri`-nya, dan mencoba mengaturnya sebagai latar belakang `View`, tetapi ini mungkin tidak dapat diandalkan.

### **Tantangan Utama di Dcoder**
*   **Tidak Ada Database:** Dcoder tidak menyediakan akses mudah ke SQLite, membuat manajemen data yang kompleks menjadi sulit.
*   **Keterbatasan UI:** Anda terbatas pada apa yang dapat Anda definisikan dalam satu file XML.
*   **Integrasi Pustaka:** Menambahkan pustaka eksternal (seperti untuk pengenalan tulisan tangan atau editor teks kaya) hampir tidak mungkin.

Singkatnya, Anda dapat membuat versi yang sangat sederhana dari NiTe di Dcoder, tetapi untuk fitur-fitur canggih, Anda akan dengan cepat mencapai batas platform. Gunakan ini sebagai latihan untuk memahami dasar-dasar pengembangan Android dengan Java.
