import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whiteboard_swd/components/button_upload_file.dart';
import 'package:whiteboard_swd/presenters/firebaseApi.dart';

class ImagePickerr extends StatefulWidget {
  final Function callBackFunc;
  const ImagePickerr({Key? key, required this.callBackFunc}) : super(key: key);

  @override
  _ImagePickerrState createState() => _ImagePickerrState();
}

class _ImagePickerrState extends State<ImagePickerr> {
  final ImagePicker picker = ImagePicker();
  bool check = false;

  List<XFile> imageFileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Center(
          //   child: OutlinedButton(
          //       onPressed: () {
          //         check = true;
          //         selectImages();
          //         // Navigator.flPageRoute(builder: (context) => CreatePost()));
          //       },
          //       child: Text('Chọn ảnh')),
          // ),
          ButtonUploadFile(
              icon: Icons.file_upload_outlined,
              text: 'Chọn hình',
              onClicked: selectImages),
          SizedBox(
            height: 5,
          ),
          (check == true)
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: imageFileList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.file(
                                File(imageFileList[index].path),
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                  ),
                )
              : SizedBox(),
          // ButtonUploadFile(
          //     icon: Icons.file_upload_outlined,
          //     text: 'Chọn hình',
          //     onClicked: uploadFile),
        ],
      ),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {
      check = true;
      widget.callBackFunc(imageFileList);
    });
  }

  Future uploadFile() async {
    if (imageFileList == null) return;
    List<Map<String, dynamic>> imageList = [];
    for (int i = 0; i < imageFileList.length; i++) {
      final fileName = imageFileList[i].path;
      String date = DateTime.now().toString();
      final destination = 'files/post-image/$date';

      var task = await FirebaseApi.uploadFile(
          destination, File(imageFileList[i].path));
      String url = await task!.ref.getDownloadURL();
      Map<String, dynamic> image = new Map<String, dynamic>();
      image['image'] = url;
      imageList.add(image);
      setState(() {});
    }
    setState(() {
      widget.callBackFunc(imageList);
    });
  }
}
