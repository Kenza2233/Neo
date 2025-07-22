import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class ConversionService {
  // --- Number System Conversions ---

  String? convertBase(String fromValue, int fromBase, int toBase) {
    try {
      final intValue = int.parse(fromValue, radix: fromBase);
      return intValue.toRadixString(toBase);
    } catch (e) {
      return null; // Invalid input
    }
  }

  // --- Character Encoding ---

  String textToAscii(String text) {
    try {
      return ascii.encode(text).join(' ');
    } catch (e) {
      return 'Error: Mengandung karakter non-ASCII';
    }
  }

  String asciiToText(String asciiCodes) {
    try {
      final codes = asciiCodes.split(' ').map(int.parse).toList();
      return ascii.decode(codes);
    } catch (e) {
      return 'Error: Kode ASCII tidak valid';
    }
  }

  String textToUnicode(String text) {
    // UTF-8 is the default in Dart, so this is more about showing the code points.
    return text.runes.map((rune) => 'U+${rune.toRadixString(16).padLeft(4, '0')}').join(' ');
  }

  String unicodeToText(String unicodePoints) {
    try {
      final points = unicodePoints.split(' ').map((p) => int.parse(p.replaceFirst('U+', ''), radix: 16));
      return String.fromCharCodes(points);
    } catch (e) {
      return 'Error: Poin Unicode tidak valid';
    }
  }

  // --- Encryption/Decryption ---

  // WARNING: In a real app, do not hardcode keys or IVs.
  // They should be securely generated and managed.
  static final _key = Key.fromUtf8('my32lengthsupersecretnooneknows1'); // Must be 32 chars
  static final _iv = IV.fromLength(16); // IV for AES

  String encryptAES(String text) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  String decryptAES(String encryptedText) {
    try {
      final encrypter = Encrypter(AES(_key));
      final decrypted = encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: _iv);
      return decrypted;
    } catch (e) {
      return 'Error: Gagal mendekripsi. Teks atau kunci tidak valid.';
    }
  }
}
