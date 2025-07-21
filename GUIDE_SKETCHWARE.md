# 🎨 Rekreasi di Sketchware (Panduan Konseptual)

Bagi pengguna [Sketchware](https://sketchware.io/), Anda tidak dapat menggunakan basis kode Flutter ini secara langsung. Namun, Anda dapat mereplikasi fungsionalitas NiTe menggunakan blok logika visual Sketchware. Berikut adalah panduan konseptualnya:

### **1. Struktur Aplikasi Dasar**
*   **Tampilan Daftar Catatan:** Gunakan `ListView` atau `RecyclerView` untuk menampilkan daftar catatan. Setiap item dalam daftar akan menjadi `CardView`.
*   **Tampilan Editor Catatan:** Buat aktivitas baru (`Activity`) untuk editor. Gunakan `EditText` untuk input teks dasar.
*   **Penyimpanan Data:** Gunakan komponen `SharedPreferences` untuk menyimpan dan memuat data catatan. Simpan daftar catatan sebagai string JSON.

### **2. Mereplikasi Fitur Unggulan**
*   **Wallpaper Catatan:**
    *   Di editor, tambahkan `ImageView` di belakang `EditText`.
    *   Gunakan blok `FilePicker` untuk memungkinkan pengguna memilih gambar.
    *   Simpan path gambar yang dipilih di `SharedPreferences` bersama dengan data catatan lainnya.
*   **Kunci Catatan:**
    *   Tambahkan variabel boolean `isLocked` ke data catatan Anda.
    *   Saat membuka catatan, periksa `isLocked`. Jika `true`, tampilkan `Dialog` yang meminta kata sandi sebelum menampilkan konten.
    *   Gunakan `SharedPreferences` untuk menyimpan hash kata sandi.
*   **Perekaman Audio:**
    *   Gunakan komponen `SoundRecorder` untuk merekam audio.
    *   Simpan path file audio yang direkam di `SharedPreferences`.
    *   Gunakan komponen `MediaPlayer` untuk memutar audio.
*   **Tangkapan Layar:**
    *   Buat `View` kustom yang berisi semua elemen yang ingin Anda tangkap.
    *   Gunakan blok `View.getDrawingCache()` untuk mendapatkan `Bitmap` dari `View` tersebut.
    *   Gunakan blok kode Java kustom untuk menyimpan `Bitmap` ke penyimpanan eksternal.

### **Tantangan**
*   **Editor Teks Kaya:** Mereplikasi editor teks kaya seperti `Quill` di Sketchware sangat sulit. Anda mungkin terbatas pada pemformatan dasar menggunakan `SpannableString` melalui blok kode Java.
*   **Draw to Text:** Ini memerlukan integrasi dengan API eksternal atau model ML, yang sangat canggih untuk Sketchware dan kemungkinan besar memerlukan proyek kustom atau pustaka eksternal.

Panduan ini seharusnya memberi Anda titik awal yang baik untuk membangun aplikasi seperti NiTe di Sketchware. Selamat mencoba!
