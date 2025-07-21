import 'package:crypto/crypto.dart';
import 'dart:convert';

class Note {
  String id;
  String content; // Will store Quill's Delta as a JSON string
  String? wallpaperPath;
  int typingDuration;
  int wordCount;
  int openCount;
  int deleteCount;
  String? audioPath;
  bool isLocked;
  String? passwordHash;

  int textColor;

  Note({
    required this.id,
    required this.content,
    this.wallpaperPath,
    this.typingDuration = 0,
    this.wordCount = 0,
    this.openCount = 0,
    this.deleteCount = 0,
    this.audioPath,
    this.isLocked = false,
    this.passwordHash,
    this.textColor = 0xFF000000, // Default to black
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'wallpaperPath': wallpaperPath,
      'typingDuration': typingDuration,
      'wordCount': wordCount,
      'openCount': openCount,
      'deleteCount': deleteCount,
      'audioPath': audioPath,
      'isLocked': isLocked,
      'passwordHash': passwordHash,
      'textColor': textColor,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      wallpaperPath: map['wallpaperPath'],
      typingDuration: map['typingDuration'] ?? 0,
      wordCount: map['wordCount'] ?? 0,
      openCount: map['openCount'] ?? 0,
      deleteCount: map['deleteCount'] ?? 0,
      audioPath: map['audioPath'],
      isLocked: map['isLocked'] ?? false,
      passwordHash: map['passwordHash'],
      textColor: map['textColor'] ?? 0xFF000000,
    );
  }

  void setPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    passwordHash = digest.toString();
  }

  bool checkPassword(String password) {
    if (passwordHash == null) return false;
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString() == passwordHash;
  }
}
