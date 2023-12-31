import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:life_notepad_app/model/Location.dart';
import 'package:photo_view/photo_view.dart';
import '../../model/NoteListRes.dart';

class NotepadCard extends StatelessWidget {
  const NotepadCard({super.key, required this.note});

  final NoteList note;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
          child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(8),
                child: Image(
                  image: NetworkImage(
                    note.avatar ?? "",
                  ),
                ),
              ),
              Text(
                note.nickName ?? "",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            child: Text(
              note.content ?? "",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          (note.images == null || note.images!.isEmpty)
              ? const Text("")
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: note.images?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int position) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: true,
                            pageBuilder: (BuildContext context, _, __) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: PhotoView(
                                  imageProvider:
                                      NetworkImage(note.images![position]),
                                ),
                              );
                            }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Image(
                          image: NetworkImage(note.images![position]),
                        ),
                      ),
                    );
                  }),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              note.createTime ?? "",
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              note.location == null || note.location!.isEmpty
                  ? ""
                  : Location.fromJson(jsonDecode(note.location!)).address,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
