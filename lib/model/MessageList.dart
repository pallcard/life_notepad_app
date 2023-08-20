import 'dart:convert';

/// Id : 1
/// SenderId : 1
/// ReceiverId : 5
/// Content : "搞时间呀"
/// IsLiked : 2
/// Unread : 1
/// CreateTime : "2023-08-20 17:22:28"

MessageList messageListFromJson(String str) => MessageList.fromJson(json.decode(str));
String messageListToJson(MessageList data) => json.encode(data.toJson());
class MessageList {
  MessageList({
      num? id, 
      num? senderId, 
      num? receiverId, 
      String? content, 
      num? isLiked, 
      num? unread, 
      String? createTime,}){
    _id = id;
    _senderId = senderId;
    _receiverId = receiverId;
    _content = content;
    _isLiked = isLiked;
    _unread = unread;
    _createTime = createTime;
}

  MessageList.fromJson(dynamic json) {
    _id = json['Id'];
    _senderId = json['SenderId'];
    _receiverId = json['ReceiverId'];
    _content = json['Content'];
    _isLiked = json['IsLiked'];
    _unread = json['Unread'];
    _createTime = json['CreateTime'];
  }
  num? _id;
  num? _senderId;
  num? _receiverId;
  String? _content;
  num? _isLiked;
  num? _unread;
  String? _createTime;
MessageList copyWith({  num? id,
  num? senderId,
  num? receiverId,
  String? content,
  num? isLiked,
  num? unread,
  String? createTime,
}) => MessageList(  id: id ?? _id,
  senderId: senderId ?? _senderId,
  receiverId: receiverId ?? _receiverId,
  content: content ?? _content,
  isLiked: isLiked ?? _isLiked,
  unread: unread ?? _unread,
  createTime: createTime ?? _createTime,
);
  num? get id => _id;
  num? get senderId => _senderId;
  num? get receiverId => _receiverId;
  String? get content => _content;
  num? get isLiked => _isLiked;
  num? get unread => _unread;
  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['SenderId'] = _senderId;
    map['ReceiverId'] = _receiverId;
    map['Content'] = _content;
    map['IsLiked'] = _isLiked;
    map['Unread'] = _unread;
    map['CreateTime'] = _createTime;
    return map;
  }

}