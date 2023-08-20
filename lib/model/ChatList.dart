import 'dart:convert';

/// Id : 1
/// SenderId : 1
/// SenderAvatar : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"
/// NickName : "小小"
/// Content : "搞事情呀"
/// IsLiked : 2
/// Unread : 1
/// CreateTime : "2023-08-20 17:21:46"

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));

String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    int? id,
    int? senderId,
    String? senderAvatar,
    String? nickName,
    String? content,
    int? isLiked,
    int? unread,
    String? createTime,}) {
    _id = id;
    _senderId = senderId;
    _senderAvatar = senderAvatar;
    _nickName = nickName;
    _content = content;
    _isLiked = isLiked;
    _unread = unread;
    _createTime = createTime;
  }

  ChatList.fromJson(dynamic json) {
    _id = json['Id'];
    _senderId = json['SenderId'];
    _senderAvatar = json['SenderAvatar'];
    _nickName = json['NickName'];
    _content = json['Content'];
    _isLiked = json['IsLiked'];
    _unread = json['Unread'];
    _createTime = json['CreateTime'];
  }

  int? _id;
  int? _senderId;
  String? _senderAvatar;
  String? _nickName;
  String? _content;
  int? _isLiked;
  int? _unread;
  String? _createTime;

  ChatList copyWith({ int? id,
    int? senderId,
    String? senderAvatar,
    String? nickName,
    String? content,
    int? isLiked,
    int? unread,
    String? createTime,
  }) =>
      ChatList(
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        senderAvatar: senderAvatar ?? _senderAvatar,
        nickName: nickName ?? _nickName,
        content: content ?? _content,
        isLiked: isLiked ?? _isLiked,
        unread: unread ?? _unread,
        createTime: createTime ?? _createTime,
      );

  int? get id => _id;

  int? get senderId => _senderId;

  String? get senderAvatar => _senderAvatar;

  String? get nickName => _nickName;

  String? get content => _content;

  int? get isLiked => _isLiked;

  int? get unread => _unread;

  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['SenderId'] = _senderId;
    map['SenderAvatar'] = _senderAvatar;
    map['NickName'] = _nickName;
    map['Content'] = _content;
    map['IsLiked'] = _isLiked;
    map['Unread'] = _unread;
    map['CreateTime'] = _createTime;
    return map;
  }

}