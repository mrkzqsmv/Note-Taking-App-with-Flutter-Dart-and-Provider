import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider extends ChangeNotifier {
  // Variables
  final List<NoteModel> _notes = [];

  // Getters
  List<NoteModel> get notes => _notes;


  // Shared Preferences key
  static const String notesKey = 'notes';

  // Load Notes
  void loadNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? notesStringList = prefs.getStringList(notesKey);

    if (notesStringList != null) {
      _notes.clear();
      for (String noteString in notesStringList) {
        final NoteModel note = NoteModel.fromJson(noteString);
        _notes.add(note);
      }
      notifyListeners();
    }
  }

  // Add Note
  void addNote(NoteModel noteModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.add(noteModel);

    // Convert notes to a List of Strings before saving to SharedPreferences
    final List<String> notesStringList = _notes.map((note) => note.toJson()).toList();
    prefs.setStringList(notesKey, notesStringList);

    notifyListeners();
  }

  // Delete Note
  void deleteNote(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.removeAt(index);

    // Convert notes to a List of Strings before saving to SharedPreferences
    final List<String> notesStringList = _notes.map((note) => note.toJson()).toList();
    prefs.setStringList(notesKey, notesStringList);
    notifyListeners();
  }

  // Delete All Notes
  void deleteAllTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.clear();
    prefs.remove(notesKey);
    notifyListeners();
  }
}
