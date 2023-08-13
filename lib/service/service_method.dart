import "package:dio/dio.dart";
import 'package:flutter/widgets.dart';
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
