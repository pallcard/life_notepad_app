import 'dart:convert';
import 'MessageList.dart';

/// MessageList : [{"Id":1,"SenderId":1,"ReceiverId":5,"Content":"搞时间呀","IsLiked":2,"Unread":1,"CreateTime":"2023-08-20 17:22:28"}]
/// Total : 1

MessageListRes messageListResFromJson(String str) =>
    MessageListRes.fromJson(json.decode(str));

String messageListResToJson(MessageListRes data) => json.encode(data.toJson());

class MessageListRes {
  MessageListRes({
    List<MessageList>? messageList,
    num? total,
  }) {
    _messageList = messageList;
    _total = total;
  }

  MessageListRes.fromJson(dynamic json) {
    if (json['MessageList'] != null) {
      _messageList = [];
      json['MessageList'].forEach((v) {
        _messageList?.add(MessageList.fromJson(v));
      });
    }
    _total = json['Total'];
  }

  List<MessageList>? _messageList;
  num? _total;

  MessageListRes copyWith({
    List<MessageList>? messageList,
    num? total,
  }) =>
      MessageListRes(
        messageList: messageList ?? _messageList,
        total: total ?? _total,
      );

  List<MessageList>? get messageList => _messageList;

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messageList != null) {
      map['MessageList'] = _messageList?.map((v) => v.toJson()).toList();
    }
    map['Total'] = _total;
    return map;
  }
}
