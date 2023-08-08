/// Avatar : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"
/// NickName : "用爱发电的小程序开发者"
/// CreateTime : "2022-11-11 11:11:11"
/// Content : "对研究经济学的学者来讲，2003年以来中国经济出现了许多不容易  理解的现象。"
/// Images : ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9","https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9"]
/// Location : "湖北武汉"

class NoteItem {
  NoteItem({
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

  NoteItem.fromJson(dynamic json) {
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
NoteItem copyWith({  String? avatar,
  String? nickName,
  String? createTime,
  String? content,
  List<String>? images,
  String? location,
}) => NoteItem(  avatar: avatar ?? _avatar,
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