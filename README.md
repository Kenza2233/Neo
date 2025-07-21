# NiTe - Aplikasi Catatan

NiTe adalah aplikasi pencatat serbaguna yang dirancang untuk menjadi pendamping utama Anda untuk menangkap ide, pemikiran, dan pengingat. Dengan antarmuka yang bersih dan intuitif, NiTe memudahkan untuk tetap teratur dan produktif.

## Fitur

### Manajemen Catatan Inti
*   **Editor Teks Kaya:** Buat dan edit catatan dengan opsi pemformatan dasar.
*   **Penyimpanan Lokal:** Catatan disimpan dengan aman di perangkat Anda untuk akses offline.
*   **Tata Letak Grid:** Lihat catatan Anda dalam tata letak grid yang dapat disesuaikan.

### Personalisasi
*   **Wallpaper Catatan:** Atur gambar dari galeri Anda sebagai latar belakang untuk setiap catatan.
*   **Palet Warna (Akan Datang):** Personalisasi catatan Anda dengan 99 pilihan warna yang berbeda.

### Alat Produktivitas
*   **Dasbor Statistik:** Dapatkan wawasan tentang kebiasaan mencatat Anda dengan statistik terperinci untuk setiap catatan:
    *   Durasi mengetik
    *   Jumlah kata
    *   Jumlah pembukaan
    *   Jumlah penghapusan
*   **Tangkapan Layar:** Ambil tangkapan layar dari catatan Anda dengan mudah dan simpan ke galeri Anda.
*   **Perekaman Audio:** Lampirkan rekaman audio ke catatan Anda.

### Fitur Multimedia (Akan Datang)
*   **Video ke GIF:** Konversikan video pendek menjadi GIF animasi.
*   **Suara ke Teks:** Diktekan catatan Anda dan minta NiTe mengubahnya menjadi teks.

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
