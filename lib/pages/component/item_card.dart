import 'package:flutter/material.dart';

// class ItemData {
//   ItemData({
//     Icon? icon,
//     String? label,
//   }) {
//     icon = icon;
//     label = label;
//   }
//
//   late Icon icon;
//   late String label;
// }

class ItemCard extends StatelessWidget {
  const ItemCard({super.key});

  // final ItemData item;

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
                child: Icon(Icons.logout),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("登出"),
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
