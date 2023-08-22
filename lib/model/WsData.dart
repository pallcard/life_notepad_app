import 'dart:convert';

/// type : "single"
/// data : "hello123243"
/// sender_id : "1"
/// receiver_id : "5"
/// create_time : "2023-1-1"

WsData wsDataFromJson(String str) => WsData.fromJson(json.decode(str));

String wsDataToJson(WsData data) => json.encode(data.toJson());

class WsData {
  WsData({
    String? type,
    String? data,
    String? senderId,
    String? receiverId,
    String? createTime,
  }) {
    _type = type;
    _data = data;
    _senderId = senderId;
    _receiverId = receiverId;
    _createTime = createTime;
  }

  WsData.fromJson(dynamic json) {
    _type = json['type'];
    _data = json['data'];
    _senderId = json['sender_id'];
    _receiverId = json['receiver_id'];
    _createTime = json['create_time'];
  }

  String? _type;
  String? _data;
  String? _senderId;
  String? _receiverId;
  String? _createTime;

  WsData copyWith({
    String? type,
    String? data,
    String? senderId,
    String? receiverId,
    String? createTime,
  }) =>
      WsData(
        type: type ?? _type,
        data: data ?? _data,
        senderId: senderId ?? _senderId,
        receiverId: receiverId ?? _receiverId,
        createTime: createTime ?? _createTime,
      );

  String? get type => _type;

  String? get data => _data;

  String? get senderId => _senderId;

  String? get receiverId => _receiverId;

  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['data'] = _data;
    map['sender_id'] = _senderId;
    map['receiver_id'] = _receiverId;
    map['create_time'] = _createTime;
    return map;
  }

  @override
  String toString() {
    return '{"type": "$_type", "data": "$_data", "sender_id": "$_senderId", "receiver_id": "$_receiverId", "create_time": "$_createTime"}';
  }
}
