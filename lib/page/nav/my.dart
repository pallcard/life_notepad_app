import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/avatar_card.dart';
import '../component/item_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AvatarCard(),
        ItemCard(),
      ],
    );
  }
}
