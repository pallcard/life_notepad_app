import 'dart:convert';

/// Id : 1
/// SenderId : 1
/// ReceiverId : 5
/// Content : "搞时间呀"
/// Link : 2
/// Unread : 1
/// CreateTime : "2023-08-20 17:22:28"

MessageList messageListFromJson(String str) =>
    MessageList.fromJson(json.decode(str));

String messageListToJson(MessageList data) => json.encode(data.toJson());

class MessageList {
  MessageList({
    int? id,
    int? senderId,
    int? receiverId,
    String? content,
    int? link,
    int? unread,
    String? createTime,
  }) {
    _id = id;
    _senderId = senderId;
    _receiverId = receiverId;
    _content = content;
    _link = link;
    _unread = unread;
    _createTime = createTime;
  }

  MessageList.fromJson(dynamic json) {
    _id = json['Id'];
    _senderId = json['SenderId'];
    _receiverId = json['ReceiverId'];
    _content = json['Content'];
    _link = json['Link'];
    _unread = json['Unread'];
    _createTime = json['CreateTime'];
  }

  int? _id;
  int? _senderId;
  int? _receiverId;
  String? _content;
  int? _link;
  int? _unread;
  String? _createTime;

  MessageList copyWith({
    int? id,
    int? senderId,
    int? receiverId,
    String? content,
    int? link,
    int? unread,
    String? createTime,
  }) =>
      MessageList(
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        receiverId: receiverId ?? _receiverId,
        content: content ?? _content,
        link: link ?? _link,
        unread: unread ?? _unread,
        createTime: createTime ?? _createTime,
      );

  int? get id => _id;

  int? get senderId => _senderId;

  int? get receiverId => _receiverId;

  String? get content => _content;

  int? get link => _link;

  int? get unread => _unread;

  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['SenderId'] = _senderId;
    map['ReceiverId'] = _receiverId;
    map['Content'] = _content;
    map['Link'] = _link;
    map['Unread'] = _unread;
    map['CreateTime'] = _createTime;
    return map;
  }
}
