class Note {
  String id;
  String content;
  String? wallpaperPath;
  int typingDuration;
  int wordCount;
  int openCount;
  int deleteCount;
  String? audioPath;

  Note({
    required this.id,
    required this.content,
    this.wallpaperPath,
    this.typingDuration = 0,
    this.wordCount = 0,
    this.openCount = 0,
    this.deleteCount = 0,
    this.audioPath,
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
    );
  }
}
