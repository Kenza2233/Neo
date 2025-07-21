# NiTe - Aplikasi Catatan

NiTe adalah aplikasi pencatat serbaguna yang dirancang untuk menjadi pendamping utama Anda untuk menangkap ide, pemikiran, dan pengingat. Dengan antarmuka yang bersih dan intuitif, NiTe memudahkan untuk tetap teratur dan produktif.

## ✨ Fitur Unggulan NiTe ✨

NiTe bukan sekadar aplikasi catatan biasa. Ini adalah ruang kerja kreatif Anda, yang dirancang untuk beradaptasi dengan cara Anda berpikir dan bekerja.

### 🎨 **Ekspresikan Diri Anda Sepenuhnya**
*   **Editor Teks Supercharged:** Lebih dari sekadar tebal dan miring. Gunakan **Neolights** untuk menyorot ide-ide cemerlang Anda dengan warna-warna neon yang cerah, dan pilih dari palet warna yang luas untuk membuat setiap catatan menjadi milik Anda.
*   **Wallpaper Kustom:** Bosan dengan latar belakang putih? Atur gambar *apa pun* dari galeri Anda sebagai wallpaper untuk catatan Anda. Personalisasi tidak pernah semenyenangkan ini!

### 🔒 **Privasi & Keamanan Tingkat Lanjut**
*   **Kunci Catatan 18+:** Simpan pemikiran pribadi Anda dengan aman. Lindungi catatan sensitif dengan **kata sandi** untuk memastikan hanya Anda yang dapat mengaksesnya.

### 🚀 **Tingkatkan Produktivitas Anda**
*   **Dasbor Analitik:** Pernah bertanya-tanya berapa lama waktu yang Anda habiskan untuk sebuah ide? Dasbor kami memberikan wawasan mendalam tentang kebiasaan mencatat Anda, termasuk *durasi mengetik*, *jumlah kata*, dan banyak lagi.
*   **Tangkapan Layar Instan:** Abadikan catatan Anda sebagai gambar dengan sekali ketuk. Sempurna untuk dibagikan atau disimpan sebagai referensi visual.

### 🎙️ **Aksesibilitas untuk Semua**
*   **Bot Suara Cerdas:** Dengarkan catatan Anda dibacakan dengan suara yang jernih, atau gunakan suara Anda untuk menulis. NiTe dirancang agar dapat diakses oleh semua orang, termasuk mereka yang memiliki keterbatasan penglihatan.
*   **Rekam & Putar:** Lampirkan memo suara ke catatan Anda. Jangan biarkan ide brilian hilang hanya karena Anda tidak sempat menuliskannya.

## Memulai

Bagian ini akan memandu Anda melalui proses penyiapan lingkungan pengembangan Anda untuk menjalankan NiTe.

### Prasyarat

Sebelum Anda mulai, pastikan Anda telah menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install) di mesin Anda. Anda dapat memverifikasi instalasi Anda dengan menjalankan perintah berikut di terminal Anda:

```bash
flutter doctor
```

Perintah ini akan memeriksa lingkungan Anda dan menampilkan laporan tentang status instalasi Flutter Anda. Pastikan tidak ada masalah kritis yang dilaporkan sebelum melanjutkan.

### Instalasi

1.  **Kloning Repositori**

    Gunakan `git` untuk mengkloning repositori ini ke mesin lokal Anda:

    ```bash
    git clone https://github.com/pengguna/nite.git
    ```

2.  **Arahkan ke Direktori Proyek**

    Setelah kloning selesai, pindah ke direktori proyek:

    ```bash
    cd nite
    ```

3.  **Instal Dependensi**

    Jalankan perintah berikut untuk mengunduh semua dependensi proyek yang diperlukan:

    ```bash
    flutter pub get
    ```

### Menjalankan Aplikasi

Setelah Anda menginstal semua dependensi, Anda dapat menjalankan aplikasi di emulator atau perangkat fisik yang terhubung.

1.  **Pilih Perangkat**

    Pastikan Anda memiliki emulator yang berjalan atau perangkat yang terhubung. Anda dapat melihat daftar perangkat yang tersedia dengan menjalankan:

    ```bash
    flutter devices
    ```

2.  **Jalankan Aplikasi**

    Gunakan perintah berikut untuk membangun dan menjalankan aplikasi:

    ```bash
    flutter run
    ```

    Ini akan menginstal aplikasi di perangkat yang dipilih dan meluncurkannya. Hot reload diaktifkan secara default, jadi Anda dapat melihat perubahan pada kode Anda secara instan.

## Teknologi yang Digunakan

*   [Flutter](https://flutter.dev/) - Framework UI untuk membangun aplikasi yang dikompilasi secara native untuk seluler, web, dan desktop dari satu basis kode.
*   [Shared Preferences](https://pub.dev/packages/shared_preferences) - Untuk penyimpanan data lokal.
*   [Image Picker](https://pub.dev/packages/image_picker) - Untuk memilih gambar dari galeri.

## Kontribusi

Kontribusi dipersilakan! Silakan buka masalah atau kirimkan permintaan tarik untuk setiap perubahan.

---

## 📱 Panduan Lengkap: Kembangkan NiTe di Ponsel Anda (Eksperimental)

Ingin merasakan kebebasan *ngoding* di mana saja? Panduan ini akan memandu Anda langkah demi langkah untuk menyiapkan lingkungan pengembangan NiTe langsung di ponsel Android Anda menggunakan Acode dan Termux.

### **Tahap 1: Persiapan Lingkungan**

1.  **Instal Acode & Termux:**
    *   **Acode:** Dapatkan dari [Google Play Store](https://play.google.com/store/apps/details?id=com.foxdebug.acode). Ini akan menjadi editor kode Anda.
    *   **Termux:** Unduh dari [F-Droid](https://f-droid.org/en/packages/com.termux/). Ini adalah terminal Linux Anda. **Penting:** Versi di Play Store sudah usang.

2.  **Siapkan Termux:**
    *   Buka Termux dan perbarui paketnya:
        ```bash
        pkg update && pkg upgrade
        ```
    *   Instal `git` dan `wget` (jika belum ada):
        ```bash
        pkg install git wget
        ```

3.  **Instal Flutter SDK di Termux:**
    *   **Langkah A: Unduh Flutter SDK.** Kunjungi [situs web Flutter SDK](https://flutter.dev/docs/get-started/install/linux) dan salin tautan unduhan untuk "Linux (ARM64)". Di Termux, gunakan `wget` untuk mengunduh file tersebut. Contoh (pastikan untuk memeriksa versi terbaru):
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
    *   **Langkah D: Terapkan Perubahan.** Muat ulang konfigurasi shell Anda:
        ```bash
        source ~/.bashrc
        ```
    *   **Langkah E: Verifikasi Instalasi.** Sekarang, tutup dan buka kembali Termux, lalu jalankan:
        ```bash
        flutter doctor
        ```
    *   Jangan khawatir jika ada beberapa tanda centang yang hilang (seperti "Chrome" atau "Android Studio"). Yang penting adalah komponen inti Flutter terinstal dan tidak ada error fatal.

### **Tahap 2: Memulai Proyek NiTe**

1.  **Kloning Repositori:**
    *   Di Termux, kloning proyek NiTe:
        ```bash
        git clone https://github.com/pengguna/nite.git
        ```

2.  **Buka di Acode:**
    *   Buka Acode.
    *   Buka menu (tiga titik di kanan atas) dan pilih "Buka Folder".
    *   Arahkan ke direktori tempat Anda mengkloning proyek NiTe dan pilih folder tersebut.

3.  **Instal Dependensi:**
    *   Kembali ke Termux. Pastikan Anda berada di dalam direktori proyek NiTe:
        ```bash
        cd nite
        ```
    *   Jalankan perintah untuk mengambil semua paket yang dibutuhkan:
        ```bash
        flutter pub get
        ```

### **Tahap 3: Edit, Bangun, dan Jalankan**

1.  **Edit Kode di Acode:**
    *   Sekarang Anda bebas mengedit file `.dart` di dalam folder `lib` menggunakan Acode. Nikmati fitur-fitur seperti penyorotan sintaks dan pelengkapan kode.

2.  **Jalankan Aplikasi:**
    *   Kembali ke Termux (pastikan Anda masih di dalam direktori `nite`).
    *   Jalankan perintah berikut untuk membangun dan menginstal aplikasi di ponsel Anda:
        ```bash
        flutter run --release
        ```
    *   Menggunakan flag `--release` direkomendasikan untuk kinerja yang lebih baik di ponsel. Proses build pertama kali mungkin memakan waktu cukup lama.

### **Tips & Pemecahan Masalah:**

*   **Hot Reload?** Hot reload mungkin tidak berfungsi dengan andal dalam alur kerja ini. Anda mungkin perlu menjalankan ulang `flutter run` untuk melihat perubahan.
*   **Ruang Penyimpanan:** Flutter SDK dan dependensi bisa memakan banyak ruang (beberapa GB). Pastikan ponsel Anda memiliki cukup ruang kosong.
*   **Error Build?** Jika Anda mengalami error, baca log dengan cermat. Seringkali, ini terkait dengan versi paket atau konfigurasi yang salah. Coba jalankan `flutter clean` lalu `flutter pub get` lagi.
*   **Kesabaran adalah Kunci:** Mengembangkan di ponsel adalah tantangan, tetapi juga sangat memuaskan. Bersabarlah dan jangan ragu untuk mencari solusi secara online!

---

## 🎨 Rekreasi di Sketchware (Panduan Konseptual)

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
