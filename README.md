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
