import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

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
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const Icon(Icons.settings),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text("设置"),
              ),
              const Expanded(child: Text("")),
              Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ));
  }
}
