import 'dart:convert';

import 'package:planner/modules/notes_module/data/note_model.dart';
import 'package:planner/modules/user_module/data/user_model.dart';

class Task {
  String? title;
  int? durationseconds;
  List<Note>? taskNotes;
  List<int>? sharedWith;
  List<int>? editableWith;
  int? owner;
  bool? withNotification;
  DateTime? selectedDay;
  String? repeated;
  List<Comment>? comments;
  bool? isDone;
}

class Comment {
  int? writerId;
  String? comment;
}

class Category {
  int? id;
  List<Task>? tasks;
  String? icon;
  String? name;
  List<Note>? notes;
  List<Subcategory>? subcategories; // List of Subcategory objects

  Category({
    this.id,
    this.icon,
    this.name,
    this.notes,
    this.subcategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'notes': notes?.map((x) => x?.toMap())?.toList(),
      'subcategories': subcategories?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toInt(),
      icon: map['icon'],
      name: map['name'],
      notes: map['notes'] != null
          ? List<Note>.from(map['notes']?.map((x) => Note.fromMap(x)))
          : null,
      subcategories: map['subcategories'] != null
          ? List<Subcategory>.from(
              map['subcategories']?.map((x) => Subcategory.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}

class Subcategory {
  int? id;
  String? name;
  List<Note>? notes;

  Subcategory({this.id, this.name, this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'notes': notes?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Subcategory.fromMap(Map<String, dynamic> map) {
    return Subcategory(
      id: map['id']?.toInt(),
      name: map['name'],
      notes: map['notes'] != null
          ? List<Note>.from(map['notes']?.map((x) => Note.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subcategory.fromJson(String source) =>
      Subcategory.fromMap(json.decode(source));
}
