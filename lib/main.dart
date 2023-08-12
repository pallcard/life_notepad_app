import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_notepad_app/model/NoteItem.dart';
import 'package:life_notepad_app/page/component/notepad_card.dart';
import 'package:life_notepad_app/page/navigation.dart';
import 'package:life_notepad_app/provide/current_index.dart';
import 'package:life_notepad_app/provide/note_list.dart';
import 'package:provider/provider.dart';

void main() {
  final router = FluroRouter();
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BottomNavigation(),
        );
      },
    );
  }
}
