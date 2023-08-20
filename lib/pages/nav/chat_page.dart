import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_notepad_app/model/ChatListRes.dart';
import '../../config/service_url.dart';
import '../../model/ChatList.dart';
import '../../routers/routes.dart';
import '../../service/service_method.dart';
import '../../utils/user_util.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  int pageNum = 1;
  int pageSize = 5;
  List<ChatList> _chatList = [];
  late EasyRefreshController _easyRefreshController;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  Future _getChatList(BuildContext context) async {
    var params = {
      'PageNum': pageNum,
      'PageSize': pageSize,
      'UserId': UserUtil
          .getUserInfo()
          .userId,
    };
    var val = await request(context, ServiceUrl.chatList, params: params);

    if (val["code"] != 0) {
      Fluttertoast.showToast(
          msg: '${val["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    } else {
      // print(val["data"]);
      return val["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChatList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (_chatList.isEmpty) {
            pageNum++;
            var newChatListRes = ChatListRes.fromJson(snapshot.data);
            for (int i = 0; i < newChatListRes.chatList!.length; i++) {
              _chatList.add(newChatListRes.chatList![i]);
            }
          }
          return EasyRefresh(
            controller: _easyRefreshController,
            header: MaterialHeader(),
            footer: const ClassicFooter(
              noMoreText: "我也是有底线的",
              messageText: '最后更新于%T',
            ),
            onLoad: () async {
              print('开始加载更多${pageNum}');
              var params = {'PageNum': pageNum, 'PageSize': pageSize};
              await request(context, ServiceUrl.chatList, params: params)
                  .then((val) {
                if (val["code"] != 0) {
                  Fluttertoast.showToast(
                      msg: '${val["message"]}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return null;
                } else {
                  var newChatListRes = ChatListRes.fromJson(val["data"]);
                  if (newChatListRes.chatList!.isNotEmpty) {
                    pageNum++;
                    setState(() {
                      for (int i = 0;
                      i < newChatListRes.chatList!.length;
                      i++) {
                        _chatList.add(newChatListRes.chatList![i]);
                      }
                    });
                    print("load ...");
                    _easyRefreshController.finishLoad(IndicatorResult.success);
                  } else {
                    print("load over");
                    _easyRefreshController.finishLoad(IndicatorResult.noMore);
                  }
                }
              });
            },
            onRefresh: () async {
              pageNum = 1;
              var params = {'PageNum': pageNum, 'PageSize': pageSize};
              await request(context, ServiceUrl.noteList, params: params)
                  .then((val) {
                if (val["code"] != 0) {
                  Fluttertoast.showToast(
                      msg: '${val["message"]}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  return null;
                } else {
                  var newChatListRes = ChatListRes.fromJson(val["data"]);
                  setState(() {
                    _chatList = newChatListRes.chatList!;
                    pageNum++;
                  });
                  _easyRefreshController.finishRefresh();
                  _easyRefreshController.resetFooter();
                }
              });
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _chatList.length,
                itemBuilder: (BuildContext context, int i) {
                  String unreadStr = "";
                  if (_chatList[i].unread! >= 100) {
                    unreadStr = "99+";
                  } else if (_chatList[i].unread! > 0) {
                    unreadStr = "${_chatList[i].unread!}";
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.message);
                    },
                    child: Container(
                      height: 90,
                      margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: _chatList[i].unread != null
                              ? const Color(0xFFFFEFEE)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    _chatList[i].senderAvatar ?? ""),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      _chatList[i].nickName ?? "",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.45,
                                    child: Text(
                                      _chatList[i].content ?? "",
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  _chatList[i].createTime?.substring(11) ?? "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),),
                              const SizedBox(
                                height: 5,
                              ),
                              unreadStr != ""
                                  ? Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                child: Text(
                                  unreadStr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              )
                                  : const Text(''),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
