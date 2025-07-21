#  Panduan untuk Pengembang iOS

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
