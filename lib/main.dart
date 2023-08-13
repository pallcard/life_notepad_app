import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_notepad_app/pages/basic/navigation.dart';
import 'package:life_notepad_app/provide/current_index.dart';
import 'package:life_notepad_app/provide/note_list.dart';
import 'package:life_notepad_app/routers/application.dart';
import 'package:life_notepad_app/routers/routes.dart';
import 'package:provider/provider.dart';

void main() {
  final router = FluroRouter();
  Application.router = router; // 先写
  Routes.configureRoutes(router); // 后写
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NoteListProvide>(
        create: (ctx) => NoteListProvide(),
      ),
      ChangeNotifierProvider<CurrentIndexProvide>(
        create: (ctx) => CurrentIndexProvide(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: '人生记事本',
          debugShowCheckedModeBanner: false,
          // 不显示右上角的 debug
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BottomNavigationPage(),
          onGenerateRoute: Application.router.generator, //全局注册
        );
      },
    );
  }
}
