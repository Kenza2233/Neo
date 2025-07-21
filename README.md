# NiTe - Aplikasi Catatan

NiTe adalah aplikasi pencatat serbaguna yang dirancang untuk menjadi pendamping utama Anda untuk menangkap ide, pemikiran, dan pengingat. Dengan antarmuka yang bersih dan intuitif, NiTe memudahkan untuk tetap teratur dan produktif.

## ✨ Fitur Unggulan NiTe ✨

NiTe bukan sekadar aplikasi catatan biasa. Ini adalah ekosistem produktivitas lengkap Anda, yang dirancang untuk menangkap, menyempurnakan, dan mengelola ide-ide Anda dengan cara yang belum pernah ada sebelumnya.

### 🎨 **Kustomisasi Tanpa Batas**
*   **Editor Teks Supercharged:** Lebih dari sekadar tebal dan miring. Gunakan **Neolights** untuk menyorot ide-ide cemerlang, sisipkan gambar langsung di dalam catatan, dan atur setiap aspek tipografi mulai dari **ukuran font** hingga **spasi baris**.
*   **Tema & Estetika:** Pilih antara **mode terang dan gelap** yang indah, atau matikan animasi UI untuk pengalaman yang lebih cepat. Jadikan NiTe benar-benar milik Anda.
*   **Atur Tata Letak Anda:** Pilih dari **lima tata letak catatan yang berbeda** (termasuk grid, daftar, dan staggered) untuk disesuaikan dengan alur kerja visual Anda.
*   **Wallpaper Kustom:** Atur gambar *apa pun* dari galeri Anda sebagai latar belakang untuk setiap catatan.

### 🚀 **Alat Produktivitas Cerdas**
*   **Hub Catatan:** Akses laci navigasi khusus untuk melihat catatan Anda yang diurutkan berdasarkan tanggal, memberikan perspektif baru pada pekerjaan Anda tanpa mengganggu tata letak utama Anda.
*   **Riwayat Versi:** Jangan pernah takut kehilangan ide bagus. Simpan *snapshot* dari catatan Anda dan pulihkan versi sebelumnya kapan saja.
*   **Fitur Istirahat Cerdas:** Jaga kesehatan digital Anda. Atur batas kata, dan NiTe akan dengan lembut mengingatkan Anda untuk beristirahat.
*   **Dasbor Analitik:** Dapatkan wawasan mendalam tentang kebiasaan mencatat Anda, termasuk *durasi mengetik*, *jumlah kata*, dan banyak lagi.

### 🌐 **Konektivitas & Aksesibilitas**
*   **Terjemahkan dengan Sekali Ketuk:** Terjemahkan konten catatan Anda ke berbagai bahasa langsung di dalam aplikasi.
*   **Ekspor/Impor XML:** Cadangkan atau bagikan catatan Anda dengan mudah menggunakan format XML standar.
*   **Cetak ke PDF:** Ubah catatan Anda menjadi dokumen PDF yang dapat dicetak dengan sempurna.
*   **Draw to Text:** Tulis tangan ide-ide Anda, dan biarkan NiTe mengubahnya menjadi teks yang dapat diedit.
*   **Aksesibilitas Penuh:** Dengan dukungan **Text-to-Speech (Bot Suara)** dan **perekaman audio**, NiTe dirancang untuk dapat diakses oleh semua orang.

### 🔒 **Privasi & Keamanan Tingkat Lanjut**
*   **Kunci Catatan 18+:** Lindungi catatan sensitif dengan **kata sandi** untuk memastikan hanya Anda yang dapat mengaksesnya.

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

##  Panduan untuk Pengembang iOS

Menjalankan NiTe di lingkungan macOS untuk pengembangan iOS juga mudah. Berikut adalah langkah-langkahnya:

### **Prasyarat**
1.  **Flutter SDK:** Pastikan Anda telah menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install/macos) di Mac Anda.
2.  **Xcode:** Instal Xcode dari Mac App Store. Ini akan menginstal semua alat baris perintah dan kompiler yang diperlukan.
3.  **CocoaPods:** Ini adalah manajer dependensi untuk proyek Xcode. Jika Anda belum memilikinya, instal dengan perintah berikut:
    ```bash
    sudo gem install cocoapods
    ```

### **Langkah-langkah**
1.  **Kloning & Persiapan:**
    *   Buka Terminal dan kloning repositori:
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

2.  **Menjalankan di Simulator atau Perangkat:**
    *   **Buka Simulator:** Jalankan perintah berikut untuk membuka simulator iOS:
        ```bash
        open -a Simulator
        ```
    *   **Jalankan Aplikasi:** Di jendela terminal Anda, jalankan:
        ```bash
        flutter run
        ```
    *   Flutter akan secara otomatis mendeteksi simulator yang berjalan (atau perangkat iOS yang terhubung) dan menginstal aplikasi di sana.

### **Pemecahan Masalah Umum iOS**
*   **Error CocoaPods:** Jika Anda mengalami error terkait CocoaPods, coba jalankan perintah berikut di dalam direktori `ios` dari proyek Anda:
    ```bash
    pod install --repo-update
    ```
*   **Masalah Penandatanganan Kode (Code Signing):** Untuk menjalankan di perangkat fisik, Anda mungkin perlu mengkonfigurasi penandatanganan kode di Xcode. Buka file `Runner.xcworkspace` di dalam folder `ios` proyek Anda, pilih "Runner" di navigator proyek, dan pergi ke tab "Signing & Capabilities" untuk mengkonfigurasi tim Anda.

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
