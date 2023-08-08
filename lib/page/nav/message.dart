import 'package:flutter/cupertino.dart';
import 'package:life_notepad_app/page/component/message_card.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int i) {
      return const MessageCard();
    });
  }
}
