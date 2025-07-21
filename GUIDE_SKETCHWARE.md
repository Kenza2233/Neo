# 🎨 Panduan Lengkap untuk Rekreasi di Sketchware

Bagi pengguna [Sketchware Pro](https://github.com/Sketchware-Pro/Sketchware-Pro), Anda dapat mereplikasi banyak fitur NiTe menggunakan blok logika visual dan beberapa kode kustom. Panduan ini memberikan peta jalan yang lebih konkret.

> **Peringatan:** Ini adalah proyek tingkat lanjut untuk Sketchware. Anda tidak dapat menggunakan kode Flutter kami secara langsung.

### **1. Struktur Proyek & Data**

*   **Aktivitas Utama (`MainActivity`):**
    *   **UI:** Gunakan `ListView` (beri nama, mis. `noteListView`). Tambahkan `FloatingActionButton` untuk catatan baru.
    *   **Logika:** Di `onCreate`, buat atau muat daftar catatan Anda. Gunakan komponen `SharedPreferences` (beri nama, mis. `notes_data`) untuk menyimpan daftar catatan sebagai string JSON.
    *   **Contoh Blok (`onCreate`):**
        ```
        [SharedPreferences: notes_data, key: "all_notes", if not present: "[]"] -> [Get String to: noteListJson]
        [JSONUtil: noteListJson to List Map: noteList]
        [ListView: noteListView, set list map: noteList]
        [ListView: noteListView, refresh data]
        ```

*   **Aktivitas Editor (`EditorActivity`):**
    *   **UI:** Gunakan `EditText` (mis. `contentEditText`) untuk teks. Tambahkan `Button` untuk menyimpan.
    *   **Logika:** Di `onCreate`, terima data catatan yang diteruskan melalui `Intent`. Saat tombol simpan diklik, simpan perubahan kembali ke `SharedPreferences` dan `finish()` aktivitas.

*   **Adaptor `ListView` Kustom:**
    *   Buat "Tampilan Kustom" (`custom_note_item.xml`) dengan `TextView` untuk menampilkan pratinjau teks.
    *   Di `MainActivity`, di tab "Tampilan", atur tampilan kustom untuk `noteListView`.
    *   Di acara `onBindCustomView`, atur teks `TextView` dari `noteList` map pada posisi yang diberikan.

### **2. Mereplikasi Fitur Unggulan**

*   **Kunci Catatan (dengan `SharedPreferences`):**
    *   **Logika:** Tambahkan boolean `isLocked` dan String `passwordHash` ke setiap `map` catatan.
    *   **Contoh Blok (`onItemClicked` di `noteListView`):**
        ```
        [Get value at: position, from list map: noteList, to map: clickedNote]
        [If (map: clickedNote, get "isLocked" as boolean)] then {
            [Show a custom Dialog with an EditText for password input]
        } else {
            [Intent: setScreen to EditorActivity]
            [Intent: putExtra, key: "noteData", value: (map to JSON string: clickedNote)]
            [StartActivity: intent]
        }
        ```

*   **Perekaman Audio:**
    *   **Komponen:** Tambahkan komponen `MediaRecorder` (`recorder`) dan `MediaPlayer` (`player`).
    *   **Logika:** Gunakan `recorder.start(path)` dan `recorder.stop()`. Simpan `path` ke map catatan Anda. Gunakan `player.setDataSource(path)` dan `player.start()` untuk memutar. Anda perlu menangani izin `RECORD_AUDIO`.

*   **Tangkapan Layar:**
    *   **Blok Kode Sumber Langsung:** Ini adalah cara termudah di Sketchware.
    *   **Contoh Blok (di acara `onClick` tombol tangkapan layar):**
        ```java
        // Get the root view of your layout
        View rootView = getWindow().getDecorView().getRootView();
        rootView.setDrawingCacheEnabled(true);
        Bitmap bitmap = Bitmap.createBitmap(rootView.getDrawingCache());
        rootView.setDrawingCacheEnabled(false);

        // Save the bitmap
        String path = "/storage/emulated/0/Pictures/NiTe_Screenshot_" + System.currentTimeMillis() + ".png";
        try (FileOutputStream out = new FileOutputStream(path)) {
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
            Toast.makeText(getApplicationContext(), "Screenshot saved to " + path, Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            e.printStackTrace();
        }
        ```

### **Tantangan Utama**
*   **Editor Teks Kaya & Draw-to-Text:** Fitur-fitur ini sangat sulit atau tidak mungkin dilakukan tanpa integrasi pustaka Java kustom yang mendalam, yang berada di luar cakupan Sketchware standar.

Panduan ini seharusnya memberikan fondasi yang kuat. Kunci keberhasilan di Sketchware adalah memecah masalah menjadi bagian-bagian kecil dan menggunakan komponen dan blok yang tersedia secara kreatif. Selamat mencoba!
