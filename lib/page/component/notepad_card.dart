import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:life_notepad_app/model/NoteItem.dart';

class NotepadCard extends StatelessWidget {
  const NotepadCard({super.key});

  // late String avatar;
  // late String nickName;
  // late String createTime;
  // late String content;
  // late List<String> images;
  // late String location;

  Future<NoteItem> mockNetworkData() async {
    Dio dio = Dio();
    Response response = await dio.get("http://127.0.0.1:8000/user");
    if (response.statusCode == HttpStatus.ok) {
      print(response.headers);
      print(response.data);
    }
    print(response);
    return NoteItem.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    var images = [
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9",
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9",
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9",
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9",
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9",
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: FutureBuilder<NoteItem>(
          future: mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot<NoteItem> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Image(
                            image: NetworkImage(
                              snapshot.data!.avatar ?? "",
                              // "${snapshot.data.avatar}"
                            ),
                          ),
                        ),
                        Text(
                          snapshot.data!.nickName ?? "",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        snapshot.data!.content ?? "",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.images?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3,
                                  childAspectRatio: 1.0),
                          itemBuilder: (BuildContext context, int position) {
                            return Container(
                              padding: EdgeInsets.all(8),
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data!.images![position]),
                              ),
                            );
                          }),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        snapshot.data!.createTime ?? "",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Text(
                        snapshot.data!.location ?? "",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),

        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         Container(
        //           width: 50,
        //           height: 50,
        //           padding: const EdgeInsets.all(8),
        //           child: const Image(
        //             image: NetworkImage(
        //                 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9'),
        //           ),
        //         ),
        //         const Text(
        //           "用爱发电的小程序开发者",
        //           style: TextStyle(
        //             fontSize: 12,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Container(
        //       alignment: Alignment.centerLeft,
        //       padding: const EdgeInsets.all(8),
        //       child: const Text(
        //         "对研究经济学的学者来讲，2003年以来中国经济出现了许多不容易理解的现象。从2003年开始中国的经济连续4年平均每年的增长",
        //         style: TextStyle(
        //           fontSize: 15,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       child: GridView.builder(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemCount: images.length,
        //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 3,
        //               mainAxisSpacing: 3,
        //               childAspectRatio: 1.0),
        //           itemBuilder: (BuildContext context, int position) {
        //             return Container(
        //               padding: EdgeInsets.all(8),
        //               child: Image(
        //                 image: NetworkImage(
        //                     'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9'),
        //               ),
        //             );
        //           }),
        //     ),
        //     Container(
        //       alignment: Alignment.centerLeft,
        //       padding: const EdgeInsets.only(left: 8),
        //       child: const Text(
        //         "2022-11-11 11:11:11",
        //         style: TextStyle(
        //           fontSize: 10,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       alignment: Alignment.centerLeft,
        //       padding: const EdgeInsets.only(left: 8, bottom: 8),
        //       child: const Text(
        //         "湖北武汉",
        //         style: TextStyle(
        //           fontSize: 10,
        //         ),
        //       ),
        //     ),
        //   ],
        // )),
      ),
    );
  }
}
