import 'dart:convert';

import 'ChatList.dart';

/// ChatList : [{"Id":1,"SenderId":1,"SenderAvatar":"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9","NickName":"小小","Content":"搞事情呀","IsLiked":2,"Unread":1,"CreateTime":"2023-08-20 17:21:46"}]
/// Total : 1

ChatListRes chatListResFromJson(String str) =>
    ChatListRes.fromJson(json.decode(str));

String chatListResToJson(ChatListRes data) => json.encode(data.toJson());

class ChatListRes {
  ChatListRes({
    List<ChatList>? chatList,
    num? total,
  }) {
    _chatList = chatList;
    _total = total;
  }

  ChatListRes.fromJson(dynamic json) {
    if (json['ChatList'] != null) {
      _chatList = [];
      json['ChatList'].forEach((v) {
        _chatList?.add(ChatList.fromJson(v));
      });
    }
    _total = json['Total'];
  }

  List<ChatList>? _chatList;
  num? _total;

  ChatListRes copyWith({
    List<ChatList>? chatList,
    num? total,
  }) =>
      ChatListRes(
        chatList: chatList ?? _chatList,
        total: total ?? _total,
      );

  List<ChatList>? get chatList => _chatList;

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_chatList != null) {
      map['ChatList'] = _chatList?.map((v) => v.toJson()).toList();
    }
    map['Total'] = _total;
    return map;
  }
}
