import "package:dio/dio.dart";
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_notepad_app/utils/user_util.dart';
import 'dart:async';
import '../config/service_url.dart';
import '../routers/routes.dart';

Future request(BuildContext context, url, {params}) async {
  try {
    //print('开始获取数据...............');
    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    if (url != ServiceUrl.login) {
      // 非登陆接口
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        if (!UserUtil.isLogin()) {
          Navigator.pushNamed(context, Routes.login);
        } else {
          return handler.next(options);
        }
      }));
    }

    if (params == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: params);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

Future uploadFile(BuildContext context, url, List<XFile> _imageFile) async {
  try {
    Dio dio = Dio();
    // dio.options.contentType = "multipart/form-data";
    FormData formData = FormData();
    for (int i = 0; i < _imageFile.length; i++) {
      formData.files.add(MapEntry("files",
          await MultipartFile.fromFile(_imageFile[i].path.toString())));
    }

    final response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
