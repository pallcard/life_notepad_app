import 'package:flutter/cupertino.dart';

class NoteListProvider with ChangeNotifier {
  List noteList = [];

  void getNoteList(List list) {
    noteList = list;
    notifyListeners();
  }
}
