import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key});

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
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9'),
            ),
          ),
          const Text(
            "用爱发电的小程序开发者",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      )),
    );
  }
}
