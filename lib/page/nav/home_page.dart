import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../../model/NoteListRes.dart';
import '../../service/service_method.dart';
import '../component/notepad_card.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage>
    with AutomaticKeepAliveClientMixin {
  int page = 2;
  List<NoteList> _noteList = [];

  EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    var params = {'PageNum': 1, 'PageSize': 5};
    return
        // return Stack(
        //   children: [
        FutureBuilder(
      future: request('noteList', params: params),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var noteListRes = NoteListRes.fromJson(snapshot.data);
          _noteList = noteListRes.noteList!;
          return

              //   ListView.builder(
              //   key: UniqueKey(),
              //   itemCount: _noteList.length,
              //   itemBuilder: (BuildContext context, int i) {
              //     return NotepadCard(
              //       note: _noteList[i],
              //     );
              //   },
              // );
              EasyRefresh(
            controller: easyRefreshController,
            onLoad: () async {
              print('开始加载更多${page}');
              var params = {'PageNum': page, 'PageSize': 10};
              await request('noteList', params: params).then((val) {
                var newNoteListRes = NoteListRes.fromJson(val);
                setState(() {
                  // easyRefreshController.finishLoad(IndicatorResult.success);
                  _noteList
                      .addAll(newNoteListRes.noteList as Iterable<NoteList>);
                  page++;
                  print('_noteList:${_noteList.length}');
                });
              });
            },
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  // 控制器关闭刷新功能
                  // easyRefreshController
                  //     .finishRefresh(IndicatorResult.success);
                });
              });
            },
            child:
                // ListView(
                //   children: noteList.map((e) => NotepadCard(note: e)).toList(),
                // ),

                ListView.builder(
                    //itemExtent: 800.0,
                    shrinkWrap: true,
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: _noteList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return NotepadCard(
                        note: _noteList[i],
                      );
                    }),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
    // Container(
    //   alignment: Alignment.bottomRight,
    //   padding: const EdgeInsets.only(right: 10, bottom: 10),
    //   child: FloatingActionButton(
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.blue,
    //     elevation: 6.0,
    //     highlightElevation: 12.0,
    //     shape: const CircleBorder(),
    //     child: const Icon(Icons.add),
    //     onPressed: () {
    //       setState(() {
    //         _noteList.add(_noteList[0]);
    //         print(_noteList.length);
    //       });
    //     },
    //   ),
    // );
    // ],
    // );
  }

  @override
  bool get wantKeepAlive => true;
}
