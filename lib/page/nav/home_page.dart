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
  int pageNum = 1;
  int pageSize = 5;
  List<NoteList> _noteList = [];
  List widgets = [];

  EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    var params = {'PageNum': pageNum, 'PageSize': pageSize};
    return Stack(
      children: [
        FutureBuilder(
          future: request('noteList', params: params),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_noteList.isEmpty) {
                pageNum++;
                var newNoteListRes = NoteListRes.fromJson(snapshot.data);
                for (int i = 0; i < newNoteListRes.noteList!.length; i++) {
                  _noteList.add(newNoteListRes.noteList![i]);
                }
              }
              return EasyRefresh(
                controller: easyRefreshController,
                footer: const ClassicFooter(
                  noMoreText: '我也是有底线的！！！',
                  showText: true,
                  showMessage: true,
                ),
                onLoad: () async {
                  print('开始加载更多${pageNum}');
                  var params = {'PageNum': pageNum, 'PageSize': pageSize};
                  await request('noteList', params: params).then((val) {
                    var newNoteListRes = NoteListRes.fromJson(val);
                    if (newNoteListRes.noteList!.isNotEmpty) {
                      pageNum++;
                      setState(() {
                        for (int i = 0;
                        i < newNoteListRes.noteList!.length;
                        i++) {
                          _noteList.add(newNoteListRes.noteList![i]);
                        }
                      });
                    } else {
                      print("load over");
                    }
                  });
                },
                onRefresh: () async {
                  pageNum = 1;
                  var params = {'PageNum': pageNum, 'PageSize': pageSize};
                  await request('noteList', params: params).then((val) {
                    var newNoteListRes = NoteListRes.fromJson(val);
                    setState(() {
                      _noteList = newNoteListRes.noteList!;
                      pageNum++;
                    });
                  });
                },
                child: ListView.builder(
                  // shrinkWrap: true,
                    itemCount: _noteList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        child: NotepadCard(
                          note: _noteList[i],
                        ),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            elevation: 6.0,
            highlightElevation: 12.0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _noteList.add(_noteList[0]);
                print(_noteList.length);
              });
            },
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}