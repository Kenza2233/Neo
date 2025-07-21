import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'note_editor_screen.dart';
import 'note_model.dart';
import 'layout_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          PopupMenuButton<LayoutType>(
            onSelected: _saveLayout,
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
      body: _buildNotesView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
