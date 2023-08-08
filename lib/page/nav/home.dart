import 'package:flutter/material.dart';
import 'package:life_notepad_app/page/component/notepad_card.dart';

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
        ListView.builder(itemBuilder: (BuildContext context, int i) {
          return NotepadCard();
        }),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: FloatingActionButton(
            // tooltip: "快新增一条吧！",
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            elevation: 6.0,
            highlightElevation: 12.0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
            onPressed: () {
              print("ssss");
            },
          ),
        )
      ],
    );
  }
}
