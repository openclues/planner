import 'dart:convert';

class Note {
  String? title;
  String? description;
  int? id;
  Note({
    this.title,
    this.description,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'id': id,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
      id: map['id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}
