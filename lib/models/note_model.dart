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

  @override
  String toString() {
    return 'title: $title, description: $description id: $id, date: ${date.toUtc()}';
  }
}
