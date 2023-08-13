// fluro 路由配置
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:life_notepad_app/pages/basic/add_note.dart';
import '../pages/basic/navigation.dart';
import '../pages/basic/login.dart';

// 对应处理函数(一般处理函数单独放一个文件)
var _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BottomNavigationPage();
});
var _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const LoginPage();
});

var _addNoteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const AddNotePage();
});

// 路由配置
class Routes {
  static String home = "/";
  static String login = "/login";
  static String addNote = "/add_note";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(home, handler: _homeHandler);
    router.define(login, handler: _loginHandler);
    router.define(addNote, handler: _addNoteHandler);
  }
}
