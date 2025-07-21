import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert';
import 'note_model.dart';

class VersionHistoryScreen extends StatelessWidget {
  final Note note;

  const VersionHistoryScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Versi'),
      ),
      body: ListView.builder(
        itemCount: note.versionHistory.length,
        itemBuilder: (context, index) {
          final versionContent = note.versionHistory[index];
          final doc = quill.Document.fromJson(jsonDecode(versionContent));
          final plainText = doc.toPlainText();

          return ListTile(
            title: Text('Versi ${index + 1}'),
            subtitle: Text(plainText, maxLines: 2, overflow: TextOverflow.ellipsis),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pulihkan Versi?'),
                    content: const Text('Apakah Anda yakin ingin memulihkan versi ini? Perubahan saat ini akan hilang.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, versionContent);
                        },
                        child: const Text('Pulihkan'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
