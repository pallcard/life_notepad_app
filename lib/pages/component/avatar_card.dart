import 'package:flutter/material.dart';
import 'package:life_notepad_app/model/User.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user.avatar ?? "",
              ),
            ),
          ),
          Column(
            children: [
              Text(
                user.nickName ?? "",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                user.description ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
