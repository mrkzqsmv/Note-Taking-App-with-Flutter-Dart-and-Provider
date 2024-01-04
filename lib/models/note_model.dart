// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoteModel {
  final String title;
  final String description;
  final String id;
  final DateTime date;

  NoteModel({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
  });

  NoteModel copyWith({
    String? title,
    String? description,
    String? id,
    DateTime? date,
  }) {
    return NoteModel(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'title: $title, description: $description id: $id, date: ${date.toUtc()}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'id': id,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
