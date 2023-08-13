import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_notepad_app/pages/basic/navigation.dart';
import 'package:life_notepad_app/provide/current_index.dart';
import 'package:life_notepad_app/provide/note_list.dart';
import 'package:life_notepad_app/provide/user.dart';
import 'package:life_notepad_app/routers/application.dart';
import 'package:life_notepad_app/routers/routes.dart';
import 'package:life_notepad_app/utils/sp_util.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //sp
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.init();

  //router
  final router = FluroRouter();
  Application.router = router;
  Routes.configureRoutes(router);
  // provider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NoteListProvide>(
        create: (ctx) => NoteListProvide(),
      ),
      ChangeNotifierProvider<CurrentIndexProvide>(
        create: (ctx) => CurrentIndexProvide(),
      ),
      ChangeNotifierProvider<UserProvide>(
        create: (ctx) => UserProvide(),
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
