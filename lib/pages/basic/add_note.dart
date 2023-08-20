import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_notepad_app/model/FilesRes.dart';
import 'package:life_notepad_app/utils/user_util.dart';

import '../../config/service_url.dart';
import '../../model/Location.dart';
import '../../service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_z_location/flutter_z_location.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late Location _location;

  // 是否显示位置
  bool showLocation = false;

  // 是否上传完图片
  bool imageUpload = true;

  final List<XFile> _images = []; //图片文件
  final List<String> _imageNames = [];
  final TextEditingController _contentController = TextEditingController();

  Future _getInitData(BuildContext context) async {
    var permission = await requestLocationPermission();
    if (permission) {
      // 获取GPS定位经纬度
      final coordinate = await FlutterZLocation.getCoordinate();
      // 经纬度反向地理编码获取地址信息(省、市、区)
      final res1 = await FlutterZLocation.geocodeCoordinate(
          coordinate.latitude, coordinate.longitude,
          pathHead: 'assets/');

      return res1;
    } else {
      return null;
    }
  }

  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var locationWhenInUse = await Permission.location.status;
    if (locationWhenInUse == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      locationWhenInUse = await Permission.location.request();
      if (locationWhenInUse == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getInitData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _location = Location.fromGeocodeEntity(snapshot.data);
          showLocation = true;
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.send),
                  tooltip: "发布",
                  onPressed: () async {
                    print(_contentController.text);
                    var params = {
                      'UserId': UserUtil.getUserInfo().userId,
                      'Content': _contentController.text,
                      'Images': _imageNames,
                      'Location': showLocation ? jsonEncode(_location) : "",
                    };

                    await request(context, ServiceUrl.addNote, params: params)
                        .then((val) {
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
                        Navigator.pop(context);
                      }
                    });
                  }),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  buildTextField(),
                  buildImageField(),
                  buildLocal(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: _contentController,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.justify,
      // todo 两端对齐不生效问题
      style: const TextStyle(
        decorationStyle: TextDecorationStyle.double,
      ),
      maxLines: 100,
      minLines: 1,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "这一刻的想法...",
      ),
    );
  }

  Widget buildLocal() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        showLocation ? _location.address : "",
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildImageField() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _images.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 3, childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int position) {
          return GestureDetector(
            onTap: () async {
              if (position == 0) {
                imageUpload = false;
                var imageFiles = await ImagePicker().pickMultiImage();
                setState(() {
                  _images.addAll(imageFiles);
                });
                await uploadFile(context, ServiceUrl.fileUpload, imageFiles)
                    .then((val) {
                  if (val["code"] != 0) {
                    Fluttertoast.showToast(
                        msg: '${val["message"]}',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    imageUpload = true;
                    print(val["data"]);
                    var filesRes = FilesRes.fromJson(val["data"]);
                    _imageNames.addAll(filesRes.names ?? []);
                  }
                });
              }
            },
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: position == 0
                  ? const Image(
                      image: NetworkImage(
                          "https://img2.baidu.com/it/u=1697454050,833742662&fm=253"),
                    )
                  : Image.file(File(_images.elementAt(position - 1).path)),
            ),
          );
        });
  }
//
// static Widget imagePicker(
//   String formKey,
//   ValueChanged<String> onTapped, {
//   File imageFile,
//   String imageUrl,
//   double width = 80.0,
//   double height = 80.0,
// }) {
//   return GestureDetector(
//     child: Container(
//       margin: EdgeInsets.all(10),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         border: Border.all(width: 0.5, style: BorderStyle.solid),
//         borderRadius: BorderRadius.all(Radius.circular(4.0)),
//       ),
//       child: _getImageWidget(imageFile, imageUrl, width, height),
//       width: width,
//       height: height,
//     ),
//     onTap: () {
//       onTapped();
//     },
//   );
// }
//
// static Widget _getImageWidget(
//     File imageFile, String imageUrl, double width, double height) {
//   if (imageFile != null) {
//     return Image.file(
//       imageFile,
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//     );
//   }
//   if (imageUrl != null) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//     );
//   }
//
//   return Icon(Icons.add_photo_alternate);
// }
//
// List<Widget> _getForm(BuildContext context) {
//   List<Widget> widgets = [];
//   formData.forEach((key, formParams) {
//     widgets.add(FormUtil.textField(key, formParams['value'],
//         controller: formParams['controller'] ?? null,
//         hintText: formParams['hintText'] ?? '',
//         prefixIcon: formParams['icon'],
//         onChanged: handleTextFieldChanged,
//         onClear: handleClear));
//   });
//   widgets.add(FormUtil.imagePicker(
//     'imageUrl',
//     () {
//       _pickImage(context);
//     },
//     imageFile: imageFile,
//     imageUrl: imageUrl,
//   ));
//
//   widgets.add(ButtonUtil.primaryTextButton(
//     buttonName,
//     handleSubmit,
//     context,
//     width: MediaQuery.of(context).size.width - 20,
//   ));
//
//   return widgets;
// }
//
// void _pickImage(BuildContext context) async {
//   final List<AssetEntity> assets =
//       await AssetPicker.pickAssets(context, maxAssets: 1);
//   if (assets.length > 0) {
//     File file = await assets[0].file;
//     handleImagePicked(file);
//   }
// }
}
