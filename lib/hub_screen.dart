import 'package:flutter/material.dart';
import 'note_model.dart';
import 'note_editor_screen.dart';

class HubScreen extends StatelessWidget {
  final List<Note> notes;

  const HubScreen({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort notes by creation date in descending order
    final sortedNotes = List<Note>.from(notes)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Terarsip'),
      ),
      body: ListView.builder(
        itemCount: sortedNotes.length,
        itemBuilder: (context, index) {
          final note = sortedNotes[index];
          return ListTile(
            title: Text(note.content, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('Dibuat pada: ${note.createdAt.toLocal()}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteEditorScreen(note: note)),
              );
            },
          );
        },
      ),
    );
  }
}
