import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../config/service_url.dart';
import '../../service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late String _location;
  late final List<String> _images = [];
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  'UserId': 1,
                  'Content': _contentController.text,
                  'Images': _images.sublist(1),
                  'Location': _location,
                };
                await request(addNoteUri, params: params).then((val) {
                  if (val["Code"] != 0) {
                    Fluttertoast.showToast(
                        msg: val["Error"],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    print(val["Data"]);
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
        _location,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 增加加号图片
    _images.add("https://img2.baidu.com/it/u=1697454050,833742662&fm=253");
    _location = "湖北";
  }

  Widget buildImageField() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 3, childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int position) {
          return GestureDetector(
            onTap: () {
              if (position == 0) {
                //最后一张图片（添加按钮）
                print("增加图片");

                // final List<AssetEntity>? assets =
                //     await AssetPicker.pickAssets(context);

                setState(() {
                  _images.add(
                      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F1c5a5c88-3063-4615-905a-a9b9e4c2acb5%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1694020103&t=15637d7ccac5a81aa1e0fa4a558efed9");
                });
              }
            },
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Image(
                image: NetworkImage(_images[position]),
              ),
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
