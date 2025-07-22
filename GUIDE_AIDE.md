# 🅰️ Panduan Lengkap untuk Rekreasi di AIDE

[AIDE (Android IDE)](https://www.android-ide.com/) adalah IDE yang kuat untuk mengembangkan aplikasi Android asli langsung di ponsel Anda menggunakan Java. Panduan ini memberikan peta jalan teknis untuk membangun kembali NiTe di AIDE.

### **1. Struktur Proyek & Database**

Fondasi yang kuat sangat penting.

*   **Buat Proyek Baru:** Mulailah dengan proyek "Aplikasi Android" standar di AIDE.
*   **Database Helper (`DatabaseHelper.java`):**
    *   Buat kelas baru yang memperluas `SQLiteOpenHelper`.
    *   Di `onCreate`, definisikan `CREATE TABLE` SQL Anda.
        ```sql
        CREATE TABLE notes (
            id TEXT PRIMARY KEY,
            content TEXT,
            wallpaper_path TEXT,
            is_locked INTEGER, -- 0 for false, 1 for true
            password_hash TEXT,
            -- ... dan kolom lainnya
        );
        ```
    *   Implementasikan metode untuk `addNote`, `updateNote`, `deleteNote`, dan `getAllNotes`. Metode `getAllNotes` harus mengembalikan `List<Note>`.

*   **Model (`Note.java`):**
    *   Buat kelas POJO (Plain Old Java Object) `Note` dengan bidang-bidang yang sesuai dengan kolom tabel Anda. Sertakan konstruktor dan metode getter/setter.

*   **Aktivitas Utama (`MainActivity.java`):**
    *   Gunakan `RecyclerView` untuk kinerja terbaik. Anda perlu menambahkan dependensi `RecyclerView` di `build.gradle` jika belum ada.
    *   Buat `NoteAdapter` kustom yang memperluas `RecyclerView.Adapter` untuk mengikat `List<Note>` Anda ke `RecyclerView`.

### **2. Mereplikasi Fitur Unggulan (Contoh Kode Java)**

*   **Penyimpanan & Pengambilan Catatan:**
    ```java
    // Di MainActivity.java
    DatabaseHelper db;
    List<Note> noteList;
    NoteAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        db = new DatabaseHelper(this);
        noteList = db.getAllNotes();

        RecyclerView recyclerView = findViewById(R.id.noteRecyclerView);
        adapter = new NoteAdapter(this, noteList);
        recyclerView.setAdapter(adapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));
    }
    ```

*   **Kunci Catatan:**
    *   Di `onBindViewHolder` dari `NoteAdapter` Anda, atur `onClickListener`.
    *   Di dalam listener, periksa `note.isLocked()`.
    *   Jika terkunci, buat `AlertDialog.Builder`. Gunakan `.setView()` untuk menambahkan `EditText` kustom untuk input kata sandi. Bandingkan hash kata sandi yang dimasukkan dengan yang disimpan sebelum memulai `EditorActivity`.

*   **Wallpaper (di `EditorActivity.java`):**
    ```java
    // Panggil ini untuk memilih gambar
    private void pickImage() {
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        startActivityForResult(intent, RESULT_LOAD_IMAGE);
    }

    // Tangani hasilnya
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RESULT_LOAD_IMAGE && resultCode == RESULT_OK && null != data) {
            Uri selectedImage = data.getData();
            // Simpan URI ini (sebagai String) ke database Anda
            // Gunakan library seperti Glide atau Picasso untuk memuat URI ke ImageView Anda
        }
    }
    ```

*   **Text-to-Speech (di `EditorActivity.java`):**
    ```java
    private TextToSpeech tts;

    // Inisialisasi di onCreate
    tts = new TextToSpeech(this, new TextToSpeech.OnInitListener() {
        @Override
        public void onInit(int status) {
            if (status == TextToSpeech.SUCCESS) {
                tts.setLanguage(Locale.US); // Atur bahasa
            }
        }
    });

    // Panggil ini untuk berbicara
    private void speakText() {
        String text = myEditText.getText().toString();
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null);
    }
    ```

### **Tantangan di AIDE**
*   **Ketergantungan Eksternal:** Menambahkan pustaka pihak ketiga (misalnya, `flutter_quill` tidak mungkin, tetapi alternatif Java seperti `RichEditor-Android`) memerlukan modifikasi manual pada file `build.gradle`, yang bisa jadi rumit di AIDE.
*   **UI/UX Modern:** Mencapai efek visual yang kompleks seperti "frosted glass" atau animasi transisi yang mulus memerlukan pemahaman mendalam tentang sistem `View` Android dan mungkin beberapa XML `drawable` kustom.

AIDE adalah alat yang luar biasa untuk pengembangan Android asli di mana saja, dan dengan pemahaman yang baik tentang konsep-konsep ini, Anda dapat membuat aplikasi yang sangat kuat dan berfungsi penuh.
