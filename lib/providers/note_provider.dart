import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider extends ChangeNotifier {
  //variables
  final List _notes = [];

  //getters
  List get notes => _notes;

  //loadData
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> noteList = prefs.getStringList('_notes') ?? [];
    notifyListeners();
  }

  //addNote
  void addNote(NoteModel noteModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.add(noteModel);
    notifyListeners();
  }

  //deleteNote
  void deleteNote(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.removeAt(index);
    notifyListeners();
  }

  //deleteAllTasks
  void deleteAllTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.clear();
    prefs.clear();
    notifyListeners();
  }
}
