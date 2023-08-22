import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/contant.dart';
import '../../config/service_url.dart';
import '../../model/MessageList.dart';
import '../../model/MessageListRes.dart';
import '../../model/WsData.dart';
import '../../service/service_method.dart';
import '../../utils/user_util.dart';
import 'package:web_socket_channel/io.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late String senderId;
  late String receiverId;
  int pageNum = 1;
  int pageSize = 10;
  final List<MessageList> _messageList = [];
  final TextEditingController _contentController = TextEditingController();
  late EasyRefreshController _easyRefreshController;
  IOWebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    _connect();
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

  void _connect() {
    _channel = IOWebSocketChannel.connect(
        "${Constant.serviceWsUrl}/chat/web-socket?userId=${UserUtil.getUserInfo().userId}");
    _channel?.stream.listen((message) {
      var wsData = WsData.fromJson(message);
      var link = 2;
      var content = "";
      if (wsData.data!.startsWith("[link]")) {
        link = 1;
        content = wsData.data!.replaceFirst("[link]", "");
      }
      setState(() {
        _messageList.insert(
            0,
            MessageList(
                senderId: int.parse(wsData.senderId ?? ""),
                receiverId: int.parse(wsData.receiverId ?? ""),
                link: link,
                content: content,
                createTime: wsData.createTime,
                unread: 2));
      });
    });
  }

  void _sendMessage() {
    var text = _contentController.text;
    if (text.isNotEmpty) {
      _channel?.sink.add(WsData(
        type: "single",
        data: text,
        senderId: "${UserUtil.getUserInfo().userId}",
        receiverId: "1",
      ).toString());
      setState(() {
        _messageList.insert(
            0,
            MessageList(
                senderId: 5,
                receiverId: 1,
                link: 2,
                content: text,
                createTime:
                    DateTime.now().toLocal().toString().substring(0, 19),
                unread: 2));
      });
      _contentController.clear();
    }
  }

  _buildMessage(MessageList message) {
    var isMe = message.senderId == UserUtil.getUserInfo().userId;
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(top: 8, bottom: 8, left: 80)
          : EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: isMe ? Colors.lightBlueAccent : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.createTime ?? "",
            style: TextStyle(
                color: isMe ? Colors.black : Colors.blueGrey,
                fontSize: 8,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            message.content ?? "",
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: isMe ? Colors.black : Colors.blueGrey, fontSize: 15),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "发送图片尽请期待",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
          ),
          Expanded(
            child: TextField(
              controller: _contentController,
              decoration: const InputDecoration(hintText: "发送一条消息吧！"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _sendMessage();
            },
          )
        ],
      ),
    );
  }

  Future _getMessageList(BuildContext context) async {
    var params = {
      'PageNum': pageNum,
      'PageSize': pageSize,
      'SenderId': senderId,
      'ReceiverId': receiverId,
    };
    var val = await request(context, ServiceUrl.messageList, params: params);

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
    /*获取传递过来的参数*/
    Map? args = ModalRoute.of(context)?.settings.arguments as Map?;
    senderId = args?["senderId"];
    receiverId = args?["receiverId"];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          UserUtil.getUserInfo().nickName ?? "",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: FutureBuilder(
                    future: _getMessageList(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (_messageList.isEmpty) {
                          pageNum++;
                          var newMessageListRes =
                              MessageListRes.fromJson(snapshot.data);
                          for (int i = 0;
                              i < newMessageListRes.messageList!.length;
                              i++) {
                            _messageList.add(newMessageListRes.messageList![i]);
                          }
                        }
                        return EasyRefresh(
                            controller: _easyRefreshController,
                            header: const ClassicHeader(
                              noMoreText: "我也是有底线的",
                              messageText: '最后更新于%T',
                            ),
                            // onRefresh: () async {
                            //   print('开始加载更多222${pageNum}');
                            // },
                            onLoad: () async {
                              print('开始加载更多${pageNum}');
                              var params = {
                                'PageNum': pageNum,
                                'PageSize': pageSize,
                                'SenderId': senderId,
                                'ReceiverId': receiverId,
                              };
                              await request(context, ServiceUrl.messageList,
                                      params: params)
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
                                  var newMessageListRes =
                                      MessageListRes.fromJson(val["data"]);
                                  if (newMessageListRes
                                      .messageList!.isNotEmpty) {
                                    pageNum++;
                                    setState(() {
                                      for (int i = 0;
                                          i <
                                              newMessageListRes
                                                  .messageList!.length;
                                          i++) {
                                        _messageList.add(
                                            newMessageListRes.messageList![i]);
                                      }
                                    });
                                    print("load ...");
                                    _easyRefreshController
                                        .finishLoad(IndicatorResult.success);
                                  } else {
                                    print("load over");
                                    _easyRefreshController
                                        .finishLoad(IndicatorResult.noMore);
                                  }
                                }
                              });
                            },
                            child: ListView.builder(
                                reverse: true,
                                padding: const EdgeInsets.only(top: 15),
                                itemCount: _messageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildMessage(_messageList[index]);
                                }));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer()
          ],
        ),
      ),
    );
  }
}
