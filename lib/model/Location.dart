import 'dart:convert';

import 'package:flutter_z_location/geocode_entity.dart';

/// province : "广东省"
/// provinceId : 440000
/// city : "深圳市"
/// cityId : 440300
/// district : "南山区"
/// districtId : 440305
/// latitude : 22.525818
/// longitude : 113.915973

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    String? province,
    String? provinceId,
    String? city,
    String? cityId,
    String? district,
    String? districtId,
    double? latitude,
    double? longitude,
  }) {
    _province = province;
    _provinceId = provinceId;
    _city = city;
    _cityId = cityId;
    _district = district;
    _districtId = districtId;
    _latitude = latitude;
    _longitude = longitude;
  }

  Location.fromJson(dynamic json) {
    _province = json['province'];
    _provinceId = json['provinceId'];
    _city = json['city'];
    _cityId = json['cityId'];
    _district = json['district'];
    _districtId = json['districtId'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Location.fromGeocodeEntity(GeocodeEntity geocodeEntity) {
    _province = geocodeEntity.province;
    _provinceId = geocodeEntity.provinceId;
    _city = geocodeEntity.city;
    _cityId = geocodeEntity.cityId;
    _district = geocodeEntity.district;
    _districtId = geocodeEntity.districtId;
    _latitude = geocodeEntity.latitude;
    _longitude = geocodeEntity.longitude;
  }

  String? _province;
  String? _provinceId;
  String? _city;
  String? _cityId;
  String? _district;
  String? _districtId;
  double? _latitude;
  double? _longitude;

  Location copyWith({
    String? province,
    String? provinceId,
    String? city,
    String? cityId,
    String? district,
    String? districtId,
    double? latitude,
    double? longitude,
  }) =>
      Location(
        province: province ?? _province,
        provinceId: provinceId ?? _provinceId,
        city: city ?? _city,
        cityId: cityId ?? _cityId,
        district: district ?? _district,
        districtId: districtId ?? _districtId,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
      );

  String? get province => _province;

  String? get provinceId => _provinceId;

  String? get city => _city;

  String? get cityId => _cityId;

  String? get district => _district;

  String? get districtId => _districtId;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  @override
  String toString() {
    return 'Location{_province: $_province, _provinceId: $_provinceId, _city: $_city, _cityId: $_cityId, _district: $_district, _districtId: $_districtId, _latitude: $_latitude, _longitude: $_longitude}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['province'] = _province;
    map['provinceId'] = _provinceId;
    map['city'] = _city;
    map['cityId'] = _cityId;
    map['district'] = _district;
    map['districtId'] = _districtId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}

extension ExLocation on Location {
  /// 地址
  String get address {
    final res = [province, city, district]
        .where((element) => element?.isNotEmpty ?? false)
        .join('-');
    return res;
  }
}
