import 'package:flutter/cupertino.dart';

class NoteListProvide with ChangeNotifier {
  List noteList = [];

  void getNoteList(List list) {
    noteList = list;
    notifyListeners();
  }
}
