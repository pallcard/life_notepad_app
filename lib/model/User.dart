import 'dart:convert';

/// UserId : 1
/// Avatar : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"
/// NickName : "开发者"
/// Description : "用爱发电的小程序开发者"
/// CreateTime : "2022-11-11 11:11:11"

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    int? userId,
    String? avatar,
    String? nickName,
    String? description,
    String? createTime,
  }) {
    _userId = userId;
    _avatar = avatar;
    _nickName = nickName;
    _description = description;
    _createTime = createTime;
  }

  User.fromJson(dynamic json) {
    _userId = json['UserId'];
    _avatar = json['Avatar'];
    _nickName = json['NickName'];
    _description = json['Description'];
    _createTime = json['CreateTime'];
  }

  int? _userId;
  String? _avatar;
  String? _nickName;
  String? _description;
  String? _createTime;

  User copyWith({
    int? userId,
    String? avatar,
    String? nickName,
    String? description,
    String? createTime,
  }) =>
      User(
        userId: userId ?? _userId,
        avatar: avatar ?? _avatar,
        nickName: nickName ?? _nickName,
        description: description ?? _description,
        createTime: createTime ?? _createTime,
      );

  int? get userId => _userId;

  String? get avatar => _avatar;

  String? get nickName => _nickName;

  String? get description => _description;

  String? get createTime => _createTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = _userId;
    map['Avatar'] = _avatar;
    map['NickName'] = _nickName;
    map['Description'] = _description;
    map['CreateTime'] = _createTime;
    return map;
  }
}
