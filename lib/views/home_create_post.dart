import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whiteboard_swd/components/bottom_tab.dart';
import 'package:whiteboard_swd/components/button_upload_file.dart';
import 'package:whiteboard_swd/components/chip_custom_create_post.dart';
import 'package:whiteboard_swd/components/image_picker.dart';
import 'package:whiteboard_swd/presenters/firebaseApi.dart';
import 'package:whiteboard_swd/views/success_create_post.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';
import 'package:whiteboard_swd/utils/color.dart';

class CreatePost extends StatefulWidget {
  final Campaign campaign;
  final String reviewerId;
  final String token;
  const CreatePost(
      {Key? key,
      required this.campaign,
      required this.reviewerId,
      required this.token})
      : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? file;
  UploadTask? task;

  int currentStep = 0;
  bool isCompleted = false;
  int check1 = 0;
  List<Map<String, dynamic>> criteria = [];
  TextEditingController titleController = TextEditingController()..text = '';
  TextEditingController contentController = TextEditingController()..text = '';
  List<XFile>? listImage;
  List<Map<String, dynamic>> listImages = [];

  void callback(int num, String id) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['criterionId'] = id;
    map['rating'] = 4;
    setState(() {
      if (num > 0) {
        criteria.add(map);
      } else {
        criteria.removeWhere((element) => element.values.contains(id));
      }
      check1 += num;
    });
  }

  void callbackImage(List<XFile> list) {
    setState(() {
      listImage = list;
    });
  }

  Future uploadFile() async {
    if (listImage == null) return;
    for (int i = 0; i < listImage!.length; i++) {
      String date = DateTime.now().toString();
      final destination = 'files/post-image/$date';

      var task =
          await FirebaseApi.uploadFile(destination, File(listImage![i].path));
      String url = await task!.ref.getDownloadURL();
      Map<String, dynamic> image = new Map<String, dynamic>();
      image['image'] = url;
      setState(() {
        listImages.add(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tạo bài viết'),
          leading: Container(),
          actions: [
            if (!isCompleted)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) =>
                            // CampainDetailPage(campaign: widget.campaign)

                            BottomTab()));
                  },
                  icon: Icon(Icons.close))
          ],
        ),
        body: isCompleted
            ? buildCompleted(context)
            : Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: white_blue),
                ),
                child: Stepper(
                    type: StepperType.horizontal,
                    steps: getSteps(context),
                    currentStep: currentStep,
                    onStepContinue: () async {
                      if (check1 > 0 || currentStep >= 1) {
                        final isLastStep =
                            currentStep == getSteps(context).length - 1;
                        if (isLastStep) {
                          await uploadFile();
                          setState(() => isCompleted = true);
                          Map<String, dynamic> post =
                              new Map<String, dynamic>();
                          post['title'] = titleController.text.toString();
                          post['content'] = contentController.text.toString();
                          post['criterions'] = criteria;
                          post['campaignId'] = widget.campaign.id;
                          post['reviewerId'] = widget.reviewerId;
                          post['images'] = listImages;

                          await PostRequest.createPost(post, widget.token);
                        } else {
                          setState(() => currentStep += 1);
                        }
                      }
                    },
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() {
                              currentStep -= 1;
                              check1 = 0;
                            }),
                    controlsBuilder: (context, details) {
                      // setState(() {
                      //   check1 = 0;
                      // });
                      final isLastStep =
                          currentStep == getSteps(context).length - 1;
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(
                                "Trở về",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              onPressed: details.onStepCancel,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: (check1 > 0 || currentStep >= 1)
                                ? ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.5),
                                      child: Text(
                                        isLastStep ? "Hoàn tất" : "Tiếp tục",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onPressed: details.onStepContinue,
                                  )
                                : Container(
                                    height: 37,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(5)
                                        //     backgroundColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Colors.grey.shade300),
                                        //     shape: null,
                                        //     shadowColor:
                                        //         MaterialStateProperty.all<Color>(
                                        //             Colors.white)),
                                        // onPressed: () {},
                                        ),
                                    child: Center(
                                      child: Text(
                                        'Tiếp tục',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.35),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                          ),
                          // if (currentStep != 0)
                        ],
                      );
                    }),
              ),
      ),
    );
  }

  List<Step> getSteps(BuildContext context) {
    final fileName = file != null ? file!.path : 'No File Selected';
    final size = MediaQuery.of(context).size;
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(""),
        content: Container(
          height: size.height - 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tiêu chí: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 10,
                children: getCriterial(widget.campaign.campaignCriteria!),
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(""),
        content: Container(
          height: size.height - 300,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                // onChanged: (value) {
                //   titleController..text = value;
                // },
                onFieldSubmitted: (value) {
                  titleController..text = value;
                },
                decoration: InputDecoration(
                  labelText: "Tiêu đề* ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: contentController,
                // onChanged: (value) {
                //   contentController..text = value;
                // },
                onFieldSubmitted: (value) {
                  contentController..text = value;
                },
                maxLines: 20,
                decoration: InputDecoration(
                  labelText: "Nội dung* ",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text(""),
        content: Container(
          height: size.height - 300,
          child: Column(
            children: [
              // Container(
              //   width: size.width * 0.7,
              //   height: size.height * 0.5,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         // image: AssetImage("assets/images/anh.png"),
              //         fit: BoxFit.fitWidth),
              //   ),
              // ),
              // ),
              Container(
                  height: 300,
                  width: 300,
                  child: ImagePickerr(
                    callBackFunc: callbackImage,
                  )),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> getCriterial(List<Criteria> criteria) {
    final result = <Widget>[];
    for (var i = 0; i < criteria.length; i++) {
      result.add(
        Container(
            child: ChipCustom(
          criteria: criteria[i],
          callback: this.callback,
        )),
      );
    }
    return result;
  }
}
