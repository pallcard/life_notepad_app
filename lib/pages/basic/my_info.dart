import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/service_url.dart';
import '../../model/FilesRes.dart';
import '../../model/User.dart';
import '../../service/service_method.dart';
import '../../utils/user_util.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text("个人信息"),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: buildTextField(
                100, "头像", buildAvatar(UserUtil.getUserInfo().avatar)),
            onTap: () async {
              print("修改头像");

              var imageFiles = await ImagePicker().pickMultiImage();
              // setState(() {
              //   _images.addAll(imageFiles);
              // });
              await uploadFile(
                      context, ServiceUrl.fileUpload, imageFiles.sublist(0, 1))
                  .then((val) async {
                if (val["code"] != 0) {
                  Fluttertoast.showToast(
                      msg: '${val["message"]}',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  print(val["data"]);
                  var filesRes = FilesRes.fromJson(val["data"]);

                  await request(context, ServiceUrl.updateUser, params: {
                    "UserId": UserUtil.getUserInfo().userId,
                    "Avatar": filesRes.names?.first
                  }).then((val) async {
                    print(val);
                    if (val["code"] != 0) {
                      Fluttertoast.showToast(
                          msg: '${val["message"]}',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "修改成功！",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print(val["data"]);
                      UserUtil.saveUserInfo(User.fromJson(val["data"]));
                      Navigator.pop(context);
                    }
                  });
                }
              });
            },
          ),
          GestureDetector(
            child: buildTextField(
                30, "昵称", Text(UserUtil.getUserInfo().nickName ?? "")),
            onTap: () {
              print("修改名称");
              _showDialog(context, "昵称");
            },
          ),
          GestureDetector(
            child: buildTextField(
                30, "个性签名", Text(UserUtil.getUserInfo().description ?? "")),
            onTap: () {
              print("修改个性签名");
              _showDialog(context, "个性签名");
            },
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String label) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('修改$label'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '请输入$label',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('确定'),
                    onPressed: () async {
                      print('$label：${controller.text}');
                      if (label == "昵称") {
                        UserUtil.updateNickName(controller.text);
                        await request(context, ServiceUrl.updateUser, params: {
                          "UserId": UserUtil.getUserInfo().userId,
                          "NickName": controller.text,
                        }).then((val) async {
                          print(val);
                          if (val["code"] != 0) {
                            Fluttertoast.showToast(
                                msg: '${val["message"]}',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            print(val["data"]);
                            UserUtil.saveUserInfo(User.fromJson(val["data"]));
                            Navigator.pop(context);
                          }
                        });
                      } else if (label == "个性签名") {
                        UserUtil.updateDescription(controller.text);
                        await request(context, ServiceUrl.updateUser, params: {
                          "UserId": UserUtil.getUserInfo().userId,
                          "Description": controller.text,
                        }).then((val) async {
                          print(val);
                          if (val["code"] != 0) {
                            Fluttertoast.showToast(
                                msg: '${val["message"]}',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            print(val["data"]);
                            UserUtil.saveUserInfo(User.fromJson(val["data"]));
                            Navigator.pop(context);
                          }
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  Widget buildAvatar(String? avatar) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          avatar ?? "",
        ),
      ),
    );
  }

  Widget buildTextField(double height, String infoLabel, Widget widget) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        // color: Colors.blueGrey,
        child: Container(
          height: height,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(infoLabel),
              ),
              const Expanded(child: Text("")),
              Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: widget,
              ),
            ],
          ),
        ));
  }
}
