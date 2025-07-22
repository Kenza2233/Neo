#  Panduan Lengkap untuk Pengembang iOS

Selamat datang, pengembang iOS! Panduan ini akan memandu Anda melalui setiap langkah untuk menjalankan NiTe di lingkungan macOS, mulai dari penyiapan hingga menjalankan aplikasi di perangkat nyata.

### **Tahap 1: Menyiapkan Lingkungan Emas Anda**

Sebelum menyentuh kode NiTe, pastikan lingkungan pengembangan macOS Anda siap tempur.

1.  **Instal Homebrew (Opsional, tapi Sangat Direkomendasikan):**
    *   Homebrew adalah manajer paket untuk macOS. Ini akan memudahkan instalasi alat lain. Buka Terminal dan jalankan:
        ```bash
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ```

2.  **Instal Flutter SDK:**
    *   Cara termudah adalah melalui Homebrew:
        ```bash
        brew install --cask flutter
        ```
    *   Setelah selesai, tambahkan Flutter ke `PATH` Anda. Edit file konfigurasi shell Anda (misalnya, `~/.zshrc` untuk Zsh, yang merupakan default di macOS modern):
        ```bash
        echo 'export PATH="$PATH":"$HOME/flutter/bin"' >> ~/.zshrc
        ```
    *   Muat ulang shell Anda: `source ~/.zshrc`.

3.  **Instal Xcode:**
    *   Ini adalah langkah yang paling penting. Instal Xcode **langsung dari Mac App Store**. Ini akan memakan waktu cukup lama.
    *   Setelah instalasi selesai, **buka Xcode sekali** untuk menyetujui persyaratan lisensi dan menginstal komponen tambahan.
    *   Instal Alat Baris Perintah Xcode:
        ```bash
        xcode-select --install
        ```

4.  **Instal CocoaPods:**
    *   CocoaPods mengelola dependensi untuk proyek Xcode. Ini sangat penting.
        ```bash
        sudo gem install cocoapods
        ```

5.  **Pemeriksaan Akhir dengan `flutter doctor`:**
    *   Jalankan `flutter doctor`. Perhatikan baik-baik outputnya.
    *   Anda harus melihat tanda centang hijau untuk "Flutter", "Xcode", dan "CocoaPods". Jika ada masalah (ditandai dengan `!`), ikuti instruksi yang diberikan oleh `flutter doctor` untuk menyelesaikannya.

### **Tahap 2: Menjalankan NiTe**

1.  **Kloning & Persiapan Proyek:**
    *   Di Terminal, arahkan ke direktori tempat Anda ingin menyimpan proyek, lalu kloning:
        ```bash
        git clone https://github.com/pengguna/nite.git
        cd nite
        ```
    *   Ambil semua dependensi Flutter. Ini akan membaca file `pubspec.yaml` dan mengunduh semua paket yang diperlukan.
        ```bash
        flutter pub get
        ```

2.  **Menjalankan di Simulator:**
    *   Buka simulator dari baris perintah:
        ```bash
        open -a Simulator
        ```
    *   Kemudian, jalankan aplikasi:
        ```bash
        flutter run
        ```

3.  **Menjalankan di Perangkat iOS Fisik:**
    *   Hubungkan iPhone atau iPad Anda ke Mac Anda.
    *   Buka proyek iOS di Xcode:
        ```bash
        open ios/Runner.xcworkspace
        ```
    *   Di Xcode, pilih perangkat Anda dari daftar di bagian atas.
    *   Klik pada "Runner" di navigator proyek di sebelah kiri, lalu pergi ke tab "Signing & Capabilities".
    *   Di bawah "Signing", pilih "Team" Anda (biasanya ID Apple pribadi Anda). Xcode mungkin meminta Anda untuk mendaftarkan perangkat Anda.
    *   Setelah penandatanganan diatur, Anda dapat menutup Xcode dan menjalankan `flutter run` dari Terminal. Flutter akan menginstal dan meluncurkan aplikasi di perangkat Anda.

### **Pemecahan Masalah Umum iOS**
*   **"Podfile.lock" Error:** Jika Anda melihat kesalahan tentang `Podfile.lock`, ini biasanya berarti ada ketidakcocokan. Cara paling andal untuk memperbaikinya adalah dengan menghapus file yang bermasalah dan menginstalnya kembali.
    ```bash
    cd ios
    rm Podfile.lock
    pod install --repo-update
    cd ..
    ```
*   **"Could not find module '...'" di Xcode:** Ini sering kali merupakan masalah cache. Coba bersihkan build folder di Xcode (Product > Clean Build Folder) atau jalankan `flutter clean` di Terminal.
*   **Aplikasi Langsung Crash di Perangkat:** Ini hampir selalu merupakan masalah penandatanganan kode. Periksa kembali pengaturan "Signing & Capabilities" Anda di Xcode. Pastikan Anda mempercayai pengembang di perangkat Anda (Pengaturan > Umum > Manajemen VPN & Perangkat).
