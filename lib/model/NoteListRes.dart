import 'dart:convert';
/// NoteList : [{"Avatar":"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9","NickName":"用爱发电的小程序开发者","CreateTime":"2022-11-11 11:11:11","Content":"内容0","Images":["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"],"Location":"湖北武汉"}]
/// Total : 14

NoteListRes noteListResFromJson(String str) => NoteListRes.fromJson(json.decode(str));
String noteListResToJson(NoteListRes data) => json.encode(data.toJson());
class NoteListRes {
  NoteListRes({
      List<NoteList>? noteList, 
      num? total,}){
    _noteList = noteList;
    _total = total;
}

  NoteListRes.fromJson(dynamic json) {
    if (json['NoteList'] != null) {
      _noteList = [];
      json['NoteList'].forEach((v) {
        _noteList?.add(NoteList.fromJson(v));
      });
    }
    _total = json['Total'];
  }
  List<NoteList>? _noteList;
  num? _total;
NoteListRes copyWith({  List<NoteList>? noteList,
  num? total,
}) => NoteListRes(  noteList: noteList ?? _noteList,
  total: total ?? _total,
);
  List<NoteList>? get noteList => _noteList;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_noteList != null) {
      map['NoteList'] = _noteList?.map((v) => v.toJson()).toList();
    }
    map['Total'] = _total;
    return map;
  }

}

/// Avatar : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"
/// NickName : "用爱发电的小程序开发者"
/// CreateTime : "2022-11-11 11:11:11"
/// Content : "内容0"
/// Images : ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"]
/// Location : "湖北武汉"

NoteList noteListFromJson(String str) => NoteList.fromJson(json.decode(str));
String noteListToJson(NoteList data) => json.encode(data.toJson());
class NoteList {
  NoteList({
      String? avatar, 
      String? nickName, 
      String? createTime, 
      String? content, 
      List<String>? images, 
      String? location,}){
    _avatar = avatar;
    _nickName = nickName;
    _createTime = createTime;
    _content = content;
    _images = images;
    _location = location;
}

  NoteList.fromJson(dynamic json) {
    _avatar = json['Avatar'];
    _nickName = json['NickName'];
    _createTime = json['CreateTime'];
    _content = json['Content'];
    _images = json['Images'] != null ? json['Images'].cast<String>() : [];
    _location = json['Location'];
  }
  String? _avatar;
  String? _nickName;
  String? _createTime;
  String? _content;
  List<String>? _images;
  String? _location;
NoteList copyWith({  String? avatar,
  String? nickName,
  String? createTime,
  String? content,
  List<String>? images,
  String? location,
}) => NoteList(  avatar: avatar ?? _avatar,
  nickName: nickName ?? _nickName,
  createTime: createTime ?? _createTime,
  content: content ?? _content,
  images: images ?? _images,
  location: location ?? _location,
);
  String? get avatar => _avatar;
  String? get nickName => _nickName;
  String? get createTime => _createTime;
  String? get content => _content;
  List<String>? get images => _images;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Avatar'] = _avatar;
    map['NickName'] = _nickName;
    map['CreateTime'] = _createTime;
    map['Content'] = _content;
    map['Images'] = _images;
    map['Location'] = _location;
    return map;
  }

}