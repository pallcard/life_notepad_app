import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_notepad_app/config/service_url.dart';
import '../../model/NoteListRes.dart';
import '../../routers/routes.dart';
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

  late EasyRefreshController _easyRefreshController;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }

  Future _getNoteList(BuildContext context) async {
    var params = {'PageNum': pageNum, 'PageSize': pageSize};
    var val = await request(context, ServiceUrl.noteList, params: params);

    if (val["code"] != 0) {
      Fluttertoast.showToast(
          msg: '${val["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    } else {
      print(val["data"]);
      return val["data"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: _getNoteList(context),
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
                controller: _easyRefreshController,
                header: MaterialHeader(),
                footer: const ClassicFooter(
                  noMoreText: "我也是有底线的",
                  messageText: '最后更新于%T',
                ),
                onLoad: () async {
                  print('开始加载更多${pageNum}');
                  var params = {'PageNum': pageNum, 'PageSize': pageSize};
                  await request(context, ServiceUrl.noteList, params: params)
                      .then((val) {
                    if (val["code"] != 0) {
                      Fluttertoast.showToast(
                          msg: '${val["message"]}',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return null;
                    } else {
                      var newNoteListRes = NoteListRes.fromJson(val["data"]);
                      if (newNoteListRes.noteList!.isNotEmpty) {
                        pageNum++;
                        setState(() {
                          for (int i = 0;
                              i < newNoteListRes.noteList!.length;
                              i++) {
                            _noteList.add(newNoteListRes.noteList![i]);
                          }
                        });
                        print("load ...");
                        _easyRefreshController
                            .finishLoad(IndicatorResult.success);
                      } else {
                        print("load over");
                        _easyRefreshController
                            .finishLoad(IndicatorResult.noMore);
                      }
                    }
                  });
                },
                onRefresh: () async {
                  pageNum = 1;
                  var params = {'PageNum': pageNum, 'PageSize': pageSize};
                  await request(context, ServiceUrl.noteList, params: params)
                      .then((val) {
                    if (val["code"] != 0) {
                      Fluttertoast.showToast(
                          msg: '${val["message"]}',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      return null;
                    } else {
                      var newNoteListRes = NoteListRes.fromJson(val["data"]);
                      setState(() {
                        _noteList = newNoteListRes.noteList!;
                        pageNum++;
                      });
                      _easyRefreshController.finishRefresh();
                      _easyRefreshController.resetFooter();
                    }
                  });
                },
                child: ListView.builder(
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
              return const Center(
                child: CircularProgressIndicator(),
              );
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
              Navigator.pushNamed(context, Routes.addNote);
            },
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
