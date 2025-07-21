import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note_editor_screen.dart';
import 'note_model.dart';
import 'layout_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'xml_exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'hub_screen.dart';

void main() {
  runApp(const NiTeApp());
}

class _NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const _NoteCard({required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Text(note.content, maxLines: 10, overflow: TextOverflow.ellipsis),
              if (note.isLocked)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.lock, size: 16, color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NiTeApp extends StatelessWidget {
  const NiTeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NiTe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> _notes = [];
  LayoutType _layoutType = LayoutType.gridTwoColumn;

  @override
  void initState() {
    super.initState();
    _loadNotesAndLayout();
  }

  Future<void> _loadNotesAndLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getStringList('notes') ?? [];
    final layoutIndex = prefs.getInt('layoutType') ?? 0;
    setState(() {
      _notes = notesData.map((noteData) => Note.fromMap(jsonDecode(noteData))).toList();
      _layoutType = LayoutType.values[layoutIndex];
    });
  }

  Future<void> _exportNotes() async {
    final xmlString = XmlExporter.toXml(_notes);
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/nite_notes.xml');
    await file.writeAsString(xmlString);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan diekspor ke ${file.path}')),
    );
  }

  Future<void> _importNotes() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xml'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final xmlString = await file.readAsString();
      final importedNotes = XmlExporter.fromXml(xmlString);
      // Di sini, Anda mungkin ingin menggabungkan catatan yang diimpor dengan yang sudah ada,
      // atau menimpa. Untuk kesederhanaan, kita akan menimpa.
      final prefs = await SharedPreferences.getInstance();
      final notesData = importedNotes.map((note) => jsonEncode(note.toMap())).toList();
      await prefs.setStringList('notes', notesData);
      _loadNotesAndLayout();
    }
  }

  Future<void> _saveLayout(LayoutType layoutType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('layoutType', layoutType.index);
    setState(() {
      _layoutType = layoutType;
    });
  }

  void _navigateToEditor({Note? note}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditorScreen(note: note)),
    );
    _loadNotesAndLayout();
  }

  Widget _buildNotesView() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _buildLayout(_layoutType),
    );
  }

  Widget _buildLayout(LayoutType layoutType) {
    switch (layoutType) {
      case LayoutType.gridTwoColumn:
        return GridView.builder(
          key: const ValueKey('gridTwo'),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: _notes.length,
          itemBuilder: (context, index) => _NoteCard(note: _notes[index], onTap: () => _navigateToEditor(note: _notes[index])),
        );
      case LayoutType.gridThreeColumn:
        return GridView.builder(
          key: const ValueKey('gridThree'),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: _notes.length,
          itemBuilder: (context, index) => _NoteCard(note: _notes[index], onTap: () => _navigateToEditor(note: _notes[index])),
        );
      case LayoutType.list:
        return ListView.builder(
          key: const ValueKey('list'),
          itemCount: _notes.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_notes[index].content, maxLines: 1, overflow: TextOverflow.ellipsis),
            onTap: () => _navigateToEditor(note: _notes[index]),
            trailing: _notes[index].isLocked ? const Icon(Icons.lock, size: 16) : null,
          ),
        );
      case LayoutType.listWithImage:
        // This would require more logic to extract the first image from the note content
        return ListView.builder(
          key: const ValueKey('listWithImage'),
          itemCount: _notes.length,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.image), // Placeholder
            title: Text(_notes[index].content, maxLines: 1, overflow: TextOverflow.ellipsis),
            onTap: () => _navigateToEditor(note: _notes[index]),
          ),
        );
      case LayoutType.staggered:
        return MasonryGridView.count(
          key: const ValueKey('staggered'),
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return _NoteCard(note: _notes[index], onTap: () => _navigateToEditor(note: _notes[index]));
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NiTe'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value is LayoutType) {
                _saveLayout(value);
              } else if (value == 'export') {
                _exportNotes();
              } else if (value == 'import') {
                _importNotes();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: LayoutType.gridTwoColumn,
                child: Text('Grid (2 Kolom)'),
              ),
              const PopupMenuItem(
                value: LayoutType.gridThreeColumn,
                child: Text('Grid (3 Kolom)'),
              ),
              const PopupMenuItem(
                value: LayoutType.list,
                child: Text('Daftar'),
              ),
              const PopupMenuItem(
                value: LayoutType.listWithImage,
                child: Text('Daftar dengan Gambar'),
              ),
              const PopupMenuItem(
                value: LayoutType.staggered,
                child: Text('Staggered'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'export',
                child: Text('Ekspor ke XML'),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Text('Impor dari XML'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('NiTe Hub', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Catatan Terarsip'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => HubScreen(notes: _notes)));
              },
            ),
          ],
        ),
      ),
      body: _buildNotesView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
