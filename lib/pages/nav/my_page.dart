import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_notepad_app/utils/user_util.dart';
import '../../routers/routes.dart';
import '../component/avatar_card.dart';
import '../component/item_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: AvatarCard(user: UserUtil.getUserInfo()),
          onTap: () {
            Navigator.pushNamed(context, Routes.myInfo);
          },
        ),
        GestureDetector(
          child: ItemCard(),
          onTap: () {
            UserUtil.logOut();
            Fluttertoast.showToast(
                msg: "登出成功！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushNamed(context, Routes.login);
          },
        ),
      ],
    );
  }
}
