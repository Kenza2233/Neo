import 'package:flutter/material.dart';
import 'note_model.dart';

class DashboardScreen extends StatelessWidget {
  final Note note;

  const DashboardScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dasbor Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statistik untuk: ${note.content.substring(0, 20)}...'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Durasi Mengetik'),
              trailing: Text('${note.typingDuration} detik'),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Jumlah Kata'),
              trailing: Text('${note.wordCount}'),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Jumlah Dibuka'),
              trailing: Text('${note.openCount}'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text('Jumlah Hapus (Karakter)'),
              trailing: Text('${note.deleteCount}'),
            ),
          ],
        ),
      ),
    );
  }
}
