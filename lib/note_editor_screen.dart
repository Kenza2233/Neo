import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dashboard_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_tts/flutter_tts.dart';
import 'drawing_canvas.dart';
import 'version_history_screen.dart';
import 'dart:ui' as ui;
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:translator/translator.dart';
import 'genius_service.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  quill.QuillController _quillController = quill.QuillController.basic();
  FlutterTts flutterTts = FlutterTts();
  String? _wallpaperPath;
  late Note _note;
  Timer? _typingTimer;
  int _deleteCount = 0;
  String _previousText = '';
  ScreenshotController screenshotController = ScreenshotController();
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;

  bool _isUnlocked = false;

  double _defaultTextSize = 16.0;

  @override
  void initState() {
    super.initState();
    _note = widget.note ?? Note(id: DateTime.now().toIso8601String(), content: '[{"insert":"\\n"}]');
    _note.openCount++;
    try {
      final doc = quill.Document.fromJson(jsonDecode(_note.content));
      _quillController = quill.QuillController(document: doc, selection: const TextSelection.collapsed(offset: 0));
    } catch (e) {
      _quillController = quill.QuillController.basic();
    }
    _wallpaperPath = _note.wallpaperPath;

    if (_note.isLocked) {
      _promptForPassword();
    } else {
      _isUnlocked = true;
    }

    _loadEditorSettings();
    _loadRestWordLimit();
    _quillController.addListener(_onTextChanged);
    _startTypingTimer();
    _initSound();
  }

  void _loadEditorSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _defaultTextSize = double.tryParse(prefs.getString('defaultTextSize') ?? '16.0') ?? 16.0;
      // Load other settings similarly
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _wallpaperPath = pickedFile.path;
      });
    }
  }

  int _restWordLimit = 100;
  bool _restAlertShown = false;

  void _loadRestWordLimit() async {
    final prefs = await SharedPreferences.getInstance();
    _restWordLimit = prefs.getInt('restWordLimit') ?? 100;
  }

  void _onTextChanged() {
    final currentText = _quillController.document.toPlainText();
    if (currentText.length < _previousText.length) {
      _deleteCount++;
    }
    _previousText = currentText;

    final wordCount = currentText.split(' ').where((s) => s.isNotEmpty).length;
    setState(() {
      _note.wordCount = wordCount;
    });

    if (wordCount >= _restWordLimit && !_restAlertShown) {
      _showRestDialog();
      _restAlertShown = true; // Prevent dialog from showing again in this session
    }
  }

  void _showRestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Waktunya Istirahat!'),
          content: Text('Anda telah mengetik lebih dari $_restWordLimit kata. Ambil napas sejenak.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _startTypingTimer() {
    _typingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _note.typingDuration++;
    });
  }

  Future<void> _initSound() async {
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _quillController.removeListener(_onTextChanged);
    _quillController.dispose();
    _recorder?.closeRecorder();
    _player?.closePlayer();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    _note.content = jsonEncode(_quillController.document.toDelta().toJson());
    _note.deleteCount += _deleteCount;
    final notes = prefs.getStringList('notes') ?? [];
    final noteIndex = notes.indexWhere((noteData) => Note.fromMap(jsonDecode(noteData)).id == _note.id);
    if (noteIndex != -1) {
      notes[noteIndex] = jsonEncode(_note.toMap());
    } else {
      notes.add(jsonEncode(_note.toMap()));
    }
    await prefs.setStringList('notes', notes);
  }

  void _promptForPassword() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Masukkan Kata Sandi'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Kata Sandi'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back if cancelled
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_note.checkPassword(passwordController.text)) {
                  setState(() {
                    _isUnlocked = true;
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kata sandi salah')),
                  );
                }
              },
              child: const Text('Buka'),
            ),
          ],
        );
      },
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih Warna Teks'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Color(_note.textColor),
              onColorChanged: (color) {
                setState(() {
                  _note.textColor = color.value;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Selesai'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTranslateDialog() async {
    String? selectedLanguage = 'en'; // Default to English
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Terjemahkan ke'),
          content: DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            },
            items: <String>['en', 'es', 'fr', 'de', 'id'] // Example languages
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final translator = GoogleTranslator();
                final originalText = _quillController.document.toPlainText();
                final translation = await translator.translate(originalText, to: selectedLanguage!);
                _quillController.document.insert(_quillController.document.length -1, '\n\n--- Terjemahan ---\n${translation.text}');
              },
              child: const Text('Terjemahkan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _printNote() async {
    final doc = pw.Document();
    final plainText = _quillController.document.toPlainText();

    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Text(plainText);
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
    );
  }

  Widget _buildActionButton(IconData icon, String tooltip, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }

  Future<String?> _pickAndProcessImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return null;

    final inputImage = InputImage.fromFilePath(pickedFile.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    textRecognizer.close();

    return recognizedText.text;
  }

  void _showImageSourceDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Pilih Sumber Gambar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeri'),
                    onTap: () {
                      Navigator.pop(context);
                      _triggerOcr(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Kamera'),
                    onTap: () {
                      Navigator.pop(context);
                      _triggerOcr(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ));
  }

  void _triggerOcr(ImageSource source) async {
    final recognizedText = await _pickAndProcessImage(source);
    if (recognizedText != null && recognizedText.isNotEmpty) {
      _quillController.document.insert(_quillController.selection.baseOffset, recognizedText);
    }
  }

  void _showPasswordDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_note.isLocked ? 'Ubah Kata Sandi' : 'Atur Kata Sandi'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Masukkan kata sandi'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _note.setPassword(passwordController.text);
                  _note.isLocked = true;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showLyricsSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => const _LyricsSearchDialog(),
    );
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    } else {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException("Izin mikrofon tidak diberikan");
      }
      await _recorder!.startRecorder(
        toFile: 'note_audio_${_note.id}.aac',
        codec: Codec.aacADTS,
      );
      setState(() {
        _isRecording = true;
        _note.audioPath = 'note_audio_${_note.id}.aac';
      });
    }
  }

  Future<void> _togglePlaying() async {
    if (_isPlaying) {
      await _player!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _player!.startPlayer(
        fromURI: _note.audioPath,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(note: _note),
                ),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'save',
                child: Text('Simpan Versi'),
              ),
              const PopupMenuItem(
                value: 'view',
                child: Text('Lihat Riwayat'),
              ),
            ],
            onSelected: (value) async {
              if (value == 'save') {
                setState(() {
                  _note.versionHistory.add(jsonEncode(_quillController.document.toDelta().toJson()));
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Versi disimpan.')),
                );
              } else if (value == 'view') {
                final restoredVersion = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VersionHistoryScreen(note: _note),
                  ),
                );
                if (restoredVersion != null) {
                  setState(() {
                    final doc = quill.Document.fromJson(jsonDecode(restoredVersion));
                    _quillController = quill.QuillController(document: doc, selection: const TextSelection.collapsed(offset: 0));
                  });
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printNote,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveNote();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: _isUnlocked
          ? Stack(
              children: [
                if (_wallpaperPath != null)
                  Image.file(
                    File(_wallpaperPath!),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        height: 50,
                        color: Colors.white.withOpacity(0.2),
                        child: const Center(child: Text('Toolbar Placeholder')),
                      ),
                    ),
                      ),
                      const SizedBox(height: 16),
                      quill.QuillToolbar.basic(
                        controller: _quillController,
                        showBackgroundColorButton: true,
                        showColorButton: true,
                        showImageButton: true,
                        onImagePickCallback: (file) async {
                          return file.path;
                        },
                      ),
                      Expanded(
                        child: quill.QuillEditor(
                          controller: _quillController,
                          readOnly: false,
                          focusNode: FocusNode(),
                          scrollController: ScrollController(),
                          scrollable: true,
                          padding: EdgeInsets.zero,
                          autoFocus: false,
                          expands: false,
                          customStyles: quill.DefaultStyles(
                            paragraph: quill.DefaultTextBlockStyle(
                              TextStyle(
                                fontSize: _defaultTextSize,
                                // line-height and letter-spacing are more complex in Quill
                              ),
                              const quill.VerticalSpacing(0, 0),
                              const quill.VerticalSpacing(0, 0),
                              null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: GestureDetector(
                        onTap: _showColorPicker,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Warna Teks'),
                                const SizedBox(width: 10),
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Color(_note.textColor),
                                ),
                              ],
                          ),
                          ),
                      ),
                    ),
                  ),
                      ),
                      const SizedBox(height: 16),
                      // Action buttons
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Group 1: Input Methods
                            _buildActionButton(Icons.image_search, 'Teks dari Gambar', () => _showImageSourceDialog()),
                            _buildActionButton(Icons.draw, 'Gambar', () async {
                              final recognizedText = await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => const DrawingCanvas()));
                              if (recognizedText != null && recognizedText.isNotEmpty) {
                                _quillController.document.insert(_quillController.selection.baseOffset, recognizedText);
                              }
                            }),
                            _buildActionButton(_isRecording ? Icons.stop : Icons.mic, 'Rekam', _toggleRecording),

                            // Group 2: Content & API
                            _buildActionButton(Icons.music_note, 'Lirik', _showLyricsSearchDialog),
                            _buildActionButton(Icons.translate, 'Terjemahkan', _showTranslateDialog),

                            // Group 3: Utility
                            _buildActionButton(Icons.camera_alt, 'Screenshot', () {
                               screenshotController.capture(delay: const Duration(milliseconds: 10)).then((capturedImage) async {
                                if (capturedImage != null) {
                                  final result = await ImageGallerySaver.saveImage(capturedImage);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['isSuccess'] ? 'Tangkapan layar disimpan' : 'Gagal menyimpan')));
                                }
                              });
                            }),
                            _buildActionButton(_note.isLocked ? Icons.lock : Icons.lock_open, 'Kunci', _showPasswordDialog),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: Text('Catatan ini terkunci.'),
            ),
    );
  }
}

class _LyricsSearchDialog extends StatefulWidget {
  const _LyricsSearchDialog({Key? key}) : super(key: key);

  @override
  __LyricsSearchDialogState createState() => __LyricsSearchDialogState();
}

class __LyricsSearchDialogState extends State<_LyricsSearchDialog> {
  final _searchController = TextEditingController();
  final _geniusService = GeniusService();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  void _search() async {
    if (_searchController.text.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final results = await _geniusService.search(_searchController.text);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cari Lirik di Genius'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Masukkan judul lagu...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final hit = _searchResults[index]['result'];
                    return ListTile(
                      title: Text(hit['full_title']),
                      onTap: () async {
                        final url = hit['url'];
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
