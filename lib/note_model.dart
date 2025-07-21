class Note {
  String id;
  String content;

  Note({required this.id, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
    );
  }
}
