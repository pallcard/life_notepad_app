import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard({super.key});

  // final ItemData item;
  final String _InfoLabel = "";
  final Widget widget = Container(
    child: Text(""),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        // color: Colors.blueGrey,
        child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(_InfoLabel),
              ),
              const Expanded(child: Text("")),
              Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: widget,
              ),
            ],
          ),
        ));
  }
}
