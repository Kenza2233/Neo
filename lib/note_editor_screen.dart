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

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

import 'dart:async';

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _textController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _note = widget.note ?? Note(id: DateTime.now().toIso8601String(), content: '');
    _note.openCount++;
    _textController.text = _note.content;
    _wallpaperPath = _note.wallpaperPath;
    _previousText = _note.content;

    _textController.addListener(_onTextChanged);
    _startTypingTimer();
    _initSound();
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

  void _onTextChanged() {
    final currentText = _textController.text;
    if (currentText.length < _previousText.length) {
      _deleteCount++;
    }
    _previousText = currentText;

    setState(() {
      _note.wordCount = currentText.split(' ').where((s) => s.isNotEmpty).length;
    });
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
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _recorder?.closeRecorder();
    _player?.closePlayer();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    _note.content = _textController.text;
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
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveNote();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
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
                // Placeholder for toolbar
                Container(
                  height: 50,
                  color: Colors.grey[200]?.withOpacity(0.5),
                  child: const Center(child: Text('Toolbar Placeholder')),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(backgroundColor: Colors.white.withOpacity(0.5)),
                    decoration: const InputDecoration(
                      hintText: 'Mulai menulis...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Placeholder for color palette
                Container(
                  height: 50,
                  color: Colors.grey[200]?.withOpacity(0.5),
                  child: const Center(child: Text('Color Palette Placeholder')),
                ),
                const SizedBox(height: 16),
                // Placeholder for action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.videocam),
                      onPressed: () {
                        // Implement video to GIF
                      },
                    ),
                    IconButton(
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  onPressed: _toggleRecording,
                    ),
                if (_note.audioPath != null)
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                    onPressed: _togglePlaying,
                  ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _pickImage,
                    ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    screenshotController
                        .capture(delay: const Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      if (capturedImage != null) {
                        final result = await ImageGallerySaver.saveImage(capturedImage);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result['isSuccess'] ? 'Tangkapan layar disimpan ke galeri' : 'Gagal menyimpan tangkapan layar'),
                          ),
                        );
                      }
                    });
                  },
                ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
