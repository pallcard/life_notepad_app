import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        // color: Colors.blueGrey,
        child: Container(
          height: 80,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9'),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: const Text(
                      "设置",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: const Text(
                      "设置",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              // const Expanded(child: Text("")),
              // Container(
              //   margin: const EdgeInsets.only(right: 10),
              //   alignment: Alignment.center,
              //   child: const Icon(Icons.more_horiz),
              // ),
            ],
          ),
        ));
  }
}
