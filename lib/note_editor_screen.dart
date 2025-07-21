import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _textController = TextEditingController();
  String? _wallpaperPath;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _textController.text = widget.note!.content;
      _wallpaperPath = widget.note!.wallpaperPath;
    }
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

  Future<void> _saveNote() async {
    final prefs = await SharedPreferences.getInstance();
    final newNote = Note(
      id: widget.note?.id ?? DateTime.now().toIso8601String(),
      content: _textController.text,
      wallpaperPath: _wallpaperPath,
    );
    final notes = prefs.getStringList('notes') ?? [];
    final noteIndex = notes.indexWhere((note) => Note.fromMap(jsonDecode(note)).id == newNote.id);
    if (noteIndex != -1) {
      notes[noteIndex] = jsonEncode(newNote.toMap());
    } else {
      notes.add(jsonEncode(newNote.toMap()));
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
                      icon: const Icon(Icons.mic),
                      onPressed: () {
                        // Implement voice to text
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _pickImage,
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
