class Note {
  String id;
  String content;
  String? wallpaperPath;

  Note({required this.id, required this.content, this.wallpaperPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'wallpaperPath': wallpaperPath,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      wallpaperPath: map['wallpaperPath'],
    );
  }
}
