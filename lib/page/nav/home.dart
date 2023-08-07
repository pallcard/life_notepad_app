import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_notepad_app/page/component/NotepadCard.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    ListView.builder(
    itemBuilder: (BuildContext context, int i) {
      return NotepadCard();
    }),
        FloatingActionButton( child: const Icon(Icons.add),onPressed: () { print("ssss"); },)
      ],
    );

  }
}
