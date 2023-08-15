import 'dart:convert';

/// Names : ["table_calendar_base-1692036579.dart","table_calendar-1692036579.dart"]

FilesRes filesResFromJson(String str) => FilesRes.fromJson(json.decode(str));
String filesResToJson(FilesRes data) => json.encode(data.toJson());
class FilesRes {
  FilesRes({
      List<String>? names,}){
    _names = names;
}

  FilesRes.fromJson(dynamic json) {
    _names = json['Names'] != null ? json['Names'].cast<String>() : [];
  }
  List<String>? _names;
FilesRes copyWith({  List<String>? names,
}) => FilesRes(  names: names ?? _names,
);
  List<String>? get names => _names;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Names'] = _names;
    return map;
  }

}