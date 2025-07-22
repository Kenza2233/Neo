import 'package:xml/xml.dart';
import 'note_model.dart';
import 'dart:convert';

class XmlExporter {
  static String toXml(List<Note> notes) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('notes', nest: () {
      for (final note in notes) {
        builder.element('note', nest: () {
          builder.element('id', nest: note.id);
          builder.element('content', nest: note.content);
          if (note.wallpaperPath != null) {
            builder.element('wallpaperPath', nest: note.wallpaperPath);
          }
          // ... tambahkan bidang lain di sini
        });
      }
    });
    return builder.buildDocument().toXmlString(pretty: true);
  }

  static List<Note> fromXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final notes = <Note>[];
    final noteElements = document.findAllElements('note');
    for (final noteElement in noteElements) {
      final id = noteElement.findElements('id').single.text;
      final content = noteElement.findElements('content').single.text;
      final wallpaperPath = noteElement.findElements('wallpaperPath').firstOrNull?.text;
      // ... ekstrak bidang lain di sini

      // Membuat objek Note baru. Perhatikan bahwa beberapa bidang mungkin memerlukan nilai default
      // jika tidak ada di XML.
      notes.add(Note(
        id: id,
        content: content,
        wallpaperPath: wallpaperPath,
        // ... inisialisasi bidang lain di sini
      ));
    }
    return notes;
  }
}
